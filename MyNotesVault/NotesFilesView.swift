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
    @State var showTextContentInputSheet: Bool = false
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 10, content: {
            ForEach(vm.notes, id: \.self) { file in
                buildFileIcons(title: file.description)
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
                    showFileInputSheet = false
                    showTextContentInputSheet = true
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
                .sheet(isPresented: $showTextContentInputSheet) {
                    buildContentInputSheet()
                        .toolbar {
                            ToolbarItem(
                                placement: .topBarLeading) {
                                    Button(action: {
                                        
                                    }) {
                                        Image(systemName: "xmark")
                                            .foregroundStyle(.white)
                                    }
                                }
                            
                            if isFocused && !vm.content.description.isEmpty {
                                ToolbarItem(
                                    placement: .topBarTrailing) {
                                        Button(role: .confirm) {
                                            vm.createFile(folderName: folderTitle ?? "")
                                        }
                                    }
                            }
                        }
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
    }
    
    // CONTENT INPUT SHEET
    @ViewBuilder
    func buildContentInputSheet() -> some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $vm.content)
                .frame(maxWidth: .infinity)
                .focused($isFocused)
                .textEditorStyle(.plain)
                .padding()
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
