//
//  DateFormatterUtils.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import Foundation

class DateFormatterUtils {
    // MARK: - Shared Formatters

    /// A shared date formatter with the format "dd-MM-yyyy HH:mm:ss".
    static let shared: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return dateFormatter
    }()

    /// A shared date formatter with the short date format "dd/MM/yyyy".
    static let shortDateFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()

    /// A shared date formatter with the time format "HH:mm:ss".
    static let timeFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }()

    /// A shared date formatter with a custom format "yyyy-MM-dd'T'HH:mm:ssZ".
    static let customFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()

    // MARK: - Formatted Date Methods

    /// Formats a date from a timestamp using a specified format.
    static func formattedDate(from timestamp: Int, format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

    /// Formats the current date using a specified format.
    static func formattedCurrentDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }

    /// Formats a date from a timestamp using a specified style.
    static func formattedDateWithStyle(from timestamp: Int, style: DateFormatter.Style) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: date)
    }

    // MARK: - Additional Formatted Date Methods

    /// Formats a date in 12-hour format with AM/PM.
    static func formattedDate12Hour(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }

    /// Formats a date with 12-hour time, AM/PM, and abbreviated day of the week.
    static func formattedDateWithDay(from timestamp: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a E"
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
        return dateString
    }

    /// Formats a date with the full weekday name and day of the month.
    static func formattedDateWithWeekdayAndDay(from timestamp: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd"
        return dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
    }

    /// Formats a date with a custom date and time format.
    static func formattedDateTime(from timestamp: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy 'at' ha"
        return dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
    }
}
