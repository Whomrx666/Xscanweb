# Variabel
INSTALL_SCRIPT=install.sh
PYTHON=python3
MAIN=Xscanweb.py

install:
	@echo "Menjalankan script instalasi..."
	bash $(INSTALL_SCRIPT)
	@echo "Instalasi selesai!"

run:
	@echo "Menjalankan aplikasi..."
	$(PYTHON) $(MAIN)

clean:
	@echo "Membersihkan cache Python..."
	find . -type d -name "__pycache__" -exec rm -rf {} +
	@echo "Cache Python telah dibersihkan."