Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F245BD63E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiISVUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiISVUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:20:09 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE920F60
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 14:20:05 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id DB8802906A; Mon, 19 Sep 2022 23:19:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=valentin-vidic.from.hr; s=2020; t=1663622397;
        bh=iTFgAY9DAhoLaKSk5hDeoJKe1vNf6/Wy76telunIX+4=;
        h=From:To:Cc:Subject:Date:From;
        b=LcGovu9IuU5081gPATuRKI2ONMwhKMcCIInwJabjSGbuqNcRYe04Dw6Wm/AgNwcB8
         WeraaGYersyplJlYPUA5jmNsXVRPy9mNoVGwbpqPu4RBpWCC5dEaZHA2SuWknDy/Iq
         UssrJhNBREG0QeeFgWxjOu9jFHGaFGNCJt9kq/MgWEMJh2Pn1E+y6Fvbn6NgTbOaji
         ZxNqcd98lmzNYBeF2a6u6Qy4pVYK9z7kf0symqsA9Q8Y7+36pf2GFSt0Pl37XVYM41
         W77pts5HAQKbdWDipewXXhOU9UTBqfqJOKGpfWmxFNUZm1Wf3Ve1We5JrMSyHlvKT0
         2A2kyYpVDkHs7dV+LTjCcwYs/uGIEaxxUE2BzPFxOxIy9dv/4oVwrmZm8GzjlzTicT
         L02G48LD8L6X7am4XWmo/4VCZuAfke9N+zOnOup0IDqWVWmutjhnIL9SbClnB7G768
         7kebEXVSeBYEhMFacwQcF0yu2Dd0KShIclp+nfM0Jwe4SUtsiCmcgrW9JQyaSirUTg
         LpntMU3m+DzIEUfVmqbbqLEwNpzIhYv93f14CJ/LvzM+rWujY1CHBIPsH3edKzgWeA
         yVrb35dFv5dT1KMl+PBp2gvWznsooUkb6FEvuyTJhoS/829TZ33rXBLeC1b6S0b1Lb
         iMvbPa8Lk1TUEFuasM1w8QxA=
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH v2] staging: rtl8192e: fix CamelCase struct member
Date:   Mon, 19 Sep 2022 23:19:48 +0200
Message-Id: <20220919211948.136659-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings for struct member pFirmware.

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
v2: drop the 'p' prefix from the struct member and always
    use priv->firmware for access.

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  8 +++---
 .../rtl8192e/rtl8192e/r8192E_firmware.c       | 25 ++++++++-----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  8 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  2 +-
 4 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 4b9249195b5a..8f7395d20c6d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -707,19 +707,19 @@ bool rtl92e_start_adapter(struct net_device *dev)
 		rtl92e_writeb(dev, ANAPAR, 0x37);
 		mdelay(500);
 	}
-	priv->pFirmware->status = FW_STATUS_0_INIT;
+	priv->firmware->status = FW_STATUS_0_INIT;
 
 	if (priv->RegRfOff)
 		priv->rtllib->eRFPowerState = eRfOff;
 
 	ulRegRead = rtl92e_readl(dev, CPU_GEN);
-	if (priv->pFirmware->status == FW_STATUS_0_INIT)
+	if (priv->firmware->status == FW_STATUS_0_INIT)
 		ulRegRead |= CPU_GEN_SYSTEM_RESET;
-	else if (priv->pFirmware->status == FW_STATUS_5_READY)
+	else if (priv->firmware->status == FW_STATUS_5_READY)
 		ulRegRead |= CPU_GEN_FIRMWARE_RESET;
 	else
 		netdev_err(dev, "%s(): undefined firmware state: %d.\n",
-			   __func__, priv->pFirmware->status);
+			   __func__, priv->firmware->status);
 
 	rtl92e_writel(dev, CPU_GEN, ulRegRead);
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
index 38110fa4f36d..3bbd9bb86ad5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
@@ -51,32 +51,31 @@ static bool _rtl92e_fw_check_ready(struct net_device *dev,
 				   u8 load_fw_status)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_firmware *pfirmware = priv->pFirmware;
 	bool rt_status  = true;
 
 	switch (load_fw_status) {
 	case FW_INIT_STEP0_BOOT:
-		pfirmware->status = FW_STATUS_1_MOVE_BOOT_CODE;
+		priv->firmware->status = FW_STATUS_1_MOVE_BOOT_CODE;
 		break;
 
 	case FW_INIT_STEP1_MAIN:
-		pfirmware->status = FW_STATUS_2_MOVE_MAIN_CODE;
+		priv->firmware->status = FW_STATUS_2_MOVE_MAIN_CODE;
 
 		rt_status = _rtl92e_fw_boot_cpu(dev);
 		if (rt_status)
-			pfirmware->status = FW_STATUS_3_TURNON_CPU;
+			priv->firmware->status = FW_STATUS_3_TURNON_CPU;
 		else
 			netdev_dbg(dev, "_rtl92e_fw_boot_cpu fail!\n");
 
 		break;
 
 	case FW_INIT_STEP2_DATA:
-		pfirmware->status = FW_STATUS_4_MOVE_DATA_CODE;
+		priv->firmware->status = FW_STATUS_4_MOVE_DATA_CODE;
 		mdelay(1);
 
 		rt_status = _rtl92e_wait_for_fw(dev, CPU_GEN_FIRM_RDY, 20);
 		if (rt_status)
-			pfirmware->status = FW_STATUS_5_READY;
+			priv->firmware->status = FW_STATUS_5_READY;
 		else
 			RT_TRACE(COMP_FIRMWARE,
 				 "_rtl92e_is_fw_ready fail(%d)!\n",
@@ -138,15 +137,13 @@ bool rtl92e_init_fw(struct net_device *dev)
 	enum opt_rst_type rst_opt = OPT_SYSTEM_RESET;
 	enum firmware_init_step starting_state = FW_INIT_STEP0_BOOT;
 
-	struct rt_firmware *pfirmware = priv->pFirmware;
-
 	netdev_dbg(dev, " PlatformInitFirmware()==>\n");
 
-	if (pfirmware->status == FW_STATUS_0_INIT) {
+	if (priv->firmware->status == FW_STATUS_0_INIT) {
 		rst_opt = OPT_SYSTEM_RESET;
 		starting_state = FW_INIT_STEP0_BOOT;
 
-	} else if (pfirmware->status == FW_STATUS_5_READY) {
+	} else if (priv->firmware->status == FW_STATUS_5_READY) {
 		rst_opt = OPT_FIRMWARE_RESET;
 		starting_state = FW_INIT_STEP2_DATA;
 	} else {
@@ -156,7 +153,7 @@ bool rtl92e_init_fw(struct net_device *dev)
 
 	for (i = starting_state; i <= FW_INIT_STEP2_DATA; i++) {
 		if (rst_opt == OPT_SYSTEM_RESET) {
-			if (pfirmware->blobs[i].size == 0) {
+			if (priv->firmware->blobs[i].size == 0) {
 				const char *fw_name[3] = {
 					RTL8192E_BOOT_IMG_FW,
 					RTL8192E_MAIN_IMG_FW,
@@ -168,15 +165,15 @@ bool rtl92e_init_fw(struct net_device *dev)
 					pad = 128;
 
 				if (!_rtl92e_fw_prepare(dev,
-							&pfirmware->blobs[i],
+							&priv->firmware->blobs[i],
 							fw_name[i],
 							pad))
 					goto download_firmware_fail;
 			}
 		}
 
-		mapped_file = pfirmware->blobs[i].data;
-		file_length = pfirmware->blobs[i].size;
+		mapped_file = priv->firmware->blobs[i].data;
+		file_length = priv->firmware->blobs[i].size;
 
 		rt_status = rtl92e_send_cmd_pkt(dev, DESC_PACKET_TYPE_INIT,
 						mapped_file, file_length);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 671fe547639b..94e8f0706ed4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -907,8 +907,8 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 
 	priv->card_type = PCI;
 
-	priv->pFirmware = vzalloc(sizeof(struct rt_firmware));
-	if (!priv->pFirmware)
+	priv->firmware = vzalloc(sizeof(*priv->firmware));
+	if (!priv->firmware)
 		netdev_err(dev,
 			   "rtl8192e: Unable to allocate space for firmware\n");
 
@@ -2409,8 +2409,8 @@ static void _rtl92e_pci_disconnect(struct pci_dev *pdev)
 		priv->polling_timer_on = 0;
 		_rtl92e_down(dev, true);
 		rtl92e_dm_deinit(dev);
-		vfree(priv->pFirmware);
-		priv->pFirmware = NULL;
+		vfree(priv->firmware);
+		priv->firmware = NULL;
 		_rtl92e_free_rx_ring(dev);
 		for (i = 0; i < MAX_TX_QUEUE_COUNT; i++)
 			_rtl92e_free_tx_ring(dev, i);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 093887bcd463..dba789f0c9e6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -343,7 +343,7 @@ struct r8192_priv {
 
 	enum acm_method AcmMethod;
 
-	struct rt_firmware			*pFirmware;
+	struct rt_firmware			*firmware;
 	enum rtl819x_loopback LoopbackMode;
 
 	struct timer_list			watch_dog_timer;
-- 
2.30.2

