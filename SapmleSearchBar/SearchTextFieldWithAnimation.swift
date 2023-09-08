//
//  SearchTextFieldWithAnimation.swift
//  SapmleSearchBar
//
//  Created by 岩本 竜斗 on 2023/09/08.
//

import SwiftUI

struct SearchTextFieldWithAnimation: View {
    @Binding private var text: String
    private let placeholder: String
    private let updateHandler: (String) -> Void
    private let commitHandler: (String) -> Void
    private let clearButtonHandler: (() -> Void)?
    @Binding var hasFocus: Bool
    @FocusState private var isFocused: Bool
    
    var body: some View {
            HStack {
                icon
                textFields
                    .frame(height: 50)
                clearButton
            }
            .padding(.trailing, 4)
            .padding(.leading, 8)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.gray, lineWidth: 1)
                    .frame(minWidth: 50, minHeight: 50)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            hasFocus = true
                        }
                    }
                
            }
    }
    
    @ViewBuilder
    private var icon: some View {
        Image(systemName: "magnifyingglass")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 15, height: 15)
            .foregroundColor(.gray)
    }
    
    @ViewBuilder
    private var textFields: some View {
        if !hasFocus && text.isEmpty {
            EmptyView()
        } else {
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .onChange(of: isFocused) { newValue in hasFocus = newValue }
                .onChange(of: text) { newValue in updateHandler(newValue) }
                .onSubmit { commitHandler(text) }
                .submitLabel(.search)
                .frame(maxWidth: hasFocus || !text.isEmpty ? .infinity : 0)
        }
    }
    
    @ViewBuilder
    private var clearButton: some View {
        if !hasFocus && text.isEmpty {
            EmptyView()
        } else {
            Button {
                withAnimation {
                    text = ""
                }
                clearButtonHandler?()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.gray)
                    .padding(.trailing, 16)
            }
        }
    }
    
    init(
        placeholder: String = "",
        text: Binding<String>,
        hasFocus: Binding<Bool>,
        updateHandler: @escaping (String) -> Void,
        commitHandler: @escaping (String) -> Void,
        clearButtonHandler: (() -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self._hasFocus = hasFocus
        self.updateHandler = updateHandler
        self.commitHandler = commitHandler
        self.clearButtonHandler = clearButtonHandler
    }
}

struct SearchTextFieldWithAnimation_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextFieldWithAnimation(
            text: .constant(""),
            hasFocus: .constant(false),
            updateHandler: { _ in},
            commitHandler: { _ in}
        )
        .padding()
    }
}
