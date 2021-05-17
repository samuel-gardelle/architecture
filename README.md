# Présentation

Fait en coopération : Durand Ulysse et Gardelle Samuel.

Le projet qui suit est une tentative de construction d'un processeur. On l'a réalisé sans connaissance préalable sur le sujet. On s'est inspiré d'une série de [Ben Eater](https://www.youtube.com/watch?v=HyznrdDSSGM&list=PLowKtXNTBypGqImE405J2565dvjafglHU) qui construit un ordinateur 8-bit sur des breadboards et explique son architecture.

On a construit :
- un assembleur qui transforme des instructions en code machine (en Awk).
- un système de macro qui permet de transformer les macros en plusieurs lignes d'assembleur (en Awk)
- le circuit chargé d'exécuter le code machine (avec Logisim). Il y persiste des bugs.

# Jeu d'instruction

Les instructions sont codées sur 12 bits et manipulent des valeurs de 8 bits.

Il y a 4 instructions :
- write: Écrit une valeur de 8 bits dans le registre R3.
- move: Déplace une valeur d'un registre à un autre.
- jump: Change l'adresse du program counter.
- if jump: Effectue l'opération précédente si le registre donné a pour valeur 1.

Il n'y a pas d'interrupt ou de système qui permette de réagir à des actions extérieurs.

# Macros

Le système de macro permet d'écrire des programmes plus simplement.
La liste des macros est transparait dans ```macro.awk```.
Cette liste est suceptible de changer
Actuellement, des macros permettent de comparer, ajouter ou multiplier plus facilement.

# Installation

Pour utiliser l'assembleur il faut s'assurer d'avoir awk qui respecte la norme POSIX ainsi que xdd.
Certaines distributions linux ont une version par défaut de awk qui ne respecte pas cette norme. Cependant le packet gawk permet de pallier à ce problème.
Pour windows, awk n'est pas installé par défaut et il faut utiliser [ceci](http://gnuwin32.sourceforge.net/packages/gawk.htm).

```macro.awk``` permet de transformer les macros en assembleur et ```transpiler.awk``` et xdd permettent de le transformer en code machine. Le script ```assemble.sh``` automatise la compilation.

Pour charger un programme, il faut le charger dans la ROM du sous-circuit ```Program Counter```. Il faut ensuite lancer le ticker ou ticker manuellement.

# Bugs
- Lorsque l'on écrit des valeurs dans un registre et que l'on move par la suite, il arrive que les registres concernés prennent des valeurs arbirtraires en rapport avec les instructions précédentes.
- La RAM n'a pas encore été testée.
