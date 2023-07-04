Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8568474696A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGDGM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjGDGMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:12:53 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CD31A7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:12:52 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B3FA91A04CC;
        Tue,  4 Jul 2023 08:12:50 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 79F6D1A04C7;
        Tue,  4 Jul 2023 08:12:50 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 94BB91820F59;
        Tue,  4 Jul 2023 14:12:48 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, shengjiu.wang@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clk: imx8: Add audio clock mux related clock
Date:   Tue,  4 Jul 2023 13:39:34 +0800
Message-Id: <1688449175-1677-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688449175-1677-1-git-send-email-shengjiu.wang@nxp.com>
References: <1688449175-1677-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio Clock Mux is the IP for i.MX8QXP, i.MX8QM, and
i.MX8XL platform, Add the clockid for them.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/dt-bindings/clock/imx8-clock.h | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
index 2e60ce4d2622..2242ff54fc5e 100644
--- a/include/dt-bindings/clock/imx8-clock.h
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -164,4 +164,32 @@
 
 #define IMX_ADMA_LPCG_CLK_END				45
 
+#define IMX_ADMA_ACM_AUD_CLK0_SEL			0
+#define IMX_ADMA_ACM_AUD_CLK1_SEL			1
+#define IMX_ADMA_ACM_MCLKOUT0_SEL			2
+#define IMX_ADMA_ACM_MCLKOUT1_SEL			3
+#define IMX_ADMA_ACM_ESAI0_MCLK_SEL			4
+#define IMX_ADMA_ACM_ESAI1_MCLK_SEL			5
+#define IMX_ADMA_ACM_GPT0_MUX_CLK_SEL			6
+#define IMX_ADMA_ACM_GPT1_MUX_CLK_SEL			7
+#define IMX_ADMA_ACM_GPT2_MUX_CLK_SEL			8
+#define IMX_ADMA_ACM_GPT3_MUX_CLK_SEL			9
+#define IMX_ADMA_ACM_GPT4_MUX_CLK_SEL			10
+#define IMX_ADMA_ACM_GPT5_MUX_CLK_SEL			11
+#define IMX_ADMA_ACM_SAI0_MCLK_SEL			12
+#define IMX_ADMA_ACM_SAI1_MCLK_SEL			13
+#define IMX_ADMA_ACM_SAI2_MCLK_SEL			14
+#define IMX_ADMA_ACM_SAI3_MCLK_SEL			15
+#define IMX_ADMA_ACM_SAI4_MCLK_SEL			16
+#define IMX_ADMA_ACM_SAI5_MCLK_SEL			17
+#define IMX_ADMA_ACM_SAI6_MCLK_SEL			18
+#define IMX_ADMA_ACM_SAI7_MCLK_SEL			19
+#define IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL			20
+#define IMX_ADMA_ACM_SPDIF1_TX_CLK_SEL			21
+#define IMX_ADMA_ACM_MQS_TX_CLK_SEL			22
+#define IMX_ADMA_ACM_ASRC0_MUX_CLK_SEL			23
+#define IMX_ADMA_ACM_ASRC1_MUX_CLK_SEL			24
+
+#define IMX_ADMA_ACM_CLK_END				25
+
 #endif /* __DT_BINDINGS_CLOCK_IMX_H */
-- 
2.34.1

