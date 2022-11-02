/**
  Processamento de imagens - Fotomosaico
  
  Fotomosaico é uma imagem que tem seus "pixels" representado por outras imagens.
  
  Para o trabalho, diminuímos a resolução da imagem, no caso uma foto da EACH (540 x 960).
  Obtida a imagem reduzida (33 x 58), copiamos seus pixels, agora em menor quantidade,
  e ampliamos essa imagem de qualidade reduzida, multiplicando cada pixel com
  a variável 'fatorDeEscala'. Assim obtemos uma imagem "pixelada".
  
  O segundo passo foi copiar a imagem pixelada e passar a cópia em escala branco e preto        
  (tons de cinza), para compararmos cada quadrado da imagem pixelada com uma foto que
  possa substituí-la. Para isto, tiramos a média de brilho dos pixels de cada foto e comparamos
  com o brilho do pixel da imagem da EACH.
  
  Terceiro passo.
    Agora com os brilhos equivalente da média dos pixels da foto com o quadrado da imagem
    pixelada, substituímos as fotos que representarão seus "pixels".
*/

PImage imagem;
PImage imagemMenor;        // *1
PImage datasetImagens[];
PImage imagensBrilho[];    // *3
float brilho[];            // *3
int largura, altura;
int fatorDeEscala = 8;     // Variável divisor da quantidade de "pixels" (quadrados na imagem resultante)
                           // Quanto maior for o valor desta variável, menor será a resolução da imagem resultante.
                           // Para o valor 16, temos uma imagem de 33 x 58

int pixeladaOuMosaica = 1;    // 0 para imagem pixelada e 1 para imagem fotomosaica

String fotoOriginal = "EACH_1.jpg";
//String diretorioImagens = "data";
String diretorioImagens = "data/dataset";

void setup()
{
  size(960, 540);
  imagem = loadImage(fotoOriginal);
  
  substituiPixels();
  
  largura = imagem.width/fatorDeEscala;    // 1*
  altura = imagem.height/fatorDeEscala;    // 1*
  diminuiImagem(imagem, largura, altura);
}

void draw()
{
  image(imagem, 0, 0);
  image(imagemMenor, 0, 0);
  exibeImagem(pixeladaOuMosaica);
}

/**
  1

  Método responsável por diminuir a imagem original.
  A imagem é reduzida para que a leitura dos pixels seja possível.
  Isto é, a leitura dos pixels é feita da imagem reduzida, já que
  esta possui resolução menor, com uma quantidade menor de pixels.
  Então plotamos a imagem "pixelada" (imagem de 960 x 540) a partir
  da imagem de menor resolução.
*/
void diminuiImagem(PImage imagem, int largura, int altura) {
  imagemMenor = createImage(largura, altura, RGB);
  imagemMenor.copy(imagem, 0, 0, imagem.width, imagem.height, 0, 0, largura, altura);    // 1*
}

/**
  Estamos criando o quadrado que representa o pixel da imagem.
  Este "pixel" terá as fotos em miniatura para a representação do
  fotomosaico.
  
  Então para cada tom de cor do quadrado, iremos substituir por
  uma foto que melhor se aproxima de sua cor. Para isto, tornamos
  a imagem em tom de escala preto e branco, somente para facilitar
  a comparação da imagem com o "pixel".
*/
//*
void exibeImagem(int var)
{
  background(0);
  imagemMenor.loadPixels();
  for (int x = 0; x < largura; x++)
  {
    for (int y = 0; y < altura; y++)
    {
      int indice = x + y * largura;
      color c = imagemMenor.pixels[indice];
      
      if (var == 0) exibeImagemPixelada(c, x, y);
      else if (var == 1) exibeImagemFotomosaica(c, x, y);
    }
  }
}

void exibeImagemPixelada(color c, int x, int y)
{
  fill(c);
  //fill(brightness(c));       // Torna a imagem em tom de escala branco e preto
  noStroke();                // Comentar esta linha dá a grade, que fica um efeito legal também.
  
  // Preenchendo os quadrados que representam o pixel da imagem fotomosaica
  // com os pixels da imagem menor e multiplicando pelo fator de escala para aumentá-la.
  rect(x * fatorDeEscala, y * fatorDeEscala, fatorDeEscala, fatorDeEscala);
}
//*/

void exibeImagemFotomosaica(color c, int x, int y) {
  int ind = int(brightness(c));
  image(imagensBrilho[ind], x * fatorDeEscala, y * fatorDeEscala, fatorDeEscala, fatorDeEscala);
}

/**
  Este método:
  1. Carrega todas as fotos (imagens) do diretório "data" no array 'arquivos' como um arquivo.
  2. Inicializa o vetor de imagens com o mesmo tamanho do array mencionado acima.
  3. Armazena estes arquivos no array de datasetImagens (PImage) como sendo uma imagem
     percorrendo o laço. Para cada iteração, pegamos o nome do arquivo, e alocamos no vetor
     de imagens como sendo um PImage.
*/
void substituiPixels() {
  File arquivos[] = listFiles(sketchPath(diretorioImagens));
  datasetImagens = new PImage[arquivos.length-1];
  brilho = new float[datasetImagens.length];
  imagensBrilho = new PImage[256];
  
  for (int i = 0; i < datasetImagens.length; i++) {
    String nomeDoArquivo = arquivos[i+1].toString();
    datasetImagens[i] = loadImage(nomeDoArquivo);
    datasetImagens[i].loadPixels();
    
    // *3
    /*
      Laço que cria a média de brilho de uma foto do dataset.
      A média de brilho de uma imagem, será usada para substituir
      1 "pixel" da nossa imagem fotomosaica.
    */
    float mediaBrilho = 0;
    for (int j = 0; j < datasetImagens[i].pixels.length; j++) {
      float brilhoAux = brightness(datasetImagens[i].pixels[j]);
      mediaBrilho += brilhoAux;
    }
    mediaBrilho /= datasetImagens[i].pixels.length;
    brilho[i] = mediaBrilho;
  }
  //printArray(arquivos);
  //imagensBrilho = new PImage[256];    // *3
  printArray(brilho);
  
  
  for (int i = 0; i < imagensBrilho.length; i++) {
    float rgb = 256;
    for (int j = 0; j < brilho.length; j++) {
      float diferenca = abs(i - brilho[j]);
          if (diferenca < rgb) {
          rgb = diferenca;
          imagensBrilho[i] = datasetImagens[j];
      }
    }
  }
}

/*
File[] listFiles(String dir) {
  File arquivo = new File(dir);
  if (arquivo.isDirectory()) {
    File arquivos[] = arquivo.listFiles();
    return arquivos;
  }
  else return null;
}
//*/
