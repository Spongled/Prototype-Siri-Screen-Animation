//
//  PhoneBackground.swift
//  SiriAnimationPrototype
//
//  Created by Siddhant Mehta on 2024-06-13.
//

import SwiftUI

struct PhoneBackground: View {
    @Binding var state: ContentView.SiriState
    @Binding var origin: CGPoint
    @Binding var counter: Int
    
    private var scrimOpacity: Double {
        return 0 // Always transparent
    }
    
    private var iconName: String {
        switch state {
        case .none:
            "mic"
        case .thinking:
            "pause"
        }
    }

    var body: some View {
        ZStack {
            Image("quiz-background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaleEffect(1.2) // avoids clipping
                .ignoresSafeArea()
            
            Rectangle()
                .fill(Color.black)
                .opacity(scrimOpacity)
                .scaleEffect(1.2) // avoids clipping
            
            VStack(spacing: 32) {
                Spacer()
                
                welcomeText
                    .frame(maxHeight: .infinity, alignment: .bottom)
                
                siriButtonView
                
                Spacer()
                    .frame(height: 100)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    private var welcomeText: some View {
        Text("Where is the Eiffel Tower located?")
            .foregroundStyle(Color.white)
            .frame(maxWidth: 240)
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .fontWeight(.bold)
            .animation(.easeInOut(duration: 0.2), value: state)
            .contentTransition(.opacity)
    }
    
    private var siriButtonView: some View {
        VStack(spacing: 12) {
            ForEach(["Paris, France", "London, UK", "New York, USA", "Tokyo, Japan"], id: \.self) { answer in
                Button {
                    withAnimation(.easeInOut(duration: 0.9)) {
                        switch state {
                        case .none:
                            state = .thinking
                        case .thinking:
                            state = .none
                        }
                    }
                } label: {
                    Text(answer)
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 20, weight: .semibold))
                        .background(
                            RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                .fill(Color.gray.opacity(0.2))
                        )
                }
                .buttonStyle(.plain) // This removes the default button press animation
            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    PhoneBackground(
        state: .constant(.none),
        origin: .constant(CGPoint(x: 0.5, y: 0.5)),
        counter: .constant(0)
    )
    .previewLayout(.sizeThatFits)
}
