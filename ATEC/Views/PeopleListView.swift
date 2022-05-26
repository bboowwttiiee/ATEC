//
//  PeopleListView.swift
//  ATEC
//
//  Created by bowtie on 19.05.2022.
//

import SwiftUI

struct PeopleListView: View {
    //MARK: - PROPERTIES
    @State private var isShowingSettings: Bool = false
    @State private var avatar: UIImage = UIImage(named: randomAvatarTemp())!
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Person.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var allPersons: FetchedResults<Person>
    
    private func deletePerson(at offset: IndexSet) {
        offset.forEach { index in
            let person = allPersons[index]
            viewContext.delete(person)
            
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(allPersons) { person in
                        let personAvatar = UIImage(data: person.avatar! as Data)
                        NavigationLink {
                            PersonPageView(photo: personAvatar!, name: person.name ?? "", age: "\(calculateAge(fromDate: person.birthdate ?? Date()))")
                        } label: {
                            PersonRowView(photo: personAvatar!, name: person.name ?? "", age: "\(calculateAge(fromDate: person.birthdate ?? Date()))y")
                        }
                    } //: LOOP
                    .onDelete(perform: deletePerson)
                } //: LIST
                .listStyle(.insetGrouped)
                .navigationTitle("People List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isShowingSettings = true
                        }) {
                            Image(systemName: "plus.circle")
                        } //: BUTTON
                        .sheet(isPresented: $isShowingSettings) {
                            AddPersonPageView()
                        }
                    }
                }
                if allPersons.isEmpty {
                    VStack {
                        Text("Add new person")
                        
                        HStack {
                            Text("by clicking")
                            Image(systemName: "plus.circle")
                            Text("button.")
                        }
                    }
                    .font(.body.italic())
                    .opacity(0.25)
                    .offset(y: -30)
                }
            } //: TOOLBAR
        } //: NAVIGATION
    }
}

//MARK: - PREVIEW
struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        let persistedContainer = CoreDataManager.shared.persistentContainer
        
        PeopleListView()
            .environment(\.managedObjectContext, persistedContainer.viewContext)
    }
}
