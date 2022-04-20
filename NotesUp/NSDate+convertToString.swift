//
//  NSDate+convertToString.swift
//  NotesUp
//
//  Created by user196345 on 5/18/21.
//

import Foundation

extension Date {
  func convertToString() -> String {
    return DateFormatter.localizedString(from: self, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
  }
}
