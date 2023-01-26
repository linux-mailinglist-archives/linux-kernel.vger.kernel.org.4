Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8FC67C96C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbjAZLJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjAZLJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:09:18 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509EC3E0BA;
        Thu, 26 Jan 2023 03:09:16 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MTRrt-1pCz6N2Yj9-00SQNF;
 Thu, 26 Jan 2023 12:08:57 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v5 02/10] arm64: dts: imx8-ss-dma: add io-channel-cells to adc nodes
Date:   Thu, 26 Jan 2023 12:08:25 +0100
Message-Id: <20230126110833.264439-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230126110833.264439-1-marcel@ziswiler.com>
References: <20230126110833.264439-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TqowiqmeLKwSnxtcWA6HCPQj032KaJFjew20ZdS2KX+YgiedgUm
 eVoHwir07g7g0REKnfHDq1VlS5Te5OF619npoY/gpcmxiThrYgkQI1QZdoFzl4PNhdrGc8K
 EF5D5Lz9A5Dp+L9NAKIxZ8p5xe9RSlq1PLpYfjYzT37e1hwdfp2ZBRnvChbMbA+7caDCm7k
 8uQZU4AB2lidwHcGahncw==
UI-OutboundReport: notjunk:1;M01:P0:9RMIB8OrtEk=;fpxKQ+ksOavLCiKgMvBIFL8ftGB
 dG5xvOeIAoBN5mLenXJSqb8dT7e97kwgKHoIcrfSiVXhWCPhDHmnCqA6Tb6ZYdVpKh2Gy0xXC
 tEpS+Wv1554XuybI2AdkfFBoC4ab9keARGeA9dPxyzrgY/iFgl20NsY7R60xW/uzV/2QVe51i
 AxYMUz7PQL4ELwbugqNIuKDI5+t/ptPqu5ATQpYvLgVktyOkzZvcfnJpaBj5NagqZQ2oYYK6O
 11xixo4Q/Ke2nQx3xGIbb2b9yUkdpeT/ZOY0zLAE7nfeIU3oTUakDrOiERkxqnq+03u0eHpnG
 gZ3TAHWRw0Bm0jPERd0MuFjeG0n1UWhPHhzfoa2eMMwNOrZp9QYErpE4XN006+J63I+I1WCCW
 vSpP7nMUGo1FSxMQMV81fUoxWkXn3fYvkJ2Pfd/h2bip4Ph7GifH1nHxKAJG7xYedMTjuaLy9
 jcBZXpX7TnVsP4ksPwpgTAC++Yzy/HqVSzFhnn0JPFsAxM6M0TPRURjtJsaAzS6vob+50/Dj3
 arRI0ewXoPuoCHKIpdQGLkZmP0BAeLetdw01dO9/CNCIxX2MMAwpB8Ewa3YiA53+lEOeLaAtn
 6KfOVC6A9NMPlC/Zln7LhMsRZBVJ88rs6whKDoW2HhsNeAiE1WVxXdYBP6oJDI2+bN/U6mKog
 5nCUMnqzj4Xk0CMMIwMDYpMp3NfQGfXOA0VE0v45rw==
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

(no changes since v3)

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

