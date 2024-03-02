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

                List(viewModel.searchResults, id: \.self) { result in
                    Text(result)
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle("曲を検索する")
        }.onAppear {
//            // ここで初期化やデータの取得などの関数を実行
//            self.viewModel.fetchAccessToken(clientID: "afc5043bd1e14ab4b72728034eddb2b1", clientSecret: "ae8da7f4356c402aade099898e9f88dd") { accessToken in
//                DispatchQueue.main.async {
//                    if let accessToken = accessToken {
//                        print("取得したアクセストークン: \(accessToken)")
//                        // ここで取得したアクセストークンを使用する処理を行う
//                    } else {
//                        print("アクセストークンを取得できませんでした。")
//                    }
//                }
//            }

            //ここでアクセストークン使って検索処理を実行する
            let accessToken = "BQC3AbVyM1dXZa_S-LKNKhGlLWeO1xwUeBA9-94O75QsS64fCpyvn9BD0tFO9P4CPQ_69nX60BHGosYJKJWP0HNGRjq1HJy2L2x-7nesFvjUpZpdSQI"

            self.viewModel.searchSpotify(query: "Here Comes The Sun", type: "track", accessToken: accessToken) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                // JSONデータの処理
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    // ここで検索結果を処理
                    print(json)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
