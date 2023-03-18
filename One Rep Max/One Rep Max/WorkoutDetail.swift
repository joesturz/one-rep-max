//
//  WorkoutDetail.swift
//  One Rep Max
//
//  Created by Joe Sturzenegger on 3/17/23.
//

import SwiftUI
import Charts

struct WorkoutDetail: View {
  var workout: Workout
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(workout.name).font(.title2).multilineTextAlignment(.leading)
        Spacer()
        Text("\(workout.getAverageOneRepMax())").font(.title).multilineTextAlignment(.trailing)
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
      Chart(workout.getOneRepMaxPerDay()) { item in
        LineMark(x: .value("Date", item.date),
                   y: .value("Weight", item.maxRep))
        .symbol(by: .value("Workout", workout.name))
      }
      .frame(minHeight: 100, maxHeight: 250)
      .chartYScale(domain: workout.getMinMaxOfMax().min - 20 ... workout.getMinMaxOfMax().max + 20 )
      .chartLegend(.hidden)
      Spacer()
    }
    .padding(.horizontal)
  }
}

struct WorkoutDetail_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutDetail(workout: testData[1])
  }
}
