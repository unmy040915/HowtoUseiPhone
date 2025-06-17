import SwiftUI
import TipKit


struct messageView: View {
    @Binding var selectedTab : Int
    @Binding var task: String
    @State private var showImagePicker = false
    @State private var pendingUIImage: UIImage?
    @Binding var tasks: [Task]
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(content: .image(Image("dog")), isFromUser: false),
        ChatMessage(content: .text("このテキストをコピーしよう"), isFromUser: false)
    ]
    
    @FocusState private var isInputFocused: Bool
    @FocusState private var focusedField: Field?
    let ImageTip = ImageSendTip()
    @State var CopyPasteTips = TipGroup(.ordered){
        pasteTip()
        copyPasteTip()
    }
    var body: some View {
        ZStack{
            VStack{
                TaskView(task: $task)
                Text("山田太郎")
                    .font(.title)
                Divider()
                MessageListView(messages: $messages, isInputFocused: $isInputFocused, task: $task,tasks: $tasks,)
                TipView(messageSendTip(), arrowEdge: .bottom)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
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
                            .popoverTip(ImageTip)
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
                            .popoverTip(CopyPasteTips.currentTip as? pasteTip)
                        
                    }
                    
                    if isInputFocused || pendingUIImage != nil {
                        Button(action: {
                            if !messageText.isEmpty {
                                messages.append(ChatMessage(content: .text(messageText), isFromUser: true))
                                if messageText == "このテキストをコピーしよう"{
                                    if task == "コピー&ペーストをしよう" {
                                        markTaskDone(with: task)
                                    }
                                }
                                if task == "メッセージを送信しよう" {
                                    markTaskDone(with: task)
                                }
                                messageText = ""
                            } else if let image = pendingUIImage {
                                let swiftUIImage = Image(uiImage: image)
                                messages.append(ChatMessage(content: .image(swiftUIImage), isFromUser: true))
                                if task == "画像を送信しよう" {
                                    markTaskDone(with: task)
                                }
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
            .task {
                try? Tips.configure([
                    .datastoreLocation(.applicationDefault)
                ])
                if task == "メッセージを送信しよう" && tasks[0].isDone == false{
                    messageSendTip.ismessageSend = true
                    try? Tips.resetDatastore()
                }else {
                    messageSendTip.ismessageSend = false
                }
                
            }
            .task {
                try? Tips.configure([
                    .datastoreLocation(.applicationDefault)
                ])
                if task == "画像を送信しよう" && tasks[1].isDone == false{
                    ImageSendTip.isImageSend = true
                    try? Tips.resetDatastore()
                }else {
                    ImageSendTip.isImageSend = false
                }
                
            }
            .task {
                try? Tips.configure([
                    .datastoreLocation(.applicationDefault)
                ])
                if task == "コピー&ペーストをしよう" && tasks[3].isDone == false{
                    pasteTip.isPasteSend = true
                    try? Tips.resetDatastore()
                }else {
                    pasteTip.isPasteSend = false
                }
                
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
    public func markTaskDone(with title: String) {
        if let index = tasks.firstIndex(where: { $0.title == title }) {
            tasks[index].isDone = true
        }
    }
    enum Field: Hashable {
        case field
    }
    
}


#Preview {
    messageView(selectedTab: .constant(4), task: .constant(.init()), tasks: .constant(.init()))
}
