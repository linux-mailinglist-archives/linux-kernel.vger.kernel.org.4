Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0E870A404
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 02:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjETA2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 20:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjETA2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 20:28:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E19107;
        Fri, 19 May 2023 17:28:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510d92184faso6024956a12.1;
        Fri, 19 May 2023 17:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684542497; x=1687134497;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FIdg/B+Ax41yv5HfdnGlZ+teeEBZ6tUjD7i0GnpAY4U=;
        b=WgUm/5L9cwRzFTBmmYflolTP+R3KTNl4Eoq+BFlc6V74sIFMY2OuziyuB9p96+BbXR
         IyRAvVqTMZaFzfAWL/z74XYpvTulqRIuKJswyl2zPtitpSfwpY6Tmg1dcVvIRsMobpvU
         x5Oj5HqJ449clNmGAf6P07gfH03pxVSFbXxDKWgoUTp4A3k1vjp16erFaqdWLvVECVI1
         YTQ9S3H19EuG0DWwiinXMZiqPM50osuQZuPAfOKyJAMWpRer5QhHr6OtsVAgehuPXzvj
         NOEoz0xi5FlcdT/UNA6nMe7XSM9wR+KRM1C9/8dYrYDDicCnYis0yltYsb0Xvd3Mjhev
         0biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684542497; x=1687134497;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIdg/B+Ax41yv5HfdnGlZ+teeEBZ6tUjD7i0GnpAY4U=;
        b=VgasD1dCnNY6Gf8OeN0IQ8RM2QuwUwwSNFP3WHTODd1YsYzvbsR+6LG5yQ8OCqWp5b
         QLOddcDB6UgGIrqmpIcWRa1SlH5W3zsuV9SnTjzQpD0sUvR9GD8F/Xr369vblnxmEY6Z
         nGJE3RI1luX6h4smQVpz9nxVlFJx+CyhD/79BAowRHZ3fip8tLM8H+dv2ftYyW1b04LL
         DERrg1J6rf53WgACDWHlCiHp+XVyjcpelkOfIcApD79kROX4LRqwNyJ4T472IUtom+j9
         HAjCs2ULIcEoBATgXL9Xbh+DkMEbPnzXTUhTOTUyedflfQ13tSxFBInM10nhNQzgyR/n
         pE7Q==
X-Gm-Message-State: AC+VfDx3aRj3vrOWNF2XfJM5V2Y5rjE7qu3wsvcSEtWCi99BGt8r1aER
        WjQzUP3e+ktG/u426MwVo6w=
X-Google-Smtp-Source: ACHHUZ4Lm37O5xH+xU4N67k5ZsuvCi3ElCxEeF7tF9yJK1Qi6uQJvprAVOYSiZGIQdsm/g9jlX4d0w==
X-Received: by 2002:a17:906:3051:b0:94a:845c:3528 with SMTP id d17-20020a170906305100b0094a845c3528mr2851817ejd.45.1684542497169;
        Fri, 19 May 2023 17:28:17 -0700 (PDT)
Received: from [192.168.88.92] (95-158-68-28.static.chello.pl. [95.158.68.28])
        by smtp.gmail.com with ESMTPSA id de28-20020a1709069bdc00b0096f70609406sm213691ejc.4.2023.05.19.17.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 17:28:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------UVUwz10lYSgowVlRecD0fBfA"
Message-ID: <5f637569-36af-a8d0-e378-b27a63f08501@gmail.com>
Date:   Sat, 20 May 2023 02:26:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dutkahugo@gmail.com
From:   Grzegorz Uriasz <gorbak25@gmail.com>
Subject: [PATCH] scsi: target: Fix data corruption under concurrent target
 configuration
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------UVUwz10lYSgowVlRecD0fBfA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This fixes data corruptions arising from concurrent enabling of a target
devices. When multiple enable calls are made concurrently then it is
possible for the target device to be set up twice which results in a
kernel BUG.
Introduces a per target device mutex for serializing enable requests.

Signed-off-by: Grzegorz Uriasz <gorbak25@gmail.com>
---
  drivers/target/target_core_device.c | 17 +++++++++++++----
  include/target/target_core_base.h   |  1 +
  2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_device.c 
b/drivers/target/target_core_device.c
index 90f3f4926172..6d8fb962c780 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -742,6 +742,7 @@ struct se_device *target_alloc_device(struct se_hba 
*hba, const char *name)

      INIT_WORK(&dev->delayed_cmd_work, target_do_delayed_work);
      mutex_init(&dev->lun_reset_mutex);
+    mutex_init(&dev->configure_mutex);

      dev->t10_wwn.t10_dev = dev;
      /*
@@ -904,10 +905,15 @@ int target_configure_device(struct se_device *dev)
      struct se_hba *hba = dev->se_hba;
      int ret, id;

+    ret = mutex_lock_interruptible(&dev->configure_mutex);
+    if (ret)
+        return ret;
+
      if (target_dev_configured(dev)) {
          pr_err("se_dev->se_dev_ptr already set for storage"
                  " object\n");
-        return -EEXIST;
+        ret = -EEXIST;
+        goto out_release_mutex;
      }

      /*
@@ -923,7 +929,7 @@ int target_configure_device(struct se_device *dev)
      mutex_unlock(&device_mutex);
      if (id < 0) {
          ret = -ENOMEM;
-        goto out;
+        goto out_release_vpd;
      }
      dev->dev_index = id;

@@ -969,7 +975,8 @@ int target_configure_device(struct se_device *dev)

      dev->dev_flags |= DF_CONFIGURED;

-    return 0;
+    ret = 0;
+    goto out_release_mutex;

  out_destroy_device:
      dev->transport->destroy_device(dev);
@@ -977,8 +984,10 @@ int target_configure_device(struct se_device *dev)
      mutex_lock(&device_mutex);
      idr_remove(&devices_idr, dev->dev_index);
      mutex_unlock(&device_mutex);
-out:
+out_release_vpd:
      se_release_vpd_for_dev(dev);
+out_release_mutex:
+    mutex_unlock(&dev->configure_mutex);
      return ret;
  }

diff --git a/include/target/target_core_base.h 
b/include/target/target_core_base.h
index 5f8e96f1516f..b3f9bd641688 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -869,6 +869,7 @@ struct se_device {
      int            queue_cnt;
      struct se_device_queue    *queues;
      struct mutex        lun_reset_mutex;
+    struct mutex        configure_mutex;
  };

  struct target_opcode_descriptor {
-- 
2.40.0


--------------UVUwz10lYSgowVlRecD0fBfA
Content-Type: text/plain; charset=UTF-8; name="DMESG_LOGS"
Content-Disposition: attachment; filename="DMESG_LOGS"
Content-Transfer-Encoding: base64

WyAgNzEwLjgzMTgzOF0gc2VfZGV2LT5zZV9kZXZfcHRyIGFscmVhZHkgc2V0IGZvciBzdG9y
YWdlIG9iamVjdApbICA3MTAuODMxODQxXSBzZV9kZXYtPnNlX2Rldl9wdHIgYWxyZWFkeSBz
ZXQgZm9yIHN0b3JhZ2Ugb2JqZWN0ClsgIDcxMC44MzE4NDJdIHNlX2Rldi0+c2VfZGV2X3B0
ciBhbHJlYWR5IHNldCBmb3Igc3RvcmFnZSBvYmplY3QKWyAgNzEwLjgzMTg0OF0gc2VfZGV2
LT5zZV9kZXZfcHRyIGFscmVhZHkgc2V0IGZvciBzdG9yYWdlIG9iamVjdApbICA3MTAuODMx
ODU1XSBzZV9kZXYtPnNlX2Rldl9wdHIgYWxyZWFkeSBzZXQgZm9yIHN0b3JhZ2Ugb2JqZWN0
ClsgIDcxMC44MzE4NTZdIHNlX2Rldi0+c2VfZGV2X3B0ciBhbHJlYWR5IHNldCBmb3Igc3Rv
cmFnZSBvYmplY3QKWyAgNzEwLjgzMTg1N10gc2VfZGV2LT5zZV9kZXZfcHRyIGFscmVhZHkg
c2V0IGZvciBzdG9yYWdlIG9iamVjdApbICA3MTAuODMxODU4XSBzZV9kZXYtPnNlX2Rldl9w
dHIgYWxyZWFkeSBzZXQgZm9yIHN0b3JhZ2Ugb2JqZWN0ClsgIDcxMC44MzE4NTldIHNlX2Rl
di0+c2VfZGV2X3B0ciBhbHJlYWR5IHNldCBmb3Igc3RvcmFnZSBvYmplY3QKWyAgNzEwLjgz
MTg2MF0gc2VfZGV2LT5zZV9kZXZfcHRyIGFscmVhZHkgc2V0IGZvciBzdG9yYWdlIG9iamVj
dApbICA3MTAuODMxODYxXSBzZV9kZXYtPnNlX2Rldl9wdHIgYWxyZWFkeSBzZXQgZm9yIHN0
b3JhZ2Ugb2JqZWN0ClsgIDcxMC44MzE4NjJdIHNlX2Rldi0+c2VfZGV2X3B0ciBhbHJlYWR5
IHNldCBmb3Igc3RvcmFnZSBvYmplY3QKWyAgNzEwLjgzMTg2M10gc2VfZGV2LT5zZV9kZXZf
cHRyIGFscmVhZHkgc2V0IGZvciBzdG9yYWdlIG9iamVjdApbICA3MTAuODMxODY0XSBzZV9k
ZXYtPnNlX2Rldl9wdHIgYWxyZWFkeSBzZXQgZm9yIHN0b3JhZ2Ugb2JqZWN0ClsgIDcxMC44
MzE4NjVdIHNlX2Rldi0+c2VfZGV2X3B0ciBhbHJlYWR5IHNldCBmb3Igc3RvcmFnZSBvYmpl
Y3QKWyAgNzEwLjgzMTg2Nl0gc2VfZGV2LT5zZV9kZXZfcHRyIGFscmVhZHkgc2V0IGZvciBz
dG9yYWdlIG9iamVjdApbICA3MTAuODMyMTAzXSB0Y211IG5sIGNtZCAxLy0yIGNvbXBsZXRp
b24gY291bGQgbm90IGZpbmQgZGV2aWNlIHdpdGggZGV2IGlkIDE2My4KWyAgNzEwLjgzMjQw
NV0gbGlzdF9hZGQgZG91YmxlIGFkZDogbmV3PWZmZmY4ODgyZGZkNzIwMDAsIHByZXY9ZmZm
ZmZmZmY4MmI4ZjVlMCwgbmV4dD1mZmZmODg4MmRmZDcyMDAwLgpbICA3MTAuODMyNDk0XSB0
Y211IG5sIGNtZCAxLy0yIGNvbXBsZXRpb24gY291bGQgbm90IGZpbmQgZGV2aWNlIHdpdGgg
ZGV2IGlkIDE2My4KWyAgNzEwLjgzMjg0Ml0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0t
LS0tLS0tLS0tClsgIDcxMC44MzMwMjJdIHRjbXUgbmwgY21kIDEvLTIgY29tcGxldGlvbiBj
b3VsZCBub3QgZmluZCBkZXZpY2Ugd2l0aCBkZXYgaWQgMTY0LgpbICA3MTAuODMzMzA2XSBL
ZXJuZWwgQlVHIGF0IF9fbGlzdF9hZGRfdmFsaWQuY29sZCsweDIzLzB4NWIgW3ZlcmJvc2Ug
ZGVidWcgaW5mbyB1bmF2YWlsYWJsZV0KWyAgNzEwLjgzMzUwM10gdGNtdSBubCBjbWQgMS8t
MiBjb21wbGV0aW9uIGNvdWxkIG5vdCBmaW5kIGRldmljZSB3aXRoIGRldiBpZCAxNjQuClsg
IDcxMC44MzM3ODldIGludmFsaWQgb3Bjb2RlOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9Q
VEkKWyAgNzEwLjgzMzk4N10gdGNtdSBubCBjbWQgMS8wIGNvbXBsZXRpb24gY291bGQgbm90
IGZpbmQgZGV2aWNlIHdpdGggZGV2IGlkIDE2My4KWyAgNzEwLjgzNDI2OF0gQ1BVOiAxIFBJ
RDogMzY4ODcxIENvbW06IG5vZGUgTm90IHRhaW50ZWQgNi4yLjBob2N1cyAjMQpbICA3MTAu
ODM0NDg0XSB0Y211IG5sIGNtZCAxLy0yIGNvbXBsZXRpb24gY291bGQgbm90IGZpbmQgZGV2
aWNlIHdpdGggZGV2IGlkIDE2NC4KWyAgNzEwLjgzNDc1OF0gUklQOiAwMDEwOl9fbGlzdF9h
ZGRfdmFsaWQuY29sZCsweDIzLzB4NWIKWyAgNzEwLjgzNDk1N10gdGNtdSBubCBjbWQgMS8t
MiBjb21wbGV0aW9uIGNvdWxkIG5vdCBmaW5kIGRldmljZSB3aXRoIGRldiBpZCAxNjQuClsg
IDcxMC44MzUyMzldIENvZGU6IGZmIGZmIGU5IDI2IDVhIGIyIGZmIDQ4IGM3IGM3IDkwIDFk
IDFiIDgyIGU4IGY4IGM0IGZlIGZmIDBmIDBiIDQ4IDg5IGYyIDRjIDg5IGMxIDQ4IDg5IGZl
IDQ4IGM3IGM3IDkwIDFlIDFiIDgyIGU4IGUxIGM0IGZlIGZmIDwwZj4gMGIgNDggODkgZDEg
NGMgODkgYzYgNGMgODkgY2EgNDggYzcgYzcgMzggMWUgMWIgODIgZTggY2EgYzQgZmUKWyAg
NzEwLjgzNTQ1MV0gdGNtdSBubCBjbWQgMS8tMiBjb21wbGV0aW9uIGNvdWxkIG5vdCBmaW5k
IGRldmljZSB3aXRoIGRldiBpZCAxNjQuClsgIDcxMC44MzU3MTVdIFJTUDogMDAxODpmZmZm
YzkwMDAxZTNmZDY4IEVGTEFHUzogMDAwMTAyNDYKWyAgNzEwLjgzNTk3NF0gdGNtdSBubCBj
bWQgMS8tMiBjb21wbGV0aW9uIGNvdWxkIG5vdCBmaW5kIGRldmljZSB3aXRoIGRldiBpZCAx
NjQuClsgIDcxMC44MzY2NjldIHRjbXUgbmwgY21kIDEvMCBjb21wbGV0aW9uIGNvdWxkIG5v
dCBmaW5kIGRldmljZSB3aXRoIGRldiBpZCAxNjQuClsgIDcxMC44MzY5OTRdIFJBWDogMDAw
MDAwMDAwMDAwMDA1OCBSQlg6IGZmZmY4ODgyZGZkNzIwMTggUkNYOiAwMDAwMDAwMDAwMDAw
MDAwClsgIDcxMC44MzcyMjBdIHRjbXUgbmwgY21kIDEvLTIgY29tcGxldGlvbiBjb3VsZCBu
b3QgZmluZCBkZXZpY2Ugd2l0aCBkZXYgaWQgMTY0LgpbICA3MTAuODM3NDg3XSBSRFg6IDAw
MDAwMDAwMDAwMDAwMDAgUlNJOiBmZmZmZmZmZjgyMTRlNjI0IFJESTogMDAwMDAwMDBmZmZm
ZmZmZgpbICA3MTAuODM3Nzg2XSB0Y211IGRhZW1vbjogY29tbWFuZCByZXBseSBzdXBwb3J0
IDEuClsgIDcxMC44MzgwODJdIFJCUDogZmZmZmM5MDAwMWUzZmQ2OCBSMDg6IDc0NzA1Zjc2
NjU2NDVmNjUgUjA5OiA3MzNlMmQ3NjY1NjQ1ZjY1ClsgIDcxMC44NDIxMTRdIFIxMDogNzA1
Zjc2NjU2NDVmNjU3MyBSMTE6IDNlMmQ3NjY1NjQ1ZjY1NzMgUjEyOiAwMDAwMDAwMDAwMDAw
MDAwClsgIDcxMC44NDIzNDddIFIxMzogZmZmZjg4ODJkZmQ3MjAwMCBSMTQ6IGZmZmY4ODgy
ZGZkNzIwMDAgUjE1OiBmZmZmODg4MmRmZDcyMDEwClsgIDcxMC44NDI1ODFdIEZTOiAgMDAw
MDdmYjVlNGY3ZjZjMCgwMDAwKSBHUzpmZmZmODg4NDFmYzQwMDAwKDAwMDApIGtubEdTOjAw
MDAwMDAwMDAwMDAwMDAKWyAgNzEwLjg0Mjg0N10gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAw
MDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbICA3MTAuODQzMDM1XSBDUjI6IDAwMDA3ZmI1
ZTRmN2VkMjggQ1IzOiAwMDAwMDAwMjdiMmJhMDAwIENSNDogMDAwMDAwMDAwMDM1MDZhMApb
ICA3MTAuODQzMjY5XSBDYWxsIFRyYWNlOgpbICA3MTAuODQzMzYxXSAgPFRBU0s+ClsgIDcx
MC44NDM0MzVdICB0Y211X2NvbmZpZ3VyZV9kZXZpY2UrMHgyOWIvMHgzOTAKWyAgNzEwLjg0
MzU5NF0gIHRhcmdldF9jb25maWd1cmVfZGV2aWNlKzB4N2MvMHgyYjAKWyAgNzEwLjg0Mzc0
OV0gIHRhcmdldF9kZXZfZW5hYmxlX3N0b3JlKzB4MzYvMHg1MApbICA3MTAuODQzODk3XSAg
Y29uZmlnZnNfd3JpdGVfaXRlcisweGM1LzB4MTMwClsgIDcxMC44NDQwNDVdICB2ZnNfd3Jp
dGUrMHgyYzMvMHgzZjAKWyAgNzEwLjg0NDE2M10gIGtzeXNfd3JpdGUrMHg2Ni8weGYwClsg
IDcxMC44NDQyNzVdICBfX3g2NF9zeXNfd3JpdGUrMHgxOC8weDIwClsgIDcxMC44NDQ0MDBd
ICBkb19zeXNjYWxsXzY0KzB4M2YvMHg5MApbICA3MTAuODQ0NTI0XSAgZW50cnlfU1lTQ0FM
TF82NF9hZnRlcl9od2ZyYW1lKzB4NzIvMHhkYwpbICA3MTAuODQ0NzA0XSBSSVA6IDAwMzM6
MHg3ZmI1ZTg0ODcxMWYKWyAgNzEwLjg0NDgyNF0gQ29kZTogODkgNTQgMjQgMTggNDggODkg
NzQgMjQgMTAgODkgN2MgMjQgMDggZTggMzkgZDUgZjggZmYgNDggOGIgNTQgMjQgMTggNDgg
OGIgNzQgMjQgMTAgNDEgODkgYzAgOGIgN2MgMjQgMDggYjggMDEgMDAgMDAgMDAgMGYgMDUg
PDQ4PiAzZCAwMCBmMCBmZiBmZiA3NyAzMSA0NCA4OSBjNyA0OCA4OSA0NCAyNCAwOCBlOCA4
YyBkNSBmOCBmZiA0OApbICA3MTAuODQ1NDIwXSBSU1A6IDAwMmI6MDAwMDdmYjVlNGY3ZWNm
MCBFRkxBR1M6IDAwMDAwMjkzIE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDAxClsgIDcxMC44
NDU2NjZdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNY
OiAwMDAwN2ZiNWU4NDg3MTFmClsgIDcxMC44NDU4OTddIFJEWDogMDAwMDAwMDAwMDAwMDAw
MSBSU0k6IDAwMDA3ZmI1ZTVhNGU1NzggUkRJOiAwMDAwMDAwMDAwMDAwMDFmClsgIDcxMC44
NDYxMzVdIFJCUDogMDAwMDdmYjVlNGY3ZWUyMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5
OiAwMDAwMDAwMGZmZmZmZmZmClsgIDcxMC44NDYzNjhdIFIxMDogMDAwMDAwMDAwMDAwMDAw
MCBSMTE6IDAwMDAwMDAwMDAwMDAyOTMgUjEyOiAwMDAwN2ZiNWU0ZjdmNWMwClsgIDcxMC44
NDY1OTldIFIxMzogMDAwMDdmYjVlNTg4MDEyOCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDEgUjE1
OiAwMDAwMDAwMDAwMDAwNDAwClsgIDcxMC44NDY4MzBdICA8L1RBU0s+ClsgIDcxMC44NDY5
NDddIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQpbICA3MTAuODQ3MTA4
XSBSSVA6IDAwMTA6X19saXN0X2FkZF92YWxpZC5jb2xkKzB4MjMvMHg1YgpbICA3MTAuODQ3
Mjc5XSBDb2RlOiBmZiBmZiBlOSAyNiA1YSBiMiBmZiA0OCBjNyBjNyA5MCAxZCAxYiA4MiBl
OCBmOCBjNCBmZSBmZiAwZiAwYiA0OCA4OSBmMiA0YyA4OSBjMSA0OCA4OSBmZSA0OCBjNyBj
NyA5MCAxZSAxYiA4MiBlOCBlMSBjNCBmZSBmZiA8MGY+IDBiIDQ4IDg5IGQxIDRjIDg5IGM2
IDRjIDg5IGNhIDQ4IGM3IGM3IDM4IDFlIDFiIDgyIGU4IGNhIGM0IGZlClsgIDcxMC44NDc4
OTVdIFJTUDogMDAxODpmZmZmYzkwMDAxZTNmZDY4IEVGTEFHUzogMDAwMTAyNDYKWyAgNzEw
Ljg0ODA2OV0gUkFYOiAwMDAwMDAwMDAwMDAwMDU4IFJCWDogZmZmZjg4ODJkZmQ3MjAxOCBS
Q1g6IDAwMDAwMDAwMDAwMDAwMDAKWyAgNzEwLjg0ODMwMV0gUkRYOiAwMDAwMDAwMDAwMDAw
MDAwIFJTSTogZmZmZmZmZmY4MjE0ZTYyNCBSREk6IDAwMDAwMDAwZmZmZmZmZmYKWyAgNzEw
Ljg0ODUzNF0gUkJQOiBmZmZmYzkwMDAxZTNmZDY4IFIwODogNzQ3MDVmNzY2NTY0NWY2NSBS
MDk6IDczM2UyZDc2NjU2NDVmNjUKWyAgNzEwLjg0ODc2Nl0gUjEwOiA3MDVmNzY2NTY0NWY2
NTczIFIxMTogM2UyZDc2NjU2NDVmNjU3MyBSMTI6IDAwMDAwMDAwMDAwMDAwMDAKWyAgNzEw
Ljg0ODk5OF0gUjEzOiBmZmZmODg4MmRmZDcyMDAwIFIxNDogZmZmZjg4ODJkZmQ3MjAwMCBS
MTU6IGZmZmY4ODgyZGZkNzIwMTAKWyAgNzEwLjg0OTIzMF0gRlM6ICAwMDAwN2ZiNWU0Zjdm
NmMwKDAwMDApIEdTOmZmZmY4ODg0MWZjNDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAw
MDAwMApbICA3MTAuODQ5NDk4XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAw
MDAwMDAwMDgwMDUwMDMzClsgIDcxMC44NDk2ODZdIENSMjogMDAwMDdmYjVlNGY3ZWQyOCBD
UjM6IDAwMDAwMDAyN2IyYmEwMDAgQ1I0OiAwMDAwMDAwMDAwMzUwNmEwCgo=

--------------UVUwz10lYSgowVlRecD0fBfA--
