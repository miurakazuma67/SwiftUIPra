//
//  LoadingView.swift
//  SwiftUIPra
//
//  Created by 三浦　一真 on 2024/01/15.
//
// link: https://qiita.com/MilanistaDev/items/fce3987b02a284f5112a
// progressView: インジケーター表示時に使用(iOS14から使用可能)


import SwiftUI

/// ローディング画面を出すViewModifier
struct LoadingViewModifier: ViewModifier {
    var isRefreshing: Bool //ローディング中かどうか

    func body(content: Content) -> some View {
        ZStack {
            content
                .allowsHitTesting(!isRefreshing)

            if isRefreshing {
                ProgressView {
                    Text("Loading...")
                }
            }
        }
    }
}
