import SwiftUI

struct messageView: View {
    @Binding var selectedTab : Int
    @Binding var task: String
    
    @State private var messageText: String = ""
    @State private var messages: [String] = []
    @State private var receivedImages: [Image] = [Image("dog")]
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        ZStack{
            VStack{
                TaskView(task: $task)
                Text("山田太郎")
                    .font(.title)
                Divider()
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(receivedImages.indices, id: \.self) { index in
                                HStack(alignment: .top, spacing: 8) {
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    receivedImages[index]
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200)
                                        .cornerRadius(12)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("このテキストをコピーしよう")
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .foregroundColor(.black)
                                    .cornerRadius(12)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ForEach(messages.indices, id: \.self) { index in
                                HStack(alignment: .top, spacing: 8) {
                                    Spacer()
                                    Text(messages[index])
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: messages.count) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.indices.last, anchor: .bottom)
                        }
                    }
                }
                
                HStack {
                    ZStack{
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 300, height: 40)
                            .cornerRadius(12)
                        TextField("メッセージを入力", text: $messageText)
                            .cornerRadius(12)
                            .focused($isInputFocused)
                    }
                    
                    Button("送信") {//入力されたら現れるようにしたい．
                        guard !messageText.isEmpty else { return }
                        messages.append(messageText)
                        messageText = ""
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
    }
    
}


#Preview {
    messageView(selectedTab: .constant(4), task: .constant(.init()))
}
