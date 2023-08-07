//
//  LoadingImageCard.swift
//  Concurrency_Ditto
//
//  Created by laptop MCO on 07/08/23.
//

import SwiftUI

struct LoadingImageCard: View {
    @State private var isLoading = false
    @State private var gradientStart = UnitPoint(x: -1, y: 0.5)
    @State private var gradientEnd = UnitPoint(x: 2, y: 0.5)
    
    var body: some View {
        // Shimmering effect overlay
        Circle()
        .fill(
            LinearGradient(
                gradient: Gradient(
                    colors: [Color.gray.opacity(0.5), Color.gray.opacity(0.2), Color.gray.opacity(0.5)]),
                startPoint: gradientStart,
                endPoint: gradientEnd
            )
        )
        .frame(width: 100, height: 100)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false)) {
                gradientStart = UnitPoint(x: 2, y: 0.5)
                gradientEnd = UnitPoint(x: -1, y: 0.5)
            }
        }
    }
}


struct LoadingImageCard_Previews: PreviewProvider {
    static var previews: some View {
        LoadingImageCard()
    }
}
