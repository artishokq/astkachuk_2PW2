//
//  WishMakerViewController.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 28.10.2024.
//

import UIKit

final class WishMakerViewController: UIViewController {
    
    // MARK: - Properties
    private var colorModel = ColorModel()
    private let wishMakerView = WishMakerView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = wishMakerView
        wishMakerView.sliderRed.slider.setValue(Float(colorModel.red), animated: false)
        wishMakerView.sliderGreen.slider.setValue(Float(colorModel.green), animated: false)
        wishMakerView.sliderBlue.slider.setValue(Float(colorModel.blue), animated: false)
        
        configureSliderActions()
        configureButtonActions()
        updateBackgroundColor()
    }
    
    // MARK: - Configure Actions
    private func configureSliderActions() {
        wishMakerView.sliderRed.valueChanged = { [weak self] value in
            guard let self = self else { return }
            self.colorModel.red = CGFloat(value)
            self.updateBackgroundColor()
        }
        
        wishMakerView.sliderGreen.valueChanged = { [weak self] value in
            guard let self = self else { return }
            self.colorModel.green = CGFloat(value)
            self.updateBackgroundColor()
        }
        
        wishMakerView.sliderBlue.valueChanged = { [weak self] value in
            guard let self = self else { return }
            self.colorModel.blue = CGFloat(value)
            self.updateBackgroundColor()
        }
    }
    
    private func configureButtonActions() {
        wishMakerView.randomColorButton.addTarget(self, action: #selector(changeToRandomColor), for: .touchUpInside)
        wishMakerView.hexColorButton.addTarget(self, action: #selector(chanheToHexColor), for: .touchUpInside)
        wishMakerView.hideSlidersButton.addTarget(self, action: #selector(slidersVisibility), for: .touchUpInside)
    }
    
    // MARK: - Background Update
    private func updateBackgroundColor() {
        view.backgroundColor = colorModel.getColor()
    }
    
    // MARK: - Button Actions
    @objc
    private func slidersVisibility() {
        wishMakerView.slidersStack.isHidden.toggle()
        let buttonTitle = wishMakerView.slidersStack.isHidden ? "Вернуть слайдеры" : "Скрыть слайдеры"
        wishMakerView.hideSlidersButton.setTitle(buttonTitle, for: .normal)
    }
    
    @objc
    private func changeToRandomColor() {
        let newColor = ColorModel(random: true)
        colorModel = newColor
        updateBackgroundColor()
        
        wishMakerView.sliderRed.slider.setValue(Float(colorModel.red), animated: true)
        wishMakerView.sliderGreen.slider.setValue(Float(colorModel.green), animated: true)
        wishMakerView.sliderBlue.slider.setValue(Float(colorModel.blue), animated: true)
    }
    
    @objc
    private func chanheToHexColor() {
        let alertController = UIAlertController(title: "Введите Hex-код", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "#FFFFFF"
            textField.keyboardType = .default
        }
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self,
                  let hexText = alertController.textFields?.first?.text else { return }
            
            // Убираем лишние символы и приводим к верхнему регистру
            let cleanedHexString = hexText.trimmingCharacters(in: CharacterSet.alphanumerics.inverted).uppercased()
            
            // Создаем множество допустимых символов и проверяем наличие только этих символов
            let validHexCharacters = CharacterSet(charactersIn: "0123456789ABCDEF")
            let hexCharacterSet = CharacterSet(charactersIn: cleanedHexString)
            let isValidHex = validHexCharacters.isSuperset(of: hexCharacterSet)
            
            // Проверяем длину строки
            let isValidLength = cleanedHexString.count == 6
            
            if isValidHex && isValidLength {
                // Создаем UIColor и преобразуем в CIColor для получения компонентов RGB
                if let color = UIColor(hexString: cleanedHexString) {
                    let rgbColorComponents = CIColor(color: color)
                    self.colorModel.red = rgbColorComponents.red
                    self.colorModel.green = rgbColorComponents.green
                    self.colorModel.blue = rgbColorComponents.blue
                    
                    // Обновляем слайдеры с новыми значениями
                    self.wishMakerView.sliderRed.slider.setValue(Float(self.colorModel.red), animated: true)
                    self.wishMakerView.sliderGreen.slider.setValue(Float(self.colorModel.green), animated: true)
                    self.wishMakerView.sliderBlue.slider.setValue(Float(self.colorModel.blue), animated: true)
                    
                    self.updateBackgroundColor()
                }
            } else {
                // Показываем предупреждение о некорректном hex-коде
                let errorAlert = UIAlertController(
                    title: "Ошибка",
                    message: "Некорректный Hex-код цвета. Пожалуйста, введите 6 символов, используя цифры 0-9 и буквы A-F. Пример: #FFFFFF или FFFFFF",
                    preferredStyle: .alert
                )
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
