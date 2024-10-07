from fpdf import FPDF

def create_pdf():
    pdf = FPDF()
    pdf.add_page()
    pdf.set_font("Arial", size=12)
    pdf.cell(200, 10, txt="Form Fillable PDF", ln=True, align='C')
    pdf.output("form_fillable.pdf")
    print("PDF created successfully.")

if __name__ == "__main__":
    create_pdf()
