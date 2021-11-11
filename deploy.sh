docker build -t ndbinh/multi-client:latest -t ndbinh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ndbinh/multi-server:latest -t ndbinh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ndbinh/multi-worker:latest -t ndbinh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ndbinh/multi-client:latest
docker push ndbinh/multi-server:latest
docker push ndbinh/multi-worker:latest

docker push ndbinh/multi-client:$SHA
docker push ndbinh/multi-server:$SHA
docker push ndbinh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ndbinh/multi-server:$SHA
kubectl set image deployments/client-deployment client=ndbinh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ndbinh/multi-worker:$SHA