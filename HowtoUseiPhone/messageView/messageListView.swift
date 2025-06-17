import SwiftUI
import TipKit

struct ChatMessage: Identifiable {
    enum Content {
        case text(String)
        case image(Image)
    }

    let id = UUID()
    let content: Content
    let isFromUser: Bool
}

struct MessageListView: View {
    @Binding var messages: [ChatMessage]
    
    var isInputFocused: FocusState<Bool>.Binding
    @Binding var task: String
    @Binding var tasks: [Task]

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(messages) { message in
                        ChatMessageView(message: message, task: $task, tasks: $tasks)
                    }
                    Color.clear.frame(height: 1).id("bottom")
                }
                .padding()
                
            }
            .onChange(of: messages.count) { _ in
                withAnimation {
                    proxy.scrollTo("bottom", anchor: .bottom)
                }
            }
            .onChange(of: isInputFocused.wrappedValue) { newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation {
                            proxy.scrollTo("bottom", anchor: .bottom)
                        }
                    }
                }
            }
        }
    }
}

    



