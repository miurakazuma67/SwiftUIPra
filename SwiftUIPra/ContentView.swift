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
    @State var pass = ""
    @State var address = ""
    @State var tel = ""
    var body: some View {
        VStack{
            Text("曲の良さを投稿する").font(.title)
            Form{
                Section(header: Text("曲を検索する")){
                    TextField("曲名を入力してください", text: $name)
//                    SecureField("パスワードを入力してください", text: $pass)
                }
                Section(header: Text("曲の好きなところを自由に書こう")){
                    TextField("", text: $address)
//                    SecureField("電話番号", text: $tel)
                }
            }

            Spacer(minLength: 0)
            Button("投稿する", action: {})
                .frame(maxWidth: .infinity, minHeight: 44.0)
                .background(Color.green.ignoresSafeArea(edges: .bottom))
                .foregroundColor(Color.white)
            // OK
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
