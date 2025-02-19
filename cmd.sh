# Build container
( cd Docker_TAMU && docker build -f Dockerfile_RRMLUE_23bProd -t blubywaff/adc-cicd:24b-gpu . )

# Run container (same command for self hosted runnere)
docker run -it --rm --privileged --shm-size=15gb -v /etc/vulkan/icd.d/nvidia_icd.json:/etc/vulkan/icd.d/nvidia_icd.json -v ./TokenTAMUAutoDrive.txt:/batchtoken.txt -v './Final Run:/adc' -v './license.lic:/home/matlab/.local/share/MathWorks/RoadRunner/R2024b/Licenses/license.lic' --runtime=nvidia --gpus all -p 5901:5901 -p 6080:6080 -e MLM_LICENSE_TOKEN=$(cat TokenTAMUAutoDrive.txt | head -2 | tail -1) --mac-address 02:12:00:00:00:12 blubywaff/adc-cicd:24b-gpu -vnc
