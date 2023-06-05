docker build -t stephengrider/multi-client:latest -t stephengrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cygnetops/multi-server-pgfix-5-11:latest -t stephengrider/multi-server-pgfix-5-11:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker:latest -t stephengrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push luqmanfak/multi-client:latest
docker push luqmanfak/multi-server:latest
docker push luqmanfak/multi-worker:latest

docker push luqmanfak/multi-client:$SHA
docker push luqmanfak/multi-server:$SHA
docker push luqmanfak/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cygnetops/multi-server-pgfix-5-11:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA
