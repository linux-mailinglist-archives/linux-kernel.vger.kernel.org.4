Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9445B5FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiILSJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiILSIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:08:47 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C114057D;
        Mon, 12 Sep 2022 11:08:45 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1oXnrN-00GaLM-BM; Mon, 12 Sep 2022 18:08:41 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 4/5] arm64: dts: imx8mp-venice-gw74xx: add cpu-supply node for cpufreq
Date:   Mon, 12 Sep 2022 11:08:35 -0700
Message-Id: <20220912180836.773729-4-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912180836.773729-1-tharvey@gateworks.com>
References: <20220912180836.773729-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator config for cpu-supply in order to support cpufreq.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: no changes
---
 .../dts/freescale/imx8mp-venice-gw74xx.dts     | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 211e6a1b296e..066a4afaf8a1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -141,6 +141,22 @@ reg_wifi_en: regulator-wifi-en {
 	};
 };
 
+&A53_0 {
+	cpu-supply = <&reg_arm>;
+};
+
+&A53_1 {
+	cpu-supply = <&reg_arm>;
+};
+
+&A53_2 {
+	cpu-supply = <&reg_arm>;
+};
+
+&A53_3 {
+	cpu-supply = <&reg_arm>;
+};
+
 /* off-board header */
 &ecspi2 {
 	pinctrl-names = "default";
@@ -361,7 +377,7 @@ BUCK1 {
 				regulator-ramp-delay = <3125>;
 			};
 
-			BUCK2 {
+			reg_arm: BUCK2 {
 				regulator-name = "BUCK2";
 				regulator-min-microvolt = <720000>;
 				regulator-max-microvolt = <1025000>;
-- 
2.25.1

