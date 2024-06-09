# Memoria

## Motivación

En el desarrollo de software es fundamental la comprobación frecuente del código, tanto la depuración como el testeo.
Los videojuegos concretamente son sofware con reputacion por su alto nivel de complejidad.
Cuando una persona desarrolla un juego le puede ser fácil hacer una build y comprobar su funcionamiento, pero cuando un juego escala y aumenta el tamaño del estudio aparecen problemas a la hora de "sincronizar" el trabajo de múltiples personas y comprobar su funcionamiento.
Una manera de comprobar este funcionamiento es crear estas builds cada cierto tiempo para que el código de las personas involucradas se mantenga sano.
Esto puede requerir poco tiempo, pero a medida que el proyecto creca una build de 30 segundos puede llegar a ser de 1 hora y dejar el ordenador (u ordenadores) que lo corren inservibles.

La automatizacion de estos procesos en ordenadores dedicados elimina no solo este tiempo de buildeo (traducir luego) sino que elimina la necesidad de realizarlas manualmente salvando tiempo a la larga.


## Estado del arte(?)

## Godot Engine

Godot corre desde un ejecutable autoconetniado. No hace falta instalarlo. Existe una version normal en exe y una version sin GUI para poder usarse desde consola de comandos (headless).

Se requiere descargar y configurar unas export templates de manera manual. Son los archvios que se usan para crear los ejecutables del juego, exe en windows o apk en android por ejemplo. Estas export tempaltes se descargan en la carpeta appdata, se requiere al menos usar una vez el editor con GUI para ello. Esto quiere decir que la maquina que corra Jenkins tiene que tener instaladas estas templates, las cuales incluyen JDk y SDK de antroid para la build de android.

## Jenkins

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
Por lo visto esto se solucionó en un [Pull Request](https://github.com/godotengine/godot/pull/76165)

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