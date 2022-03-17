//
//  extensions.swift
//  Netflix
//
//  Created by Amirkhouzam on 15/03/2022.
//

import UIKit

extension String {

    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890-().")
        return self.filter {okayChars.contains($0) }
    }
}
