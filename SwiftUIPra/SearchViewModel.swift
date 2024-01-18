//
//  SearchViewModel.swift
//  SwiftUIPra
//
//  Created by 三浦　一真 on 2024/01/15.
//

// SearchViewModel.swift
import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [String] = []

    private var cancellables: Set<AnyCancellable> = []

    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.search(for: text)
            }
            .store(in: &cancellables)
    }

    private func search(for query: String) {
        // ここで実際の検索ロジックを追加
        // 例えば、API呼び出しやデータベースクエリを実行することがある
        // この例では、単純に文字列の配列を更新しています。
        searchResults = ["Result 1", "Result 2", "Result 3"] // 仮の結果例
    }
}


