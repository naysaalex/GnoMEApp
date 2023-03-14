//
//  WelcomeScreen.swift
//  GnoMe
//
//  Created by cashamirica on 3/12/23.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color("tan")
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Image("title")
                            .resizable()
                            .frame(width: 120.0, height: 50.0)
                            .position(CGPoint(x:70,y:30))
                        Image("circleIcon")
                            .resizable()
                            .frame(width:60.0,height:60.0)
                            .position(CGPoint(x:150,y:35))
                    }
                    //Spacer()
                    Text("Welcome. Ready to let people Gno you?")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    HStack{
                        NavigationLink(destination: SignUp1()){
                            Text("Sign Up")
                                .frame(minWidth: 0,maxWidth: 100)
                                .padding()
                                .foregroundColor(.blue)
                                .background(Color("beige"))
                                .cornerRadius(40)
                                .position(x:109,y:40)
                        }
                        
                        Spacer()
                        NavigationLink(destination: SignUp1()){
                            Text("Log In")
                                .frame(minWidth: 0,maxWidth: 100)
                                .padding()
                                .foregroundColor(.blue)
                                .background(Color("beige"))
                                .cornerRadius(40)
                                .position(x:90,y:40)
                        }
                        
                    }
                    Spacer()
                }
                
            }
        }
        
    }
}

struct SignUp: View {
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var confirmPass:String = ""
    var body: some View {
        ZStack{
            Color("tan")
                .ignoresSafeArea()
            VStack{
                HStack{
                    Image("title")
                        .resizable()
                        .frame(width: 120.0, height: 50.0)
                        .position(CGPoint(x:70,y:30))
                    Image("circleIcon")
                        .resizable()
                        .frame(width:60.0,height:60.0)
                        .position(CGPoint(x:150,y:35))
                }
                VStack{
                    TextField("Email", text: $email)
                        .disableAutocorrection(true)
                        .position(x:180,y:-200)
                        .frame(width:360)
                    TextField("Password", text: $password)
                        .disableAutocorrection(true)
                        .frame(width:360)
                        .position(x:195,y:-130)
                    TextField("Confirm Password", text: $confirmPass)
                        .disableAutocorrection(true)
                        .frame(width: 360)
                        .position(x:195,y:-200)
                }
                .textFieldStyle(.roundedBorder)
                
                NavigationLink(destination: SignUp2()){
                    Text("Continue")
                        .frame(minWidth: 0,maxWidth: 100)
                        .padding()
                        .foregroundColor(.blue)
                        .background(Color("beige"))
                        .cornerRadius(40)
                }
            }
            
        }
    }
}
struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
