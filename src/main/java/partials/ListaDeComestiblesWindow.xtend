package partials

import domain.Articulo
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.WindowOwner
import viewModel.ListaDeComestiblesModel
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class ListaDeComestiblesWindow extends TransactionalDialog<ListaDeComestiblesModel> {

	new(WindowOwner owner, ListaDeComestiblesModel model) {
		super(owner, model)
	}

	override protected createFormPanel(Panel mainPanel) {
		title = "Crear Lista de Comestibles"
		val topPanel = new Panel(mainPanel)
		new Label(topPanel).text = "Descripcion"
		new TextBox(topPanel) => [
			value <=> "descripcionTemp"
			width = 200
		]

		val articulosPanel = new Panel(mainPanel)
		articulosPanel.layout = new HorizontalLayout
		val selectorArticulosPanel = new Panel(articulosPanel)
		val listBotonesPanel = new Panel(articulosPanel)

		new Selector<Articulo>(selectorArticulosPanel) => [
			items <=> "articulos"
			value <=> "articulo"
			val bindingAcciones = items <=> "articulos"
			bindingAcciones.adapter = new PropertyAdapter(typeof(Articulo), "nombre")
		]
		new Button(selectorArticulosPanel) => [
			caption = "Agregar"
			onClick[|modelObject.agregar()]
		]
		new Button(selectorArticulosPanel) => [
			caption = "Eliminar"
			onClick[|modelObject.eliminar()]
		]

		new List<Articulo>(listBotonesPanel) => [
			items <=> "articulosLista"
			value <=> "seleccionado"
			width = 150
			val bindingAcciones = items <=> "articulosLista"
			bindingAcciones.adapter = new PropertyAdapter(typeof(Articulo), "nombre")
		]

	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Crear"
			onClick[|
				this.accept()
			]
		]
	}

	override executeTask() {
		modelObject.crearLista
		super.executeTask
	}

}
