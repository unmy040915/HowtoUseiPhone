import SwiftUI

struct homeView: View {
    @Binding var selectedTab : Int
    @State var task: String = "初期"
    var body: some View {
        ZStack{

            VStack{
                Text("クエスト一覧")
                    .font(.system(size:48))
                    .bold(true)
                List{
                    Section{
                        Button("文字を入れて検索しよう"){
                            selectedTab = 2
                            task="文字を入れて検索しよう"
                        }
                        .foregroundStyle(.black)
                            
                        Button("広告を削除しよう"){
                            selectedTab = 2
                        }
                        .foregroundStyle(.black)
                        Button("拡大・縮小しよう"){
                            selectedTab = 2
                        }
                        .foregroundStyle(.black)
                    } header:{
                        Text("調べ物")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                    Section{
                        Button("電話をかけよう"){
                            selectedTab = 3
                        }
                        .foregroundStyle(.black)
                        
                        Button("電話を取ろう"){
                            selectedTab = 3
                        }
                        .foregroundStyle(.black)
                        Button("電話を切ろう"){
                            selectedTab = 3
                        }
                        .foregroundStyle(.black)
                        
                    } header:{
                        Text("電話")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                    Section{
                        Button("メッセージを送信しよう"){
                            selectedTab = 4
                        }
                        .foregroundStyle(.black)
                        Button("画像を送信しよう"){
                            selectedTab = 4
                        }
                        .foregroundStyle(.black)
                        Button("画像の保存をしよう"){
                            selectedTab = 4
                        }
                        .foregroundStyle(.black)
                        Button("コピーアンドペーストをしよう"){
                            selectedTab = 4
                        }
                        .foregroundStyle(.black)
                        Button("文字の取り消し操作をしよう"){
                            selectedTab = 4
                        }
                        .foregroundStyle(.black)
                    } header:{
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
}

#Preview {
    homeView(selectedTab: .constant(1))
}
