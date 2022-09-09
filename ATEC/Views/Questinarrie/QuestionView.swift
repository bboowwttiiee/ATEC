//
//  QuestionView.swift
//  ATEC
//
//  Created by bowtie on 07.07.2022.
//

import SwiftUI

struct QuestionView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var questionnaireManager: QuestionnaireManager
    @Binding var questionGroup: Int
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Text("\(questionGroup)st Group")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Spacer()
                Text("\(questionnaireManager.index + 1) out of \(questionnaireManager.length)")
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
            } //: HSTACK
            
            ProgressBar(progress: questionnaireManager.progress)
            
            VStack(alignment: .leading, spacing: 20) {
                Text(questionnaireManager.question)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.gray)
                
                HStack {
                    ForEach(questionnaireManager.answerChoices) { answer in
                        AnswerButton(answer: answer.isYes ? "Yes" : "No")
                            .environmentObject(questionnaireManager)
                    }
                } //: HSTACK
            } //: VSTACK
            
            Button {
                questionnaireManager.goToNextQuestion()
            } label: {
                Text("Next")
                    .font(.body.bold())
                    .foregroundColor(questionnaireManager.answerSelected ? .black : .gray)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color(UIColor.secondarySystemBackground))
                    )
            }
            .disabled(!questionnaireManager.answerSelected)
            
            Spacer()
        } //: VSTACK
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
    }
}

// MARK: - PREVIEW
struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(questionGroup: .constant(1))
            .environmentObject(QuestionnaireManager())
    }
}
