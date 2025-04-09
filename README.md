# HandsRecognition
 AI Hands recognition

Este programa permite tocar notas musicales usando solo gestos de la mano frente a una cámara. Detecta la mano, identifica la posición de los dedos y reproduce un sonido cuando detecta que un dedo está cerrado. Todo se muestra en una interfaz visual donde se ve la cámara y los puntos clave de la mano, haciendo que sea fácil y divertido de usar.

## Prerrequisitos
 Para poder utilizar el software, es necesario contar con:
-	MATLAB instalado en tu sistema. Versión utilizada: 24.2.0.2833386 (R2024b) Update 4
-	Deep Learning Toolbox de MATLAB.
-	Deep Learning Toolbox Converter for ONNX Model Format para cargar y utilizar el modelo de reconocimiento de manos

## Descarga del Software
A continuación, vamos a descargar el software de la aplicación. Lo podemos encontrar en el siguiente enlace: https://github.com/DannaZal/HandsRecognition.

## Estructura
La estructura del proyecto consta de un script principal ejecutar.m y otros scripts que contienen las funciones del programa para preprocesamiento, postprocesamiento y dibujo de estructuras. Las ultimas mencionadas están distribuidas como:

![image](https://github.com/user-attachments/assets/c95e18b3-fc3f-47ba-b6ae-b5e491f1624c)

A su vez existe una carpeta models que contiene los modelos usados para procesar las imágenes. El modelo palm_detection_full_inf_post_192x192.onnx se encarga de detectar las manos de una imagen, mientras que hand_landmark_sparse_Nx3x224x224.onnx es el que se utiliza para obtener los puntos referenciales de la mano. Ambos modelos se encuentran en el siguiente enlace: https://github.com/PINTO0309/hand-gesture-recognition-using-onnx/tree/main/model

Finalmente tenemos la carpeta GUI, que contiene el archivo mlapp que es el que sirve para mostrar una interfaz gráfica amigable para que el usuario se sienta cómodo al usar el aplicativo. 

## Ejecución
Para ejecutar el programa abrimos el archivo ejecutar.m y lo corremos. Esto abrirá la siguiente ventana:

![image](https://github.com/user-attachments/assets/34ad83a2-a317-469e-a139-7c955a82e2bf)

Una vez la veamos presionamos el botón de Iniciar Video. Puede tardar un tiempo en cargar los modelos, al ejecutarse por primera vez, por lo que debemos esperar hasta que se muestre el video de nuestra cámara en la ventana. 

La aplicación es capaz de detectar correctamente hasta 2 manos. Donde cada dedo exceptuando los pulgares se encargan de reproducir una nota distinta. A continuación, se muestra un esquema de las respectivas notas para cada dedo desde nuestra perspectiva. 

![image](https://github.com/user-attachments/assets/6a4d1a10-8dff-4538-a9e6-bfb922c749e0)

Finalmente, para hacer sonar la nota, solo debemos de doblar el dedo respectivo, así de manera automática, nuestro aplicativo emitirá el sonido correspondiente. 
En la zona de notas musicales detectadas, que contiene todas las notas, su respectivo foco se encenderá para indicar cual nota esta siendo tocada.

![image](https://github.com/user-attachments/assets/917163ff-6731-48fb-8d23-5bbbb1ae0c28)



