//
//  EditPersonalInfoView.swift
//  ATEC
//
//  Created by bowtie on 09.06.2022.
//

import SwiftUI

struct EditPersonalInfoView: View {
    // MARK: - PROPERTIES
    var name: String
    var bd: Date
    var gender: Bool
    
    // MARK: - BODY
    var body: some View {
        List {
//            HStack {
//                Text("Username").bold()
//                Divider()
//                TextField("Name", text: $name)
//            }
//            
//            DatePicker(selection: $bd, in: ...Date(), displayedComponents: .date) {
//                Text("Birthdate").bold()
//            }
//            
//            Toggle(isOn: $gender) {
//                Text("Enable Notifications").bold()
//            }
        }
        .listStyle(.inset)
    }
}

// MARK: - PREVIEW
struct EditPersonalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EditPersonalInfoView(name: "Jack", bd: Date(), gender: true)
    }
}
