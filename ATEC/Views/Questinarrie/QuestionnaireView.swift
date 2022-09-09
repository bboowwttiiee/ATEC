//
//  QuestionnaireView.swift
//  ATEC
//
//  Created by bowtie on 22.06.2022.
//

import SwiftUI

struct QuestionnaireView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var questionnaireManager: QuestionnaireManager
    var person: Person
    @State private var questionGroup: Int = 1
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "xmark").font(.title2)
                }
            }
            .padding(.trailing)
            
            if questionnaireManager.reachedEnd {
                VStack(spacing: 20) {
                    Text("You completed the \(questionGroup)st group of questions.")
                    
                    Text("Your 'yes' answers are \(questionnaireManager.score) out of \(questionnaireManager.length).")
                    
                    Text("Press the button below to continue the questionnaire.")
                    
                    Button {
                        if questionGroup <= 1 {
                            questionnaireManager.fetchQuestionnaire(forGroup: questionGroup)
                            questionGroup += 1
                        } else {
                            saveScores(forThis: person)
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text(questionGroup == 2 ? "End Questionnaire" : "Next Group")
                            .font(.body.bold())
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color(UIColor.secondarySystemBackground))
                            )
                    }
                } //: VSTACK
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                QuestionView(questionGroup: $questionGroup)
                    .environmentObject(questionnaireManager)
            }
        }
    }
    
    private func saveScores(forThis: Person) {
        let thisPerson = forThis
        
        do {
            thisPerson.scores = Int16(questionnaireManager.score)
            
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - PREVIEW
struct QuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView(person: Person())
            .environmentObject(QuestionnaireManager())
    }
}
