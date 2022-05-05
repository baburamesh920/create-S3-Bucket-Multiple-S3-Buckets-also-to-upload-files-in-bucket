# Create a bucket
# resource "aws_s3_bucket" "onebucket" {
#    bucket = "testing-s3-with-terraform-ramesh"
#    acl    = "private"   # or can be "public-read"

#    versioning {
#       enabled = true
#    }

#    tags = {
#      Environment = "Test"
#    }
# }


# Create a multiple buckets at a time
variable "s3_bucket_name" {
   type = list
   default = ["ramesh-buc-1", "ramesh-buc-2", "ramesh-buc-3"]
}

resource "aws_s3_bucket" "henrys_bucket" {
   count = "${length(var.s3_bucket_name)}"
   bucket = "${var.s3_bucket_name[count.index]}"
   acl = "private"

   versioning {
      enabled = true
   }

     tags = {
    Environment = "Test"
  }

   force_destroy = "true"
}

# Upload objects in buckets with index
resource "aws_s3_bucket_object" "object1" {
for_each = fileset("myfiles/", "*")

bucket = aws_s3_bucket.henrys_bucket[0].id

key = each.value

source = "myfiles/${each.value}"

etag = filemd5("myfiles/${each.value}")
}


