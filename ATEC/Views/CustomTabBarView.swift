//
//  CustomTabBarView.swift
//  ATEC
//
//  Created by bowtie on 31.05.2022.
//

import SwiftUI

struct CustomTabBarView: View {
    // MARK: - PROPERTIES
    @Binding var selectedTab: Tab
    @State var tabPoints: [CGFloat] = []
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabBarButton(image: tab, selectedTab: $selectedTab, tabPoints: $tabPoints)
            }
        } //: HSTACK
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.thinMaterial)
                .clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
        )
        .overlay {
            VStack {
                Circle()
                    .fill(.blue.opacity(0.8))
                    .frame(width: 10, height: 10)
                    .offset(x: getCurvePoint() - 20)
            }
            .frame(maxWidth: .infinity, maxHeight: 80, alignment: .bottomLeading)
        }
        .padding(.horizontal)
    }
    
    func getCurvePoint() -> CGFloat {
        if tabPoints.isEmpty {
            return 10
        } else {
            switch selectedTab {
            case .peopleList:
                return tabPoints.min() ?? 0
            case .settings:
                return tabPoints.max() ?? 0
            }
        }
    }
}

// MARK: - PREVIEW
struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabBarButton: View {
    var image: Tab
    @Binding var selectedTab: Tab
    @Binding var tabPoints: [CGFloat]
    
    var body: some View {
        GeometryReader { proxy -> AnyView in
            let midX = proxy.frame(in: .global).midX
            
            DispatchQueue.main.async {
                if tabPoints.count <= 2 {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
                Button {
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
                        selectedTab = image
                    }
                } label: {
                    Image(systemName: image.rawValue)
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(selectedTab == image ? .blue.opacity(0.8) : .gray.opacity(0.8))
                        .offset(y: selectedTab == image ? -10 : 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        .frame(height: 50)
    }
}
