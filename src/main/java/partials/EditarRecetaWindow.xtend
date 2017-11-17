package partials

import domain.Articulo
import domain.Receta
import domain.UnidadDeMedida
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner
import viewModel.EditarRecetasModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditarRecetaWindow extends TransactionalDialog<EditarRecetasModel> {

	new(WindowOwner owner, Receta receta) {
		super(owner, new EditarRecetasModel(receta))
	}

	override protected createFormPanel(Panel mainPanel) {
		title = "Editar Receta"
		val topPanel = new Panel(mainPanel)
		new Label(topPanel).text = "Nombre Receta"
		new TextBox(topPanel) => [
			value <=> "nombreTemp"
		]
		new Label(topPanel).text = "Descripcion"
		new TextBox(topPanel) => [
			value <=> "descripcionTemp"
		]

		val articulosPanel = new Panel(mainPanel)
		articulosPanel.layout = new HorizontalLayout
		val selectorArticulosPanel = new Panel(articulosPanel)
		val listBotonesPanel = new Panel(articulosPanel)

		new Selector<Articulo>(selectorArticulosPanel) => [
			items <=> "articulosAAgregar"
			value <=> "articulo"
			val bindingAcciones = items <=> "articulosAAgregar"
			bindingAcciones.adapter = new PropertyAdapter(typeof(Articulo), "nombre")
		]
		new Selector<UnidadDeMedida>(selectorArticulosPanel) => [
			items <=> "medidas"
			value <=> "medidaTemp"
			val bindingAcciones = items <=> "medidas"
			bindingAcciones.adapter = new PropertyAdapter(typeof(UnidadDeMedida), "nombre")
		]
		new NumericField(selectorArticulosPanel) => [
			value <=> "cantidadTemp"
		]
//			new Label(selectorArticulosPanel).text = ""
		new Button(selectorArticulosPanel) => [
			caption = "Agregar"
			onClick[|modelObject.agregar()]
		]
		new Button(selectorArticulosPanel) => [
			caption = "Eliminar"
			onClick[|modelObject.eliminar()]
		]

		this.loadTable(listBotonesPanel)

		new List<Articulo>(listBotonesPanel) => [
			items <=> "articulosAgregados"
			value <=> "seleccionado"
			width = 150
			val bindingAcciones = items <=> "articulosAgregados"
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

	def loadTable(Panel panel) {
		val tablaDeProcesos = new Table<Articulo>(panel, typeof(Articulo)) => [
			items <=> "articulosAgregados"
			value <=> "seleccionado"
			numberVisibleRows = 3
		]

		new Column<Articulo>(tablaDeProcesos) => [
			title = "Articulo"
			fixedSize = 200
			bindContentsToProperty("nombre")
		]

		new Column<Articulo>(tablaDeProcesos) => [
			title = "cantidad"
			fixedSize = 150
			bindContentsToProperty("cantidad")
		]
		new Column<Articulo>(tablaDeProcesos) => [
			title = "unidad"
			fixedSize = 150
			bindContentsToProperty("unidad.nombre") // .adapter = new PropertyAdapter(typeof(UnidadDeMedida),"nombre")
		]
	}

	override executeTask() {
		modelObject.crearReceta
		super.executeTask
	}

}
