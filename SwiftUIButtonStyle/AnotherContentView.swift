//
//  AnotherContentView.swift
//  SwiftUIButtonStyle
//
//  Created by 김정민 on 2/18/25.
//

import SwiftUI


struct InsetRoundButton: ButtonStyle {
    var textColor: Color = Color.white
    var backgroundColor: Color = Color.blue
    
    var disabledTextColor: Color = Color.gray
    var disabledBackgroundColor: Color = Color.yellow
    
    @Binding var disabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(
                self.disabled
                ? self.disabledTextColor
                : self.textColor
            )
            .padding(.horizontal, 50)
            .padding(.vertical, 13)
            .background(Capsule().fill(backgroundColor))
    }
}

struct AnotherContentView: View {
    
    @State private var disabled: Bool = false
    
    var body: some View {
        VStack {
            Button("InsetRoundButton") {
              print("tap button")
            }
            .buttonStyle(
                InsetRoundButton(
                    textColor: .white,
                    backgroundColor: .blue,
                    disabled: $disabled
                )
            )

        }
    }
}

#Preview {
    AnotherContentView()
}
