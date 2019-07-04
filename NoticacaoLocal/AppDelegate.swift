//
//  AppDelegate.swift
//  NoticacaoLocal
//
//  Created by Matheus Gois on 25/06/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import UIKit

//Importamos a framework
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    //Criando o centro de Notifições que é resposável por todo o
    //gerenciamento das mesmas
    let centroDeNotificacao = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Para usar podermos usar o protocolo UNUserNotificationCenterDelegate
        //na extensão mais abaixo
        centroDeNotificacao.delegate = self
        
        //Aqui pedimos três coisas ao usuário, para a notificação gerar um alerta
        //com som e um pontinho vermelhor junto ao logo da nossa aplicação
        let opcoes: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        //Método que pede permissão ao usuáio
        centroDeNotificacao.requestAuthorization(options: opcoes) {
            (foiPermitido, error) in
            if !foiPermitido {
                print("O usúario não permitiu, não podemos enviar notificacão")
            }
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func enviarNotificacao(_ titulo:String, _ subtitulo:String, _ mensagem:String, _ identificador:String, _ tempo:TimeInterval) {
        
        //Essa instancia de classe é necessária para criar o corpo da notificação
        let contexto = UNMutableNotificationContent()
        
        //Criando corpo da notificação
        contexto.title = titulo
        contexto.subtitle = subtitulo
        contexto.body = mensagem
        contexto.sound = UNNotificationSound.default
        //Badge é a o alerta vermelho que fica no icone do aplicativo quando há notificações e ela pode ser incrementada
        contexto.badge = 1
        contexto.categoryIdentifier = identificador
        
        
        //Colocando a imgem de fundo
        let nomeDaImagem = "logo"
        //Aqui verificamos se a mensagem realmente existe, caso ela não exista ele para a função a retornando.
        guard let imageURL = Bundle.main.url(forResource: nomeDaImagem, withExtension: "jpeg") else { return }
        //Anexando a imagem
        let anexo = try! UNNotificationAttachment(identifier: nomeDaImagem, url: imageURL, options: .none)
        contexto.attachments = [anexo]
        
        
        //Criando os botões de ações
        let acaoDeSoneca = UNNotificationAction(identifier: "Soneca", title: "Soneca", options: [])
        let acaoDeDesligar = UNNotificationAction(identifier: "Desligar", title: "Desligar", options: [.destructive])
        let categoria = UNNotificationCategory(identifier: identificador,
                                               actions: [acaoDeSoneca, acaoDeDesligar],
                                               intentIdentifiers: [],
                                               options: [])
        
        
        //Adicionando as ações ao nosso centro de notificações
        centroDeNotificacao.setNotificationCategories([categoria])
        
        //Criando a requisição
        let gatilho = UNTimeIntervalNotificationTrigger(timeInterval: tempo, repeats: false)
        let requisicao = UNNotificationRequest(identifier: identificador, content: contexto, trigger: gatilho)
        
        //Adicionando a requisição ao nosso centro de notificações
        centroDeNotificacao.add(requisicao) { (error) in
            if let error = error {
                print("Deu ruim: \(error.localizedDescription)")
            }
        }
        
        
        
        
    }
    
    //Quando a notificacao é enviada e o aplicativo está aberto
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        //Aqui definimos que a notificação deve gerar um alerta com som, mas sem o badge
        completionHandler([.alert,.sound])
    }
    
    
    //Quando a notificacao é respondida
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //Chamando identificador de ações
        let identificador = response.actionIdentifier
        
        //Pegando a resposta da notificação pela resposta da ação
        if identificador == "Soneca"{
            print("Deixa eu dormir mais um pouquinho!")
        }
        else if identificador == "Desligar" {
            print("Ahhh, vou chegar atrasado mesmo!")
        }
        
        //Não há retorno
        completionHandler()
    }
}


