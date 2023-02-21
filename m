Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0540A69DD16
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjBUJnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjBUJm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:42:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4CD30E9;
        Tue, 21 Feb 2023 01:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676972576; x=1708508576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VdRIV4wFzCNVr8yDuZx/Q+Vky4EpLNRgaQcQ7QQdiLY=;
  b=EHh4QRy+q/XHg2kYtrkMvjVmpiv2Dzwu9X3DwiXIUxTNsI81JQGXN90n
   /XlNI+5/QpYIkw9QLDmk/Og+K9MSTLWHaToGQGlHdthoxkh/szt4NMBeu
   FGH3B16C3DBypfIlC2PSo9VhcNLIGl/07eJesEGCmL9KPjNaTdBBxVfi0
   vax6puiiM214gGwsfcUj1jrCpc981m6fd1C8L3bzfUqETLmA+MFOgbjG3
   dB31oPCq+C+lV07DM9uWT9njBjIxKce3krJiE+cAZHfsGEsqtZnFJx5er
   tRzvjigLtPG/u6wBt6YOQUdKGgCmxmlGtjOt3Y8ZHYzrUn9uFarVSFO2H
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669100400"; 
   d="scan'208";a="138246831"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2023 02:42:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 02:42:54 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 02:42:49 -0700
From:   Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
To:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linus.walleij@linaro.org>,
        <dmitry.torokhov@gmail.com>, <ulf.hansson@linaro.org>
CC:     <hari.prasathge@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH v4 2/2] mmc: atmel-mci: move atmel MCI header file
Date:   Tue, 21 Feb 2023 15:12:07 +0530
Message-ID: <20230221094207.102006-3-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221094207.102006-1-balamanikandan.gunasundar@microchip.com>
References: <20230221094207.102006-1-balamanikandan.gunasundar@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the contents of linux/atmel-mci.h into
drivers/mmc/host/atmel-mci.c as it is only used in one file

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---
 drivers/mmc/host/atmel-mci.c | 39 +++++++++++++++++++++++++++++-
 include/linux/atmel-mci.h    | 46 ------------------------------------
 2 files changed, 38 insertions(+), 47 deletions(-)
 delete mode 100644 include/linux/atmel-mci.h

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index ddad5a929634..8b5116d7ae74 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -30,7 +30,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio.h>
 
-#include <linux/atmel-mci.h>
 #include <linux/atmel_pdc.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -40,6 +39,8 @@
 #include <asm/io.h>
 #include <asm/unaligned.h>
 
+#define ATMCI_MAX_NR_SLOTS	2
+
 /*
  * Superset of MCI IP registers integrated in Atmel AT91 Processor
  * Registers and bitfields marked with [2] are only available in MCI2
@@ -201,6 +202,42 @@ enum atmci_pdc_buf {
 	PDC_SECOND_BUF,
 };
 
+/**
+ * struct mci_slot_pdata - board-specific per-slot configuration
+ * @bus_width: Number of data lines wired up the slot
+ * @detect_pin: GPIO pin wired to the card detect switch
+ * @wp_pin: GPIO pin wired to the write protect sensor
+ * @detect_is_active_high: The state of the detect pin when it is active
+ * @non_removable: The slot is not removable, only detect once
+ *
+ * If a given slot is not present on the board, @bus_width should be
+ * set to 0. The other fields are ignored in this case.
+ *
+ * Any pins that aren't available should be set to a negative value.
+ *
+ * Note that support for multiple slots is experimental -- some cards
+ * might get upset if we don't get the clock management exactly right.
+ * But in most cases, it should work just fine.
+ */
+struct mci_slot_pdata {
+	unsigned int		bus_width;
+	struct gpio_desc        *detect_pin;
+	struct gpio_desc	*wp_pin;
+	bool			detect_is_active_high;
+	bool			non_removable;
+};
+
+/**
+ * struct mci_platform_data - board-specific MMC/SDcard configuration
+ * @dma_slave: DMA slave interface to use in data transfers.
+ * @slot: Per-slot configuration data.
+ */
+struct mci_platform_data {
+	void			*dma_slave;
+	dma_filter_fn		dma_filter;
+	struct mci_slot_pdata	slot[ATMCI_MAX_NR_SLOTS];
+};
+
 struct atmel_mci_caps {
 	bool    has_dma_conf_reg;
 	bool    has_pdc;
diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
deleted file mode 100644
index 017e7d8f6126..000000000000
--- a/include/linux/atmel-mci.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_ATMEL_MCI_H
-#define __LINUX_ATMEL_MCI_H
-
-#include <linux/types.h>
-#include <linux/dmaengine.h>
-
-#define ATMCI_MAX_NR_SLOTS	2
-
-/**
- * struct mci_slot_pdata - board-specific per-slot configuration
- * @bus_width: Number of data lines wired up the slot
- * @detect_pin: GPIO pin wired to the card detect switch
- * @wp_pin: GPIO pin wired to the write protect sensor
- * @detect_is_active_high: The state of the detect pin when it is active
- * @non_removable: The slot is not removable, only detect once
- *
- * If a given slot is not present on the board, @bus_width should be
- * set to 0. The other fields are ignored in this case.
- *
- * Any pins that aren't available should be set to a negative value.
- *
- * Note that support for multiple slots is experimental -- some cards
- * might get upset if we don't get the clock management exactly right.
- * But in most cases, it should work just fine.
- */
-struct mci_slot_pdata {
-	unsigned int		bus_width;
-	struct gpio_desc        *detect_pin;
-	struct gpio_desc	*wp_pin;
-	bool			detect_is_active_high;
-	bool			non_removable;
-};
-
-/**
- * struct mci_platform_data - board-specific MMC/SDcard configuration
- * @dma_slave: DMA slave interface to use in data transfers.
- * @slot: Per-slot configuration data.
- */
-struct mci_platform_data {
-	void			*dma_slave;
-	dma_filter_fn		dma_filter;
-	struct mci_slot_pdata	slot[ATMCI_MAX_NR_SLOTS];
-};
-
-#endif /* __LINUX_ATMEL_MCI_H */
-- 
2.25.1

