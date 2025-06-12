import SwiftUI
import TipKit

struct searchView: View {
    @Binding var selectedTab : Int
    @Binding var task: String
    @State private var searchTextTop = ""
    @State private var searchTextBottom = ""
    @FocusState private var focusedField: Field?
    @Binding var tasks: [Task]
    @State private var selectedImageName: String? = nil
    
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
                    .padding(.horizontal)
                TipView(AdvertisementTip(), arrowEdge: .bottom)
                    .padding(.horizontal)
                ScrollView{
                    Button(action:{
                        selectedImageName = "ImageSearchViewWoman"
                    }){
                        Image("ImageSearchViewWoman")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                            .padding()
                    }
                    Button(action:{
                        selectedImageName = "ImageSearchViewMan"
                    }){
                        Image("ImageSearchViewMan")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                    
                }
                
            }
            .task {
                try? Tips.configure([
                    .datastoreLocation(.applicationDefault)
                ])
                if task == "広告を削除しよう" && tasks[1].isDone == false{
                    AdvertisementTip.isTaskAdvertisement = true
                    try? Tips.resetDatastore()
                }else {
                    AdvertisementTip.isTaskAdvertisement = false
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
                    .padding(.horizontal)
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
                            .onSubmit {
                                if task == "文字を入れて検索しよう" {
                                    markTaskDone(with: task)
                                }
                            }
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
            if let imageName = selectedImageName {
                ZStack{
                    Color.black.opacity(0.6)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        ZStack(alignment: .topTrailing){
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 10)
                                .padding()
                                .padding(.top,150)
                            
                            Button(action: {
                                selectedImageName = nil
                                if task == "広告を削除しよう" {
                                    markTaskDone(with: task)
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(.black)
                                    .padding()
                                    .padding(.top,150)
                            }
                        }
                        TipView(CrossTip(), arrowEdge: .top)
                            .padding(.horizontal)
                    }
                    .task {
                        try? Tips.configure([
                            .datastoreLocation(.applicationDefault)
                        ])
                        if task == "広告を削除しよう" && tasks[1].isDone == false{
                            CrossTip.isCross = true
                            try? Tips.resetDatastore()
                        }else {
                           CrossTip.isCross = false
                        }
                    
                    }
                }
                .transition(.opacity)
                .zIndex(1)
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

