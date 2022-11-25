//
//  ContentView.swift
//  AV Camera
//
//  Created by Okhunjon Mamajonov on 2022/11/26.
//

import SwiftUI


struct ContentView: View {
  

    @State private var capturedImage:UIImage? = nil
    @State private var isCustomCameraViewPresented = false

    var body: some View {
       
        ZStack{
            
            if capturedImage != nil {
                Image(uiImage: capturedImage!)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                Color(UIColor.systemBackground)
            }
            
            VStack{
                Spacer()
                Button (action: {
                    isCustomCameraViewPresented.toggle()
                }, label: {
                  Image(systemName: "camera.fill")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
  )
                .padding(.bottom)
                .sheet(isPresented: $isCustomCameraViewPresented) {
                    CustomCamera(capturedImage: $capturedImage)
                }
            }
        }
           
        }
    }

   
