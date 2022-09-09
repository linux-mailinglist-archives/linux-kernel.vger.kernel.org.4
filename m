Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A545B30B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiIIHmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiIIHmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:42:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DBF11B01F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:38:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so1292401wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=WAXuAdMYCi1g4B3dZtIrUPbn2Rjq0LvUklClvaIr8b8=;
        b=hixeKMNDSjZK3KfMycWsysM82K7TRLETak/YdjVEpPzYcAiTEyk1am1Y6ucG8fceex
         gOBbgIHZEWeBRdgDLIHXwL/X4Bl2ustyrVlJlTITV9SlwE6ZstmXh/kthIVTS1Hbo6Ty
         4LOP/ZaSecGllpo7+qyebW78n6H7y/TICy3iRg5GW/WwK/8Fv/2mNWFX3zxZYwolR+OQ
         +GfGCLfmC1vuUWsIIvGsq8HPALZUPSB9sR7qLw4yZHU0Jx0FWdVZcDQoahIOb6A9giT+
         KDtlJQdeSPKs98fcE/Y9nj/GIKcWMT9HMZn7fsw0bzoCfE9lN9M4UuiDtHMoxgTcM6O9
         mq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=WAXuAdMYCi1g4B3dZtIrUPbn2Rjq0LvUklClvaIr8b8=;
        b=B4XztDV/U93TRsIq8kJGm9Fw3X/7/2jSNxn1M1bwnKROCpgkVBah6vAAJtIYxBv8O2
         XY18M0q3sWVmq66sYlJ1iyZHPTXTV3mdD0zH1RYMjBDNeevBJC3sWr4WD+RBrTOroLvU
         rX5vlCrSYmBraNhaBqut43slKfzVa2NnGz4Mi9KoNtExaBPKNAihhLGxcnaZk27qhSjj
         Uym1h31kmOggYjJnsFqLs0cS5FELH7umDrYRebddGl2hsDaGOBtW1Ppt2Q+HqLZu8eA/
         pYypysFX/YM1LklI+fzjKQ+x2O5Lw4bRGqz1bkoDh1nAEAwZV1+01GeYqdIpQOkVRGQz
         jPMg==
X-Gm-Message-State: ACgBeo0uqLGW7+vhbduSjE9OchA+eYJ+zYU9zgCd+oVIxPjX6wGE9W0x
        dWnsoVEeW+YnvFLR9IGsbLBPSA==
X-Google-Smtp-Source: AA6agR75OF2EH+cFAiCFUtN0kMdkH9+f5B4FNPLDQ7a3iVi2EQXbEUCBkPoYSszQ+aDBYO//mF1y4w==
X-Received: by 2002:a5d:494d:0:b0:228:d840:99f5 with SMTP id r13-20020a5d494d000000b00228d84099f5mr7203566wrs.458.1662709053950;
        Fri, 09 Sep 2022 00:37:33 -0700 (PDT)
Received: from amjad-ThinkPad-T490.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h7-20020a05600c414700b003a83ca67f73sm1252976wmm.3.2022.09.09.00.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 00:37:33 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     matthias.bgg@gmail.com
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>, rafael@kernel.org,
        fparent@baylibre.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH v4 2/4] thermal: mediatek: control buffer enablement tweaks
Date:   Fri,  9 Sep 2022 09:37:26 +0200
Message-Id: <20220909073726.32423-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

Add logic in order to be able to turn on the control buffer on MT8365.
This change now allows to have control buffer support for MTK_THERMAL_V1,
and it allows to define the register offset, and mask used to enable it.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 drivers/thermal/mtk_thermal.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 8440692e3890..d8ddceb75372 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -271,6 +271,9 @@ struct mtk_thermal_data {
 	bool need_switch_bank;
 	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
 	enum mtk_thermal_version version;
+	u32 apmixed_buffer_ctl_reg;
+	u32 apmixed_buffer_ctl_mask;
+	u32 apmixed_buffer_ctl_set;
 };
 
 struct mtk_thermal {
@@ -514,6 +517,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
 	.adcpnp = mt7622_adcpnp,
 	.sensor_mux_values = mt7622_mux_values,
 	.version = MTK_THERMAL_V2,
+	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
+	.apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
+	.apmixed_buffer_ctl_set = BIT(0),
 };
 
 /*
@@ -963,14 +969,18 @@ static const struct of_device_id mtk_thermal_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
 
-static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
+static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
+				       void __iomem *apmixed_base)
 {
-	int tmp;
+	u32 tmp;
+
+	if (!mt->conf->apmixed_buffer_ctl_reg)
+		return;
 
-	tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
-	tmp &= ~(0x37);
-	tmp |= 0x1;
-	writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
+	tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
+	tmp &= mt->conf->apmixed_buffer_ctl_mask;
+	tmp |= mt->conf->apmixed_buffer_ctl_set;
+	writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
 	udelay(200);
 }
 
@@ -1070,8 +1080,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_auxadc;
 	}
 
+	mtk_thermal_turn_on_buffer(mt, apmixed_base);
+
 	if (mt->conf->version == MTK_THERMAL_V2) {
-		mtk_thermal_turn_on_buffer(apmixed_base);
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 	}
 
-- 
2.37.3

