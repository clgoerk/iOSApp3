//
//  ContentView.swift
//  ExerciseApp
//
//  Created by Chris Goerk on 2025-02-19.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        ExerciseListView()
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

#Preview {
  ContentView()
}
