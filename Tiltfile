print("📦 Building")
app_name = "fastapi-example"
image_name = "{}:latest".format(app_name)
print("Building docker image: ", image_name)
docker_build(image_name, ".",
    live_update=[
        sync('./app', '/app'),
        run('cd /app && pip install -r requirements.txt',
            trigger='requirements.txt'),
    ])

print("🚀 Deploying")
values_file = "./charts/values.yaml"
helm_yaml = helm(
    './charts',
    name=app_name,
    values=[values_file],
    )
k8s_yaml(helm_yaml)


print("🔧 Configuring")

k8s_resource(workload=app_name, objects=[
    '{}:serviceaccount'.format(app_name),
    '{}:ingress'.format(app_name),
    '{}-configmap:configmap'.format(app_name)
])

values_file_yaml = read_yaml(values_file)
if "local" in values_file_yaml["app"]:
    print("mounting local path: ", values_file_yaml["app"]["local"])
    k8s_resource(new_name="{}:storage".format(app_name), objects=[
        '{}-local-sc:storageclass'.format(app_name),
        '{}-local-pv:persistentvolume'.format(app_name),
        '{}-local-pvc:persistentvolumeclaim'.format(app_name)
])
