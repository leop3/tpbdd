package Runnable

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import partials.MenuWindow

class HeladeraApp extends Application{
	new() {
		super()
	}

	static def void main(String[] args) {
		new HeladeraApp().start()
	}

	override protected Window<?> createMainWindow() {
		return new MenuWindow(this)
	}	
	
}