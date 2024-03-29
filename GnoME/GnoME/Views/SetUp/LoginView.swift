//
//  LoginView.swift
//  GnoME
//
//  Created by cashamirica on 4/18/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage


struct LoginView: View {
    @State var emailID: String = ""
    @State var password: String = ""
    
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    
    var body: some View {
        ZStack{
            Color("gnomeBlue")
                .ignoresSafeArea()
            
            VStack(spacing: 10){
                
                HStack{
                    Image("title")
                        .resizable()
                        .frame(width: 120.0, height: 50.0)
                        //.padding(.top)
                    Spacer()
                    Image("circleIcon")
                        .resizable()
                        .frame(width:60.0,height:60.0)
                        //.padding(.top)
                }
                .padding(.top, -20)
                
                Text("Log In")
                    .font(.largeTitle.bold())
                    .hAlign(.leading)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 25)
                    .padding(.top, 80)
                
//                Text("Ready to let people Gno you?!")
//                    .font(.title3)
//                    .hAlign(.leading)
//                    .foregroundColor(Color.white)
                
                VStack(spacing:12){
                    TextField("Email", text: $emailID)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.5))
                        //.padding(.top, 25)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                    
                    SecureField("Password", text: $password)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.5))
                        .background(Color.white)
                        .foregroundColor(Color.black)
                    
                    Button("Reset password?", action: resetPassword)
                        .font(.callout)
                        .fontWeight(.medium)
                        .tint(.black)
                        .hAlign(.trailing)
                    
                    Button(action: loginUser){
                        Text("Sign in")
                            .fillView(Color("gnomeBeige"))
                            .foregroundColor(Color.black)
                            .hAlign(.center)
                    }
                    //.background(Color("gnomeBeige"))
                    //.foregroundColor(Color.black)
                    .padding(.top,10)
                }
                
                HStack{
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    
                    Button("Register Now"){
                        createAccount.toggle()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                }
                .vAlign(.bottom)
                .font(.callout)
            }
            .vAlign(.top)
            .padding(15)
            .overlay(content:{
                LoadingView(show: $isLoading)
            })
            .fullScreenCover(isPresented: $createAccount){
                RegisterView()
            }
            .alert(errorMessage, isPresented: $showError, actions: {})
        }
    }
    
    func loginUser()
    {
        isLoading = true
        closeKeyboard()
        Task{
            do{
                try await Auth.auth().signIn(withEmail: emailID, password: password)
                print("User Found")
                try await fetchUser()
            }catch{
                await setError(error)
            }
        }
    }
    
    func fetchUser()async throws{
        guard let userID = Auth.auth().currentUser?.uid else{return}
        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
        await MainActor.run(body: {
            userUID = userID
            userNameStored = user.username
            //let userProfileURLString = user.userProfileURL as? String
            profileURL = URL(string: user.userProfileURL ?? "")
            logStatus = true
        })
    }
    
    func resetPassword(){
        Task{
            do{
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("Link Sent")
            }catch{
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


