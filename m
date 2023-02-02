Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60F768831F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjBBPyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjBBPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:54:10 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74D717149;
        Thu,  2 Feb 2023 07:54:09 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.17]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M5ukJ-1oPiYW21er-00xvDK;
 Thu, 02 Feb 2023 16:32:46 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-imx@nxp.com, Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v6 02/10] arm64: dts: imx8-ss-dma: add io-channel-cells to adc nodes
Date:   Thu,  2 Feb 2023 16:32:12 +0100
Message-Id: <20230202153221.197308-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230202153221.197308-1-marcel@ziswiler.com>
References: <20230202153221.197308-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:d+sROg43lq7zrO9rP9ELErNA5F7AApp/IXiWIudUJERjflY0vzN
 11yPHoYb6/AtyeyuNi6dIAkX3w1RzJrgA86vcFPV6HU6hlZUnI7Rb3Kozlh3XvI0BaizBso
 ReHPYBD1CuXOUk4/nm0W9iK+fUm959Do3C3t0NJ0yUOhsxKN6FSo46l8jNuLS0EDMyLFETX
 UR6dboyApFpmrfDP0Gy/Q==
UI-OutboundReport: notjunk:1;M01:P0:AbBA4rc6TUQ=;Xlooh/Laf1AlXg4k9eNRSDbZuGC
 SgVZwzZ1N5DWaUEYyDU6LJ54ABJzewnHKDFf15SNw84Ysm70+q95FqvMBwRsy2LqTnH/adfCV
 oHjVkPkF6enIVbBlUvBRk6YgRNOqAK3lpLUxMeiAgpwcoH5B1u76QKs2FtQQoeOdcT5ZXFpvE
 mke8Hx5NCETiIckInjecye/G3+9u1UIijTXGYikvcc+aaRz4sMIfKRT7oV6OyptrtbRo2rYMX
 aUrgbjSv5P2WjPhSaVpHeFxVj1ve+nemP7GRattCwGQ0KL5j3njZcJiXof0ySowlXz1GUKRyf
 pSY0PMUDv+GWXZ/GiaDap0wXjU1bqUskayA26+6Sc/ZBhOXkWSyBxdoAney6h48HO8ixhAHW1
 fIGPwZ5L87QsUnRmKfmrGeabBfLALbD8jaqvzseDCVNlBHuT/VwagBGxAKqcM6mFCwvthm0jD
 T/To4pFgjXZ7yWHG72mHLEa6ojgROnkgzoPc6Mgxqx4HiwXveh0XdWQleQL3fCaYPjmbHNg3c
 vKVQ6MWmERRdzPuTUfqbDmBY1qsm4C6a9Ya2JF72f2ZayjdrL1ROC245DIIY4Jzx7U+twVsb6
 /O2M0S/I1sTcS5WbYiUw2NBKqwc9W4mIQ3pjWHshpg6uyw/2XdS3ZCmpn7G4XkgCS4vWDtrxw
 cUs53TbbtcgrJqKz7f8XGYIV/Rr+ffZU/hHtuT1YcA==
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
Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>

---

Changes in v6:
- Add Alexander's acked-by. Thanks!

Changes in v3:
- Fix subject as pointed out by Shawn. Thanks!

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
2.36.1

