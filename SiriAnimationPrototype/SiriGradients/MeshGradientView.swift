//
//  MeshGradient.swift
//  SiriAnimationPrototype
//
//  Created by Siddhant Mehta on 2024-06-13.
//

import SwiftUI

struct MeshGradientView: View {
    @Binding var maskTimer: Float
    @Binding var gradientSpeed: Float

    var body: some View {
        MeshGradient(width: 3, height: 3, points: [
            .init(0, 0), .init(0.0, 0), .init(1, 0),
            
            [sinInRange(-0.8...(-0.2), offset: 0.439, timeScale: 0.142, t: maskTimer), sinInRange(0.3...0.7, offset: 3.42, timeScale: 0.384, t: maskTimer)],
            [sinInRange(0.1...0.8, offset: 0.239, timeScale: 0.054, t: maskTimer), sinInRange(0.2...0.8, offset: 5.21, timeScale: 0.142, t: maskTimer)],
            [sinInRange(1.0...1.5, offset: 0.939, timeScale: 0.054, t: maskTimer), sinInRange(0.4...0.8, offset: 0.25, timeScale: 0.242, t: maskTimer)],
            [sinInRange(-0.8...0.0, offset: 1.439, timeScale: 0.142, t: maskTimer), sinInRange(1.4...1.9, offset: 3.42, timeScale: 0.384, t: maskTimer)],
            [sinInRange(0.3...0.6, offset: 0.339, timeScale: 0.284, t: maskTimer), sinInRange(1.0...1.2, offset: 1.22, timeScale: 0.272, t: maskTimer)],
            [sinInRange(1.0...1.5, offset: 0.939, timeScale: 0.036, t: maskTimer), sinInRange(1.3...1.7, offset: 0.47, timeScale: 0.142, t: maskTimer)]
        ], colors: [
            Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.7),  // Pure white
            Color(red: 1.0, green: 0.98, blue: 0.94).opacity(0.6),  // Warm white
            Color(red: 0.98, green: 1.0, blue: 0.96).opacity(0.7),  // Cool white
            Color(red: 1.0, green: 0.96, blue: 0.90).opacity(0.6),  // Warm glow
            Color(red: 0.96, green: 1.0, blue: 0.94).opacity(0.7),  // Ethereal white
            Color(red: 1.0, green: 0.94, blue: 0.88).opacity(0.6),  // Warm light
            Color(red: 0.94, green: 1.0, blue: 0.92).opacity(0.7),  // Soft white
            Color(red: 1.0, green: 0.92, blue: 0.86).opacity(0.6),  // Warm accent
            Color(red: 0.92, green: 1.0, blue: 0.90).opacity(0.7)   // Pure glow
        ])
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                DispatchQueue.main.async {
                    maskTimer += gradientSpeed
                }
            }
        }
        .ignoresSafeArea()
    }

    private func sinInRange(_ range: ClosedRange<Float>, offset: Float, timeScale: Float, t: Float) -> Float {
        let amplitude = (range.upperBound - range.lowerBound) / 2
        let midPoint = (range.upperBound + range.lowerBound) / 2
        return midPoint + amplitude * sin(timeScale * t + offset)
    }
}

#Preview {
    MeshGradientView(maskTimer: .constant(0.0), gradientSpeed: .constant(0.05))
}
