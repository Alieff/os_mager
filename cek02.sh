
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
	>&2 echo -e " \e[93m parent($path) found, ls available parent :\e[0m"
        >&2 ls -a $path;
    else 
        >&2 echo -e " \e[92m $originalPath found\e[0m"
        
    fi
    
    echo $result
}
function cek_file(){
	nama=$1
	path_file=$2
	metode=$3

	if [ -z "$metode" ] ; then
	    metode="exist"
	fi

	echo -e "\e[1;31m $path_file---- perintah : $metode \e[0m"
	if [ $(adagak $nama/$path_file) -eq 1 ]; then
		if [ $metode == "exist" ]; then
		   PASSED=$nama/$path_file
		   if [[ -d $PASSED ]]; then
			echo "$PASSED is a directory"
			ls -a $PASSED
		    elif [[ -f $PASSED ]]; then
			echo "$PASSED is a file"
		    else
			echo "$PASSED is not valid"
		    fi 
		elif [ $metode == "cat" ]; then
		    cat $nama/$path_file
		elif [ $metode == "eq" ]; then
		    file_pembanding=$4
		    python samagak.py $nama/$path_file kunci_jawaban/$file_pembanding
		elif [ $metode == "run" ]; then
		    ./$nama/$path_file
		fi
	fi
	echo ""

}
function cek(){
    nama=$1

    if [ ! -f daftar_file.txt ]; then
        echo "Tolong buat daftar_file.txt yang isinya daftar file yang mau dicek, file tsb2 harus dalam folder [nama mahasiswa]/[path file]"
        echo "contoh : "
        echo "week01/report.txt [kode pengecekan]"
        echo "week01/lab01.txt [kode pengecekan]"
        echo "week01/dll.txt [kode pengecekan]"
        echo "nanti pakainya : cek [nama mahasiswa]"
        echo "kode pengecekan : "
	echo "exist : mengecek apakah file ada atau tidak"
	echo "cat : meng-cat isi file"
	echo "eq [nama file]: mengecek apakah isi sama dengan file [nama file],harap membuat folder eq yang berisi [nama file] tsb"
	echo "run : menjalankan file tsb (asumsi : bisa di run dengan ./[nama file] "


    else
        echo -e "\e[1;31m ===================================== \e[0m"
        #for path_file in `cat daftar_file.txt`; do
	#    cek_file $nama $path_file
        #done
	while read perintah ; do
	    cek_file $nama $perintah
	done < daftar_file.txt;
    fi
}
