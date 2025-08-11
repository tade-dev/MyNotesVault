//
//  NotesVaultViewModel.swift
//  MyNotesVault
//
//  Created by BSTAR on 10/08/2025.
//

import Combine
import Foundation

class NotesVaultViewModel: ObservableObject {
    
    @Published var folderText: String = ""
    @Published var noteText: String = ""
    @Published var folders: [String] = []
    @Published var notes: [String] = []
    @Published var content = AttributedString()
    let manager = LocalFileManager.instance
    
    init() {
        loadAllFolders()
    }
    
    func loadAllFolderContent(folderName: String) {
        self.notes = manager.loadAllFolderContents(folderName: folderName) ?? []
    }
    
    func loadAllFolders() {
        self.folders = manager.loadAllContents() ?? []
    }
    
    func createFolder() {
        manager.createFolder(folderName: folderText)
        self.folders.append(folderText)
        self.folderText = ""
    }
    
    func deleteFolder(folderName: String) {
        manager.deleteFolder(folderName: folderName)
        if let index = self.folders.firstIndex(where: { folder in
            folder.lowercased().contains(folderName.lowercased())
        }) {
            self.folders.remove(at: index)
        }
    }
    
    func createFile(folderName: String) {
        let contentData = content.description.data(using: .utf8)
        manager.createFile(fileName: noteText, folderName: folderName, content: contentData!)
        self.content = ""
        self.noteText = ""
    }
    
    func deleteFile(fileName: String, folderName: String) {
        manager.deleteFile(fileName: fileName, folderName: folderName)
        if let index = self.notes.firstIndex(where: { note in
            note.lowercased().contains(fileName.lowercased())
        }) {
            self.notes.remove(at: index)
        }
    }
    
}
