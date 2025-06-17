//
//  ChatMessageView.swift
//  HowtoUseiPhone
//
//  Created by 牟禮優汰 on 2025/06/16.
//

import SwiftUI
import TipKit

struct ChatMessageView: View {
    var message: ChatMessage
    @Binding var task: String
    @Binding var tasks: [Task]
    @State var CopyPasteTips = TipGroup(.ordered){
        copyPasteTip()
        pasteTip()
    }
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if message.isFromUser {
                Spacer()
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
            }

            Group {
                switch message.content {
                case .text(let text):
                    Text(text)
                        .padding()
                        .background(message.isFromUser ? Color.green : Color.gray.opacity(0.2))
                        .foregroundColor(message.isFromUser ? .white : .black)
                        .cornerRadius(12)
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = text
                            }) {
                                Label("コピー", systemImage: "doc.on.doc")
                            }
                        }
                        .popoverTip(CopyPasteTips.currentTip as? copyPasteTip)
                    
                case .image(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .cornerRadius(12)
                }
            }

            if !message.isFromUser {
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: message.isFromUser ? .trailing : .leading)
        .task {
            try? Tips.configure([
                .datastoreLocation(.applicationDefault)
            ])
            if task == "コピー&ペーストをしよう" && tasks[3].isDone == false{
                copyPasteTip.isCopySend = true
                try? Tips.resetDatastore()
            }else {
                copyPasteTip.isCopySend = false
            }
            
        }
    }
}



