//
//  Exercise.swift
//  ExerciseApp
//
//  Created by Chris Goerk on 2025-02-19.
//

struct Exercise: Identifiable, Codable {
  let id: String
  let name: String
  let bodyPart: String
  let equipment: String
  let target: String
  let gifUrl: String
  let instructions: [String]  // Change from String to [String]
}
