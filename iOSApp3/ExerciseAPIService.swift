//
//  ExerciseAPIService.swift
//  ExerciseApp
//
//  Created by Chris Goerk on 2025-02-19.
// 84dd5efc9amsh604ad34912c234ap11e182jsn200f44914c41

import Foundation

class ExerciseAPIService {
  private let apiKey = "84dd5efc9amsh604ad34912c234ap11e182jsn200f44914c41"
  private let apiHost = "exercisedb.p.rapidapi.com"

  func fetchExercises() async throws -> [Exercise] {
    let urlString = "https://exercisedb.p.rapidapi.com/exercises?limit=0&offset=0" // ✅ No limit
    return try await fetchFromAPI(urlString: urlString)
  }

  func searchExercises(query: String) async throws -> [Exercise] {
    let formattedQuery = query.lowercased()
    let urlString = "https://exercisedb.p.rapidapi.com/exercises/name/\(formattedQuery)"
    return try await fetchFromAPI(urlString: urlString)
  }

  func fetchExercisesByBodyPart(_ bodyPart: String) async throws -> [Exercise] {
    let formattedBodyPart = bodyPart.lowercased().replacingOccurrences(of: " ", with: "%20")
    let urlString = "https://exercisedb.p.rapidapi.com/exercises/bodyPart/\(formattedBodyPart)?limit=0"

    let exercises = try await fetchFromAPI(urlString: urlString)
    print("✅ Fetched \(exercises.count) exercises for body part: \(bodyPart)")
    return exercises
  }
  
  private func fetchFromAPI(urlString: String) async throws -> [Exercise] {
    guard let url = URL(string: urlString) else {
      throw URLError(.badURL)
    }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
    request.setValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")

    let (data, response) = try await URLSession.shared.data(for: request)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw URLError(.badServerResponse)
    }

    return try JSONDecoder().decode([Exercise].self, from: data)
  }
}
