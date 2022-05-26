//
//  PersonCardView.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

struct PersonPageView: View {
    //MARK: - PROPERTIES
    var photo: UIImage
    var name: String
    var age: String
    
    @AppStorage("isPlay") var isPlay: Bool = false
    @AppStorage("isDance") var isDance: Bool = false
    
    //MARK: - BODY
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Image(uiImage: photo)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 72, height: 72)
                    .clipShape(Circle())
                    .clipped()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(name)
                        .font(.title)
                    .fontWeight(.bold)
                    
                    Text(age + " years old")
                        .font(.body)
                        .foregroundColor(Color.secondary)
                }
                
                Spacer()
            } //: HSTACK
            .padding()
            
            Form {
                Section("Recent questions") {
                    Text("Does Jack like to play with other kids?")
                    Toggle(isOn: $isPlay) {
                        if isPlay {
                            Text("Yes".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                        } else {
                            Text("No".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.secondary)
                        }
                    }
                }
                Section {
                    Text("Does Jack like to dance?")
                    Toggle(isOn: $isDance) {
                        if isDance {
                            Text("Yes".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                        } else {
                            Text("No".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.secondary)
                        }
                    }
                }
            }
            
            Spacer()
        } //: VSTACK
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Person details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - PREVIEW
struct PersonCardView_Previews: PreviewProvider {
    static var previews: some View {
        PersonPageView(photo: UIImage(named: "avatarTemp1")!, name: "Jack", age: "13")
    }
}
