//
//  LoginView.swift
//  StudySwiftUI
//
//  Created by Shuraw on 3/22/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isUserLoggedIn = false
    
    var isValidEmail: Bool {
        isValid(regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    }
    
    func login() {
        isUserLoggedIn = isValidEmail
    }
    
    private func isValid(regex: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: email)
    }
}

struct LoginView: View {
    @StateObject private var loginVM = LoginViewModel() // SwiftUI 2.0, SwiftUI가 상태를 관리함

    var body: some View {
        VStack {
            Text("로그인을 해주세요").font(.largeTitle).bold()
            
            TextField("이메일을 입력해주세요", text: $loginVM.email)
                .roundedField()

            
            SecureField("비밀번호를 입력해주세요", text: $loginVM.password)
                .roundedField()
            
            Text("dddd")
            
            Button("로그인") {
                loginVM.login()
            }
            .disabled(!loginVM.isValidEmail)
        }
        .fullScreenCover(isPresented: $loginVM.isUserLoggedIn) {
            Text(loginVM.email)
        }
    }
}

struct LoginView2: View {
    @ObservedObject var loginVM = LoginViewModel() // SwiftUI 1.0 SwiftUI가 상태를 관리하지 않아서 뷰가 랜더링되면 갖고있던데이터를 다시 초기화함
    
    var body: some View {
        VStack {
            Text("로그인을 해주세요").font(.largeTitle).bold()
            
            TextField("이메일을 입력해주세요", text: $loginVM.email)
                .roundedField()

            
            SecureField("비밀번호를 입력해주세요", text: $loginVM.password)
                .roundedField()
            
            Button("로그인") {
                loginVM.login()
            }
            .disabled(!loginVM.isValidEmail)
        }
        .fullScreenCover(isPresented: $loginVM.isUserLoggedIn) {
            Text(loginVM.email)
        }
    }
}

struct LoginVC: View {
    @State private var isToggle = false
    
    var body: some View {
        VStack {
            Toggle("화면갱신용", isOn: $isToggle)
            
            LoginView()
            
            LoginView2()
        }
    }
}


extension View {
    func roundedField() -> some View {
        self
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 20).stroke()
            }
            .padding()
    }
}

#Preview {
    // ObservedObject를 사용할 때 화면갱신이 초기화되는걸 막음
//    @StateObject var loginVM = LoginViewModel()
//    LoginView(loginInfo: loginVM)
    
//    LoginView()
    
    
    LoginVC()
}
