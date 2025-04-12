#!/bin/bash

echo "       REPORTE DE VENTAS DIARIO        "
CSV_FILE="Ventas.csv"

if [ ! -f "$CSV_FILE" ]; then
    echo "Error: El archivo $CSV_FILE no existe."
    exit 1
fi

echo "------------------------------------"
echo "        TOP 10 MAS VENDIDOS         "
echo "------------------------------------"
tail -n +2 "$CSV_FILE" | cut -d',' -f3,4 | \
awk -F',' '{ventas[$1]+=$2} END {for (p in ventas) print ventas[p],p}' | \
sort -nr | head -n 10

echo "------------------------------------"
echo "    TOTAL INGRESOS POR CATEGORIA    "
echo "------------------------------------"
tail -n +2 "$CSV_FILE" | cut -d',' -f3,5 | \
awk -F',' '{categoria[$1]+=$2} END {for (c in categoria) printf "%-20s $%.2f\\n", c,categoria[c]}' | sort

echo "------------------------------------"
echo "          Ventas Mensuales          "
echo "------------------------------------"
tail -n +2 "$CSV_FILE" | cut -d',' -f6,5 | \
awk -F',' '{mes[$1]+=$2} END {for (m in mes) printf "%-10s $%.2f\\n", m,mes[m]}' | sort

echo "-------------------------------------"
echo "    TOTAL DE INGRESOS POR CLIENTE    "
echo "-------------------------------------"
tail -n +2 "$CSV_FILE" | cut -d',' -f2,5 | \
awk -F',' '{cl[$1]+=$2} END {for (cl in cliente) printf "%-10s $%.2f\\n", cl,cliente[cl]}' | sort


echo "------------------------------------"
echo "         Cliente destacado          "
echo "------------------------------------"
awk -F, '{
    cliente = toupper($2)
    gsub(/^ +| +$/, "", cliente)
    clientes[cliente]++
}
END {
    max = 0
    clienteDestacado = ""
    for (cl in clientes){
        if (clientes[cl] > max){
            max = clientes[cl]
            clienteDestacado = cl
        }
    }
    printf "       %s (%d compras)\n", clienteDestacado, max
}' tmp_Ventas.csv

echo "--------------------------------------"
echo "            Reporte Anual             "
echo "--------------------------------------"
awk -F, '{
    total += $5
}
END {
    printf "               $%.2f\n", total
}' tmp_Ventas.csv

rm tmp_Ventas.csv

if [ -t 1 ]; then
    echo "Presione la tecla TAB para cerrar..."
    while IFS= read -rsn1 tecla; do
        [[ $tecla == $'\t' ]] && break
    done
fi