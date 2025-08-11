//
//  NotesFolderView.swift
//  MyNotesVault
//
//  Created by BSTAR on 10/08/2025.
//

import SwiftUI

struct NotesFolderView: View {
    
    // VIEW MODEL
    @StateObject var vm = NotesVaultViewModel()
    
    // SHEETS
    @State var showFolderInputSheet: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(0..<5) { folder in
                    NavigationLink {
                        NotesFilesView(
                            folderTitle: "This is folder \(folder.description)",
                            vm: vm
                        )
                    } label: {
                        buildFolderIcons(title: "This is folder \(folder.description)")
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
            .navigationTitle("My Notes")
            .toolbar {
                ToolbarItem(
                    placement: .topBarTrailing) {
                        fabButton
                    }
            }
        }
    }
    
    // FAB
    var fabButton: some View {
        Button {
            showFolderInputSheet.toggle()
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.black)
        }
        .sheet(isPresented: $showFolderInputSheet) {
            buildFolderInputSheet()
                .presentationDetents([.fraction(0.3)])
        }
    }
    
    // FOLDER INPUT SHEET
    func buildFolderInputSheet() -> some View {
        ScrollView {
            VStack {
                
                Text("Enter Folder Name")
                    .font(.headline)
                    .padding(.top, 20)
                
                TextField("Folder name", text: $vm.folderText)
                    .padding(.vertical)
                    .padding(.leading)
                    .foregroundStyle(.black)
                    .background {
                        Color.gray.opacity(0.1)
                            .cornerRadius(50)
                    }
                    .padding(.bottom, 20)
                
                Button {
                    
                } label: {
                    Text("Create Folder")
                        .padding(.vertical, 15)
                        .foregroundStyle(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .background(
                            Color.blue
                                .cornerRadius(50)
                                .glassEffect(.regular)
                        )
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
    }
    
    // FOLDER ICONS
    func buildFolderIcons(title: String) -> some View {
        HStack(spacing: 5) {
            
            Image(systemName: "folder.fill")
                .foregroundStyle(.blue)
                .font(.title)
            
            Text(title)
                .foregroundStyle(.gray)
                .fontWeight(.medium)
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
}

#Preview {
    NotesFolderView()
}
