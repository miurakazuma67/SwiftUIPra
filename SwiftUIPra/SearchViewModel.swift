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
                self?.search(for: text) // 検索ワードを渡し、検索処理を実行
            }
            .store(in: &cancellables)
    }

    ///検索時に実行されるメソッド
    private func search(for query: String) {
        // ここで実際の検索ロジックを追加
        // 例えば、API呼び出しやデータベースクエリを実行することがある
        // この例では、単純に文字列の配列を更新しています。
        searchResults = ["Result 1", "Result 2", "Result 3"] // 仮の結果例
        // 1.検索ワードを元に検索(api処理を実行)
        // 2.一致するデータを返し、配列に格納
        // 3.配列に格納したデータを表示
    }

    /// アクセストークンを取得
    func fetchAccessToken(clientID: String, clientSecret: String, completion: @escaping (String?) -> Void) {
        let credentials = "\(clientID):\(clientSecret)".data(using: .utf8)!.base64EncodedString()

        var request = URLRequest(url: URL(string: "https://accounts.spotify.com/api/token")!)
        request.httpMethod = "POST"
        request.addValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let accessToken = json["access_token"] as? String {
                completion(accessToken)
//                print(accessToken)
                print(request)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    /// 検索クエリとアクセストークンを使用してSpotifyで曲またはアーティストを検索する関数
    func searchSpotify(query: String, type: String, accessToken: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let env = try! LoadEnv()
        print(env.value("CLIENT_ID") ?? ".envからの値取得失敗")

        let urlEncodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.spotify.com/v1/search?q=\(urlEncodedQuery)&type=\(type)&limit=10"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }

    /// アクセストークンの再取得+再検索をする関数(必要かはわからない)
    func refreshTokenAndRetrySearch(query: String, type: String, clientID: String, clientSecret: String, originalCompletion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        // アクセストークンを再取得
        fetchAccessToken(clientID: clientID, clientSecret: clientSecret) { newAccessToken in
            DispatchQueue.main.async {
                if let newAccessToken = newAccessToken {
                    // indicatorを回す
                    // 新しいトークンを使用して検索を再試行
                    self.searchSpotify(query: query, type: type, accessToken: newAccessToken, completion: originalCompletion)
                } else {
                    // 新しいトークンの取得に失敗した場合の処理
                    print("新しいアクセストークンの取得に失敗しました。")
                }
            }
        }
    }


    /// リフレッシュトークンを使用したアクセストークンの更新
    func refreshToken(refreshToken: String, clientID: String, clientSecret: String, completion: @escaping (String?) -> Void) {
        let params = "grant_type=refresh_token&refresh_token=\(refreshToken)"
        let postData = params.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://accounts.spotify.com/api/token")!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let credentials = "\(clientID):\(clientSecret)".data(using: .utf8)!.base64EncodedString()
        request.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")

        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let newAccessToken = json["access_token"] as? String {
                completion(newAccessToken)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}


