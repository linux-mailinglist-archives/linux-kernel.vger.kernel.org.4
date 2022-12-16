Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9730664E6F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 06:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLPFdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 00:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiLPFdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 00:33:38 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99FC54458;
        Thu, 15 Dec 2022 21:33:34 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BG5XKnF010042;
        Thu, 15 Dec 2022 23:33:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671168800;
        bh=QpTAIVh7j+hfdk9u9QJfTuSkM1bq1jTgxwTMUXPa/NI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hFnkXDJSPZOEelZgmQWZdkGENVIg5dWn4F7wXh6hC4PoVuwGgK+r0EJoH9aRqhAZ9
         SdImeVoqe5b6CQzO19RE8dBBaepI3YpPiU9Qdlj5Z1on8IC7dtctErkDCbhLg67Zln
         DvtcL1f/bG3JBBFat7odq3j2V9bJNiakQzwrXgy4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BG5XK9L113111
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Dec 2022 23:33:20 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 15
 Dec 2022 23:33:19 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 15 Dec 2022 23:33:20 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BG5XJlj042469;
        Thu, 15 Dec 2022 23:33:19 -0600
Received: from localhost (a0501179-pc.dhcp.ti.com [10.24.69.114])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 2BG5XIvW008921;
        Thu, 15 Dec 2022 23:33:19 -0600
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <srk@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v12 2/6] remoteproc: pru: Add enum for PRU Core Identifiers.
Date:   Fri, 16 Dec 2022 11:03:09 +0530
Message-ID: <20221216053313.2974826-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216053313.2974826-1-danishanwar@ti.com>
References: <20221216053313.2974826-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing enum pruss_pru_id for PRU Core Identifiers.
PRUSS_PRU0 indicates PRU Core 0.
PRUSS_PRU1 indicates PRU Core 1.
PRUSS_NUM_PRUS indicates the total number of PRU Cores.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/remoteproc/pru_rproc.c |  7 ++++---
 include/linux/pruss.h          | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/pruss.h

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 128bf9912f2c..a1a208b31846 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/pruss.h>
 #include <linux/pruss_driver.h>
 #include <linux/remoteproc.h>
 
@@ -438,7 +439,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
 	dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
 	dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
 	/* PRU1 has its local RAM addresses reversed */
-	if (pru->id == 1)
+	if (pru->id == PRUSS_PRU1)
 		swap(dram0, dram1);
 	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
 
@@ -747,14 +748,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
 	case RTU0_IRAM_ADDR_MASK:
 		fallthrough;
 	case PRU0_IRAM_ADDR_MASK:
-		pru->id = 0;
+		pru->id = PRUSS_PRU0;
 		break;
 	case TX_PRU1_IRAM_ADDR_MASK:
 		fallthrough;
 	case RTU1_IRAM_ADDR_MASK:
 		fallthrough;
 	case PRU1_IRAM_ADDR_MASK:
-		pru->id = 1;
+		pru->id = PRUSS_PRU1;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
new file mode 100644
index 000000000000..fbe4fbb45807
--- /dev/null
+++ b/include/linux/pruss.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * PRU-ICSS Subsystem user interfaces
+ *
+ * Copyright (C) 2015-2022 Texas Instruments Incorporated - http://www.ti.com
+ *	Suman Anna <s-anna@ti.com>
+ */
+
+#ifndef __LINUX_PRUSS_H
+#define __LINUX_PRUSS_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+#define PRU_RPROC_DRVNAME "pru-rproc"
+
+/**
+ * enum pruss_pru_id - PRU core identifiers
+ * @PRUSS_PRU0: PRU Core 0.
+ * @PRUSS_PRU1: PRU Core 1.
+ * @PRUSS_NUM_PRUS: Total number of PRU Cores available.
+ *
+ */
+
+enum pruss_pru_id {
+	PRUSS_PRU0 = 0,
+	PRUSS_PRU1,
+	PRUSS_NUM_PRUS,
+};
+
+
+#endif /* __LINUX_PRUSS_H */
\ No newline at end of file
-- 
2.25.1

