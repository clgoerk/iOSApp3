//
//  ExerciseViewModel.swift
//  ExerciseApp
//
//  Created by Chris Goerk on 2025-02-19.
//

import SwiftUI

class ExerciseViewModel: ObservableObject {
  @Published var exercises: [Exercise] = []
  @Published var searchText: String = ""
  @Published var selectedBodyPart: String = "All"

  private let apiService = ExerciseAPIService()

  func loadExercises() async {
    do {
      exercises = try await apiService.fetchExercises()
    } catch {
      print("❌ Failed to load exercises: \(error)")
    }
  } // loadExercises()

  func searchExercises() async {
    guard !searchText.isEmpty else { return }
    do {
      exercises = try await apiService.searchExercises(query: searchText)
    } catch {
      print("❌ Failed to search exercises: \(error)")
    }
  } // searchExercises()

  func filterByBodyPart() async {
    do {
      exercises = try await apiService.fetchExercisesByBodyPart(selectedBodyPart)
    } catch {
      print("❌ Failed to filter exercises: \(error)")
    }
  } // filterByBodyPart()
} // ExerciseViewModel
