//
//  NotesFilesView.swift
//  MyNotesVault
//
//  Created by BSTAR on 10/08/2025.
//

import SwiftUI

struct NotesFilesView: View {
    
    var folderTitle: String?
    @ObservedObject var vm: NotesVaultViewModel
    @State var showFileInputSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 10, content: {
            ForEach(0..<5) { file in
                buildFileIcons(title: "This is File \(file)")
            }
            Spacer()
        })
        .padding(.top, 20)
        .navigationTitle(folderTitle ?? "")
        .toolbar {
            ToolbarItem(
                placement: .topBarTrailing) {
                    fabButton
                }
        }
    }
    
    // FAB
    var fabButton: some View {
        Button {
            showFileInputSheet.toggle()
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.black)
        }
        .sheet(isPresented: $showFileInputSheet) {
            buildFileInputSheet()
                .presentationDetents([.fraction(0.3)])
        }
    }
    
    // FOLDER INPUT SHEET
    func buildFileInputSheet() -> some View {
        ScrollView {
            VStack {
                
                Text("Enter File Name")
                    .font(.headline)
                    .padding(.top, 20)
                
                TextField("File name", text: $vm.noteText)
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
                    Text("Create File")
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
    func buildFileIcons(title: String) -> some View {
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
    NotesFilesView(
        vm: NotesVaultViewModel()
    )
}
