Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0145BBDAE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIRLtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRLtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:49:39 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B20826ED
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:49:35 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id E383A2902E; Sun, 18 Sep 2022 13:49:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=valentin-vidic.from.hr; s=2020; t=1663501770;
        bh=Rg8LCxl2vpPn29DS9j6JoiyB1CX/vnVtKEj/9poUE6w=;
        h=From:To:Cc:Subject:Date:From;
        b=sbvbO8nJ5Z/nnEYhBeBkQWtpvaXKwsS8KSSmJSUGwuR0Aft3N1fwRK3NntJDoXw/X
         GPchme2d9IycDAR2XGn/lp5hcNFubMdhsIN3YBb9Vorhx6q3ouNZYggPk1SzLSk4Qk
         5Lu3ym0DdQZ6waq09JjfNxtsQLIql/OWmmopyNE1amPxo8Qsxarc85Wtw59bLjW4ZH
         bFIoove9dMry0saG38Y/5FdWtYI2tB2VQuRA6q0AFky/0N6xRjfmsT9B+JBr2sL5VE
         yYq33qQ30hlXVxrtMvBVz9laJSOB0/2CGbfzF+756gLm4r0V0b9CKFfKS6uOjt1OJi
         UGZVloBHz8GEAtq9lgePzhLKKq46kWsN2pPHzsSe6MImbGefVpuPM7yT05X3bftBUW
         GvGK6ezph2HKHnSbid0ugmWYdsKo7VReQe5tIL/V8MfF7iOBWYTRT2CJ7zFky3cpy5
         xag8cRcnS2nlkYmCZk4PUkTzVpa+XuQwa6TLTKNt3+hx64Ar3RA3askdEi349x6AKo
         xEOLHaVu1c460vtkRnt9kM4M9UHgvIQMcCZM/y6y6LYPPUR0RdLP/To2N0In3qAonn
         AxOLOv27fa6CFTcMlTOGce22WYCx1HY/7nER+NJJh+MbG1tDVrQagMKmS26Kk4ys8q
         SxZWlccvQu/YouTNBuuHkRL0=
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH] staging: rtl8192e: fix CamelCase struct member
Date:   Sun, 18 Sep 2022 13:49:26 +0200
Message-Id: <20220918114926.3809060-1-vvidic@valentin-vidic.from.hr>
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
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c      | 8 ++++----
 drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c        | 8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h        | 2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 4b9249195b5a..6308a25e064c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -707,19 +707,19 @@ bool rtl92e_start_adapter(struct net_device *dev)
 		rtl92e_writeb(dev, ANAPAR, 0x37);
 		mdelay(500);
 	}
-	priv->pFirmware->status = FW_STATUS_0_INIT;
+	priv->pfirmware->status = FW_STATUS_0_INIT;
 
 	if (priv->RegRfOff)
 		priv->rtllib->eRFPowerState = eRfOff;
 
 	ulRegRead = rtl92e_readl(dev, CPU_GEN);
-	if (priv->pFirmware->status == FW_STATUS_0_INIT)
+	if (priv->pfirmware->status == FW_STATUS_0_INIT)
 		ulRegRead |= CPU_GEN_SYSTEM_RESET;
-	else if (priv->pFirmware->status == FW_STATUS_5_READY)
+	else if (priv->pfirmware->status == FW_STATUS_5_READY)
 		ulRegRead |= CPU_GEN_FIRMWARE_RESET;
 	else
 		netdev_err(dev, "%s(): undefined firmware state: %d.\n",
-			   __func__, priv->pFirmware->status);
+			   __func__, priv->pfirmware->status);
 
 	rtl92e_writel(dev, CPU_GEN, ulRegRead);
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
index 38110fa4f36d..364f34acd81c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
@@ -51,7 +51,7 @@ static bool _rtl92e_fw_check_ready(struct net_device *dev,
 				   u8 load_fw_status)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_firmware *pfirmware = priv->pFirmware;
+	struct rt_firmware *pfirmware = priv->pfirmware;
 	bool rt_status  = true;
 
 	switch (load_fw_status) {
@@ -138,7 +138,7 @@ bool rtl92e_init_fw(struct net_device *dev)
 	enum opt_rst_type rst_opt = OPT_SYSTEM_RESET;
 	enum firmware_init_step starting_state = FW_INIT_STEP0_BOOT;
 
-	struct rt_firmware *pfirmware = priv->pFirmware;
+	struct rt_firmware *pfirmware = priv->pfirmware;
 
 	netdev_dbg(dev, " PlatformInitFirmware()==>\n");
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 671fe547639b..fea01e2ba5ab 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -907,8 +907,8 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 
 	priv->card_type = PCI;
 
-	priv->pFirmware = vzalloc(sizeof(struct rt_firmware));
-	if (!priv->pFirmware)
+	priv->pfirmware = vzalloc(sizeof(*priv->pfirmware));
+	if (!priv->pfirmware)
 		netdev_err(dev,
 			   "rtl8192e: Unable to allocate space for firmware\n");
 
@@ -2409,8 +2409,8 @@ static void _rtl92e_pci_disconnect(struct pci_dev *pdev)
 		priv->polling_timer_on = 0;
 		_rtl92e_down(dev, true);
 		rtl92e_dm_deinit(dev);
-		vfree(priv->pFirmware);
-		priv->pFirmware = NULL;
+		vfree(priv->pfirmware);
+		priv->pfirmware = NULL;
 		_rtl92e_free_rx_ring(dev);
 		for (i = 0; i < MAX_TX_QUEUE_COUNT; i++)
 			_rtl92e_free_tx_ring(dev, i);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 093887bcd463..b7b934932b43 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -343,7 +343,7 @@ struct r8192_priv {
 
 	enum acm_method AcmMethod;
 
-	struct rt_firmware			*pFirmware;
+	struct rt_firmware			*pfirmware;
 	enum rtl819x_loopback LoopbackMode;
 
 	struct timer_list			watch_dog_timer;
-- 
2.30.2

