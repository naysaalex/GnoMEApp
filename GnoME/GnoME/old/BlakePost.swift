//
//  BlakePost.swift
//  GnoME usingData
//
//  Created by gnome on 4/1/23.
//

import SwiftUI

struct BlakePost: View {
    // Define a variable to hold the post data
    let post: [String: Any] = [
        "profilePic": "Blake",
        "userName": "Blake",
        "time": "11:00 AM",
        "date": "2023-03-31",
        "answer": "I have an interview on Tuesday and I can't wait to dress to impress",
        "likes": 2,
        "comments": [
            [
                "userName": "Niyati",
                "commentText": "You got this Blake!!!",
                "profilePic": "Niyati"
            ],
            [
                "userName": "Naysa",
                "commentText": "Excited?!! I get so nervous",
                "profilePic": "Naysa"
            ],
            [
                "userName": "Jackson",
                "commentText": "He's basically hired",
                "profilePic": "Jackson"
            ]
        ]
    ]
    
    @State var showComments = false //toggle the comments section
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color(hue: 0.034, saturation: 0.807, brightness: 0.855))
                    .cornerRadius(15)
                    .padding(.vertical, -20)
                    .frame(width: 370)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.black, lineWidth: 2)
                            .padding(.vertical, -20)
                        )
                    .shadow(radius: 2)
                //.padding(.horizontal, -8)
                
                VStack{
                    HStack{
                        // Display profile picture
                        Image((post["profilePic"]!) as! String)
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text(post["userName"] as! String)
                                .font(.headline)
                            Text("\(post["time"] as! String) - \(post["date"] as! String)")
                                .font(.subheadline)
                                .foregroundColor(.black)
                               
                        }// Display username and post time
                    }
                    .padding(.trailing, 100)
                    
                    
                    
                    Text(post["answer"] as! String)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 8)
                        .padding(.leading, 25)
                    // Display post answer
                    
                    HStack {
                        Image("Mushroom 1")
                            .resizable()
                            .frame(width: 49*(5/6), height: 34*(5/6))
                        Text("\(post["likes"] as! Int)")
                        
                        
                        Button(action: {
                            
                            showComments.toggle()
                        }) {
                            Image("Chat")
                        }
                        
                        
                        Text("\((post["comments"]! as AnyObject).count)")
                    }//Comment & Like Count
                    .padding(.leading, 200)
                }
            }//Profile Pic, Name, Date, Time, Answer, Likes, Comments
            
            
            
            if showComments {
                
                VStack {
                    Rectangle()
                        .fill(Color(red: 0.8313725490196079, green: 0.7647058823529411, blue: 0.6941176470588235))
                        .frame(width: 349, height: 50)
                        .padding(.bottom, -40)
                        .padding(.top, -9)
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 0.8313725490196079, green: 0.7647058823529411, blue: 0.6941176470588235))
                            .cornerRadius( 15)
                            .padding(.vertical, -10)
                            .frame(width: 349)
                        VStack (alignment: .leading) {
                            ForEach(post["comments"] as! [[String: String]], id: \.self) { comment in
                                HStack {
                                    HStack (alignment: .center) {
                                        Image(comment["profilePic"]!)
                                            .frame(width: 25, height: 25)
                                        VStack(alignment: .leading) {
                                            Text(comment["userName"]!)
                                                .font(.subheadline)
                                            Text(comment["commentText"]!)
                                                .font(.subheadline)
                                           
                                              
                                        }
                                    }
                                    Spacer()
                                    Image("Mushroom 1")
                                        .frame(width: 100, height: 100, alignment: .trailing)
                                        .padding(.trailing, 25)
                                   

                                }
                                Divider()
                                    .frame(width: 300, height: 2)
                                    .background(Color.black)

                            }
                        }//Comments
                        .padding(.leading, 50)
                      
                       
                    }
                    
                }//Comments with Background
                .padding(.top, 17)
            }
        }
        .padding(.vertical, 20)
    }
}

struct BlakePost_Previews: PreviewProvider {
    static var previews: some View {
        BlakePost()
    }
}

