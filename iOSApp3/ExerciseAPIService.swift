//
//  ExerciseAPIService.swift
//  ExerciseApp
//
//  Created by Chris Goerk on 2025-02-19.
// 84dd5efc9amsh604ad34912c234ap11e182jsn200f44914c41

import Foundation

class ExerciseAPIService {
  private let apiKey = "91ef78fe02msh4ef3366c47cc325p17ea8ejsnebfcc37c70ac"
  private let apiHost = "exercisedb.p.rapidapi.com"

  func fetchExercises() async throws -> [Exercise] {
    let urlString = "https://exercisedb.p.rapidapi.com/exercises?limit=10&offset=0" 
    return try await fetchFromAPI(urlString: urlString)
  } // fetchExercise()

  func searchExercises(query: String) async throws -> [Exercise] {
    let formattedQuery = query.lowercased()
    let urlString = "https://exercisedb.p.rapidapi.com/exercises/name/\(formattedQuery)"
    return try await fetchFromAPI(urlString: urlString)
  } // searchExercise()

  func fetchExercisesByBodyPart(_ bodyPart: String) async throws -> [Exercise] {
    let formattedBodyPart = bodyPart.lowercased().replacingOccurrences(of: " ", with: "%20")
    let urlString = "https://exercisedb.p.rapidapi.com/exercises/bodyPart/\(formattedBodyPart)?limit=0"

    let exercises = try await fetchFromAPI(urlString: urlString)
    print("✅ Fetched \(exercises.count) exercises for body part: \(bodyPart)")
    return exercises
  } // fetchExerciseByBodyPart()
  
  private func fetchFromAPI(urlString: String) async throws -> [Exercise] {
    guard let url = URL(string: urlString) else {
      print("❌ Invalid URL: \(urlString)")
      throw URLError(.badURL)
    }

    print("🔗 Requesting: \(urlString)")

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
    request.setValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")

    do {
      let (data, response) = try await URLSession.shared.data(for: request)

      if let httpResponse = response as? HTTPURLResponse {
        print("📡 Response Code: \(httpResponse.statusCode)")

        if httpResponse.statusCode != 200 {
          let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
          print("❌ API Error: \(httpResponse.statusCode) - \(errorMessage)")
          throw URLError(.badServerResponse)
        }
      }

      do {
        return try JSONDecoder().decode([Exercise].self, from: data)
      } catch {
        print("❌ JSON Decoding Error: \(error)")
        throw error
      }
    } catch {
      print("❌ Network Request Failed: \(error.localizedDescription)")
      throw error
    }
  }
} // ExerciseAPIService
