//
//  ViewController.swift
//  NoticacaoLocal
//
//  Created by Matheus Gois on 25/06/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UIViewController {
    
    //O appDelegate é chamado para usar seu novo método de notificação
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    
    //Botão de envio
    @IBOutlet weak var botaoEnviarNotificacao: UIButton!
    @IBAction func botaoEnviarNotificacao(_ sender: Any) {
        
        //Nas variáveis abaixo definimos o corpo da mensagem
        let titulo = "Aqui vai o título"
        let subtitulo = "Aqui vai o subtítulo"
        let mensagem = "Aqui colocamos o corpo da mensagem"
        
        //O identificador serve para o caso de queremos identificar uma notificação especifica
        let identificador = "identifier\(Int.random(in: 0..<6))"
        self.appDelegate?.enviarNotificacao(titulo, subtitulo, mensagem, identificador)
   
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Testa há autorização para enviar notificações
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
            (granted, error) in
            if granted {
                print("O usúario permitiu, podemos enviar a notificacão")
            } else {
                print("O usúario não permitiu, não podemos enviar a notificacão")
            }
        }
    }
}

