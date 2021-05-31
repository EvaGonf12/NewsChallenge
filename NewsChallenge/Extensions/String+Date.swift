//
//  String+Date.swift
//  NewsChallenge
//
//  Created by Eva Gonzalez Ferreira on 29/5/21.
//

import Foundation

private enum Defaults {
    static let defaultFormat = "dd MMM yyyy HH:mm"
    static let serverFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
}

extension String {
  func toDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Defaults.serverFormat
    return dateFormatter.date(from: self)
  }
}

extension Date {
  func toString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Defaults.defaultFormat
    return dateFormatter.string(from: self)
  }
}
