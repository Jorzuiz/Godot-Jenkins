# Memoria

## Estado del arte(?)
### Godot Engine

Godot corre desde un ejecutable autoconetniado. No hace falta instalarlo. Existe una version normal en exe y una version sin GUi para poder usarse desde consola de comandos.

Se requiere descargar y configurar unas export templates. SOn los archvios que se usan para crear los ejecutables del juego, exe en windows o apk en android por ejemplo. Estas export tempaltes se descargan en la carpeta appdata, se requiere al menos usar una vez el editor con GUI para ello. Esto quiere decir que la maquina que corra jenkins tiene que tener instaladas estas templates, als cuales incluyen JDk y SDK de antroid para la build de android.

### Jenkins
Jenkins es un porgrama de código abierto que automatiza tareas. tiene miles de plugins mantenidos por la comunidad. En este caso vamos a instalarlo en una maquina y mediante los plugins de github y de godot estará atento a cambios en un repositorio y hará builds para comprobar que el proyecto funciona.

Jenkins se instala como servicio en un PC y corre en la direccion localhost:8080 por defecto. Para configurarlo tendremos que usar un user admin y decargar dentro los plugins.

Dentro de Jenkins podemos correr las tareas como pipelines o para empezar como freestyle.
Definimos las variables globales para los ejecutables, bash, godot, etc.
Creamos un job, configuramos el repo con las credenciales (Plugin instalado ya) y añadinmos build steps como scripts

## Glosario

1. Integracion continua

## Implementación

Jenkins corre como un servicio de fondo en una máquina. Usa y requiere de java instalado (En este caso la version 21).
> Buildear en imagenes (Docker) evita riesgos de seguridad sobre el servidor.
Estos contenedores pueden correr en diferentes máquinas y conectarse mediante una clave SSH.
Abrir docker de fondo.
Hay un bug actualmente que no deja correr contenedores linux desde windows. [Error de turno](https://issues.jenkins.io/browse/JENKINS-60473)
Hay problemas para correr la imagen en docker pipeline porque tenemos que sacarla de algun lado.
Seteamos una variable global EN JENKINS con la ruta del exe.

El archivo cfg que se usa para generar el exe/apk contiene ciertas credenciales asique se suele añadir al gitignore, hay que encontrar una manera de configurarlas desde consola i guess.
Por lo visto esto se solucionó en un [Pull Request](https://github.com/godotengine/godot/pull/76165)