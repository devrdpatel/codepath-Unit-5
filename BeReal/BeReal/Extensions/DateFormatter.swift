//
//  DateFormatter.swift
//  BeReal
//
//  Created by Dev Patel on 2/18/23.
//

import Foundation

extension DateFormatter {
    static var postFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
}
