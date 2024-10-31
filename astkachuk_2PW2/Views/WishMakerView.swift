//
//  WishMakerView.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 30.10.2024.
//

import UIKit

final class WishMakerView: UIView {
    
    // MARK: - Constants
    enum Constants {
        static let sliderMin: Double = 0.0
        static let sliderMax: Double = 1.0
        
        static let stackRadius: CGFloat = 20.0
        static let stackBottomPadding: Double = 20.0
        static let stackLeadingPadding: Double = 20.0
        static let stackBackgroundColor: UIColor = .white
        static let stackSpace: CGFloat = 10.0
        
        static let buttonHeight: Double = 60.0
        static let buttonWidth: Double = 200.0
        static let buttonVerticalSpacing: Double = 10.0
        static let buttonHorizontalSpacing: Double = 5.0
        static let buttonLeadingPadding: Double = 20.0
        static let buttonFontSize: CGFloat = 18.0
        static let buttonCornerRadius: CGFloat = 10.0
        static let backgroundButtonColor: UIColor = .white
        static let titleOnBackgroundColor: UIColor = .black
        
        static let titleTopPadding: Double = 30.0
        static let titleLeadingPadding: Double = 20.0
        static let titleTextColor: UIColor = .white
        static let titleFontSize: CGFloat = 32
        
        static let descriptionTopPadding: Double = 20.0
        static let descriptionLeadingPadding: Double = 20.0
        static let descriptionTrailingPadding: Double = 20.0
        static let descriptionTextColor: UIColor = .white
        static let descriptionFontSize: CGFloat = 20
    }
    
    // MARK: - Fields
    let titleView = UILabel()
    let descriptionView = UILabel()
    let slidersStack = UIStackView()
    
    let hideSlidersButton = UIButton(type: .system)
    let randomColorButton = UIButton(type: .system)
    let hexColorButton = UIButton(type: .system)
    
    let sliderRed = CustomSliderView(title: "Red", min: Constants.sliderMin, max: Constants.sliderMax)
    let sliderGreen = CustomSliderView(title: "Green", min: Constants.sliderMin, max: Constants.sliderMax)
    let sliderBlue = CustomSliderView(title: "Blue", min: Constants.sliderMin, max: Constants.sliderMax)
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        configureTitle()
        configureDescription()
        configureSliders()
        configureButtons()
    }
    
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = "Wish Maker"
        titleView.textColor = Constants.titleTextColor
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleView.textAlignment = .center
        
        addSubview(titleView)
        titleView.pinCenterX(to: self)
        titleView.pinLeft(to: self, Constants.titleLeadingPadding)
        titleView.pinTop(to: safeAreaLayoutGuide.topAnchor, Constants.titleTopPadding)
    }
    
    private func configureDescription() {
        descriptionView.text = "Можно изменить цвет фона используя слайдеры, кнопку рандомного цвета или ввести HEX-код. Также возможно скрыть слайдеры."
        descriptionView.textColor = Constants.descriptionTextColor
        descriptionView.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionView.textAlignment = .justified
        descriptionView.numberOfLines = 0
        
        addSubview(descriptionView)
        
        descriptionView.pinCenterX(to: self)
        descriptionView.pinTop(to: titleView.bottomAnchor, Constants.descriptionTopPadding)
        descriptionView.pinLeft(to: self, Constants.descriptionLeadingPadding)
        descriptionView.pinRight(to: self, Constants.descriptionTrailingPadding)
    }
    
    private func configureSliders() {
        slidersStack.translatesAutoresizingMaskIntoConstraints = false
        slidersStack.axis = .vertical
        slidersStack.spacing = Constants.stackSpace
        slidersStack.layer.cornerRadius = Constants.stackRadius
        slidersStack.clipsToBounds = true
        slidersStack.backgroundColor = Constants.stackBackgroundColor
        
        addSubview(slidersStack)
        
        slidersStack.addArrangedSubview(sliderRed)
        slidersStack.addArrangedSubview(sliderGreen)
        slidersStack.addArrangedSubview(sliderBlue)
        
        slidersStack.pinLeft(to: self, Constants.stackLeadingPadding)
        slidersStack.pinRight(to: self, Constants.stackLeadingPadding)
        slidersStack.pinBottom(to: safeAreaLayoutGuide.bottomAnchor, Constants.stackBottomPadding)
    }
    
    private func configureButtons() {
        // Кнопка случайного цвета
        randomColorButton.setTitle("Случайный цвет", for: .normal)
        randomColorButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        randomColorButton.backgroundColor = Constants.backgroundButtonColor
        randomColorButton.setTitleColor(Constants.titleOnBackgroundColor, for: .normal)
        randomColorButton.layer.cornerRadius = Constants.buttonCornerRadius
        randomColorButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(randomColorButton)
        randomColorButton.pinRight(to: centerXAnchor, Constants.buttonHorizontalSpacing)
        randomColorButton.pinLeft(to: self, Constants.buttonLeadingPadding)
        randomColorButton.setHeight(mode: .equal, Constants.buttonHeight)
        randomColorButton.pinBottom(to: slidersStack.topAnchor, Constants.buttonVerticalSpacing)
        
        // Кнопка ввода hex-кода
        hexColorButton.setTitle("Введите Hex-код", for: .normal)
        hexColorButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        hexColorButton.backgroundColor = Constants.backgroundButtonColor
        hexColorButton.setTitleColor(Constants.titleOnBackgroundColor, for: .normal)
        hexColorButton.layer.cornerRadius = Constants.buttonCornerRadius
        hexColorButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(hexColorButton)
        hexColorButton.pinLeft(to: centerXAnchor, Constants.buttonHorizontalSpacing)
        hexColorButton.pinRight(to: self, Constants.buttonLeadingPadding)
        hexColorButton.setHeight(mode: .equal, Constants.buttonHeight)
        hexColorButton.pinBottom(to: slidersStack.topAnchor, Constants.buttonVerticalSpacing)
        
        // Кнопка скрытия слайдеров
        hideSlidersButton.setTitle("Скрыть слайдеры", for: .normal)
        hideSlidersButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        hideSlidersButton.backgroundColor = Constants.backgroundButtonColor
        hideSlidersButton.setTitleColor(Constants.titleOnBackgroundColor, for: .normal)
        hideSlidersButton.layer.cornerRadius = Constants.buttonCornerRadius
        hideSlidersButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(hideSlidersButton)
        hideSlidersButton.pinRight(to: centerXAnchor, Constants.buttonHorizontalSpacing)
        hideSlidersButton.pinLeft(to: self, Constants.buttonLeadingPadding)
        hideSlidersButton.setHeight(mode: .equal, Constants.buttonHeight)
        hideSlidersButton.pinBottom(to: randomColorButton.topAnchor, Constants.buttonVerticalSpacing)
    }
}
