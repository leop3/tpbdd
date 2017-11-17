package partials

import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import viewModel.MensajeModel

class MensajeWindow extends TransactionalDialog<MensajeModel> {

	new(WindowOwner parent,String msj) {
		super(parent, new MensajeModel(msj))
	}

	override protected createFormPanel(Panel mainPanel) {
		new Label(mainPanel).text = modelObject.msj
	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "aceptar"
			onClick[|this.accept()]
		]

	}

}
