//
//  CustomTabBarView.swift
//  ATEC
//
//  Created by bowtie on 31.05.2022.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case peopleList = "person.crop.rectangle.stack"
    case settings = "gearshape"
}

struct CustomTabBarView: View {
    // MARK: - PROPERTIES
    @Binding var selectedTab: Tab
    private var filledImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = tab
                    }
                } label: {
                    Image(systemName: selectedTab == tab ? filledImage : tab.rawValue)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selectedTab == tab ? .blue : .gray)
                        .scaleEffect(selectedTab == tab ? 1.4 : 1.2)
                        .padding()
                }
            } //: LOOP
        } //: HSTACK
        .frame(height: 30)
        .padding(.bottom, 10)
        .padding([.horizontal, .top])
        .background {
            Color(UIColor.secondarySystemFill)
                .ignoresSafeArea()
        }
    }
}

// MARK: - PREVIEW
struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
