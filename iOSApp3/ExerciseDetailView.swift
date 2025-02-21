//
//  ExerciseDetailView.swift
//  ExerciseApp
//
//  Created by Chris Goerk on 2025-02-19.
//

import SwiftUI

struct ExerciseDetailView: View {
  let exercise: Exercise

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        
        // Display exercise GIF or a placeholder image if unavailable
        if let gifURL = URL(string: exercise.gifUrl) {
          GIFWebView(url: gifURL)
            .frame(height: 200)
        } else {
          Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .frame(height: 200)
            .foregroundColor(.gray)
        }

        // Exercise Name
        Text(exercise.name)
          .font(.largeTitle)
          .fontWeight(.bold)

        // Targeted Muscle Group
        Text("Target: \(exercise.target)")
          .font(.title2)
          .foregroundColor(.blue)

        // Equipment Used
        Text("Equipment: \(exercise.equipment)")
          .font(.body)

        Divider()

        // Exercise Instructions
        if !exercise.instructions.isEmpty {
          Text("Instructions:")
            .font(.title2)
            .fontWeight(.semibold)
          ForEach(exercise.instructions, id: \.self) { step in
            Text("• \(step)")
              .font(.body)
              .padding(.bottom, 2)
          }
        }

        Spacer()
      }
      .padding()
      .navigationTitle(exercise.name)
    }
  } // body
} // ExerciseDetailView

#Preview {
  ExerciseDetailView(exercise: Exercise(
    id: "1",
    name: "Push-up",
    bodyPart: "Chest",
    equipment: "Body weight",
    target: "Pectorals",
    gifUrl: "https://example.com/image.gif",
    instructions: ["Start in a plank position.", "Lower your body.", "Push back up."]
  ))
} // ExerciseDetailView_Previews
