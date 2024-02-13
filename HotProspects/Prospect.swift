//
//  Prospect.swift
//  HotProspects
//
//  Created by Arpit Srivastava on 12/02/24.
//

import SwiftData

@Model
class Prospect {
    let name: String
    let email: String
    var isContacted: Bool

    init(name: String, email: String, isContacted: Bool) {
        self.name = name
        self.email = email
        self.isContacted = isContacted
    }
}
