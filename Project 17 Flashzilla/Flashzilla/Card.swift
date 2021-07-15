//
//  Card.swift
//  Flashzilla
//
//  Created by Stefan Tadic on 4/29/21.
//

import Foundation


struct Card: Codable {
    let promt: String
    var answer: String

    static var example: Card {
        Card(promt: "Who played the 13th Doctor in Doctro Who?", answer: "Jodie Whittaker")
    }
}
