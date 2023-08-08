import UIKit

class UITextViewWithPlaceholder: UITextView {
    
    
    
    // MARK: - Свойства
    /*===============================================*/
    // Метка, текст которой выполняет роль текстового заполнителя
    private let placeholderLabel = UILabel()
    
    // Текстовый заполнитель
    var placeholder: String {
        get {
            if let text = self.placeholderLabel.text {
                return text
            } else {
                return "placeholder"
            }
        }
        set {
            self.placeholderLabel.text = newValue
        }
    }
    /*===============================================*/
    
    
    
    // MARK: - Метод для настройки метки
    /*===============================================*/
    private func setUpPlaceholder() {
        
        // Настройка шрифта текста метки
        self.placeholderLabel.font = .systemFont(ofSize: 17, weight: .thin)
        
        // Настройка цвета текста метки
        self.placeholderLabel.textColor = .systemGray2
        
        // Добавление метки к родительскому вью
        self.addSubview(self.placeholderLabel)
        
        // Сокрытие метки в случае, если текст UITextView был добавлен при инициализации объекта данного класса
        if !self.text.isEmpty {
            self.placeholderLabel.isHidden = true
        }
        
        // Отключение автоматических ограничений
        self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений (значения отступов подобраны опытным путём)
        NSLayoutConstraint.activate([
            self.placeholderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            self.placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7)
        ])
        
        // Добавление обработчика изменения текста
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(hideThePlacehholder),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }
    /*===============================================*/
    
    
    
    // MARK: - Метод для сокрытия метки
    /*===============================================*/
    @objc func hideThePlacehholder() {
        if self.text.isEmpty {
            self.placeholderLabel.isHidden = false
        } else {
            self.placeholderLabel.isHidden = true
        }
    }
    /*===============================================*/
    
    
    
    // MARK: - Настройка метки
    /*===============================================*/
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setUpPlaceholder()
    }
    /*===============================================*/
    
}
