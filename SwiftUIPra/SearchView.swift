//
//  SecondView.swift
//  SwiftUIPra
//
//  Created by 三浦　一真 on 2023/12/16.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel: SearchViewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .padding()

                List(viewModel.searchResults, id: \.self) { result in
                    Text(result)
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle("検索画面")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
