//
//  ProgressBar.swift
//  ATEC
//
//  Created by bowtie on 07.07.2022.
//

import SwiftUI

struct ProgressBar: View {
    // MARK: - PROPERTIES
    var progress: CGFloat
    
    // MARK: - PROPERTIES
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(maxWidth: (UIScreen.main.bounds.width - 30), maxHeight: 4)
                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
                .cornerRadius(10)
            
            Rectangle()
                .frame(width: progress, height: 4)
                .foregroundColor(.green)
                .cornerRadius(10)
        } //: ZSTACK
    }
}

// MARK: - PREVIEW
struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: 50)
    }
}
