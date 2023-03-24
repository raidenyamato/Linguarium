//
//  File.swift
//  Linguarium
//
//  Created by Raiden Yamato on 10.11.2022.
//

import Foundation

public enum Error: Swift.Error {
    case bundleNotFound(error: Swift.Error)
    case fileNotFound(name: String)
    case fileDecodingFailed(URL, Swift.Error)
    case fileSavingFailed(object: Codable, error: Swift.Error)
}
