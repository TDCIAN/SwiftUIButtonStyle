//
//  ContentView.swift
//  SwiftUIButtonStyle
//
//  Created by 김정민 on 1/24/25.
//

import SwiftUI

enum ButtonRank {
    case primary
    case secondary
    case tertiary
}

extension ButtonStyle where Self == CustomButtonStyle {
    static func custom(rank: ButtonRank = .primary) -> CustomButtonStyle {
        return CustomButtonStyle(rank: rank)
    }
}

struct CustomButtonStyle: ButtonStyle {
    
    let rank: ButtonRank
    
    init(rank: ButtonRank) {
        self.rank = rank
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
                if self.rank == .secondary {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.blue, lineWidth: 1.0)
                }
            }
    }
    
    private var width: CGFloat? {
        switch self.rank {
        case .primary, .secondary:
            return 360
        case .tertiary:
            return nil
        }
    }
    
    private var foregroundStyle: Color {
        switch self.rank {
        case .primary:
            return .white
        case .secondary, .tertiary:
            return .blue
        }
    }
    
    private var background: Color {
        switch self.rank {
        case .primary:
            return .blue
        case .secondary:
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
            .buttonStyle(.custom(rank: .secondary))
            
            Button("Tertiary") {
                
            }
            .buttonStyle(.custom(rank: .tertiary))
            
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
 1. Consistency and Reusablity:
 Button styles enable you to define a consistent look and feel across your app.
 You can create a custom button style once and apply it to multiple buttons, ensuring uniformity in design.
 
 2. Built-in State Handling
 SwiftUI's ButtonStyle protocol includes built-in handling of states like isPressed, simplifying the process of adding visual feedback (e.g., pressed states, hover effects on macOS).
 
 Without ButtonSTyle: You might need to manually handle state changes with modifiers, making the implementation more complex and error-prone.
 
 3. Declaraitive Syntax
 Button styles align with SwiftUI's declaritive programming paradigm, making your code more readable and maintainable.
 
 Instead of embedding styling logic in every button instance, you separate concerns by encapsulating the style in a reusable structure.
 
 4. Easy Maintenance and Theming
 When you use custom button styles, updates to the button design are centralized.
 Changing the style in one place will automatically update all buttons that use it, which is especially useful when implementing app-wide themes or A/B tesing designs.
 
 5. Animation Simplications
 Animations for state changes, such as scaling or opacity adjustments, can be easily incorporated into ButtonStyle implementations.
 
 Alternative Methods and Why They Fall Short
 
 Custom View Components:
 These can be verbose and don't offer the built-in state handling and scalabilty of ButtonStyle.
 
 Custom Modifiers:
 While useful, modifiers don't encapsulate state management or provide the same level of reusability and cohesion as button styles.
 
 Custom Gestures:
 Using gestures can lead to more verbose and complex implementations that lack the semantic clarity and built-in accessibility support of ButtonStyle.
 
 */
