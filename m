Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B33D62EDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbiKRGkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241182AbiKRGkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:14 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A849BA24
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:55 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i186-20020a1c3bc3000000b003cfe29a5733so6818971wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L32WQYqlNjpcpzOFzCSuLnV69ofSUDQHZsdX8hCT388=;
        b=jt6l8/ZFxO6fTZhNNXmrGClmIOM9XFrsk2imz2RDWi/MJSvYYYDsQ5bthBwsvgdcsd
         nJ7m/b4Tjl5bY+OrlBM3oPsGIst9t9RuO1dFIFNpS1bDacEt4UXT0qFcdSqNjzmirX02
         KTSwnigcEp1wQhRdUB/Pphggk8LSc4DZbEqkQQCCOIO8PQXJOHnej2/V5Rb23bVBzbFY
         iLZPJvzhnNo03JTUHwJL9Jezj2R9ta8ZgIBG0lbrApuQ9eD8LKIytnPPbGbvNqpeMGxm
         zY3XEZZbbAb0/7RrLxs8rjerRaebQplkxlhSI72Q4ZydruW4runlK47oFpyJQXKiTC3P
         S/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L32WQYqlNjpcpzOFzCSuLnV69ofSUDQHZsdX8hCT388=;
        b=ojOULMx29cEhR9J5nP2lT/AYyVNdXYF9AiK1tg4ajqW2/KHDkcmiY42cahfktUC1V0
         y/QaqsMycp0ts56wDAumDzEqvMQ5sDrQr53OHHHUqVOUrfjixbPbUtgQqHo/ubAiB7UP
         lIFRMov3JZlS2ZZS00VwHxuu756lCFldhH8/uGzBXKZXzhi/GntZGxWJxW8znO9bCRcu
         /9kAkb0nkXIVOBw7snUsI3S6DGsEJjXpevM9yuhD4xqGVvrOMRTDCOwcNR19PpI3k2Xw
         2WyxXW1uoowHQ1a+kNSsZuxSWkHL/9msp5O7+Us80w4qh1CZkZJcPx/lXd/Vtlm+dtPQ
         /wGQ==
X-Gm-Message-State: ANoB5pn0CkIJoHELEcyd7TcXSmBmHnsHUhjNVyy8uFleliYHAIfL9LE+
        o/wMEPwWJmRJJ46o2zQmAhOHMg==
X-Google-Smtp-Source: AA0mqf7CEC2hgYpgb5gZy0Ul2cpI4zerpfVNXdecy7xemWWs0wf+RVOcB30/38GzaZbHKppUkaCe6w==
X-Received: by 2002:a7b:c454:0:b0:3b4:be28:d800 with SMTP id l20-20020a7bc454000000b003b4be28d800mr7511597wmi.170.1668753593624;
        Thu, 17 Nov 2022 22:39:53 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:39:53 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/13] nvmem: stm32: move STM32MP15_BSEC_NUM_LOWER in config
Date:   Fri, 18 Nov 2022 06:39:20 +0000
Message-Id: <20221118063932.6418-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
References: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Support STM32MP15_BSEC_NUM_LOWER in stm32 romem config to prepare
the next SoC in STM32MP family.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
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

