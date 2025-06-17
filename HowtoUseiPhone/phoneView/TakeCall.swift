//
//  TakeCall.swift
//  HowtoUseiPhone
//
//  Created by 牟禮優汰 on 2025/06/17.
//

import SwiftUI
import TipKit

struct TakeCall: View {
    @Environment(\.dismiss) var dismiss
    @Binding var tasks: [Task]
    @Binding var task: String
    @State private var showCompletePopup = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.opacity(0.85)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                    
                    Text("山田太郎")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("iPhone")
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    HStack(spacing: 60) {
                        Spacer()
                        VStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 70, height: 70)
                                .overlay(
                                    Image(systemName: "phone.down.fill")
                                        .foregroundColor(.white)
                                        .font(.title)
                                )
                            Text("拒否")
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button(action:{
                            dismiss()
                            if task == "電話を取ろう"{
                                markTaskDone(with: task)
                            }
                        }){
                            VStack {
                                
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 70, height: 70)
                                    .overlay(
                                        Image(systemName: "phone.fill")
                                            .foregroundColor(.white)
                                            .font(.title)
                                    )
                                Text("応答")
                                    .foregroundColor(.white)
                            }
                        }
                        .popoverTip(takeCallTip())
                        Spacer()
                    }
                    .padding(.top,80)
                    
                    
                }
                .task {
                    try? Tips.configure([
                        .datastoreLocation(.applicationDefault)
                    ])
                    if task == "電話を取ろう" && tasks[1].isDone == false{
                        takeCallTip.isTakeCall = true
                        try? Tips.resetDatastore()
                    }else {
                        takeCallTip.isTakeCall = false
                    }
                    
                }
                .sheet(isPresented: $showCompletePopup) {
                    TaskCompletePopupView()
                        
                }
                
            }
        }
    }
    
    func markTaskDone(with title: String) {
        if let index = tasks.firstIndex(where: { $0.title == title }) {
            tasks[index].isDone = true
            showCompletePopup = true
        }
    }
}
