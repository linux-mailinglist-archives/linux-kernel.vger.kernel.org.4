Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA77969C9D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjBTL0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjBTL03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:26:29 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BFE7EFC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676892388; x=1708428388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=totpBCjpLePkVoam+gcl3kjF9/aIeC84MC/MCZlL6DI=;
  b=o+7wLThcnPvEwAJalOIqvreDUQx8kvEpZ8aoYoO/0FE7sJQ4s2TsHd/h
   owGrQCNRzi0dH08BH6hSWIp5qst8AqXiIan2swWOpajwNkHTHpazBNdTK
   WehTcD4tU++QvmMr327Mwf2+fBzb+JsA1UiqskSn9bbDCSxIgoPR6lNpX
   nAiPcoQkyQIR2/SpbCYM8Hu0Z/8wq+BSrSw8fLJELKHceWVNtoAx69Lxs
   6FEKHzSg/hFXJtBQUGR8C2gxtz9N7lLIHahRn4WDnRN5XFFYGsilt5UTn
   iLEvGGOGiWd765LGrktV9ml02DCiyKMXc8jDEN4SWpBhbk0xDX6rt0418
   w==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669071600"; 
   d="scan'208";a="29187434"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 20 Feb 2023 12:26:21 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 20 Feb 2023 12:26:21 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 20 Feb 2023 12:26:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676892381; x=1708428381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=totpBCjpLePkVoam+gcl3kjF9/aIeC84MC/MCZlL6DI=;
  b=OZZ222vqCH3wVls1aN7tH/ZLeO4gYQgtcXJ5Z18D9yfEBA0MjPZPalgX
   daxUW8l/mN/Jh6rEPLO/BsmJMDbBVfkQ4DZug/fKIT3kDEVzSUy6+sdA1
   nPoTNWuGET5sdba4kWEPp9ntwK3/T2TNCcc+Rj0tjj1txGid2KF1N2uCS
   K3oxoolYDdTN/Aod2yHLtFjv1QRagwgwJwZCaRvrfVNjFP1aHfDTZrUgi
   VIottto8varlz6JNppemXeCdf9rKp0/1neCnB7QGZ3uYDQ6uTtXjtdyiw
   c2ZA2i9FZdY9PHsWBlK9N/Yo64MvAgrAZ7GwLNNCrAompcjZsTB/SEjpt
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669071600"; 
   d="scan'208";a="29187426"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Feb 2023 12:26:20 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 2E435280073;
        Mon, 20 Feb 2023 12:26:15 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 3/3] mfd: tqmx86: correct board names for TQMxE39x
Date:   Mon, 20 Feb 2023 12:25:46 +0100
Message-Id: <aca9a7cb42a85181bcb456c437554d2728e708ec.1676892223.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e8300a30f0791afb67d79db8089fb6004855f378.1676892223.git.matthias.schiffer@ew.tq-group.com>
References: <e8300a30f0791afb67d79db8089fb6004855f378.1676892223.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that this driver was developed based on preliminary documentation.
Report the correct names for all TQMxE39x variants, as they are used by
the released hardware revisions:

- Fix names for TQMxE39C1/C2 board IDs
- Distinguish TQMxE39M and TQMxE39S, which use the same board ID

The TQMxE39M/S are distinguished using the SAUC (Sanctioned Alternate
Uses Configuration) register of the GPIO controller. This also prepares
for the correct handling of the differences between the GPIO controllers
of our COMe and SMARC modules.

Fixes: 2f17dd34ffed ("mfd: tqmx86: IO controller with I2C, Wachdog and GPIO")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Notes:
    v2: add Reviewed-by from v1

 drivers/mfd/tqmx86.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 958334f14eb00..fac02875fe7d9 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -30,9 +30,9 @@
 #define TQMX86_REG_BOARD_ID_50UC	2
 #define TQMX86_REG_BOARD_ID_E38C	3
 #define TQMX86_REG_BOARD_ID_60EB	4
-#define TQMX86_REG_BOARD_ID_E39M	5
-#define TQMX86_REG_BOARD_ID_E39C	6
-#define TQMX86_REG_BOARD_ID_E39x	7
+#define TQMX86_REG_BOARD_ID_E39MS	5
+#define TQMX86_REG_BOARD_ID_E39C1	6
+#define TQMX86_REG_BOARD_ID_E39C2	7
 #define TQMX86_REG_BOARD_ID_70EB	8
 #define TQMX86_REG_BOARD_ID_80UC	9
 #define TQMX86_REG_BOARD_ID_110EB	11
@@ -48,6 +48,7 @@
 #define TQMX86_REG_IO_EXT_INT_12		3
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
+#define TQMX86_REG_SAUC		0x17
 
 #define TQMX86_REG_I2C_DETECT	0x1a7
 #define TQMX86_REG_I2C_DETECT_SOFT		0xa5
@@ -110,7 +111,7 @@ static const struct mfd_cell tqmx86_devs[] = {
 	},
 };
 
-static const char *tqmx86_board_id_to_name(u8 board_id)
+static const char *tqmx86_board_id_to_name(u8 board_id, u8 sauc)
 {
 	switch (board_id) {
 	case TQMX86_REG_BOARD_ID_E38M:
@@ -121,12 +122,12 @@ static const char *tqmx86_board_id_to_name(u8 board_id)
 		return "TQMxE38C";
 	case TQMX86_REG_BOARD_ID_60EB:
 		return "TQMx60EB";
-	case TQMX86_REG_BOARD_ID_E39M:
-		return "TQMxE39M";
-	case TQMX86_REG_BOARD_ID_E39C:
-		return "TQMxE39C";
-	case TQMX86_REG_BOARD_ID_E39x:
-		return "TQMxE39x";
+	case TQMX86_REG_BOARD_ID_E39MS:
+		return (sauc == 0xff) ? "TQMxE39M" : "TQMxE39S";
+	case TQMX86_REG_BOARD_ID_E39C1:
+		return "TQMxE39C1";
+	case TQMX86_REG_BOARD_ID_E39C2:
+		return "TQMxE39C2";
 	case TQMX86_REG_BOARD_ID_70EB:
 		return "TQMx70EB";
 	case TQMX86_REG_BOARD_ID_80UC:
@@ -159,9 +160,9 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 	case TQMX86_REG_BOARD_ID_E40C1:
 	case TQMX86_REG_BOARD_ID_E40C2:
 		return 24000;
-	case TQMX86_REG_BOARD_ID_E39M:
-	case TQMX86_REG_BOARD_ID_E39C:
-	case TQMX86_REG_BOARD_ID_E39x:
+	case TQMX86_REG_BOARD_ID_E39MS:
+	case TQMX86_REG_BOARD_ID_E39C1:
+	case TQMX86_REG_BOARD_ID_E39C2:
 		return 25000;
 	case TQMX86_REG_BOARD_ID_E38M:
 	case TQMX86_REG_BOARD_ID_E38C:
@@ -175,7 +176,7 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 
 static int tqmx86_probe(struct platform_device *pdev)
 {
-	u8 board_id, rev, i2c_det, io_ext_int_val;
+	u8 board_id, sauc, rev, i2c_det, io_ext_int_val;
 	struct device *dev = &pdev->dev;
 	u8 gpio_irq_cfg, readback;
 	const char *board_name;
@@ -205,7 +206,8 @@ static int tqmx86_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	board_id = ioread8(io_base + TQMX86_REG_BOARD_ID);
-	board_name = tqmx86_board_id_to_name(board_id);
+	sauc = ioread8(io_base + TQMX86_REG_SAUC);
+	board_name = tqmx86_board_id_to_name(board_id, sauc);
 	rev = ioread8(io_base + TQMX86_REG_BOARD_REV);
 
 	dev_info(dev,
-- 
2.34.1

