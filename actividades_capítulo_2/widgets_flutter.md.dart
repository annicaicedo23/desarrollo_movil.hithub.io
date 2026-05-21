Investigación de widgets fundamentales en Flutter
Nombre del estudiante:Anny Vanessa Caicedo Londoño
Curso: Desarrollo de Aplicaciones Móviles
Docente: Oscar Leonel Sanchez Conde
Fecha: 17 de mayo de 2026

1. Visibility

Descripción:

El widget Visibility controla si un widget se muestra u oculta en pantalla sin necesidad de eliminarlo del árbol de widgets. Esto es muy útil cuando se necesita mostrar u ocultar elementos según condiciones lógicas, como errores de validación, mensajes de estado o secciones opcionales de una interfaz. A diferencia de usar condicionales con if, Visibility permite mantener el widget en memoria y controlar si ocupa espacio en el diseño o no.

Ejemplo del código:

import 'package:flutter/material.dart';


void main() {
  runApp(MyAppBasico());
}


class MyAppBasico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Visibility(
              visible: true, // Propiedad fija en true para mostrar el hijo
              child: Text(
                'Este texto es visible',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}






Explicación del ejemplo:La propiedad visible recibe un valor booleano. Cuando es true, el widget hijo se muestra con normalidad. Cuando es false, el hijo desaparece de la pantalla. En este caso el texto se muestra porque visible es true.

Personalización:
Propiedad
Descripción
Ejemplo
visible
Define si el widget hijo se muestra o no.
visible: false
maintain Size
Conserva el espacio del widget aunque esté oculto.
maintain Size: true
maintainState
Mantiene el estado interno del widget aunque esté oculto.
maintainState: true
maintainAnimation
Mantiene activas las animaciones del widget oculto.
maintainAnimation: true
replacement
Widget alternativo que se muestra cuando visible es false.
replacement: SizedBox()
child
Widget que será mostrado u ocultado.
child: Text('Mensaje')


Ejemplo de personalización:

import 'package:flutter/material.dart';


void main() {
  runApp(MyAppPersonalizado());
}


class MyAppPersonalizado extends StatefulWidget {
  @override
  State<MyAppPersonalizado> createState() => _MyAppPersonalizadoState();
}


class _MyAppPersonalizadoState extends State<MyAppPersonalizado> {
  // Variable de estado que controla la visibilidad dinámicamente [cite: 21]
  bool _mostrarError = true;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              // Widget Visibility con personalizaciones de tamaño y reemplazo [cite: 20]
              Visibility(
                visible: _mostrarError,
                maintainSize: false, // Desaparece el espacio por completo al ocultarse [cite: 22, 30]
                maintainState: true, // Conserva el estado en memoria [cite: 23]
                replacement: const SizedBox.shrink(), // Reemplazo vacío sin margen residual [cite: 24, 31]
                child: const Text(
                  'El campo es obligatorio',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
             
              const SizedBox(height: 20),
             
              // Botón para alternar el estado y probar el comportamiento en vivo
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _mostrarError = !_mostrarError; // Invierte el valor booleano
                  });
                },
                child: Text(_mostrarError ? 'Ocultar Error' : 'Mostrar Error'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Cuando _mostrarError es false, el mensaje desaparece y no ocupa espacio (maintainSize: false). El replacement con SizedBox.shrink() asegura que no quede ningún espacio residual. Este patrón es ideal para mensajes de validación en formularios.
Conclusión:Visibility es fundamental para crear interfaces dinámicas sin reconstruir el árbol de widgets. Mejora el rendimiento y simplifica la lógica de mostrar u ocultar elementos en pantalla.

2. FractionallySizedBox
Descripción:El widget FractionallySizedBox permite definir el tamaño de un widget como una fracción del espacio disponible de su contenedor padre, en lugar de usar píxeles fijos. Es muy útil para crear interfaces responsivas que se adaptan a diferentes tamaños de pantalla.
Por ejemplo, se puede crear un botón que siempre ocupe el 80% del ancho de la pantalla sin importar si es un teléfono pequeño o una tablet.

Ejemplo del código:

import 'package:flutter/material.dart';


void main() {
  runApp(MyAppFractionalBasico());
}


class MyAppFractionalBasico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            // Se envuelve en un SizedBox con ancho infinito para darle una referencia de espacio al hijo
            child: SizedBox(
              width: double.infinity,
              child: FractionallySizedBox(
                widthFactor: 0.8, // Ocupa el 80% del ancho disponible
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Botón al 80%'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


widthFactor: 0.8 indica que el hijo ocupará el 80% del ancho de su contenedor. Si la pantalla tiene 400 píxeles de ancho, el botón medirá 320 píxeles automáticamente. No se necesita conocer el tamaño exacto de la pantalla.

Perzonalización:

Propiedad
Descripción
Ejemplo
widthFactor
Define la fracción del ancho que ocupará el widget hijo (de 0.0 a 1.0).
widthFactor: 0.5
heightFactor
Define la fracción de la altura que ocupará el widget hijo (de 0.0 a 1.0).
heightFactor: 0.3
alignment
Permite alinear el widget hijo dentro del espacio disponible.
alignment: Alignment.center
child
Define el widget que estará dentro del FractionallySizedBox.
child: ElevatedButton()


Ejemplo de personalización:

import 'package:flutter/material.dart';


void main() {
  runApp(MyAppFractionalPersonalizado());
}


class MyAppFractionalPersonalizado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FractionallySizedBox(
                  widthFactor: 1.0, // 100% del ancho disponible
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text('Ancho completo', style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(height: 12),
                FractionallySizedBox(
                  widthFactor: 0.6, // 60% del ancho disponible
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('60% del ancho'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


el primero ocupa el 100% del ancho y el segundo solo el 60%. Ambos se adaptan automáticamente a cualquier tamaño de pantalla, lo que hace el diseño completamente responsivo sin necesidad de MediaQuery.

Conclusión: FractionallySizedBox simplifica la creación de layouts responsivos. Es especialmente valioso cuando se construyen aplicaciones para múltiples tamaños de pantalla y se quiere evitar el uso constante de MediaQuery.of(context).size.

3. AnimatedContainer
Descripción: el widget AnimatedContainer es una versión animada del Container clásico. Cuando alguna de sus propiedades cambia (color, tamaño, bordes, etc.), la transición ocurre automáticamente con una animación suave, sin necesidad de usar controladores de animación complejos.
Es ideal para crear efectos visuales de transición como expandir tarjetas, cambiar colores al seleccionar un elemento o revelar contenido de forma progresiva.

Ejemplo del código:

import 'package:flutter/material.dart';


void main() {
  runApp(MyAppAnimatedBasico());
}


class MyAppAnimatedBasico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300), // Duración de la transición
            width: 200,
            height: 100,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text('Animado', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}


La propiedad duration define cuánto tiempo tarda la animación cuando cambia alguna propiedad. Si el valor de width, height o color cambia a través del estado, Flutter animará automáticamente la transición entre el valor anterior y el nuevo.

Personalización:

Propiedad
Descripción
Ejemplo
duration
Define cuánto tiempo dura la animación.
duration: Duration(milliseconds: 500)
curve
Define el tipo de transición o aceleración de la animación.
curve: Curves.easeInOut
color
Permite cambiar y animar el color de fondo.
color: Colors.red
width / height
Permite animar cambios de tamaño.
width: _expandido? 300 : 150
decoration
Permite animar bordes, sombras, colores y esquinas redondeadas.
decoration: BoxDecoration(...)
child
Widget que estará dentro del contenedor animado.
child: Text('Hola')


Ejemplo de personalización:

import 'package:flutter/material.dart';


void main() {
  runApp(MyAppAnimatedPersonalizado());
}


class MyAppAnimatedPersonalizado extends StatefulWidget {
  @override
  State<MyAppAnimatedPersonalizado> createState() => _MyAppAnimatedPersonalizadoState();
}


class _MyAppAnimatedPersonalizadoState extends State<MyAppAnimatedPersonalizado> {
  bool _expandido = false; // Variable de estado que conmuta la animación


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _expandido = !_expandido; // Invierte el valor al tocar
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: _expandido ? 280 : 140,
              height: _expandido ? 160 : 80,
              decoration: BoxDecoration(
                color: _expandido ? Colors.deepOrange : Colors.orange,
                borderRadius: BorderRadius.circular(_expandido ? 20 : 8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: _expandido ? 12 : 4,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                _expandido ? 'Expandido' : 'Tocar',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


Al tocar el widget, _expandido cambia y el AnimatedContainer transiciona suavemente entre los dos estados: tamaño, color, bordes redondeados y sombra se animan al mismo tiempo con una curva easeInOut. Todo esto sin un solo AnimationController.

Conclusión:AnimatedContainer es uno de los widgets más poderosos para agregar vida a una interfaz sin complejidad adicional. Elimina la necesidad de controladores de animación en casos de transiciones simples y hace que las aplicaciones se sientan fluidas y modernas.

4. LayoutBuilder
Descripción: El widget LayoutBuilder es una herramienta fundamental para el diseño responsivo. A diferencia de otros widgets, este proporciona las restricciones (constraints) de su widget padre durante el proceso de construcción, permitiendo que la interfaz se adapte dinámicamente al espacio disponible.

Ejemplo del código:

import 'package:flutter/material.dart';


void main() {
  runApp(MyAppLayoutBasico());
}


class MyAppLayoutBasico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // Muestra dinámicamente el ancho máximo del contenedor
              return Text('El ancho máximo es: ${constraints.maxWidth}');
            },
          ),
        ),
      ),
    );
  }
}

LayoutBuilder utiliza la propiedad builder, que recibe dos parámetros:
context: proporciona información del árbol de widgets.
constraints: contiene las restricciones de tamaño disponibles.
Dentro del builder, se accede a constraints.maxWidth para mostrar en pantalla el ancho máximo disponible cada vez que el tamaño del contenedor cambia (por ejemplo, al rotar el dispositivo o cambiar el tamaño de la ventana), el builder se ejecuta nuevamente, actualizando automáticamente la interfaz.


Personalización:

Propiedad
Descripción
Ejemplo
builder
Función obligatoria que construye el widget según el espacio disponible.
builder: (context, constraints) {}
constraints.maxWidth
Obtiene el ancho máximo disponible para el widget.
constraints.maxWidth > 600
constraints.maxHeight
Obtiene la altura máxima disponible para el widget.
constraints.maxHeight
child
Widget que se construirá dependiendo del espacio.
child: Container()


Ejemplo personalización:

import 'package:flutter/material.dart';


void main() {
  runApp(MyAppLayoutPersonalizado());
}


class MyAppLayoutPersonalizado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SizedBox(
            height: 160,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // Vista de escritorio o pantalla ancha
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.blue,
                          child: Center(
                            child: Text('Menú lateral', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.blue.shade50,
                          child: Center(child: Text('Contenido principal')),
                        ),
                      ),
                    ],
                  );
                } else {
                  // Vista móvil o pantalla estrecha
                  return Column(
                    children: [
                      Container(
                        color: Colors.blue,
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text('Barra superior', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.blue.shade50,
                          child: Center(child: Text('Contenido principal')),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}


sirve para analizar el ancho disponible de la pantalla: Si el ancho es mayor a 600 píxeles, interpreta que se trata de una pantalla grande (como una tablet o una aplicación web), y organiza los elementos horizontalmente usando Row.Si el ancho es menor o igual a 600 píxeles, interpreta que se trata de un dispositivo móvil, y organiza los elementos verticalmente usando Column.Esto permite que la interfaz se adapte automáticamente al dispositivo sin necesidad de crear múltiples pantallas.
 

Conclusión: LayoutBuilder es una herramienta fundamental para el desarrollo responsivo en Flutter. Permite crear interfaces flexibles, optimizar el uso del espacio disponible y mejorar la experiencia del usuario en diferentes dispositivos. Además, ayuda a prevenir errores visuales como el overflow y facilita mantener una sola base de código para múltiples plataformas.

5.Wrap
Descripción:El widget Wrap es similar a Row o Column, pero con una diferencia clave: cuando los hijos no caben en una sola línea, automáticamente los pasa a la siguiente fila o columna. Es el widget ideal para mostrar etiquetas, chips, filtros, categorías o cualquier conjunto de elementos de tamaño variable.Evita el error de desbordamiento que ocurre cuando se usa Row con muchos elementos y no hay suficiente espacio horizontal.

Ejemplo de código:
import 'package:flutter/material.dart';


void main() {
  runApp(MyAppWrapBasico());
}


class MyAppWrapBasico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8,    // Distancia horizontal entre los Chips
              runSpacing: 4, // Distancia vertical entre las líneas que se generen
              children: [
                Chip(label: Text('Flutter')),
                Chip(label: Text('Dart')),
                Chip(label: Text('Android')),
                Chip(label: Text('iOS')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Los cuatro Chip se distribuyen en fila. Si no caben todos en el ancho disponible, los que sobran pasan automáticamente a la siguiente línea. No se produce ningún error de desbordamiento.

Personalización:
Propiedad
Descripción
Ejemplo
spacing
Espacio horizontal entre hijos.
spacing: 8.0
runSpacing
Espacio vertical entre filas.
runSpacing: 4.0
alignment
Alineación horizontal de los hijos en cada fila.
alignment: WrapAlignment.center
direction
Dirección principal: horizontal o vertical.
direction: Axis.horizontal


Ejemplo de la personalización:

import 'package:flutter/material.dart';


void main() {
  runApp(MyAppWrapPersonalizado());
}


class MyAppWrapPersonalizado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: [
                'Flutter', 'Dart', 'Firebase', 'REST API',
                'GetX', 'BLoC', 'Provider', 'Hive', 'SQLite'
              ].map((tecnologia) => FilterChip(
                label: Text(tecnologia),
                selected: false,
                onSelected: (_) {},
                backgroundColor: Colors.indigo.shade50,
                labelStyle: TextStyle(color: Colors.indigo),
              )).toList(),
            ),
          ),
        ),
      ),
    );
  }
}


Esto genera dinámicamente una serie de FilterChip a partir de una lista de tecnologías. El Wrap los distribuye con un espacio de 10 entre ellos horizontalmente y 8 entre filas, organizándose automáticamente según el ancho disponible. Es perfecto para secciones de filtros o habilidades en un perfil.

Conclusión: Wrap resuelve un problema muy común que Row no puede manejar: el desbordamiento de elementos. Es indispensable para cualquier interfaz con conjuntos de etiquetas, filtros o chips de tamaño dinámico.
