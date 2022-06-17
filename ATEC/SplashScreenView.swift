//
//  LoadingScreenView.swift
//  ATEC
//
//  Created by bowtie on 10.06.2022.
//

import SwiftUI

struct SplashScreenView: View {
    // MARK: - PROPERTIES
    @State var startAnimation: Bool = false
    @Binding var endAnimation: Bool
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Color("SplashBG")
            
            LottieView(animationName: "loadingAnimation")
                .frame(width: 250, height: 250)
                .scaleEffect(endAnimation ? 0.15 : 0.9)
            
            VStack {
                Text("Powered by")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Text("Bowtie")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .foregroundColor(Color.white.opacity(0.8))
            .padding(.bottom, getSafeArea().bottom == 0 ? 15 : getSafeArea().bottom)
            .opacity(endAnimation ? 0 : 1)
        }
        .offset(y: endAnimation ? (-getRect().height * 1.5) : 0)
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(0.3)) {
                startAnimation.toggle()
            }
            
            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(1.6)) {
                endAnimation.toggle()
            }
        }
    }
}

// MARK: - PREVIEW
struct LoadingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
