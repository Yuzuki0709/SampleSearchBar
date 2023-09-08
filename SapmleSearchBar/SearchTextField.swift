//
//  SearchTextField.swift
//  SapmleSearchBar
//
//  Created by 岩本 竜斗 on 2023/09/08.
//

import SwiftUI

struct SearchTextField: View {
    enum IconType {
        case search
        case person
        case email
        case address
        
        var icon: Image {
            switch self {
            case .search : return Image(systemName: "magnifyingglass")
            case .person : return Image(systemName: "person")
            case .email  : return Image(systemName: "envelope")
            case .address: return Image(systemName: "location.fill")
            }
        }
    }
    
    private let iconType: IconType
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
                .frame(height: 52)
            
            clearButton
        }
        .padding(.trailing, 4)
        .padding(.leading, 8)
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(.gray, lineWidth: 1)
        }
    }
    
    private var icon: some View {
        iconType.icon
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(height: 15)
            .foregroundColor(.gray)
    }

    private var textFields: some View {
        TextField(placeholder, text: $text)
            .focused($isFocused)
            .onChange(of: isFocused) { newValue in hasFocus = newValue }
            .onChange(of: text) { newValue in updateHandler(newValue) }
            .onSubmit { commitHandler(text) }
            .submitLabel(.search)
    }
    
    private var clearButton: some View {
        Button {
            text = ""
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
    
    init(
        iconType: IconType,
        placeholder: String = "",
        text: Binding<String>,
        hasFocus: Binding<Bool>,
        updateHandler: @escaping (String) -> Void,
        commitHandler: @escaping (String) -> Void,
        clearButtonHandler: (() -> Void)? = nil
    ) {
        self.iconType = iconType
        self.placeholder = placeholder
        self._text = text
        self._hasFocus = hasFocus
        self.updateHandler = updateHandler
        self.commitHandler = commitHandler
        self.clearButtonHandler = clearButtonHandler
    }
}

struct SearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextField(
            iconType: .search,
            text: .constant(""),
            hasFocus: .constant(false),
            updateHandler: { _ in},
            commitHandler: { _ in}
        )
            .padding()
    }
}
