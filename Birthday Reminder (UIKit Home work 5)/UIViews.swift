import UIKit



// MARK: Color setting of root view
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/

let viewColor = UIColor.systemGray6

let colorOfUIviews = UIColor(red: (240 / 255), green: (90 / 255), blue: (89 / 255), alpha: 1)

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/



// MARK: - Buttons
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/

// MARK: Size settings
let buttonHeight: CGFloat = 50
let buttonCornerRadius: CGFloat = 25

// MARK: Color settings
let buttonBackgroundColor: UIColor = colorOfUIviews  // Цвет фона кнопки
let normalButtonTitleColor: UIColor = .white  // Цвет текста заголовка в нормальном состоянии кнопки
let highlightedButtonTitleColor: UIColor = .systemGray5  // Цвет текста заголовка нажатой кнопки

// MARK: Title font settings
let buttonFontSize: CGFloat = 22.5
let buttonFontWeight: UIFont.Weight = .semibold // "Вес" шрифта заголовка

// MARK: Function for button creation
func createButton(button: UIButton,
                  title: String,
                  fontSize: CGFloat = buttonFontSize,
                  fontWeight: UIFont.Weight = buttonFontWeight,
                  normalTitleColor: UIColor = normalButtonTitleColor,
                  highlightedTitleColor: UIColor = highlightedButtonTitleColor,
                  backgroundColor: UIColor = buttonBackgroundColor,
                  cornerRadius: CGFloat = buttonCornerRadius,
                  height: CGFloat = buttonHeight) {

    //Настройка текста заголовка кнопки
    button.setTitle(title, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: fontSize, weight: fontWeight)
    button.setTitleColor(normalTitleColor, for: .normal)
    button.setTitleColor(highlightedTitleColor, for: .highlighted)
    
    // Настройка фона кнопки
    button.backgroundColor = backgroundColor
    button.layer.cornerRadius = cornerRadius
    
    // Настройка высоты кнопки
    button.heightAnchor.constraint(equalToConstant: height).isActive = true
}
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/



// MARK: - Labels
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/

// MARK: Font settings
let labelTitleFontSize: CGFloat = 35
let labelRegularFontSize: CGFloat = 20
let labelFontWeight: UIFont.Weight = .regular // "Вес" шрифта для обычных текстов

// MARK: Color settings
let labelRegularTextColor: UIColor = .black // Цвет текста метки для обычных текстов
let labelNoticeTextColor: UIColor = colorOfUIviews  // Цвет текста для предупредительной метки

// MARK: Label creating function
func createLabel(label: UILabel,
                 text: String,
                 numberOfLines: Int = 1,
                 fontSize: CGFloat = labelRegularFontSize,
                 fontWeight: UIFont.Weight = labelFontWeight,
                 textColor: UIColor = labelRegularTextColor,
                 isCenterTextAlignment: Bool) {
    
    label.text = text
    label.numberOfLines = numberOfLines
    if isCenterTextAlignment { label.textAlignment = .center }
    label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
    label.textColor = textColor
    
}
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/



// MARK: - Text fields
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/

// MARK: Text settings
var textFieldFontSize: CGFloat = 20
var textFieldFontWeight: UIFont.Weight = .light

// MARK: Color settings
var textFieldTextColor: UIColor = .black
var textFieldColor: UIColor = viewColor

// MARK: Text field creating function
func createTextField(textfield: UITextField,
                     placeholder: String?,
                     borderStyle: UITextField.BorderStyle,
                     fontSize: CGFloat = textFieldFontSize,
                     fontWeight: UIFont.Weight = textFieldFontWeight,
                     textColor: UIColor = textFieldTextColor,
                     backgroundColor: UIColor = textFieldColor) {
    
    // Настройка текста
    textfield.placeholder = placeholder
    textfield.textColor = textColor
    textfield.font = .systemFont(ofSize: fontSize, weight: fontWeight)
    
    // Настройка цвета
    textfield.borderStyle = borderStyle
    textfield.backgroundColor = backgroundColor
    
    // Отключение автоматического написания первого символа заглавной буквой
    textfield.autocapitalizationType = .none
    
}
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
