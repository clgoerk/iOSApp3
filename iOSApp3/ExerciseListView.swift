//
//  ExerciseListView.swift
//  ExerciseApp
//
//  Created by Chris Goerk on 2025-02-19.
//

import SwiftUI

struct ExerciseListView: View {
  @StateObject private var viewModel = ExerciseViewModel()

  let bodyParts = ["All", "Cardio", "Chest", "Back", "Lower Legs", "Upper Legs", "Lower Arms", "Upper Arms", "Shoulders", "Waist", "Neck"]

  var body: some View {
    NavigationView {
      VStack {
        // Search Bar
        TextField("Search exercises...", text: $viewModel.searchText)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
          .onSubmit {
            Task { await viewModel.searchExercises() }
          }

        // Picker to filter exercises by body part
        CustomPicker(selectedBodyPart: $viewModel.selectedBodyPart, bodyParts: bodyParts)
          .padding()
          .onChange(of: viewModel.selectedBodyPart) {
            Task { await viewModel.filterByBodyPart() }
          }

        // List of Exercises with Navigation to Detail View
        List(viewModel.exercises) { exercise in
          NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
            VStack(alignment: .leading) {
              Text(exercise.name) // Exercise name
                .font(.headline)
              Text("Target: \(exercise.target)") // Targeted muscle group
                .font(.subheadline)
                .foregroundColor(.gray)
            }
          }
        }
      }
      .navigationTitle("Exercises")
      .task {
        await viewModel.loadExercises()
      }
    }
  } // body
} // ExerciseListView

#Preview {
  ExerciseListView()
} // ExerciseListView_Previews
