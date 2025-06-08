//
//  phoneView.swift
//  HowtoUseiPhone
//
//  Created by 牟禮優汰 on 2025/06/07.
//

import SwiftUI

struct phoneView: View {
    @Binding var selectedTab : Int
    let names = ["山田太郎", "山田花子"]
    var body: some View {
        VStack(spacing:0){
            Text("次の試練")
                .font(.title)
            Text("クエスト名")
                .font(.system(size:32))
            VStack(alignment: .leading,spacing: 0){
                Text("連絡先")
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                    .padding(.leading, 20)
                    .bold()
                Divider()
                    .padding(.horizontal)
                    .padding(.top, 5)
                List{
                    Section{
                        ForEach(sortedNames, id: \.self) { name in
                            Text(name)
                        }
                    }header: {
                            Text("や")
                                .font(.title3)
                                .foregroundStyle(.gray)
                    }
                    
                    
                }
                .scrollContentBackground(.hidden)
                .background(Color.white)
                .listStyle(PlainListStyle())
                .listRowInsets(EdgeInsets())
                .padding(.trailing)
            }
        }
        
    }
    
    var sortedNames: [String] {
        names.sorted {
            $0.localizedStandardCompare($1) == .orderedAscending
        }
    }
}

#Preview {
    phoneView(selectedTab: .constant(3))
}
