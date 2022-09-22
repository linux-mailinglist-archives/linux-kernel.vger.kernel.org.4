Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687005E6870
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiIVQa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiIVQaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:30:13 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAF62F011;
        Thu, 22 Sep 2022 09:30:04 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N4QTi-1pIoYK1RAM-011OpE;
 Thu, 22 Sep 2022 18:29:50 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/8] arm64: dts: verdin-imx8mm: improve pcie node
Date:   Thu, 22 Sep 2022 18:29:22 +0200
Message-Id: <20220922162925.2368577-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220922162925.2368577-1-marcel@ziswiler.com>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6nkbbLRkeC4qU0/eiq5XE6Bk3Z9EcuArXyNrgFpdIG8EzA2FswJ
 il5UO/NZodW2fuAIdgF+kJfjKNp73SI3Hq8AI0Q20Slj1N4Pl09svZji+mb7GLG8tHTj0cU
 g6PbzhyCMH+1F+IPYmt1qcbG5i0sbOiwMsaWQkY+975quRJ/251CsSQa37PxOi9ILQoB0y0
 ddQOYPXHnjSirvjdFO0Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B9uTMlgi5fE=:XbCDjY6zMoaSJitFULqSxX
 ye36g68rsXQ4SxB1snV7JW2tdDvDjTH46NMzRCDGXLscaanNz3uahmzfzbj6Xl3dQYjKEjHO3
 2rYxmyWHT4VTC0phLyO1QQAkq+xFynjHbc5jqdKj6kU9foR1FZwgema6gf5vQE3+JHdIX23g8
 PERoQvjdusXEbueXZYlZ0NURH7MbzXCZmXjoIa8bCT7ZzoYdbkxWApZpKHdM9o2qRWayBV+qm
 o3kaqpO52xy3TkvjgjyQjrte0kEJ7X0I6XC5lLNV3EV8ymWdDJLM9sQttPO2TvGK7GsIsdclO
 ILUlzP963xfkEzX3dQmSHTmd+H74km90p0T9bDJhFLxSLsyu108dQv65G2rktEH4BuNy/lCjY
 svo2XKJh4BvsfTrq5bl2oh+0Di7sAUfRLObNgR+B+4+sdkFg5wcOGeGvptBwI222MR6FA8RzG
 SXsXixMiPQrfyL2wPt08A6JxK4/slMaLMAaLtPnY/EX2h8y6ICKlbv4/IKu3hZWEAyN60GKs7
 oBQHH+H3v1LAHpYD0ws+bYkUawpJYgFDMt1G6VD9YZQwxecH1CIX6DMcwDB8u2Ed01mZzSUbZ
 Br+4VyYu+jx/k5X35GPyMJhUqeaJAQxyOKmDRmof6+CCjmo0CaF4tdEMAJZS6UaUKDhQILMrG
 9XyXkAZ8zcA/dIHYT3/Cm9WEdYt+NcGPo9lz3N5khe1fAX/v4tq2upFKv8o95QEdqRjJpQ5gb
 0mNS5kWC4V3IINqZH/2DTf9pTn5zBCDOtHX8eYiWlYBvMyJqshYuAq7xw3msbuSHnnyk7q4bx
 V4IYzdg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Slight improvement of pcie node to be more in-line with what we add on
the Verdin iMX8M Plus.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 0c2582402087..0f1c6e320c66 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -638,7 +638,8 @@ &pcie0 {
 	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
 				 <&clk IMX8MM_SYS_PLL2_250M>;
 	assigned-clock-rates = <10000000>, <250000000>;
-	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
+	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>,
+		 <&clk IMX8MM_CLK_PCIE1_AUX>,
 		 <&clk IMX8MM_CLK_PCIE1_PHY>;
 	clock-names = "pcie", "pcie_aux", "pcie_bus";
 	pinctrl-names = "default";
@@ -649,6 +650,7 @@ &pcie0 {
 
 &pcie_phy {
 	clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
+	clock-names = "ref";
 	fsl,clkreq-unsupported;
 	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
 	fsl,tx-deemph-gen1 = <0x2d>;
-- 
2.36.1

