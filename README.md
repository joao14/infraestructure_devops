# 📚 **README - Infraestructura AWS con Terraform**

---

## 🚀 **Descripción del Proyecto** <a name="descripcion-del-proyecto"></a>

Este proyecto utiliza **Terraform** para implementar una infraestructura robusta en **AWS**, que incluye:

- ✅ **VPC** con rango de IP personalizado.  
- ✅ **Subnets públicas** para separar servicios.  
- ✅ **Internet Gateway** para acceso a Internet.  
- ✅ **Instancia EC2 con PostgreSQL**, configurada automáticamente.  
- ✅ **Instancia EC2 con Nginx**, accesible públicamente.  
- ✅ **Secrets Manager** para gestionar credenciales de forma segura.  
- ✅ **Cluster ECS con PrivateBin**, desplegado como un servicio.  

---

## 📂 **Pasos para inicializar** <a name="pasos-para-inicializar"></a>

- ✅ **terraform init** permite inicializar el proyecto.  
- ✅ **terraform validate** para validar la estructura del proyecto.  
- ✅ **terraform plan** para previsualizar los cambios.  
- ✅ **terraform apply**, para desplegar los cambios en AWS.  

---

## 🛠️ **Requisitos Previos** <a name="requisitos-previos"></a>

Antes de comenzar, asegúrate de tener las siguientes herramientas instaladas:

| Herramienta        | Versión Requerida | Instalación                      |
|---------------------|-------------------|-----------------------------------|
| Terraform          | ≥ 1.0.0          | [Instalar Terraform](https://developer.hashicorp.com/terraform/downloads) |
| AWS CLI            | ≥ 2.0            | [Instalar AWS CLI](https://aws.amazon.com/cli/) |
| jq                 | ≥ 1.6            | [Instalar jq](https://stedolan.github.io/jq/) |

---

## 📂 **Estructura del Proyecto** <a name="estructura-del-proyecto"></a>

```plaintext
infra-aws-terraform/
├── main.tf             # Orquestación principal
├── providers.tf        # Configuración del proveedor AWS
├── variables.tf        # Variables globales
├── outputs.tf          # Salidas del proyecto
├── vpc.tf             # Configuración de VPC
├── subnets.tf         # Configuración de subnets
├── security_groups.tf # Grupos de seguridad
├── instances.tf       # Configuración de instancias EC2
├── secrets.tf         # AWS Secrets Manager
├── ecs.tf            # Configuración del ECS
└── README.md          # Documentación principal

---

## 📧 **Contacto** <a name="contacto"></a>

- **Autor:** [Alexander Merino]  
- **Correo Electrónico:** [alexmerino67@gmail.com]    

---

**¡Listo! 🚀 Con esta infraestructura de AWS con Terraform de manera rápida y segura.** 😊 