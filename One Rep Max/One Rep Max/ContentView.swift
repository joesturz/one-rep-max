//
//  ContentView.swift
//  One Rep Max
//
//  Created by Joe Sturzenegger on 3/17/23.
//

import SwiftUI

struct ContentView: View {
  var workouts:[Workout] = []
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(workouts) { workout in
          WorkoutCell(workout: workout)
        }
      }.listStyle(.plain)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(workouts: testData2)
  }
}

struct WorkoutCell: View {
  var workout: Workout
  var body: some View {
    NavigationLink(destination: Text(workout.name)) {
      VStack(alignment: .leading) {
        HStack {
          Text(workout.name).font(.title2).multilineTextAlignment(.leading)
          Spacer()
          Text("\(workout.getAverageWeight())").font(.title).multilineTextAlignment(.trailing)
        }
        HStack(alignment: .center) {
          Text("One Rep Max")
            .font(.subheadline)
            .foregroundColor(.secondary)
          Text("•")
            .font(.subheadline)
            .foregroundColor(.secondary)
          Text("lbs")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
      }
    }
  }
}
