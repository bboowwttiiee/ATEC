//
//  AnswerButton.swift
//  ATEC
//
//  Created by bowtie on 07.07.2022.
//

import SwiftUI

struct AnswerButton: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var questionnaireManager: QuestionnaireManager
    var answer: String
    @State private var isSelected = false
    
    // MARK: - PROPERTIES
    var body: some View {
        HStack {
            Text(answer)
                .font(.title2.bold())
        } //: HSTACK
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(questionnaireManager.answerSelected ? (isSelected ? Color("AccentColor") : .gray) : Color("AccentColor"))
        .background(questionnaireManager.answerSelected ? (isSelected ? .green : Color(UIColor.secondarySystemBackground)) : Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
        .onTapGesture {
            if !questionnaireManager.answerSelected {
                isSelected = true
                questionnaireManager.selectAnswer(answer: answer)
            }
        }
    }
}

// MARK: - PREVIEW
struct AnswerButton_Previews: PreviewProvider {
    static var previews: some View {
        AnswerButton(answer: "Yes")
            .environmentObject(QuestionnaireManager())
    }
}
