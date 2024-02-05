//
//  SearchBar.swift
//  SwiftUIPra
//
//  Created by 三浦　一真 on 2024/01/16.
//

// SearchBar.swift
import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("検索", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)

            Button(action: {
                // 検索ボタンがタップされたときのアクションを追加することもできます
                // タップ時に検索処理を実行
                
            }) {
                Image(systemName: "magnifyingglass")
                    .imageScale(.medium)
                    .foregroundColor(.blue)
            }
            .padding(.leading, 8)
        }
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
