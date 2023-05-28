# Docker cpp build test  

---

With launched docker and kubernetes for docker daemon run  
- build `docker buildx build -t docker-sample-test --memory=6g .`  
- run `docker run --memory=6g -it docker-sample-test`  

---

Repo cantain example to build cpp project based on CMake with 2 frameworks:  
1. Downloaded framework through packet manager (Qt from APT);
2. Locally builded from sources framework (VTK from GitHub).
