Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DC26A9A69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjCCPQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCCPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:16:02 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97E81ABE0;
        Fri,  3 Mar 2023 07:15:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y2so2825697pjg.3;
        Fri, 03 Mar 2023 07:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677856558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iAHNFRrErL7el295aKmjr3jbvg5dczAcuNZAYIE3HY=;
        b=kE9CYEKWX3Sct6bWzan1A+UEOTNKckGtnsSyosCKP0FShm9MZOM4yCMIdfbiVcFIqj
         PzzjtUO3+F4bHYFRSEyp69uckvRV1f0RlGgjMNDYnHiAtXT5wyIIC0FdBUezz1wYCAIL
         poUdckREKHj6MwKY9XPcHjpDjAlAi02dv4hBcEka/37PA0ZvTRYo/B9Nbsrvo/RqDS5N
         b0vQ5TGV6eK18PfTWp5uDr6XeU+w3Hg3U9PdJV1TspvMOnnbMtS7EZrWzljv/fQ0wJWz
         TQiU61Cv5poGiEI/wfzmNtate7zkdqJiCUgbT+CTiyPHL4dhh8KyQGhxIIi/wmavRNl+
         Xobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iAHNFRrErL7el295aKmjr3jbvg5dczAcuNZAYIE3HY=;
        b=cE1o5mDFS+rsbw6G4bmifk/5J75Xwb2HcDq/JR80nvg9xgz8WaBoanjmwQA0iJnFda
         JC0sgMgOAopjJEBgpnWxij9KcZjEeu7A+82EkfgUCWeKz/E3M6PN40+xbA0ErpKryZQL
         m+7JE9GNuLUC7ZT73+vkrInl3TqSvPFGUM11l2qqg20vJDMJdhZ4spKZv//i8DHrDyOu
         /zYpJ4CBVOk35gfZUQ69WnwUQOisIzW1qNNpAS4V8mwy+UtW2leel7XJ1cxtJuzCPL/h
         wgZnxL+knkTk1jXgGsWo5e+u6OUy3oCElZ8w1T6XFc6VUZlU2zsY5YghuNt9pYpc04sP
         YRUg==
X-Gm-Message-State: AO0yUKVsHaoT5pwMGbjwK5eg/2ZT7uxru9GINIGMlisu9i7sfylrqzqZ
        FTQdG0GN6LfL1crRTj713GM=
X-Google-Smtp-Source: AK7set8R5wA3yATpI05a3c/0HFtvftl38MxO+0+i8+1EvGMlXlT8A0NXJq2haKHFc4k8uS+LkCTlUQ==
X-Received: by 2002:a05:6a20:3955:b0:be:c1b2:514d with SMTP id r21-20020a056a20395500b000bec1b2514dmr2043353pzg.13.1677856558208;
        Fri, 03 Mar 2023 07:15:58 -0800 (PST)
Received: from y.ha.lan ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id p4-20020aa78604000000b005a8bdc18453sm1739721pfn.35.2023.03.03.07.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:15:57 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] clk: hisilicon: Rename some symbols for Hi3798CV200
Date:   Fri,  3 Mar 2023 23:14:11 +0800
Message-Id: <20230303151417.104321-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303151417.104321-1-mmyangfl@gmail.com>
References: <20230303151417.104321-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These symbols might cause confusion when adding support for other Hi3798
series SoCs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg-hi3798.c      | 41 ++++++++++++-------------
 include/dt-bindings/clock/histb-clock.h |  2 ++
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index 9c933172b..f834805d7 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -27,8 +27,6 @@
 #define HI3798_FIXED_300M			73
 #define HI3798_FIXED_400M			74
 #define HI3798_MMC_MUX			75
-#define HI3798_ETH_PUB_CLK			76
-#define HI3798_ETH_BUS_CLK			77
 #define HI3798_ETH_BUS0_CLK		78
 #define HI3798_ETH_BUS1_CLK		79
 #define HI3798_COMBPHY1_MUX		80
@@ -177,30 +175,31 @@ static void hi3798_sysctrl_clk_unregister(
 
 /* hi3798CV200 */
 
-static const char *const mmc_mux_p[] = {
+static const char *const hi3798cv200_mmc_mux_p[] = {
 		"100m", "50m", "25m", "200m", "150m" };
-static u32 mmc_mux_table[] = {0, 1, 2, 3, 6};
+static u32 hi3798cv200_mmc_mux_table[] = {0, 1, 2, 3, 6};
 
-static const char *const comphy_mux_p[] = {
+static const char *const hi3798cv200_comphy_mux_p[] = {
 		"100m", "25m"};
-static u32 comphy_mux_table[] = {2, 3};
+static u32 hi3798cv200_comphy_mux_table[] = {2, 3};
 
-static const char *const sdio_mux_p[] = {
+static const char *const hi3798cv200_sdio_mux_p[] = {
 		"100m", "50m", "150m", "166p5m" };
-static u32 sdio_mux_table[] = {0, 1, 2, 3};
+static u32 hi3798cv200_sdio_mux_table[] = {0, 1, 2, 3};
 
 static struct hisi_mux_clock hi3798cv200_mux_clks[] = {
-	{ HI3798_MMC_MUX, "mmc_mux", mmc_mux_p, ARRAY_SIZE(mmc_mux_p),
-		CLK_SET_RATE_PARENT, 0xa0, 8, 3, 0, mmc_mux_table, },
-	{ HI3798_COMBPHY0_MUX, "combphy0_mux",
-		comphy_mux_p, ARRAY_SIZE(comphy_mux_p),
-		CLK_SET_RATE_PARENT, 0x188, 2, 2, 0, comphy_mux_table, },
-	{ HI3798_COMBPHY1_MUX, "combphy1_mux",
-		comphy_mux_p, ARRAY_SIZE(comphy_mux_p),
-		CLK_SET_RATE_PARENT, 0x188, 10, 2, 0, comphy_mux_table, },
-	{ HI3798_SDIO0_MUX, "sdio0_mux", sdio_mux_p,
-		ARRAY_SIZE(sdio_mux_p), CLK_SET_RATE_PARENT,
-		0x9c, 8, 2, 0, sdio_mux_table, },
+	{ HI3798_MMC_MUX, "mmc_mux", hi3798cv200_mmc_mux_p,
+		ARRAY_SIZE(hi3798cv200_mmc_mux_p), CLK_SET_RATE_PARENT,
+		0xa0, 8, 3, 0, hi3798cv200_mmc_mux_table, },
+	{ HI3798_COMBPHY0_MUX, "combphy0_mux", hi3798cv200_comphy_mux_p,
+		ARRAY_SIZE(hi3798cv200_comphy_mux_p), CLK_SET_RATE_PARENT,
+		0x188, 2, 2, 0, hi3798cv200_comphy_mux_table, },
+	{ HI3798_COMBPHY1_MUX, "combphy1_mux", hi3798cv200_comphy_mux_p,
+		ARRAY_SIZE(hi3798cv200_comphy_mux_p), CLK_SET_RATE_PARENT,
+		0x188, 10, 2, 0, hi3798cv200_comphy_mux_table, },
+	{ HI3798_SDIO0_MUX, "sdio0_mux", hi3798cv200_sdio_mux_p,
+		ARRAY_SIZE(hi3798cv200_sdio_mux_p), CLK_SET_RATE_PARENT,
+		0x9c, 8, 2, 0, hi3798cv200_sdio_mux_table, },
 };
 
 static u32 mmc_phase_regvals[] = {0, 1, 2, 3, 4, 5, 6, 7};
@@ -253,9 +252,9 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 	{ HISTB_PCIE_AUX_CLK, "clk_pcie_aux", "24m",
 		CLK_SET_RATE_PARENT, 0x18c, 3, 0, },
 	/* Ethernet */
-	{ HI3798_ETH_PUB_CLK, "clk_pub", NULL,
+	{ HISTB_ETH_PUB_CLK, "clk_pub", NULL,
 		CLK_SET_RATE_PARENT, 0xcc, 5, 0, },
-	{ HI3798_ETH_BUS_CLK, "clk_bus", "clk_pub",
+	{ HISTB_ETH_BUS_CLK, "clk_bus", "clk_pub",
 		CLK_SET_RATE_PARENT, 0xcc, 0, 0, },
 	{ HI3798_ETH_BUS0_CLK, "clk_bus_m0", "clk_bus",
 		CLK_SET_RATE_PARENT, 0xcc, 1, 0, },
diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
index e64e5770a..ed47c43c3 100644
--- a/include/dt-bindings/clock/histb-clock.h
+++ b/include/dt-bindings/clock/histb-clock.h
@@ -58,6 +58,8 @@
 #define HISTB_USB3_UTMI_CLK1		48
 #define HISTB_USB3_PIPE_CLK1		49
 #define HISTB_USB3_SUSPEND_CLK1		50
+#define HISTB_ETH_PUB_CLK			51
+#define HISTB_ETH_BUS_CLK			52
 
 /* clocks provided by mcu CRG */
 #define HISTB_MCE_CLK			1
-- 
2.39.1

