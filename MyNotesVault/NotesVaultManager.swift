//
//  NotesVaultManager.swift
//  MyNotesVault
//
//  Created by BSTAR on 10/08/2025.
//

import Foundation

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    init() {
        
    }
    
    func loadAllFolderContents(folderName: String) -> [String]? {
        guard let path = FileManager
            .default
            .urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first?
            .appendingPathComponent(folderName) else {
            
            return nil
        }
        
        do {
            var content = try FileManager.default.contentsOfDirectory(atPath: path.path())
            return content
        } catch let e {
            print("Error getting contents of folder \(e)")
            return []
        }
        
    }
    
    func createFolder(folderName: String) {
        guard let path = FileManager
            .default
            .urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first?
            .appendingPathComponent(folderName) else {
            
            return
        }
        
        if !FileManager.default.fileExists(atPath: path.path()) {
            do {
                try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true , attributes: nil)
            } catch let e {
                print("Error creating folder \(e)")
            }
        }
    }
    
    func deleteFolder(folderName: String) {
        guard let path = FileManager
            .default
            .urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first?
            .appendingPathComponent(folderName) else {
            
            return
        }
        
        if !FileManager.default.fileExists(atPath: path.path()) {
            do {
                try FileManager.default.removeItem(at: path)
            } catch let e {
                print("Error deleting folder \(e)")
            }
        }
    }
    
    func createFile(fileName: String, folderName: String, content: Data) {
        guard let path = FileManager
            .default
            .urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first?
            .appendingPathComponent(folderName)
            .appendingPathComponent("\(fileName).txt") else {
            return
        }
        
        let success = FileManager.default.createFile(atPath: path.path(), contents: content)
        
        if success {
            print("File Created Successfully!")
        } else {
            print("Error Creating File!")
        }
        
    }
    
    func deleteFile(fileName: String, folderName: String) {
        guard let path = FileManager
            .default
            .urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first?
            .appendingPathComponent(folderName)
            .appendingPathComponent("\(fileName).txt") else {
            return
        }
        
        do {
            try FileManager.default.removeItem(at: path)
        } catch let e {
            print("Error deleting file: \(e)")
        }
    }

    
}
