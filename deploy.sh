docker build -t bhadrarahul/multi-client:latest -t bhadrarahul/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bhadrarahul/multi-server:latest -t bhadrarahul/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bhadrarahul/multi-worker:latest -t bhadrarahul/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bhadrarahul/multi-client:latest
docker push bhadrarahul/multi-server:latest
docker push bhadrarahul/multi-worker:latest

docker push bhadrarahul/multi-client:$SHA
docker push bhadrarahul/multi-server:$SHA
docker push bhadrarahul/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=bhadrarahul/multi-server:$SHA
kubectl set image deployments/client-deployment client=bhadrarahul/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bhadrarahul/multi-worker:$SHA