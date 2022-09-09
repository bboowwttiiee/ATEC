//
//  OnboardingView.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTIES
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @State private var selectedTab = 0
    
    // MARK: - BODY
    var body: some View {
        TabView(selection: $selectedTab) {
            OnboardingContentView(image: "kid", text: "ARI’s Diagnostic Checklist, Form E-2, was developed by Dr. Bernard Rimland to diagnose children with Kanner’s syndrome, which is also known as ‘classical autism.’ Many parents and professionals have also used the E-2 checklist to assist in the diagnosis of autism spectrum disorder (ASD).", buttonLabel: "Next") {
                withAnimation {
                    selectedTab = 1
                }
            }
            .tag(0)
            
            OnboardingContentView(image: "autism", text: "The Form E-2 checklist also asks parents to rate the effectiveness of various interventions they have tried on their son/daughter. Information on the effectiveness of interventions is compiled on a regular basis and the resulting Parent Ratings of Behavorial Effects of Biomedical Interventions are shared with families and professionals throughout the world.", buttonLabel: "Next") {
                withAnimation {
                    selectedTab = 2
                }
            }
            .tag(1)
            
            OnboardingContentView(image: "diagnostics", text: "Form E-2 is available on request in English. Our files contain information on over 40,000 children from more than 60 countries. Our service to researchers depends in part on our having a comprehensive bank of up-to-date information about children with these severe disorders. Your help in completing the E-2 checklist and submitting them to ARI will be greatly appreciated.", buttonLabel: "Next") {
                withAnimation {
                    isOnboarding = false
                }
            }
            .tag(2)
        } //: TAB
        .tabViewStyle(.page(indexDisplayMode: .never))
        .padding(.vertical, 20)
    }
}

// MARK: - PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
