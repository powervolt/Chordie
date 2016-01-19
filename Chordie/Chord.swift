//
//  Chord.swift
//  Chordie
//
//  Created by Budhathoki,Bipin on 10/29/15.
//  Copyright © 2015 Bipin Budhathoki. All rights reserved.
//

import Foundation

enum Note {
    case E
    case A
    case D
    case G
    case B
    case e
}

enum Octave {
    case first
    case second
    case third
    case fourth
}

struct chord {
    var names: [String]
    var notes: [(Note,Octave)]?
    
}