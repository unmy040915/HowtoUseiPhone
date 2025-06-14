import SwiftUI

enum MessageContent {
    case text(String)
    case image(Image)
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let content: MessageContent
    let isFromUser: Bool
}

struct messageView: View {
    @Binding var selectedTab : Int
    @Binding var task: String
    @State private var showImagePicker = false
    @State private var pendingUIImage: UIImage?
    
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(content: .image(Image("dog")), isFromUser: false),
        ChatMessage(content: .text("このテキストをコピーしよう"), isFromUser: false)
    ]
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
                            ForEach(messages) { message in
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
                
                if let image = pendingUIImage {
                    HStack {
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipped()
                                .cornerRadius(10)

                            Button(action: {
                                pendingUIImage = nil
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white)
                                    .background(Color.black.opacity(0.6))
                                    .clipShape(Circle())
                            }
                            .offset(x: 5, y: -5)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                HStack (spacing: 0){
                    Button(action: {
                        showImagePicker = true
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
                    
                    if isInputFocused || pendingUIImage != nil {
                        Button(action: {
                            if !messageText.isEmpty {
                                messages.append(ChatMessage(content: .text(messageText), isFromUser: true))
                                messageText = ""
                            } else if let image = pendingUIImage {
                                let swiftUIImage = Image(uiImage: image)
                                messages.append(ChatMessage(content: .image(swiftUIImage), isFromUser: true))
                                pendingUIImage = nil
                            }
                            isInputFocused = false
                        }) {
                            Image(systemName: "arrow.up.circle.fill")
                                .foregroundColor(Color.green)
                                .font(.system(size:30))
                        }
                        .padding(.leading,5)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                        .animation(.easeInOut, value: isInputFocused || pendingUIImage != nil)
                    }
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $pendingUIImage)
                }
                .padding(.horizontal)
                
            }
        }
        .onTapGesture {
            focusedField = nil
        }
    }
    func sendMessage() {
        guard !messageText.isEmpty else { return }
        messages.append(ChatMessage(content: .text(messageText), isFromUser: true))
        messageText = ""
        isInputFocused = false
    }
    enum Field: Hashable {
        case field
    }
}


#Preview {
    messageView(selectedTab: .constant(4), task: .constant(.init()))
}
