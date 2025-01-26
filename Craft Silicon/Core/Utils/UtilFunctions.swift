//
//  UtilFunctions.swift
//  Craft Silicon
//
//  Created by Gideon Rotich on 25/01/2025.
//

import Foundation
import SwiftUI

func formattedDate(for date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM, dd"
    return dateFormatter.string(from: date)
}

func convertTimestampToTime(_ timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: date)
}

func isTimestampNearCurrentTime(_ timestamp: Int) -> Bool {
    let currentTime = Date().timeIntervalSince1970
    let threshold: TimeInterval = 240 * 60
    let difference = abs(currentTime - TimeInterval(timestamp))
    return difference <= threshold
}

extension Date {
    func dayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
}

func getNextThreeDaysForecast(from list: [List]) -> [List] {
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    
    let groupedByDay = Dictionary(grouping: list) { data -> Date in
        let date = Date(timeIntervalSince1970: TimeInterval(data.dt))
        return calendar.startOfDay(for: date)
    }
    
    let sortedDays = groupedByDay.keys
        .filter { $0 > today }
        .sorted()
    
    let nextThreeDays = Array(sortedDays.prefix(3))
    
    var result: [List] = []
    for day in nextThreeDays {
        if let weatherData = groupedByDay[day] {
            let middleIndex = weatherData.count / 2
            result.append(weatherData[middleIndex])
        }
    }
    
    return result
}

func convertTimestampToDay(_ timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    return date.dayOfWeek()
}

struct SearchBar: View {

    @Binding var search: String

    @Environment(\.colorScheme) var colorScheme

    var isLigth: Bool {
        colorScheme == .light
    }

    var body: some View {
        HStack(spacing: 12) {

            HStack {

                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)

                TextField("Search", text: $search)
                    .textFieldStyle(PlainTextFieldStyle())


                if !search.isEmpty {
                    Button(action: {
                        search = ""
                    }, label: {
                        Image(systemName: "xmark.circle")
                    })
                    .buttonStyle(PlainButtonStyle())
                }

            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.white)
            .foregroundColor(Color.black)
            .cornerRadius(20)
            .shadow(color: (isLigth ? Color.black.opacity(0.1) : Color.white.opacity(0.2)), radius: 5, x: 5, y: 5)
            .shadow(color: (isLigth ? Color.black.opacity(0.1) : Color.white.opacity(0.2)), radius: 5, x: -1, y: -1)

        }

    }
}


struct LocationError: View {
    var body: some View {
        VStack {
            Image("out")
                .resizable()
                .frame(width: 250, height: 250)
                .padding(.top,30)
            VStack (alignment: .leading, spacing: 70) {
                Text("City not found, Kindly try again")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .foregroundColor(.white)
               
            }
            .padding(.top,18)
            .padding(.horizontal, 70)
            
        }
    }
}


 func getWeatherIcon(for description: String) -> String {
      switch description {
      case _ where description.contains("broken"):
          return "drop"
      case _ where description.contains("scattered"),
           _ where description.contains("rain"):
          return "drop"
      case _ where description.contains("few"):
          return "day"
      case _ where description.contains("clear"):
          return "dayone"
      default:
          return "app"
      }
  }
