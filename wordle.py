import random


def choose_secret(filename):
    """Dado un nombre de fichero, esta función devuelve una palabra aleatoria de este fichero transformada a mayúsculas.
    Args:
      filename: El nombre del fichero. Ej. "palabras_reduced.txt"
    Returns:
      secret: Palabra elegida aleatoriamente del fichero transformada a mayúsculas. Ej. "CREMA"
    """
    f = open("./" + filename + ".txt", mode="rt", encoding="utf-8")
    wordList = []
    for linea in f:
        wordList.append(linea)
    f.close()
    rndWord = random.choice(wordList)
    return rndWord.upper()


def compare_words(word, secret):
    """Dadas dos palabras en mayúsculas (word y secret), esta función calcula las posiciones de las letras de word que aparecen en la misma posición en secret, y las posiciones de las letras de word que aparecen en secret pero en una posición distinta.
    Args:
      word: Una palabra. Ej. "CAMPO"
      secret: Una palabra. Ej. "CREMA"
    Returns:
      same_position: Lista de posiciones de word cuyas letras coinciden en la misma posición en secret. En el caso anterior: [0]
      same_letter: Lista de posiciones de word cuyas letras están en secret pero en posiciones distintas. En el caso anterior: [1,2]
    """
    word = word.upper()
    secret = secret.upper()
    same_position = []
    same_letter = []
    indexToDelete = []
    print("compare Words")
    for i in range(0, len(word)):
        # si coincide la posicion y la letra
        if(word[i] == secret[i]):
            same_position.append(i)
        # comprobamos si hay una letra como esta en todo el string
        for secretLetter in secret:
            if(word[i] == secretLetter and word[i] not in same_position):
                same_letter.append(i)
    return same_position, same_letter


def print_word(word, same_letter_position, same_letter):
    """Dada una palabra, una lista same_position y otra lista same_letter, esta función creará un string donde aparezcan en mayúsculas las letras de la palabra que ocupen las posiciones de same_position, en minúsculas las letras de la palabra que ocupen las posiciones de same_letter y un guión (-) en el resto de posiciones
    Args:
      word: Una palabra. Ej. "CAMPO"
      same_letter_position: Lista de posiciones. Ej. [0]
      same_letter: Lista de posiciones. Ej. [1,2]
    Returns:
      transformed: La palabra aplicando las transformaciones. En el caso anterior: "Cam--"
    """
    res = ["-", "-", "-", "-", "-", ]
    for index in same_letter_position:
        temporal = list(res)
        temporal[index] = word[index].upper()
        string = "".join(temporal)
    for index in same_letter:
        temporal = list(res)
        temporal[index] = word[index].lower()
        string = "".join(temporal)
    return string


def choose_secret_advanced(filename):
    """Dado un nombre de fichero, esta función filtra solo las palabras de 5 letras que no tienen acentos (á,é,í,ó,ú). De estas palabras, la función devuelve una lista de 15 aleatorias no repetidas y una de estas 15, se selecciona aleatoriamente como palabra secret.
    Args:
      filename: El nombre del fichero. Ej. "palabras_extended.txt"
    Returns:
      selected: Lista de 15 palabras aleatorias no repetidas que tienen 5 letras y no tienen acentos
      secret: Palabra elegida aleatoriamente de la lista de 15 seleccionadas transformada a mayúsculas
    """
    forbidenList = ["á", "é", "í", "ó", "ú"]
    selected = []
    secret = ""
    count = 0
    # ELEGIMOS 15
    while (count < 15):
      # ELEGIMOS 1 ALEATORIA
        secret = choose_secret(filename)
        # SI MIDE 5 LETRAS
        if(len(list(secret)) == 6):
          print("count: " + str(count))
          print("secret: " + str(secret))
          print("len-secret: " + str(len(secret)))
          # RECORREMOS SECRET WORD
          for letter in secret:
            # RECORREMOS LETRAS PROHIBIDAS
            for forbidnLetter in forbidenList:
                # SI DENTRO DE SECRET NO HAY LETRAS PROHIBIDAS
                if letter != forbidnLetter:
                    count+=1
                    selected.append(secret)
    return selected, random.choice(selected)


def check_valid_word(selected, word):
    """Dada una lista de palabras, esta función pregunta al usuario que introduzca una palabra hasta que introduzca una que esté en la lista. Esta palabra es la que devolverá la función.
    Args:
      selected: Lista de palabras.
    Returns:
      word: Palabra introducida por el usuario que está en la lista.
    """
    while(True):
        word = input("(check_valid_word():99) - Palabra a checkear: ")
        for wordInList in selected:
            if(word.upper() == wordInList.upper()):
                return word


if __name__ == "__main__":
    selected, secret = choose_secret_advanced("palabras_extended")
    # Debug: esto es para que sepas la palabra que debes adivinar
    print("Palabra a adivinar: "+str(secret))
    for repeticiones in range(0, 6):
        word = input("Introduce una nueva palabra: ")
        same_position, same_letter = compare_words(word, secret)
        resultado = print_word(word, same_position, same_letter)
        print(resultado)
        if word == secret:
            print("HAS GANADO!!")
            exit()
    print("LO SIENTO, NO LA HAS ADIVINIDADO. LA PALABRA ERA "+secret)
