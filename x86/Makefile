##
## Makefile for epitech in /home/chapuis_s/rendu/
## 
## Made by chapui_s
## Login   <chapui_s@epitech.eu>
## 
## Started on  Sun Mar 22 01:51:09 2015 chapui_s
## Last update Sun Mar 22 01:52:12 2015 chapui_s
##

NAME			= libasm32.so

SRC			= strlen.asm		\
			  memmove.asm		\
			  memset.asm		\
			  rindex.asm		\
			  strcasecmp.asm	\
			  strchr.asm		\
			  strcmp.asm		\
			  strcspn.asm		\
			  strncmp.asm		\
			  strpbrk.asm		\
			  strstr.asm		\
			  memcpy.asm

OBJ			= $(SRC:.asm=.o)

NASM			= nasm

override NASMFLAGS	+= -f elf -Werror

LD			= ld

LDFLAGS			= -shared -m elf_i386

RM			= rm -f


$(NAME):	$(OBJ)
		$(LD) $(LDFLAGS) -o $(NAME) $(OBJ)

all:		$(NAME)

%.o:		%.asm
		$(NASM) $(NASMFLAGS) -o $@ $<

clean:
		$(RM) $(OBJ)

fclean:		clean
		$(RM) $(NAME)

re:		fclean all
