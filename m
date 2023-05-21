Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A367970ADA8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjEULpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjEULgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:36:11 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5EAED;
        Sun, 21 May 2023 04:30:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so535585e87.3;
        Sun, 21 May 2023 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684668624; x=1687260624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlC2yggVawSvbxppKJ34PQUKEJ7CvARhdsvkk+NDKMI=;
        b=Q2LUA5w/Q84VfpGTCilyZwiiNHZE+iE1cNSTVBDhP7VKNiKwhWGuXkKP4yKNav8Xa2
         TaNijdhMYXXcDm/ZxRBQedaasi4ZimCNkzINtRlaI6W+9HoEywSVNHEBCK4QJNPf8Wne
         anGXPDl3uFVxBIR0TAiTI+PAedg9U7CONgWzHSNlzcUngFc3mJRhABmyEodjH+5gVOpW
         XjVNHH5EErY5PKF4anhF0g+6IPzw0eWW15LTMggYPEnEiD5RsCAGlSYJuJcDNJMhs5G2
         riv63JYJHzUnGYo/V7oovXjhZEbqoBDq1Y45pua9yFOnsWjkg2UNZcMnOoS2TDYjtOdK
         0Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684668624; x=1687260624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlC2yggVawSvbxppKJ34PQUKEJ7CvARhdsvkk+NDKMI=;
        b=Zc9gOfA7GARRJsnYzz9mNrwx5qS+kojsOm8E4djETXkJUKAbFFkGpp/Fn2e/TRgSJ+
         voEaxqo34PLFw657FrNH+b+/HvW9ay9PxC6nSz2musOtxuEYB07jIddM3raTi0aSlXKU
         nnIQaG/jzpSfaYZBTm7ZxBJulQvPHdv8wjigyWWCiwzWCc7mNuUrT9QDP/Cp8bn0nLCN
         UIF3MQ+v2+W7yq7fF2u95yaXFgZ44gq3mEm+VpHZn48CoWcA52ccNAOyBMsZPuyqBSqX
         2TTIsf/kM+jHn1zOsd+9sf0H53fYqV+VEdUoAbmTIfwjD8xfdWj3npWqA7u81AVbXPD6
         CGPA==
X-Gm-Message-State: AC+VfDxCDANasH2i8EnioQrcsEBNs3oBkrGz2Pk4wd+tN4T8oZ5THi3l
        hXRzSIqJKQkxwleyHqXykKs=
X-Google-Smtp-Source: ACHHUZ5f2tFHNQCblF+qQv9dnRK5a1U5c+PH2DZnFJJY6rULAeGD871kNs2H98GCWmsTJpUM5pGVpQ==
X-Received: by 2002:a19:f703:0:b0:4f3:bb84:a780 with SMTP id z3-20020a19f703000000b004f3bb84a780mr651579lfe.23.1684668623330;
        Sun, 21 May 2023 04:30:23 -0700 (PDT)
Received: from [192.168.88.92] (95-158-68-28.static.chello.pl. [95.158.68.28])
        by smtp.gmail.com with ESMTPSA id d30-20020ac25ede000000b004f138ecab11sm596537lfq.24.2023.05.21.04.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 04:30:22 -0700 (PDT)
Message-ID: <d0f77858-4370-aa0c-0ece-32f4dcfe85f0@gmail.com>
Date:   Sun, 21 May 2023 13:28:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scsi: target: Fix data corruption under concurrent target
 configuration
To:     Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dutkahugo@gmail.com,
        Grzegorz Uriasz <gorbak25@gmail.com>
References: <5f637569-36af-a8d0-e378-b27a63f08501@gmail.com>
 <20230520084600.GC20571@yadro.com>
Content-Language: en-US
From:   Grzegorz Uriasz <gorbak25@gmail.com>
In-Reply-To: <20230520084600.GC20571@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for your feedback :)

On 20/05/2023 10:46, Dmitry Bogdanov wrote:
> Hi Grzegorz,
>
> On Sat, May 20, 2023 at 02:26:14AM +0200, Grzegorz Uriasz wrote:
>> This fixes data corruptions arising from concurrent enabling of a target
>> devices. When multiple enable calls are made concurrently then it is
>> possible for the target device to be set up twice which results in a
>> kernel BUG.
>> Introduces a per target device mutex for serializing enable requests.
> Device enable call is already secured by configfs per-file mutex. That
> is actually per device. So Enable procedures are already not executed
> simulteniously.
True, I've checked the code in configfs and indeed there is a per 
file/subsystem mutex.
>
> Look like you wrongly identified the root cause of double list_add.
>
>
> If you have an evidence that dev->dev_flags could have no DF_CONFIGURED
> bit, then it meeans that it (dev_flags) is raced in other
> configuration actions (udev_path, vpd_unit_serial, alias).
> Bits in dev->dev_flags are written not atomically and if you writes to
> enable, alias, udev_path,unit_serial files simulteniously, then some
> bits could be lost.
>
> IHMO the best solution is to make dev_flags changes be atomical.

I've tried that using the following patch:
---
  drivers/target/target_core_configfs.c | 12 ++++++------
  drivers/target/target_core_device.c   |  2 +-
  drivers/target/target_core_iblock.c   |  2 +-
  drivers/target/target_core_pscsi.c    |  4 ++--
  drivers/target/target_core_spc.c      |  8 ++++----
  drivers/target/target_core_tpg.c      |  2 +-
  include/target/target_core_backend.h  |  2 +-
  include/target/target_core_base.h     |  4 ++--
  8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/target/target_core_configfs.c 
b/drivers/target/target_core_configfs.c
index 74b67c346dfe..bdc06f654aa8 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1621,7 +1621,7 @@ static ssize_t 
target_wwn_vpd_unit_serial_store(struct config_item *item,
       * it is doing 'the right thing' wrt a world wide unique
       * VPD Unit Serial Number that OS dependent multipath can depend on.
       */
-    if (dev->dev_flags & DF_FIRMWARE_VPD_UNIT_SERIAL) {
+    if (atomic_read(&dev->dev_flags) & DF_FIRMWARE_VPD_UNIT_SERIAL) {
          pr_err("Underlying SCSI device firmware provided VPD"
              " Unit Serial, ignoring request\n");
          return -EOPNOTSUPP;
@@ -1654,7 +1654,7 @@ static ssize_t 
target_wwn_vpd_unit_serial_store(struct config_item *item,
      snprintf(buf, INQUIRY_VPD_SERIAL_LEN, "%s", page);
      snprintf(dev->t10_wwn.unit_serial, INQUIRY_VPD_SERIAL_LEN,
              "%s", strstrip(buf));
-    dev->dev_flags |= DF_EMULATED_VPD_UNIT_SERIAL;
+    atomic_or(DF_EMULATED_VPD_UNIT_SERIAL, &dev->dev_flags);

      pr_debug("Target_Core_ConfigFS: Set emulated VPD Unit Serial:"
              " %s\n", dev->t10_wwn.unit_serial);
@@ -2263,7 +2263,7 @@ static ssize_t target_dev_alias_show(struct 
config_item *item, char *page)
  {
      struct se_device *dev = to_device(item);

-    if (!(dev->dev_flags & DF_USING_ALIAS))
+    if (!(atomic_read(&dev->dev_flags) & DF_USING_ALIAS))
          return 0;

      return snprintf(page, PAGE_SIZE, "%s\n", dev->dev_alias);
@@ -2289,7 +2289,7 @@ static ssize_t target_dev_alias_store(struct 
config_item *item,
      if (dev->dev_alias[read_bytes - 1] == '\n')
          dev->dev_alias[read_bytes - 1] = '\0';

-    dev->dev_flags |= DF_USING_ALIAS;
+    atomic_or(DF_USING_ALIAS, &dev->dev_flags);

      pr_debug("Target_Core_ConfigFS: %s/%s set alias: %s\n",
          config_item_name(&hba->hba_group.cg_item),
@@ -2303,7 +2303,7 @@ static ssize_t target_dev_udev_path_show(struct 
config_item *item, char *page)
  {
      struct se_device *dev = to_device(item);

-    if (!(dev->dev_flags & DF_USING_UDEV_PATH))
+    if (!(atomic_read(&dev->dev_flags) & DF_USING_UDEV_PATH))
          return 0;

      return snprintf(page, PAGE_SIZE, "%s\n", dev->udev_path);
@@ -2330,7 +2330,7 @@ static ssize_t target_dev_udev_path_store(struct 
config_item *item,
      if (dev->udev_path[read_bytes - 1] == '\n')
          dev->udev_path[read_bytes - 1] = '\0';

-    dev->dev_flags |= DF_USING_UDEV_PATH;
+    atomic_or(DF_USING_UDEV_PATH, &dev->dev_flags);

      pr_debug("Target_Core_ConfigFS: %s/%s set udev_path: %s\n",
          config_item_name(&hba->hba_group.cg_item),
diff --git a/drivers/target/target_core_device.c 
b/drivers/target/target_core_device.c
index 90f3f4926172..5054b647dd0b 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -967,7 +967,7 @@ int target_configure_device(struct se_device *dev)
      hba->dev_count++;
      spin_unlock(&hba->device_lock);

-    dev->dev_flags |= DF_CONFIGURED;
+    atomic_or(DF_CONFIGURED, &dev->dev_flags);

      return 0;

diff --git a/drivers/target/target_core_iblock.c 
b/drivers/target/target_core_iblock.c
index cc838ffd1294..38d0d104661d 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -112,7 +112,7 @@ static int iblock_configure_device(struct se_device 
*dev)
      if (!ib_dev->ibd_readonly)
          mode |= FMODE_WRITE;
      else
-        dev->dev_flags |= DF_READ_ONLY;
+        atomic_or(DF_READ_ONLY, &dev->dev_flags);

      bd = blkdev_get_by_path(ib_dev->ibd_udev_path, mode, ib_dev);
      if (IS_ERR(bd)) {
diff --git a/drivers/target/target_core_pscsi.c 
b/drivers/target/target_core_pscsi.c
index e7425549e39c..36a1ac519f0b 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -201,7 +201,7 @@ pscsi_get_inquiry_vpd_serial(struct scsi_device 
*sdev, struct t10_wwn *wwn)

      snprintf(&wwn->unit_serial[0], INQUIRY_VPD_SERIAL_LEN, "%s", &buf[4]);

-    wwn->t10_dev->dev_flags |= DF_FIRMWARE_VPD_UNIT_SERIAL;
+    atomic_or(DF_FIRMWARE_VPD_UNIT_SERIAL, &wwn->t10_dev->dev_flags);

      kfree(buf);
      return 0;
@@ -450,7 +450,7 @@ static int pscsi_configure_device(struct se_device *dev)
           * For the newer PHV_VIRTUAL_HOST_ID struct scsi_device
           * reference, we enforce that udev_path has been set
           */
-        if (!(dev->dev_flags & DF_USING_UDEV_PATH)) {
+        if (!(atomic_read(&dev->dev_flags) & DF_USING_UDEV_PATH)) {
              pr_err("pSCSI: udev_path attribute has not"
                  " been set before ENABLE=1\n");
              return -EINVAL;
diff --git a/drivers/target/target_core_spc.c 
b/drivers/target/target_core_spc.c
index 89c0d56294cc..d380d08a2df0 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -159,7 +159,7 @@ spc_emulate_evpd_80(struct se_cmd *cmd, unsigned 
char *buf)
      struct se_device *dev = cmd->se_dev;
      u16 len;

-    if (dev->dev_flags & DF_EMULATED_VPD_UNIT_SERIAL) {
+    if (atomic_read(&dev->dev_flags) & DF_EMULATED_VPD_UNIT_SERIAL) {
          len = sprintf(&buf[4], "%s", dev->t10_wwn.unit_serial);
          len++; /* Extra Byte for NULL Terminator */
          buf[3] = len;
@@ -239,7 +239,7 @@ spc_emulate_evpd_83(struct se_cmd *cmd, unsigned 
char *buf)
       * /sys/kernel/config/target/core/$HBA/$DEV/wwn/vpd_unit_serial
       * value in order to return the NAA id.
       */
-    if (!(dev->dev_flags & DF_EMULATED_VPD_UNIT_SERIAL))
+    if (!(atomic_read(&dev->dev_flags) & DF_EMULATED_VPD_UNIT_SERIAL))
          goto check_t10_vend_desc;

      /* CODE SET == Binary */
@@ -267,7 +267,7 @@ spc_emulate_evpd_83(struct se_cmd *cmd, unsigned 
char *buf)
       */
      id_len = 8; /* For Vendor field */

-    if (dev->dev_flags & DF_EMULATED_VPD_UNIT_SERIAL)
+    if (atomic_read(&dev->dev_flags) & DF_EMULATED_VPD_UNIT_SERIAL)
          id_len += sprintf(&buf[off+12], "%s:%s", prod,
                  &dev->t10_wwn.unit_serial[0]);
      buf[off] = 0x2; /* ASCII */
@@ -720,7 +720,7 @@ spc_emulate_evpd_00(struct se_cmd *cmd, unsigned 
char *buf)
       * Registered Extended LUN WWN has been set via ConfigFS
       * during device creation/restart.
       */
-    if (cmd->se_dev->dev_flags & DF_EMULATED_VPD_UNIT_SERIAL) {
+    if (atomic_read(&cmd->se_dev->dev_flags) & 
DF_EMULATED_VPD_UNIT_SERIAL) {
          buf[3] = ARRAY_SIZE(evpd_handlers);
          for (p = 0; p < ARRAY_SIZE(evpd_handlers); ++p)
              buf[p + 4] = evpd_handlers[p].page;
diff --git a/drivers/target/target_core_tpg.c 
b/drivers/target/target_core_tpg.c
index c0e429e5ef31..c88dc36db6de 100644
--- a/drivers/target/target_core_tpg.c
+++ b/drivers/target/target_core_tpg.c
@@ -656,7 +656,7 @@ int core_tpg_add_lun(
      list_add_tail(&lun->lun_dev_link, &dev->dev_sep_list);
      spin_unlock(&dev->se_port_lock);

-    if (dev->dev_flags & DF_READ_ONLY)
+    if (atomic_read(&dev->dev_flags) & DF_READ_ONLY)
          lun->lun_access_ro = true;
      else
          lun->lun_access_ro = lun_access_ro;
diff --git a/include/target/target_core_backend.h 
b/include/target/target_core_backend.h
index a3c193df25b3..27c70a69e088 100644
--- a/include/target/target_core_backend.h
+++ b/include/target/target_core_backend.h
@@ -122,7 +122,7 @@ bool target_configure_unmap_from_queue(struct 
se_dev_attrib *attrib,

  static inline bool target_dev_configured(struct se_device *se_dev)
  {
-    return !!(se_dev->dev_flags & DF_CONFIGURED);
+    return !!(atomic_read(&se_dev->dev_flags) & DF_CONFIGURED);
  }

  #endif /* TARGET_CORE_BACKEND_H */
diff --git a/include/target/target_core_base.h 
b/include/target/target_core_base.h
index 5f8e96f1516f..5794b2360c47 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -792,8 +792,8 @@ struct se_device_queue {

  struct se_device {
      /* Used for SAM Task Attribute ordering */
-    u32            dev_cur_ordered_id;
-    u32            dev_flags;
+    u32         dev_cur_ordered_id;
+    atomic_t    dev_flags;
  #define DF_CONFIGURED                0x00000001
  #define DF_FIRMWARE_VPD_UNIT_SERIAL        0x00000002
  #define DF_EMULATED_VPD_UNIT_SERIAL        0x00000004
-- 
2.40.0

And it didn't fix the double add issue, additionally i was able to 
trigger a double free one time:

[  291.075508] list_del corruption. next->prev should be 
ffff8881cd240000, but was ffff88810085a000. (next=ffff88826da7a000)
[  291.075971] ------------[ cut here ]------------
[  291.075972] Kernel BUG at __list_del_entry_valid+0xc3/0xd0 [verbose 
debug info unavailable]
[  291.076304] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  291.076500] CPU: 7 PID: 19557 Comm: node Not tainted 
6.4.0-rc2hocus-00246-gd3f704310cc7-dirty #7
[  291.076821] RIP: 0010:__list_del_entry_valid+0xc3/0xd0
[  291.077014] Code: 0b 48 89 fe 48 89 c2 48 c7 c7 e8 45 1a 82 e8 a4 73 
c1 ff 0f 0b 48 89 d1 48 c7 c7 38 46 1a 82 48 89 f2 48 89 c6 e8 8d 73 c1 
ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
[  291.077698] RSP: 0018:ffffc90001f13d70 EFLAGS: 00010246
[  291.077905] RAX: 000000000000006d RBX: ffff8881cd240018 RCX: 
0000000000000000
[  291.078172] RDX: 0000000000000000 RSI: ffffffff82142371 RDI: 
00000000ffffffff
[  291.078432] RBP: ffffc90001f13d70 R08: 0000000000000000 R09: 
ffffc90001f13be8
[  291.078692] R10: 0000000000000003 R11: ffffffff82b52c48 R12: 
ffff8881cd240000
[  291.078961] R13: ffff8881f8e09030 R14: 0000000000000000 R15: 
0000000000000000
[  291.079231] FS:  00007fbf93fff6c0(0000) GS:ffff88841fdc0000(0000) 
knlGS:0000000000000000
[  291.079532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  291.079746] CR2: 00007fd57b825020 CR3: 000000022af4a000 CR4: 
00000000003506a0
[  291.080009] Call Trace:
[  291.080103]  <TASK>
[  291.080187]  tcmu_destroy_device+0x51/0x120
[  291.080362]  ? config_item_cleanup+0x2d/0xa0
[  291.080537]  target_free_device+0x4d/0x100
[  291.080699]  target_core_dev_release+0x14/0x20
[  291.080869]  config_item_cleanup+0x53/0xa0
[  291.081023]  config_item_put+0x34/0x50
[  291.081181]  configfs_rmdir+0x246/0x370
[  291.081328]  ? may_delete+0x113/0x1d0
[  291.081469]  vfs_rmdir+0x7c/0x1e0
[  291.081593]  do_rmdir+0x12e/0x170
[  291.081719]  __x64_sys_rmdir+0x41/0x60
[  291.081862]  do_syscall_64+0x3e/0x90
[  291.082011]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  291.082210] RIP: 0033:0x7fbfaad52907
[  291.082349] Code: 73 01 c3 48 8b 0d f9 84 0d 00 f7 d8 64 89 01 48 83 
c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 54 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 84 0d 00 f7 d8 64 89 01 48
[  291.083021] RSP: 002b:00007fbf93ffed18 EFLAGS: 00000297 ORIG_RAX: 
0000000000000054
[  291.083298] RAX: ffffffffffffffda RBX: 000000000679b7e0 RCX: 
00007fbfaad52907
[  291.083563] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 
00007fbf91eb1460
[  291.083828] RBP: 00007fbf93ffee20 R08: 0000000000000000 R09: 
00000000ffffffff
[  291.084099] R10: 0000000000000000 R11: 0000000000000297 R12: 
00007fbf93fff5c0
[  291.084367] R13: 000000000679b7c8 R14: 00007ffd460fbb80 R15: 
000000000679b7c8
[  291.084622]  </TASK>
[  291.084703] ---[ end trace 0000000000000000 ]---
[  291.084832] RIP: 0010:__list_del_entry_valid+0xc3/0xd0
[  291.084975] Code: 0b 48 89 fe 48 89 c2 48 c7 c7 e8 45 1a 82 e8 a4 73 
c1 ff 0f 0b 48 89 d1 48 c7 c7 38 46 1a 82 48 89 f2 48 89 c6 e8 8d 73 c1 
ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
[  291.085449] RSP: 0018:ffffc90001f13d70 EFLAGS: 00010246
[  291.085585] RAX: 000000000000006d RBX: ffff8881cd240018 RCX: 
0000000000000000
[  291.085774] RDX: 0000000000000000 RSI: ffffffff82142371 RDI: 
00000000ffffffff
[  291.085961] RBP: ffffc90001f13d70 R08: 0000000000000000 R09: 
ffffc90001f13be8
[  291.086163] R10: 0000000000000003 R11: ffffffff82b52c48 R12: 
ffff8881cd240000
[  291.086361] R13: ffff8881f8e09030 R14: 0000000000000000 R15: 
0000000000000000
[  291.086552] FS:  00007fbf93fff6c0(0000) GS:ffff88841fdc0000(0000) 
knlGS:0000000000000000
[  291.086766] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  291.086920] CR2: 00007fd57b825020 CR3: 000000022af4a000 CR4: 
00000000003506a0

I'm currently trying to hunt down the root cause behind the data 
corruption. For context those bugs are triggered by my script which is 
concurrently adding/deleting a lot of TCMU devices and exposing them to 
the system using TCM_LOOP.

>
> BR,
>   Dmitry
Best regards,
Grzegorz Uriasz
