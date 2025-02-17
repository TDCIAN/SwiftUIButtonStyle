//
//  ContentView.swift
//  SwiftUIButtonStyle
//
//  Created by 김정민 on 1/24/25.
//

import SwiftUI

enum CustomStyle {
    case filled
    case outLined
    case tertiary
}

extension ButtonStyle where Self == CustomButtonStyle {
    static func custom(style: CustomStyle = .filled) -> CustomButtonStyle {
        return CustomButtonStyle(style: style)
    }
}

struct CustomButtonStyle: ButtonStyle {
    
    let style: CustomStyle
    
    init(style: CustomStyle) {
        self.style = style
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(self.foregroundStyle)
            .frame(width: self.width, height: 48)
            .background(self.background)
            .clipShape(.rect(cornerRadius: configuration.isPressed ? 4: 4))
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .overlay {
                if self.style == .outLined {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.blue, lineWidth: 1.0)
                }
            }
    }
    
    private var width: CGFloat? {
        switch self.style {
        case .filled, .outLined:
            return 360
        case .tertiary:
            return nil
        }
    }
    
    private var foregroundStyle: Color {
        switch self.style {
        case .filled:
            return .white
        case .outLined, .tertiary:
            return .blue
        }
    }
    
    private var background: Color {
        switch self.style {
        case .filled:
            return .blue
        case .outLined:
            return .white
        case .tertiary:
            return .clear
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .frame(width: 360, height: 48)
            .background(.blue)
            .clipShape(.rect(cornerRadius: 4))
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.blue)
            .frame(width: 360, height: 48)
            .background(.clear)
            .clipShape(.rect(cornerRadius: 4))
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.blue, lineWidth: 1.0)
            }
    }
}

struct TertiaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.blue)
            .frame(width: 360, height: 48)
            .background(.clear)
            .clipShape(.rect(cornerRadius: 4))
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.blue, lineWidth: 1.0)
            }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Primary") {
                
            }
            .buttonStyle(.custom())
            
            Button("Secondary") {
                
            }
            .buttonStyle(.custom(style: .outLined))
            
            Button("Tertiary") {
                
            }
            .buttonStyle(.custom(style: .tertiary))
            
            Button("Jared Style") {
                
            }
            .buttonStyle(.custom(variant: .default))
            
            Button("Jared Style") {
                
            }
            .buttonStyle(.custom(variant: .blank))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

/*
 1. 일관성과 재사용성:
 - 버튼 스타일을 사용하면 앱 전반에 걸쳐 일관된 디자인을 정의할 수 있습니다.
 - 한 번 커스텀 버튼 스타일을 생성한 후 여러 버튼에 적용하여 디자인의 통일성을 보장할 수 있습니다.
 1. Consistency and Reusablity:
 Button styles enable you to define a consistent look and feel across your app.
 You can create a custom button style once and apply it to multiple buttons, ensuring uniformity in design.
 
 2. 내장된 상태 관리
 - SwiftUI의 ButtonStyle 프로토콜은 'isPressed'와 같은 상태를 자동으로 처리하여, 눌림 효과나 macOS에서의 호버 효과를 쉽게 추가할 수 있습니다.
 - ButtonStyle 없이 구현할 경우, 상태 변화를 직접 수정자로 처리해야 하므로 구현이 복잡하고 오류 발생 가능성이 높아집니다.
 2. Built-in State Handling
 SwiftUI's ButtonStyle protocol includes built-in handling of states like isPressed, simplifying the process of adding visual feedback (e.g., pressed states, hover effects on macOS).
 
 Without ButtonSTyle: You might need to manually handle state changes with modifiers, making the implementation more complex and error-prone.

 3. 선언형 문법
 - 버튼 스타일은 SwiftUI의 선언형 프로그래밍 패러다임에 부합하여 코드의 가독성과 유지보수성을 높여줍니다.
 - 스타일링 로직을 각 버튼 인스턴스에 삽입하는 대신, 재사용 가능한 구조체로 캡슐화하여 관심사를 분리합니다.
 3. Declaraitive Syntax
 Button styles align with SwiftUI's declaritive programming paradigm, making your code more readable and maintainable.
 
 Instead of embedding styling logic in every button instance, you separate concerns by encapsulating the style in a reusable structure.
 
 4. 쉬운 유지보수 및 테마 적용
 - 커스텀 버튼 스타일을 사용하면 버튼 디자인 변경이 중앙화됩니다.
 - 하나의 스타일만 변경하면 해당 스타일을 사용하는 모든 버튼이 자동으로 업데이트되며, 앱 전반적인 테마 변경이나 A/B 테스트에 유용합니다.
 4. Easy Maintenance and Theming
 When you use custom button styles, updates to the button design are centralized.
 Changing the style in one place will automatically update all buttons that use it, which is especially useful when implementing app-wide themes or A/B tesing designs.
 
 5. 애니메이션 간소화
 - 상태 변화(예: 크기 조정, 투명도 조정)와 관련된 애니메이션을 ButtonStyle 구현에 쉽게 통합할 수 있습니다.
 5. Animation Simplications
 Animations for state changes, such as scaling or opacity adjustments, can be easily incorporated into ButtonStyle implementations.
 
 대체 방법 및 단점
 Alternative Methods and Why They Fall Short
 
 커스텀 뷰 컴포넌트:
 코드가 장황해질 수 있으며, ButtonStyle만큼 내장된 상태 관리나 확장성을 제공하지 못합니다.
 Custom View Components:
 These can be verbose and don't offer the built-in state handling and scalabilty of ButtonStyle.
 
 커스텀 수정자:
 유용하지만, 상태 관리 기능을 캡슐화하지 못하며 ButtonStyle만큼 재사용성과 응집력이 부족합니다.
 Custom Modifiers:
 While useful, modifiers don't encapsulate state management or provide the same level of reusability and cohesion as button styles.
 
 커스텀 제스처:
 구현이 더 장황하고 복잡하며, ButtonStyle이 제공하는 접근성 지원과 내장된 명확성이 부족합니다.
 Custom Gestures:
 Using gestures can lead to more verbose and complex implementations that lack the semantic clarity and built-in accessibility support of ButtonStyle.
 
 */
