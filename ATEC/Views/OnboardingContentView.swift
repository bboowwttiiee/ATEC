//
//  OnboardingContentView.swift
//  ATEC
//
//  Created by bowtie on 26.05.2022.
//

import SwiftUI

struct OnboardingContentView: View {
    // MARK: - PROPERTIES
    var image: String
    var text: String
    var buttonLabel: String
    var buttonAction: () -> ()
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 30) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
                .shadow(color: .black.opacity(0.08), radius: 5, x: -5, y: -5)
            
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            Spacer()
            Button(action: buttonAction) {
                Text(buttonLabel)
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(Color(UIColor.secondarySystemFill))
                    .cornerRadius(10)
            }
        } //: VSTACK
        .padding()
    }
}

// MARK: - PREVIEW
struct OnboardingContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
