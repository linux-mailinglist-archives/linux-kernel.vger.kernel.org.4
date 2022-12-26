Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8299D656066
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiLZG3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiLZG3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:29:06 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837D32717;
        Sun, 25 Dec 2022 22:29:04 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.224.88]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LtYx8-1okYvL0Cua-010tRy;
 Mon, 26 Dec 2022 07:28:47 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] arm64: dts: fsl-imx8qm-device.dtsi: add io-channel-cells to adc nodes
Date:   Mon, 26 Dec 2022 07:28:20 +0100
Message-Id: <20221226062824.53113-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221226062824.53113-1-marcel@ziswiler.com>
References: <20221226062824.53113-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yT894WxflFkUPHarJEEkk3EvpndWb6L9gwAL0JWbTC2Aj4azoXI
 GD+2EW3W9648w7kwpjF0gXLigpoAXOz5+ZzRrT3IlIsS/xHwySODgAgS9v8OTwOsVmuAQ5L
 87BQRSM1f7hGD3O5ENXNZAdxQ1d7++KIUlhww3Vp/qJfzNEhiIoP4LR3Nu0cw1oQV0uDvnl
 INIUK6YJHIyqvSeN9l6Gg==
UI-OutboundReport: notjunk:1;M01:P0:fa01bK35U3o=;ckNHUpM0OMLebzZmVU/+oUuT2bp
 1cInVIcvLuenQL81HzM/TN5VeoFXn9cTW/Bwy3/YfYPiHd+QhX/r2j6XrVew/ndHbgxScjM6y
 SmRr8uDFcP2DUihWqZt+amLACyZ3t5+xTXRumRRcQod8E/LNiPnjOzCmLSqdwl5xEt+7ZtnbI
 ZSkQqet0r540OSSWKrMSI3jBYSNCQoeM1agIAmx34WydLAOoVTkZBLBBqdvhnsahzSi5MxUuT
 OoNJO5OtdmjGv04K8uDUliwk7RMIKhyeY7VaY02VA178iebJLFS0NHIC6AuCMAnvzInqs8GZy
 wjGz5XlCA+LCtwZH1YNRT+NZPLQ/ChkHwmwk3UEk3jsQ3jek76PLxuUgT0zB8NNMWMSQExMb4
 dYR01aaKXB7UhCyJvHglDrYQo/xQu5+LBAve/huynUfNPyTqIOJqRbaQuGHy+8eVO3wfvIw6a
 wSwzlNVo6y5DItuD8xVYcjSdkOe2Vx3FRSa3/fy5Ni87WkGGs1P7gBYKHeFp6iVfkFttZKpb6
 +SZveJxk70FtH6/TyjNKTP1sbsupL0jSebt189YVvuAQsgMuk5bZb918jO1xBKYDkwcJ4FDtb
 YbkDPC74GHdNvC+SQouFhFUMk8vJPSq6vf0K5KzvH+AV2lCqPieB0FHEiOttsYNdruKnVJwCM
 VzxpHIKTxovHBCthJE63eC3mIvl7VsAiUis/l7LHjQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

This commit adds io-channel-cells property to the ADC nodes. This
property is required in order for an IIO consumer driver to work.
Especially required for Apalis iMX8 QM, as the touchscreen driver
uses ADC channels with the ADC driver based on IIO framework.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index a943a1e2797f..6e5ef8b69bf8 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -270,6 +270,7 @@ i2c3: i2c@5a830000 {
 
 	adc0: adc@5a880000 {
 		compatible = "nxp,imx8qxp-adc";
+		#io-channel-cells = <1>;
 		reg = <0x5a880000 0x10000>;
 		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
@@ -284,6 +285,7 @@ adc0: adc@5a880000 {
 
 	adc1: adc@5a890000 {
 		compatible = "nxp,imx8qxp-adc";
+		#io-channel-cells = <1>;
 		reg = <0x5a890000 0x10000>;
 		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-- 
2.35.1

