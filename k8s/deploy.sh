docker build -t aliriza/multi-client:latest -t aliriza/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aliriza/multi-server:latest -t aliriza/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aliriza/multi-worker:latest -t aliriza/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aliriza/multi-client:latest
docker push aliriza/multi-server:latest
docker push aliriza/multi-worker:latest

docker push aliriza/multi-client:$SHA
docker push aliriza/multi-server:$SHA
docker push aliriza/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=aliriza/multi-server:$SHA
kubectl set image deployments/client-deployments client=aliriza/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=aliriza/multi-worker:$SHA

