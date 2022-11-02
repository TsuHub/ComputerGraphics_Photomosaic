# ComputerGraphics_Photomosaic

TsuHub

## Apresentação

<p align="left">

	O programa tem a finalidade de gerar uma imagem fotomosaica. Uma imagem fotomosaica apresenta imagens para representar seus pixels.
  Foi utilizada a imagem da EACH-USP para o processamento da imagem (https://github.com/TsuHub/ComputerGraphics_Photomosaic/blob/main/FotoMosaico/results/0%20-%20EACH_1.jpg).

  A sequência das imagens abaixo representam o fluxo do o processamento da imagem.
  
</p>

![Original](https://github.com/TsuHub/ComputerGraphics_Photomosaic/blob/main/FotoMosaico/results/0%20-%20EACH_1.jpg?raw=true)
![Pixelada Colorida](https://github.com/TsuHub/ComputerGraphics_Photomosaic/blob/main/FotoMosaico/results/0.1%20-%20ImagemPixeladaColorida.jpg?raw=true)
![Pixelada Cinza](https://github.com/TsuHub/ComputerGraphics_Photomosaic/blob/main/FotoMosaico/results/0.2%20-%20ImagemPixeladaCinza.jpg?raw=true)
![Fotomosaico 1](https://github.com/TsuHub/ComputerGraphics_Photomosaic/blob/main/FotoMosaico/results/0.3%20-%20Imagem%20Fotomosaica%201.jpg?raw=true)
![Fotomosaico 2](https://github.com/TsuHub/ComputerGraphics_Photomosaic/blob/main/FotoMosaico/results/Imagem%20Fotomosaica%205.jpg?raw=true)
![Fotomosaico 3](https://github.com/TsuHub/ComputerGraphics_Photomosaic/blob/main/FotoMosaico/results/Imagem%20Fotomosaica%206%20-%20Pixel%20aumentado%20em%208%20vezes.jpeg?raw=true)
![Fotomosaico 3](https://github.com/TsuHub/ComputerGraphics_Photomosaic/blob/main/FotoMosaico/results/Imagem%20Fotomosaica%207%20-%20Pixel%20aumentado%20em%204%20vezes.jpeg?raw=true)

## Execução do programa

<p align="left">

	É necessário possuir o Processing para executar o programa.
  Para este projeto, foi utilizado o Processing 3.5.4
	
	Para rodar o programa, basta executar o arquivo FotoMosaico/FotoMosaico.pde
  com o processing.exe
	
</p>

## Estrutura

<p align="left">

	O projeto é composto por:
    - EACH_1.jpg (imagem original)
    - data (diretório com 143 arquivos em formato .jpg)
    - FotoMosaico.pde
      - setup()
      - draw()
      - diminuiImagem(PImage imagem, int largura, int altura)
      - exibeImagem(int var)
      - exibeImagemPixelada(color c, int x, int y)
      - exibeImagemFotomosaica(color c, int x, int y)
      - substituiPixels()

</p>

## Descrição

<p align="left">

	Para a geração da imagem fotomosaica, foi diminuída a resolução da imagem EACH_1.jpg de 540 x 960 para 33 x 58. Em cima desta imagem,
  a escala dos pixels da imagem foi aumentada para a escala da foto original, utilizando a variável "fatorDeEscala" igualando a 8 pixels
  para gerar a imagem de resolução menor em 540 x 960, resultando na imagem abaixo:
  
  ![Pixelada Colorida](https://github.com/TsuHub/ComputerGraphics_Photomosaic/blob/main/FotoMosaico/results/0.1%20-%20ImagemPixeladaColorida.jpg?raw=true)
  
  Posteriormente, foram coletadas imagens da EACH-USP e formamos um pequeno dataset de 8 fotos para a formação do fotomosaico. Para representar
  o fotomosaico da imagem da USP com outras imagens da USP, para fazer uso de metalinguagem. Porém, oito imagens são insuficientes para este objetivo,
  portanto um novo dataset com 143 imagens foi criado, com imagens da EACH-USP quanto imagens aleatórias encontradas na internet.

</p>


## Metodo utilizado

<p align="left">

	Com as imagens do dataset, uma média de brilho dos pixels de cada uma das 143 imagens tirada e comparada com o brilho dos "pixels"
  (quadrados 16 x 16) da imagem original (https://github.com/TsuHub/ComputerGraphics_Photomosaic/blob/main/FotoMosaico/results/0%20-%20EACH_1.jpg).
  A comparação foi feita utilizando escalas de tons de preto e branco das imagens do dataset e da imagem original. Copiada a imagem pixelada,
  foi passada uma cópia em escala preto e branco (tons de cinza), obtendo o resultado abaixo:
  
  ![Pixelada Cinza](https://github.com/TsuHub/ComputerGraphics_Photomosaic/blob/main/FotoMosaico/results/0.2%20-%20ImagemPixeladaCinza.jpg?raw=true)
  
  Assim, a comparação vai de 0 a 255 em um único canal de cores, diminuindo em 3 vezes o processamento, comparado ao uso dos canais RGB.
  
  O passo seguinte foi substituir os quadrados 16 x 16 da imagem original pelas fotos do dataset (143 imagens) de acordo com a proximidade de brilho
  de seus pixels com a média do brilho dos pixels das fotos.
  
</p>


## Conclusão

<p align="left">

	Quanto maior a resolução, melhor é o compreendimento da imagem, porém, menores são os pixels, fazendo com que não seja trivial identificar
  as fotos que compõe os pixels da imagem.
  
  E quanto maior o volume amostral do dataset, mais próximo será ao da imagem original.
  
</p>
