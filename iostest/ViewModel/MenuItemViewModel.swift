//
//  MenuItemViewModel.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 12/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import RxSwift
import RxCocoa

enum MenuActionType {
    case dashboard, sales, products, afiliates, messages, notifications, account, about
}

class MenuItemViewModel: ViewModel, MenuItem {

    let disposeBag: DisposeBag = DisposeBag()

    fileprivate var titleVariable: Variable<String>
    var title: Driver<String> {
        return titleVariable.asDriver()
    }

    fileprivate var menuIconVariable: Variable<UIImage>
    var image: Driver<UIImage> {
        return menuIconVariable.asDriver()
    }

    fileprivate var counterVariable: Variable<Int>
    var counter: Driver<Int> {
        return counterVariable.asDriver()
    }

    let type: MenuActionType
    let style: MenuItemStyle

    required init(type: MenuActionType, style: MenuItemStyle = .white) {
        self.type = type
        self.style = style

        switch type {
        case .dashboard:
            titleVariable = Variable("Dashboard")
            menuIconVariable = Variable(R.image.ico_dashboard()!)
            counterVariable = Variable(0)
        case .sales:
            titleVariable = Variable("Minhas Vendas")
            menuIconVariable = Variable(R.image.ico_minhas_vendas()!)
            counterVariable = Variable(0)
        case .products:
            titleVariable = Variable("Meus Produtos")
            menuIconVariable = Variable(R.image.ico_meus_produtos()!)
            counterVariable = Variable(0)
        case .afiliates:
            titleVariable = Variable("Afiliados")
            menuIconVariable = Variable(R.image.ico_afiliados()!)
            counterVariable = Variable(121)
        case .messages:
            titleVariable = Variable("Mensagens")
            menuIconVariable = Variable(R.image.ico_mensagem()!)
            counterVariable = Variable(50)
        case .notifications:
            titleVariable = Variable("Notificações")
            menuIconVariable = Variable(R.image.ico_notificacoes()!)
            counterVariable = Variable(15)
        case .account:
            titleVariable = Variable("Minha conta")
            menuIconVariable = Variable(R.image.ico_minha_conta()!)
            counterVariable = Variable(0)
        case .about:
            titleVariable = Variable("Sobre o App")
            menuIconVariable = Variable(R.image.ico_sobre_o_app()!)
            counterVariable = Variable(0)
        }

    }
}
