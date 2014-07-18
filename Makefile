all:
	happy -gca Parclafer.y
	alex -g Lexclafer.x
	rm Testclafer.hs
	ghc --make claferSyntaxChecker.hs

clean:
	-rm -f *.log *.aux *.hi *.o *.dvi
	-rm -f Docclafer.ps

distclean: clean
	-rm -f Docclafer.* Lexclafer.* Parclafer.* Layoutclafer.* Skelclafer.* Printclafer.* Testclafer.* Absclafer.* Testclafer ErrM.* SharedString.* ComposOpclafer.* clafer.dtd XMLclafer.* Makefile*
	

