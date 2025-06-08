//
//  messageView.swift
//  HowtoUseiPhone
//
//  Created by 牟禮優汰 on 2025/06/07.
//

import SwiftUI

struct messageView: View {
    @Binding var selectedTab : Int
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    messageView(selectedTab: .constant(4))
}
