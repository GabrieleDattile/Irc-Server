import string
import random
from fpdf import FPDF
from PyPDF2 import PdfFileWriter

def genera_password(sicurezza):
    if sicurezza == 'alta':
        caratteri = string.ascii_letters + string.digits + string.punctuation
    elif sicurezza == 'media':
        caratteri = string.ascii_letters + string.digits
    else:
        caratteri = string.ascii_letters

    lunghezza = 12
    password = ''.join(random.choice(caratteri) for i in range(lunghezza))
    return password

password = genera_password('alta')

# Crea un PDF con la password
pdf = FPDF()
pdf.add_page()
pdf.set_font("Arial", size = 15)
pdf.cell(200, 10, txt = password, ln = True, align = 'C')
pdf_filename = "password.pdf"
pdf.output(pdf_filename)

# Protegge il PDF con una password
writer = PdfFileWriter()
reader = PdfFileReader(pdf_filename)
writer.addPage(reader.getPage(0))

file_password = "password_protezione"
writer.encrypt(file_password)

with open("password_protetta.pdf", "wb") as f:
    writer.write(f)

print("La password è stata salvata nel file 'password_protetta.pdf' che è protetto da una password.")
