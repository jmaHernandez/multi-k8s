docker build -t jmaHernandez/multi-client:latest -t jmaHernandez/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jmaHernandez/multi-server:latest -t jmaHernandez/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jmaHernandez/multi-worker:latest -t jmaHernandez/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jmaHernandez/multi-client:latest
docker push jmaHernandez/multi-server:latest
docker push jmaHernandez/multi-worker:latest

docker push jmaHernandez/multi-client:$SHA
docker push jmaHernandez/multi-server:$SHA
docker push jmaHernandez/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jmaHernandez/multi-client:$SHA
kubectl set image deployments/server-deployment server=jmaHernandez/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jmaHernandez/multi-worker:$SHA