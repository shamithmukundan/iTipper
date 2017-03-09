//
//  String+Additions.swift
//  iTipper
//
//  Created by Shamith Mukundan on 3/8/17.
//  Copyright © 2017 Shamith. All rights reserved.
//

import Foundation

extension String {
    public var description: String { return self }
    
    func trimmed(_ characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return self.trimmingCharacters(in: characterSet)
    }
}
