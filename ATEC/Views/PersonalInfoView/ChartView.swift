//
//  ChartView.swift
//  ATEC
//
//  Created by bowtie on 09.06.2022.
//

import SwiftUI

struct ChartView: View {
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .foregroundColor(.cyan.opacity(0.2))
                .frame(height: 250)
        } //: ZSTACK
    }
}

// MARK: - PREVIEW
struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
