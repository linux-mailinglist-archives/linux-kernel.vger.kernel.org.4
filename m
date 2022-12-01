Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B813963EEF9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiLALHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiLALGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:06:04 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00A77CA8E;
        Thu,  1 Dec 2022 03:05:22 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2B1B5CVq104019;
        Thu, 1 Dec 2022 05:05:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669892712;
        bh=3bLasOk9KhB8AfFE4PTyGUbS1Bde6fpNHFPFyjxnrYA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=W6WQoY4aDSGq4xbK5Szyo5ObzTI0NVOk2Kj8kr7GQ9WTtHIuiVRWT0b5m0pQZMhxE
         Du2eEjTB83rEsGbR10fr9xb+l7BAhsjrnpksaNJ71F/3qZOrW0YUFidmQtOzRYOQIz
         ogStV7pjLhCI+IWA6mM7Y8ZR3dvzrQa9HdeIz5ic=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2B1B5CwF022045
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Dec 2022 05:05:12 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 1
 Dec 2022 05:05:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 1 Dec 2022 05:05:11 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2B1B5BWU088976;
        Thu, 1 Dec 2022 05:05:11 -0600
Received: from localhost (a0501179-pc.dhcp.ti.com [10.24.69.114])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 2B1B5AA8032664;
        Thu, 1 Dec 2022 05:05:11 -0600
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
Subject: [PATCH v10 3/6] remoteproc: pru: Add enum for PRU Core Indentifiers.
Date:   Thu, 1 Dec 2022 16:34:57 +0530
Message-ID: <20221201110500.4017889-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201110500.4017889-1-danishanwar@ti.com>
References: <20221201110500.4017889-1-danishanwar@ti.com>
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
---
 drivers/remoteproc/pru_rproc.c | 16 ++++++++++++----
 include/linux/pruss.h          | 19 +++++++++++++++++--
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index b4498a505108..7d4ed39b3772 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -186,6 +186,7 @@ static struct rproc *__pru_rproc_get(struct device_node *np, int index)
  * pru_rproc_get() - get the PRU rproc instance from a device node
  * @np: the user/client device node
  * @index: index to use for the ti,prus property
+ * @pru_id: optional pointer to return the PRU remoteproc processor id
  *
  * This function looks through a client device node's "ti,prus" property at
  * index @index and returns the rproc handle for a valid PRU remote processor if
@@ -193,13 +194,17 @@ static struct rproc *__pru_rproc_get(struct device_node *np, int index)
  * time. Caller must call pru_rproc_put() when done with using the rproc, not
  * required if the function returns a failure.
  *
+ * When optional @pru_id pointer is passed the PRU remoteproc processor id is
+ * returned.
+ *
  * Return: rproc handle on success, and an ERR_PTR on failure using one
  * of the following error values
  *    -ENODEV if device is not found
  *    -EBUSY if PRU is already acquired by anyone
  *    -EPROBE_DEFER is PRU device is not probed yet
  */
-struct rproc *pru_rproc_get(struct device_node *np, int index)
+struct rproc *pru_rproc_get(struct device_node *np, int index,
+			    enum pruss_pru_id *pru_id)
 {
 	struct rproc *rproc;
 	struct pru_rproc *pru;
@@ -226,6 +231,9 @@ struct rproc *pru_rproc_get(struct device_node *np, int index)
 
 	mutex_unlock(&pru->lock);
 
+	if (pru_id)
+		*pru_id = pru->id;
+
 	return rproc;
 
 err_no_rproc_handle:
@@ -556,7 +564,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
 	dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
 	dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
 	/* PRU1 has its local RAM addresses reversed */
-	if (pru->id == 1)
+	if (pru->id == PRUSS_PRU1)
 		swap(dram0, dram1);
 	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
 
@@ -865,14 +873,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
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
index 5c5d14b1249d..efe89c586b4b 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -14,17 +14,32 @@
 
 #define PRU_RPROC_DRVNAME "pru-rproc"
 
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
 struct device_node;
 
 #if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
 
-struct rproc *pru_rproc_get(struct device_node *np, int index);
+struct rproc *pru_rproc_get(struct device_node *np, int index,
+			    enum pruss_pru_id *pru_id);
 void pru_rproc_put(struct rproc *rproc);
 
 #else
 
 static inline struct rproc *
-pru_rproc_get(struct device_node *np, int index)
+pru_rproc_get(struct device_node *np, int index, enum pruss_pru_id *pru_id)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.25.1

