Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB706560D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 08:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiLZHkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 02:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiLZHjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:39:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C02DB6;
        Sun, 25 Dec 2022 23:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1672040392; x=1703576392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=reO+M9uPJUrQnHFQ7lgJPRd7DsLi8yc69h6qz1liBlc=;
  b=ZIR4bdh/lXHIh/vXMjlhlWZA0sABu9NkqTo48ElKk9JP9hUMubDj/65G
   jeUYxwSRgQ92w4En4q86GSRPT5mktIwF/dl/SOLBp1W8p6knMMvKuFVh3
   iYVuv5uKkR8Q6as4OwKUVJKOBMMGrhdYqqYjlY0PFMxI1gKW7l3YDY0T/
   Fx7g0nQmu1lc8epfq0soD/S/6TtuU8YXEI9QJm+QztzXnKMqUYOzX8rwR
   UjXXKJetRNTyfOZMeW8aVkxWF2lMLOf/P4A2m4iVnDGqeKDzMKIghXQVO
   TGKqmw3Wcbe0q7HPfFoe22bgSMUoh75IumsoOqT4PYttgMgNPYnU1Z1Zh
   w==;
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="193216540"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Dec 2022 00:39:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 26 Dec 2022 00:39:51 -0700
Received: from che-lt-i64410lx.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 26 Dec 2022 00:39:46 -0700
From:   Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
To:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linus.walleij@linaro.org>,
        <hari.prasathge@microchip.com>, <dmitry.torokhov@gmail.com>,
        <ulf.hansson@linaro.org>
CC:     <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH v3 2/2] mmc: atmel-mci: move atmel MCI header file
Date:   Mon, 26 Dec 2022 13:09:08 +0530
Message-ID: <20221226073908.17317-3-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221226073908.17317-1-balamanikandan.gunasundar@microchip.com>
References: <20221226073908.17317-1-balamanikandan.gunasundar@microchip.com>
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
index 6ab43733ba9f..b48e440a2df8 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -30,7 +30,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio.h>
 
-#include <linux/atmel-mci.h>
 #include <linux/atmel_pdc.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -41,6 +40,8 @@
 #include <asm/unaligned.h>
 #include "../core/pwrseq.h"
 
+#define ATMCI_MAX_NR_SLOTS	2
+
 /*
  * Superset of MCI IP registers integrated in Atmel AT91 Processor
  * Registers and bitfields marked with [2] are only available in MCI2
@@ -202,6 +203,42 @@ enum atmci_pdc_buf {
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

