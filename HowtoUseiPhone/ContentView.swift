//
//  ContentView.swift
//  HowtoUseiPhone
//
//  Created by 牟禮優汰 on 2025/06/07.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    var body: some View {
        ZStack{
            VStack {
                TabView (selection: $selection){
                    homeView()
                        .tag(0)
                        .tabItem {
                            Image(systemName: "house")
                            Text("ホーム")
                                
                        }
                    searchView()
                        .tag(1)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("検索")
                        }
                    phoneView()
                        .tag(2)
                        .tabItem {
                            Image(systemName: "phone")
                            Text("電話")
                        }
                    messageView()
                        .tag(3)
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
        ContentView()
    }
