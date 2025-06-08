import SwiftUI

struct homeView: View {
    var body: some View {
        ZStack{

            VStack{
                Text("クエスト一覧")
                    .font(.system(size:48))
                    .bold(true)
                List{
                    Section{
                        Text("文字を入れて検索しよう")
                        Text("広告を削除しよう")
                        Text("拡大・縮小しよう")
                    } header:{
                        Text("調べ物")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                    Section{
                        Text("電話をかけよう")
                        Text("電話を取ろう")
                        Text("電話を切ろう")
                        
                    } header:{
                        Text("電話")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                    Section{
                        Text("メッセージを送信しよう")
                        Text("画像を送信しよう")
                        Text("画像の保存をしよう")
                        Text("コピーアンドペーストをしよう")
                        Text("文字の取り消し操作をしよう")
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
    homeView()
}
