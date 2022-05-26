//
//  NotificationQuestionPageView.swift
//  ATEC
//
//  Created by bowtie on 19.05.2022.
//

import SwiftUI

struct NotificationQuestionPageView: View {
    @AppStorage("isHeight") var isJack: Bool = false
    @AppStorage("isDiameter") var isKate: Bool = false
    @AppStorage("isMass") var isJohn: Bool = false
    @AppStorage("isPayload") var isKianu: Bool = false
    
    var body: some View {
        NavigationView {
            GroupBox {
                Text("Does s/he like to play with other kids?")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                
                Divider().padding(.vertical, 4)
                
                ScrollView(.vertical, showsIndicators: false) {
                    //MARK: - 1ST TOGGLE
                    HStack {
                        Text("Jack")
                        
                        Toggle(isOn: $isJack) {
                            if isJack {
                                Text("Yes".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.green)
                            } else {
                                Text("No".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.secondary)
                            }
                        }
                        .padding()
                        .background(
                            Color(UIColor.tertiarySystemBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    )
                    }
                    
                    //MARK: - 2ND TOGGLE
                    Toggle(isOn: $isKate) {
                        if isKate {
                            Text("Yes".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                        } else {
                            Text("No".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.secondary)
                        }
                    }
                    .padding()
                    .background(
                        Color(UIColor.tertiarySystemBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    )
                    
                    //MARK: - 3RD TOGGLE
                    Toggle(isOn: $isJohn) {
                        if isJohn {
                            Text("Yes".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                        } else {
                            Text("No".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.secondary)
                        }
                    }
                    .padding()
                    .background(
                        Color(UIColor.tertiarySystemBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    )
                    
                    //MARK: - 4TH TOGGLE
                    Toggle(isOn: $isKianu) {
                        Text("Kianu")
                            .fontWeight(.bold)
                        if isKianu {
                            Text("Yes".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                        } else {
                            Text("No".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.secondary)
                        }
                    }
                    .padding()
                    .background(
                        Color(UIColor.tertiarySystemBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    )
                }
            } //: BOX
            .padding()
            .navigationTitle("Daily Question")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NotificationQuestionPageView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationQuestionPageView()
    }
}
