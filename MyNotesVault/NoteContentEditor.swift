//
//  NoteContentEditor.swift
//  MyNotesVault
//
//  Created by BSTAR on 11/08/2025.
//

import SwiftUI

struct NoteContentEditor: View {
    
    @FocusState private var isFocused: Bool
    @ObservedObject var vm: NotesVaultViewModel
    @Binding var showFileInputSheet: Bool
    var folderTitle: String?
    var fileName: String?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView(content: {
            VStack {
                ZStack(alignment: .topLeading) {
                    
                    ScrollView {
                        TextEditor(text: $vm.content)
                            .focused($isFocused)
                            .textEditorStyle(.plain)
                            .frame(minHeight: 200)
                            .padding(8)
                            .background(Color.clear)
                            .scrollContentBackground(.hidden)
                    }
                    
                    if vm.content.description.isEmpty && !isFocused {
                        Text("Enter file content here...")
                            .foregroundStyle(.gray)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 12)
                    }
                }
                .padding(20)
                
                Spacer()
            }
            .navigationTitle(fileName ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.glass)
                }
                
                if isFocused && !vm.content.description.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(role: .confirm) {
                            vm.createFile(folderName: folderTitle ?? "")
                            vm.noteText = ""
                            vm.folderText = ""
                            vm.loadAllFolderContent(folderName: folderTitle ?? "")
                            dismiss()
                        }
                    }
                }
            }
        })
        .onDisappear {
            isFocused = false
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    NoteContentEditor(
        vm: NotesVaultViewModel(),
        showFileInputSheet: .constant(false)
    )
}
