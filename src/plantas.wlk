import wollok.game.*
import hector.*

class Planta {
	
	var property position
	method tipo() = null
	method serPlantadaEn(pos) {
		game.addVisualIn(self,pos)
		position = pos
	} 
	
	method estaListaParaLaCosecha() = true
	
	method serRegada() {}
	//method crear() {}
	//method valor{}
	method serCosechada() {
		if (self.estaListaParaLaCosecha()) {
			hector.guardarPlantaCosechada(self)
			game.removeVisual(self)
		}
	}
}


class Maiz inherits Planta {
	var imagen = "corn_baby.png"
	method image() = imagen
	override method tipo() = "maiz"
	method valor() = 150

	method crear() {
		return new Maiz()
	}

	method esAdulto() {
		return self.image() == "corn_adult.png"
	}

	override method serRegada() {
		if (not self.esAdulto()) {
			imagen = "corn_adult.png"
			game.removeVisual(self) //OJO, si no se remueve el anterior, el obj sigue existiendo (silenciosamente)
			game.addVisual(self)
		} 
	}
	
	override method estaListaParaLaCosecha() = self.esAdulto()
}

class Trigo inherits Planta {
	var etapa = trigoEtapa0
	var imagen = etapa.image()
//	var property valor = etapa.valor()
	method image() = imagen
	override method tipo() = "trigo"
	
	method valor() = etapa.valor()
	
	method crear() {
		return new Trigo()
	}
	
	override method serRegada() {
		etapa = etapa.siguienteEtapa()
		imagen = etapa.image()
		game.removeVisual(self)
		game.addVisual(self)
//		valor= etapa.valor()
	}
	
	override method estaListaParaLaCosecha() = (etapa == trigoEtapa2) || (etapa == trigoEtapa3)
}

object trigoEtapa0 {
	method image() = "wheat_0.png"
	method siguienteEtapa() = trigoEtapa1
	method valor() = 0 //nunca ejecuta
}

object trigoEtapa1 {
	method image() = "wheat_1.png"
	method siguienteEtapa() = trigoEtapa2
	method valor() = 0 //nunca ejecuta
}

object trigoEtapa2 {
	method image() = "wheat_2.png"
	method siguienteEtapa() = trigoEtapa3
	
	method valor() = 100
}

object trigoEtapa3 {
	method image() = "wheat_3.png"
	method siguienteEtapa() = trigoEtapa0

	method valor() = 200
}


class Tomaco inherits Planta {
	var imagen = "tomaco.png"
	method image() = imagen
	override method tipo() = "tomaco"

	method valor() = 80

	method crear() {
		return new Tomaco()
	}
	
	method estaEnElBorde() {
		return self.position().y() == (game.height() - 1)
	}

	override method serRegada() {
		var plantita = new Tomaco()
		
		if(not self.estaEnElBorde()) {
		game.addVisualIn(plantita,self.position().up(1))
		plantita.position(new Position(self.position().x(),self.position().y() + 1))
		} else {
			game.addVisualIn(plantita,self.position().down(game.height() - 1))
			plantita.position(new Position(self.position().x(),0))
		}
		game.removeVisual(self)
	}
	
}