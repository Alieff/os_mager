
# ====== script week01
# cara pakai :
#   1. di bash ketik perintah : "$ source cek01.sh"
#   2. pergi ke folder "pemeriksaan" (yang isinya folder2 git mahasiswa)
#   3. buat daftar_file.txt di folder "pemeriksaan", yang isinya daftar path file yang ingin di cek
#        contoh isi daftar_file.txt: 
#        sandbox/tes.txt
#        week01/report.txt
#        week01/lab01.txt
#        week01/dll.txt
#   4. cd ke folder "pemeriksaan", kemudian eksekusi perintah dibawah 
#   5. eksekusi "$ cek [nama mahasiswa]"

function adagak(){
    originalPath=$1
    path=$1
    tab="-"
    result=1

    >&2 echo -e "\e[32mchecking structure $path\e[0m"

    while [ ! -f $path ] && [ ! -d $path ]; do 
        >&2 echo "$tab $path not found, tracing parent"
        path=$(dirname $path)
        tab="$tab-"
        result=0
    done;
    
    if [ $result -eq 0 ]; then
        >&2 echo -e " \e[93m path $originalPath not found, ls available parent : $path \e[0m"
        >&2 ls $path;
    else 
        >&2 echo -e " \e[92m $originalPath found\e[0m"
        
    fi
    
    echo $result
}
function cek(){
    nama=$1

    if [ ! -f daftar_file.txt ]; then
        echo "Tolong buat daftar_file.txt yang isinya daftar file yang mau dicek, file tsb2 harus dalam folder [nama mahasiswa]/[path file]"
        echo "contoh : "
        echo "week01/report.txt"
        echo "week01/lab01.txt"
        echo "week01/dll.txt"
        echo "nanti pakainya : cek [nama mahasiswa]"

    else
        echo -e "\e[1;31m ===================================== \e[0m"
        for path_file in `cat daftar_file.txt`; do
            echo -e "\e[1;31m $path_file----\e[0m"
            if [ $(adagak $nama/$path_file) -eq 1 ]; then
                cat $nama/$path_file
            fi
            echo ""
        done
    fi
}
