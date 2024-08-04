# KEY PAIR
module "key_pair_web" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "${var.project_name}-web"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD1EJRlC4Hib49UtVjYwDid6w3Gp6hbvYiLj9VScHM2Dag12W3DU7x+u6UcJab50xU3nabBOTvNs+Zjvo0nhLfP9zByNKEToSh6BM1N4RCExLv9v2itIz/vYrgVFCO4QVENV95gopGF78AwBpfFJViXKemCH+xqZQG1i6fxGbWi1G0HUMpLVF0Ha1ildgsAKRgCol72Ef1Onn2lAXcmM8FekSrHijNLL/0QT9Siip/Hsn0XSXBvX9RN4rjzXgQhmXi8WpeytWZXWqf44rCEH99eSNXUGWUTLhWOn9EZALB6HDfm62Qu0N9Tjw1Jq87tKJPFplRFLl0UGTNbnjXQTDdCbbjGFnEB696RtUE00GjUyZKr1ZrKTwF1593ftQtq5s3Yd0M65gebkrUhmMUzCn5T7Ewrkr9Dz/pG0EGXLzuQdMEmlJxF+WBvBbL6cLX/jnBXfx7H03lwehA9Flit0WqcOT+hplOhdm9YT/Gbv9vXmGaZC8JImscn7vWSJkxbzTsNUSyW0+zvk+Qp5x9MWZ5PQ8WQ3Ho26PzGc01uDqfYqWTqyQB9grH/YUq0lMQfgKAHx1WR29NJZBT9usNutW3d3zt+NFnHDta/JcwjmSNnFErm71dYRrmGS8RSluMoN7wA1qcxyTp3npKDlzBhHm/rZR37sxyvRkzDPkLNSlZZqw== alfathmas@gmail.com"
}