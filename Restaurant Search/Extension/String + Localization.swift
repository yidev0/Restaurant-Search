//
//  String + Localization.swift
//  Restaurant Search
//
//  Created by Yuto on 2023/07/03.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
