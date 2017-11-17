package partials

import domain.Articulo
import domain.ListaDeComestibles
import domain.Receta
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import viewModel.MenuModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class MenuWindow extends SimpleWindow<MenuModel> {

	new(WindowOwner parent) {
		super(parent, new MenuModel())
	}

	override protected createFormPanel(Panel mainPanel) {
		title = "Heladera"
		val deshabilitador = new NotNullObservable("receta")
		val recetasPanel = new Panel(mainPanel)
		recetasPanel.layout = new HorizontalLayout()
		val listaRecetasPanel = new Panel(recetasPanel)
		val botonesRecetasPanel = new Panel(recetasPanel)
		
		new Label(listaRecetasPanel).text ="Recetas"
		
		new List<Receta>(listaRecetasPanel) => [
			items <=> "recetas"
			value <=> "receta"
			val bindingRecetas = items <=> "recetas"
			bindingRecetas.adapter = new PropertyAdapter(typeof(Receta), "nombre")
			width = 150
		]
		
		new Button(listaRecetasPanel)=>[
			caption = "Almacenar Receta"
			onClick[|
				///ALMACENAR
				modelObject.almacenar()
				if(modelObject.almacenadoSatisfactorio){
					openDialog(new MensajeWindow(this,"Se ha almacenado correctamente"))
					modelObject.almacenadoSatisfactorio = false
				}
			]
			bindEnabled(deshabilitador)
		]
		new Label(botonesRecetasPanel)
		new Button(botonesRecetasPanel) => [
			caption = "Crear Receta"
			onClick[|
				openDialog(new CrearRecetaWindow(this))
			]
		]

		new Button(botonesRecetasPanel) => [
			caption = "Editar Receta"
			onClick[|
				openDialog(new EditarRecetaWindow(this, modelObject.receta))
			]
			bindEnabled(deshabilitador)
		]
		new Button(botonesRecetasPanel)=>[
			caption = "Obtener Articulos"
			onClick[|modelObject.obtenerArticulos()
				
			]
		]
//		new Button(botonesRecetasPanel) => [
//			caption = "Crear Lista de Comestibles"
//			onClick[|
//				openDialog(new ListaDeComestiblesWindow(this, new ListaDeComestiblesModel()))
//			]
//		]

		new Label(mainPanel).text ="Articulos"
		new List<Articulo>(mainPanel) => [
			items <=> "articulos"
			val bindingArticulos = items <=> "articulos"
			bindingArticulos.adapter = new PropertyAdapter(typeof(Articulo), "nombre")
			width = 150
		]
	}

	override protected addActions(Panel actionsPanel) {
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[modelObject.refreshAll]
		dialog.open
	}
}
