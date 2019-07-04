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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    //Enviando a Notificação
    
    //O appDelegate é chamado para usar seu novo método de notificação
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBAction func botaoEnviarNotificacao(_ sender: Any) {
        
        //Nas variáveis abaixo definimos o corpo da mensagem
        let titulo = "Aqui vai o título"
        let subtitulo = "Aqui vai o subtítulo"
        let mensagem = "Aqui colocamos o corpo da mensagem"
        
        //O identificador serve para o caso de queremos identificar uma notificação especifica
        let identificador = "identifier\(Int.random(in: 0..<6))"
        let tempo:TimeInterval = 0.1
        
        
        self.appDelegate?.enviarNotificacao(titulo, subtitulo, mensagem, identificador, tempo)
        
    }
}

