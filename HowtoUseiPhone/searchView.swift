import SwiftUI

struct searchView: View {
    @Binding var selectedTab : Int
    @Binding var task: String
    @State private var searchTextTop = ""
    @State private var searchTextBottom = ""
    @FocusState private var focusedField: Field?
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
                        TextField("検索", text: $searchTextTop);
                    }
                    .focused($focusedField, equals: .Top)
                    .onTapGesture {
                        focusedField = .Top
                    }
                }
                .padding(.horizontal)
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
            VStack{
                Spacer()
                    .frame(width: 0)
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
}

#Preview {
    searchView(selectedTab: .constant(2), task: .constant("タスクを選択しよう"))
}

