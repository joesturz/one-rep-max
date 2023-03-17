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
    Chart {
      
    }
  }
}

struct WorkoutDetail_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutDetail(workout: testData[0])
  }
}
