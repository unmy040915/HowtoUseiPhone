import SwiftUI

struct messageView: View {
    @Binding var selectedTab : Int
    @Binding var task: String
    
    @State private var messageText: String = ""
    @State private var messages: [String] = []
    @State private var receivedImages: [Image] = [Image("dog")]
    @FocusState private var isInputFocused: Bool
    @FocusState private var focusedField: Field?
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
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            Color.clear
                                .frame(height: 1)
                                .id("bottom")
                        }
                        .padding()
                    }
                    .onChange(of: messages.count) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.indices.last, anchor: .bottom)
                        }
                    }
                    .onChange(of: isInputFocused) { newValue in
                        if newValue {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation {
                                    proxy.scrollTo("bottom", anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                
                HStack (spacing: 0){
                    Button(action: {
                        
                    }){
                        Image(systemName: "photo")
                            .font(.system(size:30))
                            .foregroundColor(Color.gray)
                            .padding(.trailing,5)
                    }
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 300, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                        
                        TextField("テキストメッセージ", text: $messageText)
                            .focused($isInputFocused)
                            .frame(width: 280, height: 35)
                            .padding(.leading)
                            .focused($focusedField, equals: .field)
                            .onTapGesture {
                                focusedField = .field
                                isInputFocused = true
                            }
                        
                    }
                    
                    if isInputFocused {
                        Button(action:{
                            guard !messageText.isEmpty else { return }
                            messages.append(messageText)
                            messageText = ""
                            isInputFocused = false // 入力終了後フォーカス外す
                        }){ Image(systemName: "arrow.up.circle.fill")
                                .foregroundColor(Color.green)
                                .font(.system(size:30))
                        }
                        .padding(.leading,5)
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                            .animation(.easeInOut, value: isInputFocused)
                    }
                }
                .padding(.horizontal)
                
            }
        }
        .onTapGesture {
            focusedField = nil
        }
    }
    enum Field: Hashable {
        case field
    }
}


#Preview {
    messageView(selectedTab: .constant(4), task: .constant(.init()))
}
