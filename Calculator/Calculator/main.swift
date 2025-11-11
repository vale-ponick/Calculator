//
//  main.swift
//  Calculator
//
//  Created by Валерия Пономарева on 07.11.2025.
//

import Foundation

print("Calculator")

class Calculator {
    var a:  Int
    var b: Int
    
    init(a: Int, b: Int) {
        self.a = a
        self.b = b
    }
    
    var addition: Int {
        return a + b
    }
    
    var subtaction: Int {
        return a - b
    }
    
    var multiplication: Int {
        return a * b
    }
    
    var division: Double {
        guard b != 0 else { return 0 }
        return Double(a) / Double(b)
    }
}

// tests
let calc = Calculator(a: 12, b: 3)
print("Addition: \(calc.addition)")
print("Subtraction: \(calc.subtaction)")
print("Multiplication: \(calc.multiplication)")
print("Division: \(calc.division)")

/* Calculator
 Addition: 15
 Subtraction: 9
 Multiplication: 36
 Division: 4 */

print("-- Упрощенный AppStore --")

enum CategoryApp: String, CaseIterable {
    case social = "SocialNetwork"
    case games = "Games"
    case education = "Education"
    case music = "Music"
    case productivity = "Productivity"
    case aiAssistant = "AI Assistant"
    case developerTools = "DeveloperTools"
}

struct App {
    let name: String
    let developer: String
    var commentsToApp: [String] = []
    var ratingToApp: [Int] = [] // оценки
}

class AppStore {
    private var apps: [CategoryApp: [App]] = [:]

    func addApp(_ app: App, to category: CategoryApp) {
        apps[category, default: []].append(app)
        print("✅ \(app.name) added to \(category.rawValue)")
    }

    func addComment(_ comment: String, to appName: String) {
        var appFound = false
        
        for (category, _) in apps {
            if let index = apps[category]?.firstIndex(where: { $0.name == appName }) {
                apps[category]?[index].commentsToApp.append(comment)
                print("💬 Комментарий добавлен к приложению \(appName)")
                appFound = true
                break
            }
        }
        
        if !appFound {
            print("❌ Приложение \(appName) не найдено")
        }
    }

    func addRateToApp(_ rate:Int, to appName: String) {
        guard rate >= 1 && rate <= 5 else {
            print("Rate must be between 1 until 5")
            return
        }
        var appFound = false
        for (category, _) in apps {
            if let index = apps[category]?.firstIndex(where: { $0.name == appName }) {
                apps[category]?[index].ratingToApp.append(rate)
                print("⭐ Rate \(rate) added to app \(appName)")
                appFound = true
                break
            }
        }
        if !appFound {
            print("❌ App \(appName) not found")
        }
    }
    
    func showApps(in category: CategoryApp) {
        print("\n📱 \(category.rawValue):")
        if let categoryApps = apps[category], !categoryApps.isEmpty {
            categoryApps.forEach { app in
                print("  - \(app.name) from \(app.developer)")
                
                // Показываем рейтинг
                if !app.ratingToApp.isEmpty {
                    let averageRating = Double(app.ratingToApp.reduce(0, +)) / Double(app.ratingToApp.count)
                    let stars = String(repeating: "⭐", count: Int(averageRating.rounded()))
                    print("    \(stars) Рейтинг: \(String(format: "%.1f", averageRating))/5 (\(app.ratingToApp.count) оценок)")
                } else {
                    print("    📊 Рейтинги пока отсутствуют")
                }
                
                // Показываем комментарии
                if !app.commentsToApp.isEmpty {
                    print("    💬 Комментарии:")
                    app.commentsToApp.forEach { comment in
                        print("      * \(comment)")
                    }
                } else {
                    print("    💬 Комментарии пока отсутствуют")
                }
                print() // пустая строка для разделения
            }
        } else {
            print("  🚫 Приложения не найдены")
        }
    }

    func showAllCategories() {
        print("\n🗂️ Все категории:")
        CategoryApp.allCases.forEach { category in
            let count = apps[category]?.count ?? 0
            print("  \(category.rawValue): \(count) приложений")
        }
    }

    func removeApp(_ appName: String) {
        var appFound = false
        for (category, _) in apps {
            if let index = apps[category]?.firstIndex(where: { $0.name == appName }) {
                let removedApp = apps[category]?.remove(at: index)
                print("🗑️ Приложение \(appName) удалено из категории \(category.rawValue)")
                appFound = true
                break
            }
        }
        if !appFound {
            print("❌ Приложение \(appName) не найдено")
        }
    }
}

// Использование
let appStore = AppStore()

// Добавляем приложения
appStore.addApp(App(name: "Telegram", developer: "Telegram Inc"), to: .social)
appStore.addApp(App(name: "Perplexity", developer: "Perplexity AI, Inc"), to: .productivity)
appStore.addApp(App(name: "Chess", developer: "GameDev"), to: .games)
appStore.addApp(App(name: "DeepSeek", developer: "DeepSeek, Inc", commentsToApp: [
    "A powerful AI assistant for development and productivity",
    "Support for multiple programming languages"
]), to: .aiAssistant)

// Добавляем комментарии
appStore.addComment("Отличное приложение!", to: "Telegram")
appStore.addComment("Очень полезно для работы!", to: "Perplexity")
appStore.addComment("Приложение не найдено", to: "NonExistentApp")

// добавляем оценки
appStore.addRateToApp(5, to: "Perplexity")
appStore.addRateToApp(5, to: "DeepSeek")

// Показываем результаты
appStore.showAllCategories()
appStore.showApps(in: .social)
appStore.showApps(in: .aiAssistant)
appStore.showApps(in: .games)
appStore.showApps(in: .education) // Пустая категория

appStore.removeApp("Telegram") // удалить из любой категории

/* -- Упрощенный AppStore --
 ✅ Telegram added to SocialNetwork
 ✅ Perplexity added to Productivity
 ✅ Chess added to Games
 ✅ DeepSeek added to AI Assistant
 💬 Комментарий добавлен к приложению Telegram
 💬 Комментарий добавлен к приложению Perplexity
 ❌ Приложение NonExistentApp не найдено
 ⭐ Rate 5 added to app Perplexity
 ⭐ Rate 5 added to app DeepSeek

 🗂️ Все категории:
   SocialNetwork: 1 приложений
   Games: 1 приложений
   Education: 0 приложений
   Music: 0 приложений
   Productivity: 1 приложений
   AI Assistant: 1 приложений
   DeveloperTools: 0 приложений

 📱 SocialNetwork:
   - Telegram from Telegram Inc
     📊 Рейтинги пока отсутствуют
     💬 Комментарии:
       * Отличное приложение!


 📱 AI Assistant:
   - DeepSeek from DeepSeek, Inc
     ⭐⭐⭐⭐⭐ Рейтинг: 5.0/5 (1 оценок)
     💬 Комментарии:
       * A powerful AI assistant for development and productivity
       * Support for multiple programming languages


 📱 Games:
   - Chess from GameDev
     📊 Рейтинги пока отсутствуют
     💬 Комментарии пока отсутствуют


 📱 Education:
   🚫 Приложения не найдены
   🗑️ Приложение Telegram удалено из категории SocialNetwork */
