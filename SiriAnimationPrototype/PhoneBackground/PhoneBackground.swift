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
    @State private var selectedAnswer: String?
    
    private var scrimOpacity: Double {
        return 0 // Always transparent
    }
    
    private let answers = [
        ("Paris, France", true),
        ("London, UK", false),
        ("New York, USA", false),
        ("Tokyo, Japan", false)
    ]
    
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
                .scaleEffect(1.2)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .font(.system(size: 24, weight: .medium))
                    }
                    .buttonStyle(.plain)
                    .frame(width: 44)
                    
                    Text("Quiz Title")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                        Text("25")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 44, alignment: .trailing)
                }
                .padding(.horizontal)
                .padding(.top, 60)
                
                VStack(spacing: 20) {
                    // Question bubble
                    welcomeText
                    
                    // Answer buttons
                    siriButtonView
                }
                .padding(.top, 32)
                
                Spacer()
                
                // Reset button
                if selectedAnswer != nil {
                    Button {
                        withAnimation {
                            selectedAnswer = nil
                            state = .none
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .font(.system(size: 32))
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 40)
                }
            }
        }
    }
    
    @ViewBuilder
    private var welcomeText: some View {
        Text("Where is the Eiffel Tower located?")
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.vertical, 24)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .padding(.horizontal, 24)
    }
    
    private var siriButtonView: some View {
        VStack(spacing: 12) {
            ForEach(answers, id: \.0) { answer, isCorrect in
                Button {
                    selectedAnswer = answer
                    if isCorrect {
                        withAnimation(.easeInOut(duration: 0.9)) {
                            state = .thinking
                        }
                    }
                } label: {
                    Text(answer)
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                        .foregroundStyle(.white)
                        .font(.title3)
                        .fontWeight(.medium)
                        .background(
                            RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                        .fill(buttonColor(for: answer))
                                )
                        )
                }
                .buttonStyle(.plain)
                .disabled(selectedAnswer != nil)
            }
        }
        .padding(.horizontal, 24)
    }
    
    private func buttonColor(for answer: String) -> AnyShapeStyle {
        guard let selectedAnswer = selectedAnswer else {
            return AnyShapeStyle(.ultraThinMaterial)
        }
        
        if answer == selectedAnswer {
            if answers.first(where: { $0.0 == answer })?.1 == true {
                return AnyShapeStyle(.green)
            } else {
                return AnyShapeStyle(.red)
            }
        }
        
        return AnyShapeStyle(.ultraThinMaterial)
    }
}

#Preview {
    PhoneBackground(
        state: .constant(.none),
        origin: .constant(CGPoint(x: 0.5, y: 0.5)),
        counter: .constant(0)
    )
}
