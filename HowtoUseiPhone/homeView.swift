import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool
}

struct homeView: View {
    @Binding var selectedTab : Int
    @Binding var task: String
    @Binding var tasks: [Task] 
    
    @State var callTasks: [Task] = [
        Task(title: "電話をかけよう", isDone: false),
        Task(title: "電話を取ろう", isDone: false),
        Task(title: "電話を切ろう", isDone: false)
    ]
    
    @State var messageTasks: [Task] = [
        Task(title: "メッセージを送信しよう", isDone: false),
        Task(title: "画像を送信しよう", isDone: false),
        Task(title: "画像の保存をしよう", isDone: false),
        Task(title: "コピーアンドペーストをしよう", isDone: false),
        Task(title: "文字の取り消し操作をしよう", isDone: false)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                Text("クエスト一覧")
                    .font(.system(size: 48))
                    .bold(true)
                
                List {
                    // 調べ物セクション
                    Section {
                        ForEach($tasks) { $task in
                            taskButton(task: $task, selectedTab: 2)
                        }
                    } header: {
                        Text("調べ物")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                    
                    // 電話セクション
                    Section {
                        ForEach($callTasks) { $task in
                            taskButton(task: $task, selectedTab: 3)
                        }
                    } header: {
                        Text("電話")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                    
                    // メッセージセクション
                    Section {
                        ForEach($messageTasks) { $task in
                            taskButton(task: $task, selectedTab: 4)
                        }
                    } header: {
                        Text("メッセージ")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.white)
            }
        }
    }

    // 共通のボタン表示ビュー
    @ViewBuilder
    private func taskButton(task: Binding<Task>, selectedTab: Int) -> some View {
        Button(action: {
            self.selectedTab = selectedTab
            self.task = task.wrappedValue.title
        }) {
            HStack {
                if task.wrappedValue.isDone {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 20, height: 20)
                            .overlay(
                                Circle().stroke(Color.black, lineWidth: 2)
                            )
                        Circle()
                            .fill(Color.black)
                            .frame(width: 15, height: 15)
                    }
                } else {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle().stroke(Color.black, lineWidth: 2)
                        )
                }
                Text(task.wrappedValue.title)
                    .foregroundStyle(.black)
            }
        }
    }
}



#Preview {
    homeView(selectedTab: .constant(1), task: .constant(.init()), tasks: .constant([]))
}
