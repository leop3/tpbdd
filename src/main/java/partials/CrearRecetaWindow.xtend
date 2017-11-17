package partials

import domain.Articulo
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
import viewModel.CrearRecetasModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class CrearRecetaWindow extends TransactionalDialog<CrearRecetasModel> {

	new(WindowOwner owner) {
		super(owner, new CrearRecetasModel)
	}

	override protected createFormPanel(Panel mainPanel) {
		title = "Crear Receta"
		val nombreDescripcionPanel = new Panel(mainPanel)
		val ingresosPanel = new Panel(mainPanel)
		val tablePanel = new Panel(mainPanel)
		val botonesPanel = new Panel(mainPanel)
		nombreDescripcionPanel.layout = new HorizontalLayout
		ingresosPanel.layout = new HorizontalLayout
		tablePanel.layout = new HorizontalLayout
		botonesPanel.layout = new HorizontalLayout

		new Label(nombreDescripcionPanel).text = "Nombre Receta"
		new TextBox(nombreDescripcionPanel) => [
			value <=> "nombreTemp"
			width = 100
		]
		new Label(nombreDescripcionPanel).text = "Descripcion"
		new TextBox(nombreDescripcionPanel) => [
			value <=> "descripcionTemp"
			width = 100
		]
		new Label(ingresosPanel).text = "Articulos:"
		new Selector<Articulo>(ingresosPanel) => [
			items <=> "articulosAAgregar"
			value <=> "articulo"
			width = 100
			val bindingAcciones = items <=> "articulosAAgregar"
			bindingAcciones.adapter = new PropertyAdapter(typeof(Articulo), "nombre")
		]
		new Label(ingresosPanel).text = "Cantidad"
		new NumericField(ingresosPanel) => [
			value <=> "cantidadTemp"
			width = 100
		]
		new Label(ingresosPanel).text = "Unidad:"
		new Selector<UnidadDeMedida>(ingresosPanel) => [
			items <=> "medidas"
			value <=> "medidaTemp"
			width = 100
			val bindingAcciones = items <=> "medidas"
			bindingAcciones.adapter = new PropertyAdapter(typeof(UnidadDeMedida), "nombre")
		]

		this.loadTable(tablePanel)
//			new Label(selectorArticulosPanel).text = ""
		new Button(botonesPanel) => [
			caption = "Agregar"
			onClick[|modelObject.agregar()]
		]
		new Button(botonesPanel) => [
			caption = "Eliminar"
			onClick[|modelObject.eliminar()]
		]

//		new List<Articulo>(listBotonesPanel) => [
//			items <=> "articulosAgregados"
//			value <=> "seleccionado"
//			width = 150
//			val bindingAcciones = items <=> "articulosAgregados"
//			bindingAcciones.adapter = new PropertyAdapter(typeof(Articulo), "nombre")
//		]
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

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Crear"
			onClick[|
				this.accept()
			]
		]
	}

	override executeTask() {
		modelObject.crearReceta
		super.executeTask
	}

}
