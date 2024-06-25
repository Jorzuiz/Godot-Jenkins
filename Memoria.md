# Memoria

## Motivación

En el desarrollo de software es fundamental la comprobación frecuente del código, tanto la depuración como el testeo.
Los videojuegos en especial son sofware con tendencia a estos errores por su alto nivel de complejidad en los numerosos sistemas que lo componen.
Cuando una persona desarrolla un juego le puede ser fácil hacer una build y comprobar su funcionamiento, pero cuando un juego escala y aumenta el tamaño del estudio aparecen problemas a la hora de "sincronizar" el trabajo de múltiples personas y comprobar su funcionamiento.
Una manera de comprobar este funcionamiento es crear estas builds cada cierto tiempo para que el código de las personas involucradas se mantenga sano.
Esto puede requerir poco tiempo, pero a medida que el proyecto creca una build de 30 segundos puede llegar a ser de 1 hora y dejar el ordenador (u ordenadores) que lo corren inservibles.

La Integración Continua (CI por su siglas en inglés) es ensencial por los siguientes motivos:

- Detección temprana de errores: Al integrar los cambios con frecuencia, los errores se pueden ver casi tan pronto como surgen.

- Trabajo en equipo más eficiente: al realizarse las construcciones y pruebas del proyecto de manera automática, los diferentes equipos pueden centrarse en el desarrollo sin interferir entre ellos y sin tener que preocuparse de la integración entre ellos.

- Reducción de costes: Al detectarse y solucionar problemas tan pronto como surgen, se ahorra la solución de problemas en etapas posteriores al desarrollo.

- Mejora de la calidad del proyecto: Cada cambio está sujeto a pruebas automáticas y construcciones de proyecto, asegurando una calidad de código antes de aprobarse.

La automatizacion de estos procesos en ordenadores dedicados elimina no solo este tiempo de buildeo (traducir luego) y de comprobación del código con pruebas, sino que elimina la necesidad de realizarlas manualmente salvando tiempo a la larga.

## Integración continua

# Godot Engine

[Godot Engine](https://godotengine.org/) es un motor de videojuegos 2D y 3D multiplataforma, libre y de código abierto, publicado bajo la Licencia MIT, eso quiere decir, que podemos desarrollar juegos en él con fines comerciales sin necesidad de comprar una licencia.

Corre desde un ejecutable autocontenido. No hace falta instalarlo. Existe una version normal en exe y una version sin GUI para poder usarse desde consola de comandos.

Para crear build en diferentes plataformas requiere de descargar y configurar unas export templates de manera manual. Estas templates son específicas a la plataformas, exe en windows o apk en android por ejemplo. Estas export tempaltes se descargan en la carpeta appdata, se puede descargar desde el Editor o desde la [página de Godot](https://github.com/godotengine/godot-builds/releases/download/4.2-stable/Godot_v4.2-stable_export_templates.tpz). Esto quiere decir que la maquina que corra Jenkins tiene que tener instaladas estas templates, y en caso de otras plataformas, tambien requiere de la instalacion y configuracion de SDKs.

## Instalación

Godot no requiere de isntalación en el sistema pues corre desde un ejecutable autocontenido. No obstante, debemos colocarlo en una carpeta fácil de localizar, o contigurar una variable PATH y usar esa ruta para los lanzamientos de los scripts de building.

## Configuración

Godot tiene la capacidad de lanzar un proyecto con las configuraciones básicas del editor y el ejecutable. Esto está bien para pequeños proyectos o para juegos a nivel de hobbie, pero cuando queremos hacer un juego a nivel profesional queremos evitar que la gente pueda navegar lñibremente por todo nuestro proyecto.
Al crecer en tamaño y empezar a ser usado por estudios más grandes y por no programadores Godot comenzó a emplear un sistema para crear builds que compilan todo el proyecto en un ejecutable y que permite usar archivos extra para los assets y los posibles DLCs que desarrollemos para nuestro juego.

>Primero deberemos configurar en el proyecto las plataformas para las que queremos construir los ejecutables.

![alt text](.\AssetsMemoria\proyectExport.png)

>Simplemente con presionar en añadir y elegir la plataforma la añadiremos al proyecto.

![alt text](.\AssetsMemoria\platformExport.png)

>En Windows tenemos un warning inicial, podemos quitarlo desactivando la opcion modificar recursos.

![alt text](.\AssetsMemoria\warningExport.png)

Para poder crear las builds Godot usa plantillas con la configuración de cada plataforma. Antes de poder realizar una build deberemos descargar estas plantillas.

![alt text](.\AssetsMemoria\editorTemplates.png)
![alt text](.\AssetsMemoria\downloadTemplates.png)

### Adicional
Podemos crear configuraciones duplicadas de plataformas para generar diferentes versiones de nuestro proyecto que usen de manera selectiva partes de el, diferentes escenas, recursos, etc

![alt text](.\AssetsMemoria\extraTemplates.png)

Esto es útil para crear diferentes versiones del juego según nuestras necesidades sin tener que crear diferentes proyectos: demos, ramas de experimentación, versiones con telemetría para QA, paquetes con DLC, etc..

***

# Lanzamiento de la build

Para su uso con Jenkis Godot no requiere de ninguna configuración específica, se puede lanzar desde la versión del ejecutable por CLI usando parámetros.

- `--headless` permite correr el ejecutable sin lanzar una ventana. Importante para ahorrar recursos al realizar la construcción de las builds ya que al ser un proceso automático no necesitaremos la ventana.

- `--export-release "Plataforma" "Ruta"` configura la build para crear el ejecutable de la plataforma en modo release. Para ello requiere de una configuracion previa en la plataforma desde el editor. Podemos añadir configuraciones extra y comprobar el nombre de las existentes en el menú `Proyecto>Exportar`, o en el archivo `export_configurations.cfg`.
Godot permite la construcción para plataformas de ordenador de base `linux` `Windows` y `MacOS`. Para configurar una build en `android` necesitaremos coinfigurar la sdk de android manualmente.
Las configuraciones disponibles se almacenan en un archivo llamado `export_configurations.cfg` en la ruta del proyecto.

- `-verbose` Imprime por pantalla información adicional durante la construcción de la build.

- `--path "Ruta"` podemos indicar de manera especifica la carpeta que contiene el proyecto a correr en el ejecutable. Si lanzamos godot en la carpeta que contienen los archivos `project.godot` y `export_configurations.cfg` no hará falta usar este parámetro.


# Jenkins

Jenkins es un porgrama de código abierto que automatiza tareas. Tiene miles de plugins mantenidos por la comunidad. En este caso vamos a instalarlo en una maquina y mediante los plugins de Github y de Godot estará atento a cambios en un repositorio y hará builds para comprobar que el proyecto funciona.

Jenkins se instala como servicio en un PC y corre en la direccion localhost:8080 por defecto. Para configurarlo tendremos que usar un user admin y decargar dentro los plugins.

Dentro de Jenkins podemos correr las tareas como pipelines o para empezar como freestyle.
Definimos las variables globales para los ejecutables, bash, godot, etc.
Creamos un job, configuramos el repo con las credenciales (Plugin instalado ya) y añadinmos build steps como scripts.


## Glosario

1. Integracion continua

## Implementación

Jenkins corre como un servicio de fondo en una máquina. Usa y requiere de java instalado (En este caso la version 21).
por defecto corre en localhols:8080 y se accede a la app a traves de un navegador
Se genera una contraseña de admin cuando se instala

> Buildear en imagenes (Docker) evita riesgos de seguridad sobre el servidor.
Estos contenedores pueden correr en diferentes máquinas y conectarse mediante una clave SSH.
Abrir docker de fondo.
Hay un bug actualmente que no deja correr contenedores linux desde windows. [Error de turno](https://issues.jenkins.io/browse/JENKINS-60473)
Hay problemas para correr la imagen en docker pipeline porque tenemos que sacarla de algun lado.
Abandono Docker para esto, va a correr todo desde la maquina destino

Seteamos una variable global EN JENKINS con la ruta del exe.

El archivo cfg que se usa para generar el exe/apk contiene ciertas credenciales asique se suele añadir al gitignore, hay que encontrar una manera de configurarlas desde consola I guess.
Por lo visto esto se solucionó en un [Pull Request](https://github.com/godotengine/godot/pull/76165) PERO no está actualizado el gitignore asique se ha usado uno diferente.


Jenkins ser puede acceder desde fuera con la "app" en navegador. Hay que configurar los puertos del server primero. en este caso se ha creado 8080 por defecto y para acceder desde otro ordenador usamos <iplocal:8080>
tenemos que crear en el server un usuario nuevo para poder entrar.
Una vez dentro tenemos acceso a las pipelines, podemos crear cosas.

La pipeline está configurada de la siguiente manera
$$\boxed{Deteccion de algo}\rightarrow\boxed{Checkout del código}\rightarrow\boxed{Ejecucion del script de build}$$

## Justificacion

-Godot: Se ha elegido Godot porque es de código abierto, gratuito y las builds son ligeras. Hay múltiples juegos "grandes" en la industria recientemente publicados con Godot y está cogiendo fuerza.

-Jenkins: Se ha elegido Jenkins porque es una herramienta de código abierto, es de las más extendidas para automatización, lo cual hace quehaya una gran cantidad de plugins que se mantienen y actualizan continuamente y hay tutoriales de ´facil acceso.
Los 'trabajos' de automatizacion pueden configurarse tanto en la app como en un archivo jenkinsfile. ambas opciones tienen ventajas y desventajas, más seguridad o más facilidad de acceso por los usuarios, etc..

-Servidor Dedicado: Aunque las builds pueden correrse en la nube o incluso en contenedores de Docker se ha decidido hacer así por simplicidad

## Documentacion - Referencias

[Construccion de contenedores de Godot](https://github.com/godotengine/build-containers)
[Scripts de building en container](https://github.com/godotengine/godot-build-scripts)
[Implementación de automatización en Gitlab](https://gitlab.com/greenfox/godot-build-automation)