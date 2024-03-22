//
//  ContentView.swift
//  StudySwiftUI
//
//  Created by Shuraw on 3/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var curTab: Tab = .home
    
    init() {
        UITabBar.appearance().isHidden = true // 기본 탭바 삭제
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView(selection: $curTab) {
                Text("홈뷰").tag(Tab.home)
                Text("게시판뷰").tag(Tab.forum)
                Text("스터디뷰").tag(Tab.study)
                Text("프로필뷰").tag(Tab.profile)
            }
//            .toolbar(.hidden, for: .tabBar) // 다른 곳에서 탭바를 쓴다면 이렇게 개별로 hidden 해줄 수 있다.
            
            CustomTapView(curTab: $curTab)
        }
    }
}

#Preview {
    ContentView()
}
