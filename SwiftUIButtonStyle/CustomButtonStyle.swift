//
//  CustomButtonStyle.swift
//  SwiftUIButtonStyle
//
//  Created by 김정민 on 2/3/25.
//

import Foundation
import SwiftUI

// based on: https://youtu.be/zFP1CJApEaE?si=lCaXZtAOediH42m8
struct Custom { }

extension Custom {
    
    enum ButtonVariant {
        case `default`
        case blank
    }
    
    struct ButtonStyle: SwiftUI.ButtonStyle {
        let variant: ButtonVariant
        
        func makeBody(configuration: Configuration) -> some View {
            ButtonContent(label: configuration.label, variant: variant)
            
        }
    }
}

extension Custom {
    struct ButtonContent<Label: View>: View {
        
        let label: Label
        let variant: ButtonVariant
        
        var body: some View {
            switch variant {
            case .default:
                label
                    .font(.title)
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
            case .blank:
                label
            }
        }
    }
}

extension ButtonStyle where Self == Custom.ButtonStyle {
    static func custom(variant: Custom.ButtonVariant) -> Self {
        .init(variant: variant)
    }
}
