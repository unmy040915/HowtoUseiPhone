
import SwiftUI

struct ContentView: View {
    @State var selectedTab: Int = 0
    @State var task = "タスクを選択しよう"
    @State var tasks: [Task] = [
        Task(title: "文字を入れて検索しよう", isDone: false),
        Task(title: "広告を削除しよう", isDone: false),
        Task(title: "拡大縮小しよう", isDone: false)
    ]
    var body: some View {
        ZStack{
            VStack {
                TabView (selection: $selectedTab){
                    homeView(selectedTab: $selectedTab, task: $task, tasks: $tasks)
                        .tag(1)
                        .tabItem {
                            Image(systemName: "house")
                            Text("ホーム")
                        }
                    searchView(selectedTab: $selectedTab, task: $task, tasks: $tasks)
                        .tag(2)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("検索")
                        }
                    phoneView(selectedTab: $selectedTab, task: $task)
                        .tag(3)
                        .tabItem {
                            Image(systemName: "phone")
                            Text("電話")
                        }
                    messageView(selectedTab: $selectedTab, task: $task)
                        .tag(4)
                        .tabItem {
                            Image(systemName: "message")
                            Text("メッセージ")
                        }
                }
            }
        }
    }
}

    
#Preview {
    StatefulPreviewWrapper("広告を削除しよう") { task in
        ContentView()
    }
}

