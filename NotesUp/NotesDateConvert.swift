//
//  NotesDateConvert.swift
//  NotesUp
//
//  Created by user196345 on 5/18/21.
//

import Foundation

extension NSDate {
  func convertToString() -> String {
    return NSDateFormatter.localizedStringFromDate(self, dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
  }
}
