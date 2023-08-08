import UIKit

class UIPersonCard: UIView {
    
    
    
    // MARK: - Графические элементы
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private let wrap               = UIView()       // Графический элемент, выполняющий роль обёртки
    private let avatar             = UIImageView()  // Аватар пользователя
    private let nameLabel          = UILabel()      // Метка с имененм
    private let noticeLabel        = UILabel()      // Метка с уведомлением о количестве дней до наступающего дня рождения
    private let bdayDateLabel      = UILabel()      // Метка с датой рождения
    private let verticalStackView  = UIStackView()  // Вертикальный стек с nameLabel, bdayDateLabel, noticeLabel
    private let horizontalStackView = UIStackView() // Горизонтальный стек с avatar и verticalStackView
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Некоторые размеры
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private let avatarDiam: CGFloat = 130       // Диаметр аватара
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для настройки обёртки
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func wrapSetting() {
        // Настройка цвета
        self.wrap.backgroundColor = .white

        // Настройка размера и формы
        self.wrap.layer.cornerRadius = 12.5

        // Добавление объекта к родительскому вью
        self.addSubview(self.wrap)

        // Установка ограничений
        self.addConstraintsToWrap()

    }
    
    private func addConstraintsToWrap() -> Void {
        self.wrap.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.wrap.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: -20),
            self.wrap.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: -20),
            self.wrap.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.wrap.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Методы для настройки аватара
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func avatarSetting(person: Person) {

        // Закругления сопряжений аватара для достижения формы круга
        self.avatar.layer.cornerRadius = (self.avatarDiam / 2)

        // Обрезка изображения аватара по границам круга
        self.avatar.clipsToBounds = true
        
        // Настройка отображения изображения
        self.avatar.contentMode = .scaleAspectFit

        // Установка ограничений
        self.addConstraintsToAvatar()

        // Рисовка границ аватара
        self.avatar.layer.borderWidth = 1
        self.avatar.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        self.setUpAvatarImage(person: person)
    }
    
    private func addConstraintsToAvatar() -> Void {
        self.avatar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.avatar.widthAnchor.constraint(equalToConstant: self.avatarDiam),
            self.avatar.heightAnchor.constraint(equalToConstant: self.avatarDiam)
        ])
    }
    
    private func setUpAvatarImage(person: Person) -> Void {
        if person.avatar == nil {
            if person.gender == .man {
                self.avatar.image = UIImage(named: "man.png")
            } else {
                self.avatar.image = UIImage(named: "woman.png")
            }
        } else {
            self.avatar.image = person.avatar
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для настройки метки с именем
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func nameLabelSetting(person: Person) {
        createLabel(label: self.nameLabel,
                    text: "\(person.name), \(person.age)",
                    fontSize: 25,
                    fontWeight: .semibold,
                    textColor: .darkGray,
                    isCenterTextAlignment: false)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для настройки метки с напоминанием
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    func noticeLabelSetting(person: Person) {
        createLabel(label: self.noticeLabel,
                    text: updateTheDateForThePerson(person: person),
                    numberOfLines: 0,
                    fontSize: 17,
                    fontWeight: .regular,
                    textColor: .black,
                    isCenterTextAlignment: false)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для настройки метки с датой рождения
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    func bDayDateLabelSetting(person: Person) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.Y"

        createLabel(label: self.bdayDateLabel,
                    text: dateFormatter.string(from: person.birthday),
                    numberOfLines: 1,
                    fontSize: 20,
                    fontWeight: .medium,
                    textColor: .darkGray,
                    isCenterTextAlignment: false)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для формирования правильного текста в уведомительной метки
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func updateTheDateForThePerson(person: Person) -> String {

        // Текст для уведомительной метки с остатком дней до дня рождения
        var textForNoticeLabel: String = ""

        // Настройка текста уведомительной метки
        let daysNumber = String(person.numberOfDaysUntilBirthday)

        if daysNumber.count == 1 {
            switch daysNumber {
            case "0": textForNoticeLabel = "Сегодня отмечает \(person.age)"
            case "1": textForNoticeLabel = "Завтра отмечает \(person.age + 1)"
            case "2": textForNoticeLabel = "Послезавтра отмечает \(person.age + 1)"
            case let day where (day == "3") || (day == "4"):
                textForNoticeLabel = "Отмечает \(person.age + 1) через \(daysNumber) дня"
            default:
                textForNoticeLabel = "Отмечает \(person.age + 1) через \(daysNumber) дней"
            }
        } else {
            switch daysNumber {
            case let day where day[day.index(day.endIndex, offsetBy: -2)] == "1":
                textForNoticeLabel = "Отмечает \(person.age + 1) через \(daysNumber) дней"
            case let day where ( day[day.index(day.endIndex, offsetBy: -1)] == "2" ) ||
                ( day[day.index(day.endIndex, offsetBy: -1)] == "3" ) ||
                ( day[day.index(day.endIndex, offsetBy: -1)] == "4" ):
                textForNoticeLabel = "Отмечает \(person.age + 1) через \(daysNumber) дня"
            case let day where day[day.index(day.endIndex, offsetBy: -1)] == "1":
                textForNoticeLabel = "Отмечает \(person.age + 1) через \(daysNumber) день"
            default:
                textForNoticeLabel = "Отмечает \(person.age + 1) через \(daysNumber) дней"
            }
        }
        return textForNoticeLabel
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для настройки вертикального стека с метками
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpVerticalStackView() -> Void {
        self.verticalStackView.axis = .vertical
        self.verticalStackView.spacing = 10
        self.verticalStackView.alignment = .leading
        self.verticalStackView.distribution = .fill
        self.verticalStackView.addArrangedSubview(self.nameLabel)
        self.verticalStackView.addArrangedSubview(self.bdayDateLabel)
        self.verticalStackView.addArrangedSubview(self.noticeLabel)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Методы для настройки горизонтальнго стека
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpHorizontalStackView() -> Void {
        self.wrap.addSubview(self.horizontalStackView)
        self.horizontalStackView.axis = .horizontal
        self.horizontalStackView.alignment = .center
        self.horizontalStackView.spacing = 10
        self.horizontalStackView.distribution = .fill
        self.horizontalStackView.addArrangedSubview(self.avatar)
        self.horizontalStackView.addArrangedSubview(self.verticalStackView)
        self.horizontalStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.horizontalStackView.isLayoutMarginsRelativeArrangement = true
        self.addConstraintsToHorizontalStackView()
    }
    
    private func addConstraintsToHorizontalStackView() -> Void {
        self.horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.horizontalStackView.topAnchor.constraint(equalTo: self.wrap.topAnchor),
            self.horizontalStackView.leadingAnchor.constraint(equalTo: self.wrap.leadingAnchor),
            self.horizontalStackView.bottomAnchor.constraint(equalTo: self.wrap.bottomAnchor),
            self.horizontalStackView.trailingAnchor.constraint(equalTo: self.wrap.trailingAnchor),
        ])
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для установки значений в UIPersonCard
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    func setUpValues(person: Person) {
        self.wrapSetting()
        self.avatarSetting(person: person)
        self.nameLabelSetting(person: person)
        self.noticeLabelSetting(person: person)
        self.bDayDateLabelSetting(person: person)
        self.setUpVerticalStackView()
        self.setUpHorizontalStackView()
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Инициализаторы
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    init(person: Person) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setUpValues(person: person)
    }
    
    init(person: Person, frame: CGRect) {
        super.init(frame: frame)
        self.setUpValues(person: person)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
}
