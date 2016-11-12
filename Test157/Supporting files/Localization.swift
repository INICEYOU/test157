//
//  Localization.swift
//  Test157
//
//  Created by Andrey on 08.11.16.
//  Copyright © 2016 Kozhurin Andrey. All rights reserved.
//

import Foundation

struct Localization
{
    // for localization purposes
    
    struct Alert {
        struct Title {
            static let ok = "Хорошо"
            static let emptyOrder = "Пустая заявка!"
            static let emptyCity = "Город не выбран!"
            static let error = "Ошибка!"
            static let success = "Успех!"
        }
        struct Message {
            static let fillAllRows = "Заполните все поля, пожалуйста."
            static let chooseCity =  "Выберите сначала город, пожалуйста."
            static let serverError = "Измените VIN, Email или повторите попытку позже."
            static let orderAccepted = "Заявка принята."
        }
    }
    
    struct  ListObjectsTitle  {
        static let Year = "Год выпуска"
        static let Class = "Класс"
        static let City = "Город"
        static let ShowRoom = "Дилер"
    }
    
    struct Label
    {
        struct User
        {
            static let gender = "Обращение"
            static let firstName = "Имя"
            static let lastName = "Фамилия"
            static let middleName = "Отчество"
            static let phone = "Телефон"
            static let email = "Email"
        }
        struct Car
        {
            static let vin = "VIN"
            static let year = "Год выпуска"
            static let classId = "Класс"
            static let showRoomId = "Дилер"
            static let city = "Город"
        }
    }
    
    struct PlaceHolder
    {
        struct User
        {
            static let gender = "1"
            static let firstName = "Введите Ваше имя"
            static let lastName = "Введите Вашу фамилию"
            static let middleName = "Введите Ваше Отчество"
            static let phone = "+7"
            static let email = "Введите email адрес"
        }
        struct Car
        {
            static let vin = "Выберите VIN"
            static let year = "Выберите год выпуска"
            static let classId = "Выберите класс"
            static let showRoomId = "Выберите дилера"
            static let city = "Выберите город"
        }
    }
}
