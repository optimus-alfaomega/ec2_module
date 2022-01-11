variable region {
  type        = string
  default     = "us-east-1"
  description = "registra la región donde despliega el modulo"
}

variable  access_key {
    type = string
    description = "llave de acceso"
}

variable secret_key {
    type = string
    description = "llave secreta de acceso"
}

variable key_pair_name{
    type = string
    description = "nombre del par de llaves de seguridad .pem"
}

variable key_pair_public_key {
    type = string
    description = "llave publica de acceso"
}
variable user_data {
   type = string
   description="configuración en ec2 que permite almacenar las configuraciones internas del servidor"
   default = "./userdata.yaml"
}

variable own_vpc{
    type = string
    description = "identificador unico en AWS del vpc"
    default = "vpc-e5b4dc98"
}

variable security_group_name {
   type = string
   description = "nombre del security group"
}

variable security_group_description {
    type = string
    description = "descripción del security group"
}

variable ami_id{
   type = string
   description = "número de id del ami"
   default = "ami-0ed9277fb7eb570c9"
}

variable instance_type_def{
  type = string
  description = "tipo de instancia"
  default = "t2.micro"
}