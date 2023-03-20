//
//  DiscCaretaker.swift
//  Linguarium
//
//  Created by Raiden Yamato on 03.11.2022.
//

import Foundation

public final class DiskCaretaker {
    public static let decoder = JSONDecoder()
    public static let encoder = JSONEncoder()
    
    
    public static func save<T: Codable>(_ object: T, to fileName: String) throws {
        do {
            let url  = createDocumetURL(withFileName: fileName)
            let data = try encoder.encode(object)
            try data.write(to: url, options: .atomic)
        } catch (let error) {
            print("Save failed: Object: `\(object)`, Error: `\(error)`")
            throw Error.fileSavingFailed(object: object, error: error)
        }
    }
    
    public static func retrieve<T: Codable>(_ type: T.Type, from fileName: String) throws -> T {
        let url = createDocumetURL(withFileName: fileName)
        return try retrieve(T.self, from: url)
    }
    
    public static func retrieve<T: Codable>(_ type: T.Type, from url: URL) throws -> T {
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(T.self, from: data)
        } catch (let error) {
            print("Retrieve failed: URL: `\(url)`, Error: `\(error)`")
            throw Error.fileDecodingFailed(url, error)
        }
    }
    
    public static func createDocumetURL(withFileName fileName: String) -> URL {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return url.appendingPathComponent(fileName).appendingPathExtension("json")
    }
}

