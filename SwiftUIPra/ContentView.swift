//
//  ContentView.swift
//  SwiftUIPra
//
//  Created by 三浦　一真 on 2023/12/16.
//

import SwiftUI

// default
//struct ContentView: View {
//    var body: some View {
//        Text("Hello, world!")
//            .padding()
//    }
//}

// scroll sample
//struct ContentView: View {
//    let data = ["Test1", "Test2", "Test3", "Test4", "Test5", "Test6", "Test7", "Test8", "Test9", "Test10"]
//    var body: some View {
//        VStack{
//            Text("スクロール編").font(.title)
//            ScrollView{
//                ForEach(data, id: \.self){
//                    Text($0)
//                        .font(.title)
//                        .padding(40)
//                    Divider() //仕切り線
//                }
//            }
//
//            Spacer(minLength: 0)
//        }
//    }
//}

// navigate sample
//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            // destination: 遷移したいView名
//            NavigationLink(destination: SecondView()) {
//                Text("画面遷移") // ハイパーリンク的イメージ
//            }
//        }
//    }
//}

// 投稿画面 値渡し sample
//struct ContentView: View {
//    var body: some View {
//        NavigationView{
//            // 画面遷移
//            NavigationLink("画面遷移", destination: DetailView(item: "画面遷移した"))
//                .navigationBarTitle("選択画面")
//        }
//    }
//}
//
//struct DetailView: View {
//    let item: String
//
//    var body: some View {
//        Text(item)
//    }
//}

// シェア画面
struct ContentView: View {
    @State var name = ""
    @State var address = ""
// グラデーション背景色を定義
    let backGroundColor = LinearGradient(gradient: Gradient(colors: [Color.green, Color.mint]), startPoint: .bottom, endPoint: .top)
// テーブルの背景色を初期化
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
// 画面遷移の時に使用するbool値
       @State private var isPresented: Bool = false

    var body: some View {
        NavigationView {
            VStack{
                Form{
                    Section(header: Text("曲名を検索する").font(.custom("Canter-Bold", size: 14))){
                        TextField("曲名を入力してください", text: $name)
                    }
                    Section(header: Text("曲の好きなところを自由に書こう").font(.custom("Canter-Bold", size: 14))){
                        TextField("", text: $address)
                            .onTapGesture {
                                // textFieldタップ時の処理
                                // 連打対策したい 現在はできていない
                                isPresented = true
                            }
                            .fullScreenCover(isPresented: $isPresented) { //フルスクリーンの画面遷移
                                SearchView()
                            }
                    }
                }

                Spacer(minLength: 0)
//                Button("投稿する", action: {})
//                    .frame(maxWidth: .infinity, minHeight: 44.0)
//                    .background(Color.green.ignoresSafeArea(edges: .bottom))
//                    .foregroundColor(Color.white)
//                // OK
            }.background(backGroundColor) // Form
            .navigationTitle("曲をシェア")
            .font(.custom("Canter-Bold", size: 16))
            .navigationBarTitleDisplayMode(.inline) // .inline指定でデフォルトのnavigationControllerと同じ見た目になる
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {

                    } label: {
                        Text("キャンセル")
                            .font(.custom("Canter-Bold", size: 14))
                            .foregroundColor(.red)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {

                    } label: {
                        Text("投稿")
                            .font(.custom("Canter-Bold", size: 14))
                            .foregroundColor(.black)
                    }
                }
            }
        } // NavigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
