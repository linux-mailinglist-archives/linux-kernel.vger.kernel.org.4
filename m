Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FC66012FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJQPuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJQPuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:50:51 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACD166862
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:50:49 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HFHYl6024503;
        Mon, 17 Oct 2022 17:50:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=PTD29u9H2awREq7QER5NbK7XrTS7AE1TFO8vQSlVClg=;
 b=GoCAm0MeFgww0b3B9e+jZXZIRjKAv0voa5MKl1riNytrpKGs0vu+LjoBqKa+3dxIe1K6
 B0QubPfx8lJ42DBOObR0JDHfF3l+T5wDRt7WK7Cdj8KKegE7GekZMSfGQg7F8WhDOgLP
 iCEfhqB8hf7fB2BOc8JMj/RAJz5mtphBP7GTY2MJidvNFczQhsfRURars6U3LjHzsPPH
 zmD37dT+gPta/9cI5yvYpbLP8fY0OIbkfcuGHVmn9e6nTf6hQ43wMCWFzPi/4Wry4/fm
 xgBtA4NDz4XahkhmyF0lSrbdSOgR1/zjVexcLHQSv3N6qBfxqwUlgAs42i8teHCOGX8B Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k7krjnsh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 17:50:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F22C8100034;
        Mon, 17 Oct 2022 17:50:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED81323C6A0;
        Mon, 17 Oct 2022 17:50:39 +0200 (CEST)
Received: from localhost (10.75.127.48) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:50:36 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 1/3] nvmem: stm32: move STM32MP15_BSEC_NUM_LOWER in config
Date:   Mon, 17 Oct 2022 17:49:55 +0200
Message-ID: <20221017174953.v2.1.I95e71328dd654723bd4c57206bd008ff81c726bb@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017154957.277120-1-patrick.delaunay@foss.st.com>
References: <20221017154957.277120-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support STM32MP15_BSEC_NUM_LOWER in stm32 romem config to prepare
the next SoC in STM32MP family.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v2:
  - Add patch "move STM32MP15_BSEC_NUM_LOWER in config" in the serie,
    solve dependency issue for "priv->lower" in patch "nvmem: stm32:
    add warning when upper OTPs are updated"

 drivers/nvmem/stm32-romem.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 354be526897f..d93baee01d7b 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -22,16 +22,15 @@
 /* shadow registers offest */
 #define STM32MP15_BSEC_DATA0		0x200
 
-/* 32 (x 32-bits) lower shadow registers */
-#define STM32MP15_BSEC_NUM_LOWER	32
-
 struct stm32_romem_cfg {
 	int size;
+	u8 lower;
 };
 
 struct stm32_romem_priv {
 	void __iomem *base;
 	struct nvmem_config cfg;
+	u8 lower;
 };
 
 static int stm32_romem_read(void *context, unsigned int offset, void *buf,
@@ -85,7 +84,7 @@ static int stm32_bsec_read(void *context, unsigned int offset, void *buf,
 	for (i = roffset; (i < roffset + rbytes); i += 4) {
 		u32 otp = i >> 2;
 
-		if (otp < STM32MP15_BSEC_NUM_LOWER) {
+		if (otp < priv->lower) {
 			/* read lower data from shadow registers */
 			val = readl_relaxed(
 				priv->base + STM32MP15_BSEC_DATA0 + i);
@@ -159,6 +158,8 @@ static int stm32_romem_probe(struct platform_device *pdev)
 	priv->cfg.priv = priv;
 	priv->cfg.owner = THIS_MODULE;
 
+	priv->lower = 0;
+
 	cfg = (const struct stm32_romem_cfg *)
 		of_match_device(dev->driver->of_match_table, dev)->data;
 	if (!cfg) {
@@ -167,6 +168,7 @@ static int stm32_romem_probe(struct platform_device *pdev)
 		priv->cfg.reg_read = stm32_romem_read;
 	} else {
 		priv->cfg.size = cfg->size;
+		priv->lower = cfg->lower;
 		priv->cfg.reg_read = stm32_bsec_read;
 		priv->cfg.reg_write = stm32_bsec_write;
 	}
@@ -174,8 +176,17 @@ static int stm32_romem_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &priv->cfg));
 }
 
+/*
+ * STM32MP15 BSEC OTP regions: 4096 OTP bits (with 3072 effective bits)
+ * => 96 x 32-bits data words
+ * - Lower: 1K bits, 2:1 redundancy, incremental bit programming
+ *   => 32 (x 32-bits) lower shadow registers = words 0 to 31
+ * - Upper: 2K bits, ECC protection, word programming only
+ *   => 64 (x 32-bits) = words 32 to 95
+ */
 static const struct stm32_romem_cfg stm32mp15_bsec_cfg = {
-	.size = 384, /* 96 x 32-bits data words */
+	.size = 384,
+	.lower = 32,
 };
 
 static const struct of_device_id stm32_romem_of_match[] = {
-- 
2.25.1

