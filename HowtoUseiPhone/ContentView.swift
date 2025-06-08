//
//  ContentView.swift
//  HowtoUseiPhone
//
//  Created by 牟禮優汰 on 2025/06/07.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: Int = 0
    var body: some View {
        ZStack{
            VStack {
                TabView (selection: $selectedTab){
                    homeView(selectedTab: $selectedTab)
                        .tag(1)
                        .tabItem {
                            Image(systemName: "house")
                            Text("ホーム")
                                
                        }
                    searchView(selectedTab: $selectedTab)
                        .tag(2)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("検索")
                        }
                    phoneView(selectedTab: $selectedTab)
                        .tag(3)
                        .tabItem {
                            Image(systemName: "phone")
                            Text("電話")
                        }
                    messageView(selectedTab: $selectedTab)
                        .tag(4)
                        .tabItem {
                            Image(systemName: "message")
                            Text("メッセージ")
                        }
                }
            }
        }
        //メモ書きテスト
    }
}

    
    #Preview {
        ContentView()
    }
