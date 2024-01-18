//
//  View+.swift
//  SwiftUIPra
//
//  Created by 三浦　一真 on 2024/01/15.
// 通信中にインジケータ表示を行う関数

import SwiftUI

extension View {
    /// 通信中にProgressViewを表示
    /// - Parameters:
    ///   - isRefreshing: 通信中か
    /// - Returns: ローディング画面
    func loading(isRefreshing: Bool, safeAreaEdges: Edge.Set = []) -> some View {
        modifier(LoadingViewModifier(isRefreshing: isRefreshing))
    }
}

// 使用方法
//struct TopListView: View {
//    @StateObject private var topListVM = TopListViewModel()
//
//    var body: some View {
//        NavigationView {
//            List(topListVM.eventData) { event in
//                NavigationLink(destination: EventDetailView(eventData: event)) {
//                    EventRowView(eventData: event)
//                }
//            }
//            .navigationBarTitle(Text("一覧"))
//            .loading(isRefreshing: topListVM.isShowIndicator) //ここ
//        }
//    }
//}
