//
//  ViewModifiers.swift
//  FindMyIP
//
//  Created by Sneha Kalariya on 2024-01-26.
//

import Foundation
import SwiftUI
//MARK: - View Modifier SectionModifier
struct SectionModifier : ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.blue)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 2)
            )
    }
}
//MARK: - View Modifier WhiteBoldText
struct WhiteBoldText : ViewModifier{
    func body(content: Content) -> some View {
        content
            .fontWeight(.bold)
            .foregroundColor(.white)
            .font(.system(size: 20))
    }
}
//MARK: - View Modifier WhiteTitleText
struct WhiteTitleText : ViewModifier{
    func body(content: Content) -> some View {
        content
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .font(.system(size: 16))
    }
}
//MARK: - View Modifier DetailText
struct DetailText : ViewModifier{
    func body(content: Content) -> some View {
        content
            .fontWeight(.regular)
            .foregroundColor(.white)
            .font(.system(size: 16))
    }
}
