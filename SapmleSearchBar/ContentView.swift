//
//  ContentView.swift
//  SapmleSearchBar
//
//  Created by 岩本 竜斗 on 2023/09/08.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    @State var hasFocus: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            SearchTextFieldWithAnimation(
                placeholder: "キーワードを入力してください",
                text: $text,
                hasFocus: $hasFocus,
                updateHandler: { _ in },
                commitHandler: { _ in }
            )
            
            Text(text)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
