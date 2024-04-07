//
//  Extensions.swift
//  MovieDBSwiftUI
//
//  Created by Muhammad Irfan on 07/04/2024.
//

import Foundation
import SwiftUI

struct ViewOnLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewOnLoadModifier(action: action))
    }
}
