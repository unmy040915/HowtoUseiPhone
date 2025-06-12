import SwiftUI
import TipKit
struct SearchTip: Tip {
    @Parameter static var isTaskSearch: Bool = false
    var title: Text{ Text("ここをタップして検索")
    }
    var rules: [Rule] {
            [
                #Rule(Self.$isTaskSearch) { $0 == true }
            ]
        }
}

struct searchView: View {
    @Binding var selectedTab : Int
    @Binding var task: String
    @State private var searchTextTop = ""
    @State private var searchTextBottom = ""
    @FocusState private var focusedField: Field?
    @Binding var tasks: [Task]

    var body: some View {
        ZStack{
            VStack{
                TaskView(task: $task)
                Image("google")
                    .resizable()
                    .scaledToFit()
                    .frame( height: 100)
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 239 / 255,
                                    green: 239 / 255,
                                    blue: 241 / 255))
                        .frame(height: 45)
                    HStack(spacing: 6) {
                        Spacer()
                            .frame(width: 0)
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("検索", text: $searchTextTop)
                            .submitLabel(.go)
                            .onSubmit {
                                if task == "文字を入れて検索しよう" {
                                            markTaskDone(with: task)
                                        }
                                            }
                    }
                    .focused($focusedField, equals: .Top)
                    .onTapGesture {
                        focusedField = .Top
                    }
                }
                .padding(.horizontal)
                TipView(SearchTip(), arrowEdge: .top)
                    .padding()
                ScrollView{
                    Image("ImageSearchViewWoman")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                        .padding()
                    Image("ImageSearchViewMan")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                
            }
            .task {
                        try? Tips.configure([
                            .datastoreLocation(.applicationDefault)
                        ])
                if task == "文字を入れて検索しよう" && tasks[0].isDone == false{
                        SearchTip.isTaskSearch = true
                    try? Tips.resetDatastore()
                    }else {
                        SearchTip.isTaskSearch = false 
                    }
                    }
            VStack{
                Spacer()
                    .frame(width: 0)
                
                TipView(SearchTip(), arrowEdge: .bottom)
                    .padding()
                ZStack{
                    Rectangle()
                        .fill(Color(red: 243 / 255, green: 243 / 255, blue: 243 / 255))
                        .frame(height: 65)
                    Rectangle()
                        .fill(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255))
                        .frame(width: 345,height: 45)
                        .cornerRadius(15)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("検索/webサイト名を入力", text: $searchTextBottom)
                            .foregroundColor(.black)
                            .focused($focusedField, equals: .Bottom)
                            .onTapGesture {
                                focusedField = .Bottom
                            }
                            .submitLabel(.go)
                        //検索/webサイト名を入力こいつを真ん中にしたい
                    }
                    .padding(.horizontal, 16) // 左右に余白を設定
                    .frame(width: 345, height: 45, alignment: .center)
                    .focused($focusedField, equals: .Bottom)
                    .onTapGesture {
                        focusedField = .Bottom
                    }
                }
            }
        }

        .contentShape(RoundedRectangle(cornerRadius: 10))
        .onTapGesture {
            focusedField = nil
        }
    }
    
    enum Field: Hashable {
        case Top
        case Bottom
    }
    func markTaskDone(with title: String) {
        if let index = tasks.firstIndex(where: { $0.title == title }) {
            tasks[index].isDone = true
        }
    }
}

#Preview {
    searchView(selectedTab: .constant(2), task: .constant("タスクを選択しよう"), tasks: .constant([]))
}

