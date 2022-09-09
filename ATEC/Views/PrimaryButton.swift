//
//  PrimaryButton.swift
//  ATEC
//
//  Created by bowtie on 07.07.2022.
//

import SwiftUI

struct PrimaryButton: View {
    // MARK: - PROPERTIES
    var text: String
    var textColor: Color = Color("AccentColor")
    
    // MARK: - PROPERTIES
    var body: some View {
        Text(text)
            .font(.body.bold())
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color(UIColor.secondarySystemBackground))
            )
    }
}

// MARK: - PREVIEW
struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(text: "Next")
    }
}
