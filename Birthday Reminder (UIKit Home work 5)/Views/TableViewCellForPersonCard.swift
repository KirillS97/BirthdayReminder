import UIKit

class TableViewCellForPersonCard: UITableViewCell {
    
    
    
    // MARK: Объект карточки товара
    /* - - - - - - - - - - - - - - - - */
    private var personCard: UIPersonCard
    /* - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка карточки
    /* - - - - - - - - - - - - - - - - */
    private func setUpPersonCard() -> Void {
        // Добавление карточки к родительскомк вью
        self.addSubview(self.personCard)

        // Отключеиние автоматических ограничений
        self.personCard.translatesAutoresizingMaskIntoConstraints = false

        // Настройка цвета фона карточки
        self.personCard.backgroundColor = viewColor

        // Установка ограничений
        NSLayoutConstraint.activate([
            self.personCard.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.personCard.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.personCard.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.personCard.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    /* - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Инициализаторы
    /* - - - - - - - - - - - - - - - - */
    init(person: Person, style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.personCard = UIPersonCard(person: person)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpPersonCard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /* - - - - - - - - - - - - - - - - */

}
