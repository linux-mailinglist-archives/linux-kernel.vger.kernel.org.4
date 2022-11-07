Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDD361FF75
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiKGUVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiKGUVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:21:40 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5949FB1B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:21:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z14so17923579wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y1SpL1GVBGhwpMih/xHdjJp7ykAJLUCGyIeESi/HS3A=;
        b=kNUcOVFCnY2cMkp3AU78gDXL1FMGL+aoC/ohFcNj3aZjaov5cRQI++6ydXfRi0gZ1t
         KayEJ2RbJ8SFQA9MiuvLjdRMlWSKchF73XYeO/Qy94dKAtM0k/tG5XlStuSj7M3R8oeH
         tvUBVqXchjDPG+YWBVBkX4xdIrw/1YCINCOuQh7oFI2nl5u3h6IUOEiHgA7Y0CQ+R1/T
         ccHEa1hFXcOMLgO60AX4MF6Rymusv083DTVvdkvlF3v85DdpJM6Td3TgNSo0M4CCiywj
         Mu96NSNXOmt7HTFdBO+tf01p9M0ihDYBgcEfCKsI9uyTuL2v8KXbCFmDjCs7BpeonkB4
         SS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1SpL1GVBGhwpMih/xHdjJp7ykAJLUCGyIeESi/HS3A=;
        b=RsLAK5u3IUwXO2be9JQ7VHJC42g+oPU9K0S/P4r+R0zcszA085Yof9riUbauDPbxnO
         1I0Bfak5Pmyswqx+c5yRtWIXEA0iNuMHqTl2bG6/5uX1zKucUpxfQKIhqhCV8VfNMwHo
         QEBwDX0kzu2xbOBN3QED9MF8d1+EDmRNSD8ZTYHTKvh+CsiR0rV3nEG2ly41EfBc18hv
         gOcfxYQZ2q1uMSUn6azlAio571pzQtEqyEBuMdsCUYdk3z+2bJTls5yy7O+V0Hv8UikS
         95V/qn9wywMvT1MZ0APdxWpgHY4Rn4oO3qZKx6MDOo4oNv2Ag3dFVYNDZAqa2w7XSlXo
         YGkQ==
X-Gm-Message-State: ACrzQf2Cm3zTKkXBSCoZ8c0SUDoJLZCWw78YKE+uxXVXsTeqtIwg7Jvx
        jE1+L2nZmbaSco+CIET8tOI=
X-Google-Smtp-Source: AMsMyM4YyKedfEPdTzi1FY9WHQEX81NLqBQ4/QBwNIJK7ju/ILFzEByhXOjVBhio8medqhfruv9/Sw==
X-Received: by 2002:adf:d1ea:0:b0:236:777d:74fd with SMTP id g10-20020adfd1ea000000b00236777d74fdmr33421513wrd.657.1667852497753;
        Mon, 07 Nov 2022 12:21:37 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c4f4300b003b47b80cec3sm13393301wmq.42.2022.11.07.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 12:21:37 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH] regmap-irq: Use the new num_config_regs property in regmap_add_irq_chip_fwnode
Date:   Mon,  7 Nov 2022 23:21:14 +0300
Message-Id: <20221107202114.823975-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Commit faa87ce9196d ("regmap-irq: Introduce config registers for irq
types") added the num_config_regs, then commit 9edd4f5aee84 ("regmap-irq:
Deprecate type registers and virtual registers") suggested to replace
num_type_reg with it. However, regmap_add_irq_chip_fwnode wasn't modified
to use the new property. Later on, commit 255a03bb1bb3 ("ASoC: wcd9335:
Convert irq chip to config regs") removed the old num_type_reg property
from the WCD9335 driver's struct regmap_irq_chip, causing a null pointer
dereference in regmap_irq_set_type when it tried to index d->type_buf as
it was never allocated in regmap_add_irq_chip_fwnode:

[   39.199374] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[   39.199383] Mem abort info:
[   39.199390]   ESR = 0x0000000096000004
[   39.199397]   EC = 0x25: DABT (current EL), IL = 32 bits
[   39.199408]   SET = 0, FnV = 0
[   39.199415]   EA = 0, S1PTW = 0
[   39.199422]   FSC = 0x04: level 0 translation fault
[   39.199430] Data abort info:
[   39.199436]   ISV = 0, ISS = 0x00000004
[   39.199443]   CM = 0, WnR = 0
[   39.199449] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000084549000
[   39.199458] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[   39.199474] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   39.199483] Modules linked in: snd_soc_wcd9335 regmap_slimbus panel_lgphilips_sw43101 ath10k_pci ath10k_core q6asm_dai msm venus_dec venus_enc ath q6routing q6afe_dai videobuf2_dma_contig mac80211 snd_soc_apq8096 q6asm q6adm snd_soc_qcom_common snd_q6dsp_common q6afe snd_soc_core q6core drm_dp_aux_bus ak7375 imx318 gpu_sched apr snd_compress libarc4 qcom_camss soundwire_bus v4l2_fwnode venus_core v4l2_async snd_pcm drm_display_helper videobuf2_dma_sg v4l2_mem2mem videobuf2_memops nxp_nci_i2c drm_kms_helper videobuf2_v4l2 nxp_nci hci_uart snd_timer btqca syscopyarea videobuf2_common nci snd sysfillrect videodev slim_qcom_ngd_ctrl soundcore sysimgblt nfc bluetooth pdr_interface fb_sys_fops mc i2c_qcom_cci lzo_rle slimbus qcom_spmi_haptics qcom_q6v5_pas qcom_q6v5_mss qcom_pil_info qcom_common qcom_q6v5 qcom_sysmon qmi_helpers socinfo mdt_loader pwm_ir_tx rmtfs_mem cfg80211 rfkill zram zsmalloc atmel_mxt_ts drm drm_panel_orientation_quirks ip_tables
[   39.199764] CPU: 0 PID: 214 Comm: kworker/u8:5 Tainted: G        W          6.1.0-rc4+ #98
[   39.199775] Hardware name: Xiaomi Mi Note 2 (DT)
[   39.199784] Workqueue: events_unbound deferred_probe_work_func
[   39.199809] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   39.199819] pc : regmap_irq_set_type+0x84/0x1c0
[   39.199833] lr : regmap_irq_set_type+0x58/0x1c0
[   39.199846] sp : ffff80000b813810
[   39.199852] x29: ffff80000b813810 x28: 0000000000000000 x27: ffff8000256b5df0
[   39.199869] x26: 0000000000000000 x25: ffff0000b12ad400 x24: ffff0000044ee660
[   39.199884] x23: 0000000000000000 x22: ffff800025691868 x21: 0000000000000001
[   39.199900] x20: ffff800025691870 x19: ffff000002d04e00 x18: ffffffffffffffff
[   39.199915] x17: 0000000000000000 x16: ffff800008153b10 x15: 0000000000000006
[   39.199930] x14: 0000000000000000 x13: ffff800009216eb0 x12: 0000000000000831
[   39.199945] x11: 00000000000002bb x10: ffff80000926eeb0 x9 : ffff800009216eb0
[   39.199960] x8 : 00000000ffffefff x7 : ffff80000926eeb0 x6 : 80000000fffff000
[   39.199975] x5 : ffff0000fdce09d0 x4 : 0000000000000000 x3 : 0000000000000000
[   39.199991] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
[   39.200006] Call trace:
[   39.200014]  regmap_irq_set_type+0x84/0x1c0
[   39.200026]  __irq_set_trigger+0x60/0x1c0
[   39.200040]  __setup_irq+0x2f4/0x78c
[   39.200051]  request_threaded_irq+0xe8/0x1a0
[   39.200063]  devm_request_threaded_irq+0x80/0x100
[   39.200074]  wcd9335_codec_probe+0x21c/0x2f0 [snd_soc_wcd9335]
[   39.200098]  snd_soc_component_probe+0x28/0x7c [snd_soc_core]
[   39.200167]  soc_probe_component+0x1cc/0x380 [snd_soc_core]
[   39.200206]  snd_soc_bind_card+0x45c/0xc80 [snd_soc_core]
[   39.200244]  snd_soc_register_card+0xf0/0x110 [snd_soc_core]
[   39.200283]  devm_snd_soc_register_card+0x4c/0xa4 [snd_soc_core]
[   39.200334]  apq8096_platform_probe+0xd0/0xf0 [snd_soc_apq8096]
[   39.200353]  platform_probe+0x68/0xc0
[   39.200366]  really_probe+0xc0/0x3dc
[   39.200375]  __driver_probe_device+0x7c/0x190
[   39.200384]  driver_probe_device+0x3c/0x110
[   39.200392]  __device_attach_driver+0xbc/0x160
[   39.200401]  bus_for_each_drv+0x78/0xd0
[   39.200414]  __device_attach+0x9c/0x1c0
[   39.200422]  device_initial_probe+0x14/0x20
[   39.200431]  bus_probe_device+0x9c/0xa4
[   39.200441]  deferred_probe_work_func+0x9c/0xf0
[   39.200456]  process_one_work+0x1d4/0x330
[   39.200471]  worker_thread+0x6c/0x430
[   39.200481]  kthread+0x108/0x10c
[   39.200490]  ret_from_fork+0x10/0x20
[   39.200507] Code: f940c663 b9400681 1ac00af7 937e7ee4 (b8646860)
[   39.200518] ---[ end trace 0000000000000000 ]---

Use num_config_regs in regmap_add_irq_chip_fwnode instead of num_type_reg,
and fall back to it if num_config_regs isn't defined to maintain backward
compatibility.

Fixes: faa87ce9196d ("regmap-irq: Introduce config registers for irq types")
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/base/regmap/regmap-irq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 4ef9488d05cd..3de89795f584 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -722,6 +722,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	int i;
 	int ret = -ENOMEM;
 	int num_type_reg;
+	int num_regs;
 	u32 reg;
 
 	if (chip->num_regs <= 0)
@@ -796,14 +797,20 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			goto err_alloc;
 	}
 
-	num_type_reg = chip->type_in_mask ? chip->num_regs : chip->num_type_reg;
-	if (num_type_reg) {
-		d->type_buf_def = kcalloc(num_type_reg,
+	/*
+	 * Use num_config_regs if defined, otherwise fall back to num_type_reg
+	 * to maintain backward compatibility.
+	 */
+	num_type_reg = chip->num_config_regs ? chip->num_config_regs
+			: chip->num_type_reg;
+	num_regs = chip->type_in_mask ? chip->num_regs : num_type_reg;
+	if (num_regs) {
+		d->type_buf_def = kcalloc(num_regs,
 					  sizeof(*d->type_buf_def), GFP_KERNEL);
 		if (!d->type_buf_def)
 			goto err_alloc;
 
-		d->type_buf = kcalloc(num_type_reg, sizeof(*d->type_buf),
+		d->type_buf = kcalloc(num_regs, sizeof(*d->type_buf),
 				      GFP_KERNEL);
 		if (!d->type_buf)
 			goto err_alloc;
-- 
2.38.1

