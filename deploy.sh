docker build -t mohamedthowbick/multi-client:latest -t mohamedthowbick/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mohamedthowbick/multi-server:latest -t mohamedthowbick/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mohamedthowbick/multi-worker:latest -t mohamedthowbick/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mohamedthowbick/multi-client:latest
docker push mohamedthowbick/multi-client:$SHA
docker push mohamedthowbick/multi-server:latest
docker push mohamedthowbick/multi-server:$SHA
docker push mohamedthowbick/multi-worker:latest
docker push mohamedthowbick/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment server=mohamedthowbick/multi-client:$SHA
kubectl set image deployments/server-deployment client=mohamedthowbick/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=mohamedthowbick/multi-worker:$SHA