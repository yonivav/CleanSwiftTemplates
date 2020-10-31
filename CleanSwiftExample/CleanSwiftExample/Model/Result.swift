//
//  Result.swift
//  CleanSwiftExample
//
//  Created by Yoni Vizel on 10/31/20.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

