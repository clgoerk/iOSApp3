//
//  CustomPicker.swift
//  ExerciseApp
//
//  Created by Chris Goerk on 2025-02-19.
//

import SwiftUI

struct CustomPicker: View {
  @Binding var selectedBodyPart: String
  let bodyParts: [String]

  var body: some View {
    Menu {
      ForEach(bodyParts, id: \.self) { part in
        Button(action: { selectedBodyPart = part }) {
          Text(part)
        }
      }
    } label: {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.blue)
          .frame(height: 40)

        Text(selectedBodyPart.isEmpty ? "Select Muscle Group" : selectedBodyPart)
          .foregroundColor(.white)
          .font(.headline)
          .frame(maxWidth: .infinity, alignment: .center)

        HStack {
          Spacer()
          Image(systemName: "chevron.down")
            .foregroundColor(.white)
            .padding(.trailing, 10)
        }
      }
      .padding(.horizontal)
    }
  }
}

#Preview {
  @Previewable @State var previewSelectedBodyPart = "Chest"

  return CustomPicker(selectedBodyPart: $previewSelectedBodyPart, bodyParts: ["Chest", "Back", "Arms", "Legs", "Shoulders", "Abs"])
}
