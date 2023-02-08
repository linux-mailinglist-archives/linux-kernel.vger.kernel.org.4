Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA9068E893
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjBHG5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBHG5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:57:20 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97DD12F18;
        Tue,  7 Feb 2023 22:57:18 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.227.109]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MTjFe-1ozDZL28Lw-00QUlV; Wed, 08 Feb 2023 07:57:00 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v7 02/10] arm64: dts: imx8-ss-dma: add io-channel-cells to adc nodes
Date:   Wed,  8 Feb 2023 07:56:33 +0100
Message-Id: <20230208065641.23544-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230208065641.23544-1-marcel@ziswiler.com>
References: <20230208065641.23544-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e9o8jMCkPT/G6ou1wpvLNcthsJilQC/1xmW8OfSgUfXndZEeNJp
 Z56IOH5FLthfqLg6QcDtPTHd4jZTqNVEEpYcqdcljfYDv/+mL8Zn3uDOaT1RL6YYGOVOclZ
 MK7/0Sz8TNThXmXyh7MdSpUzhp+VRkoE1og7Jipy+kfFYtO4FIjcboy3W9/j2FXgyam4r3H
 hVhq3SNTpvgyM2A1P6fug==
UI-OutboundReport: notjunk:1;M01:P0:0d3oSiXa5F4=;Nun3pX/+x4n3Lmmkm2Cxm+BP1kH
 XLFRqAmHuMtAWs8hBOf2hGLhOnxZsyYQO/P8vdq0tYAT5W+I1r8vCF1tNQvPnEuYLEF4TAoND
 A+7ul/251t+70mtgfGKX4pdxlV0/G8XdIN59oqvr4LpeUX0CzUB1yzVeRkI7NfUr0JMIsVHYy
 iQ+xKy73K1hLBCYOKKIXjFfh8OeVSqLOEsOk++2ftd+PB5c2u3ofEzhQgfsqNlrLfgHV/vXlo
 T6aK0iBBysqJuBryh1dj8j48ybNLKp0IpNSHhKXe/CofTQEXihYurTTuPsUJCLGWX7eBY7gNn
 0Q7E2fjKkteu+mRbN5SVMK6Jn+Znfwe/+S5HX3Cq8yW6KBU/R0hY84OPNd98McW9WorxlbLgm
 V72Mpw8ZO6vjH4KMASPxo9Ul5gN9WpU1XcLHIYneALw4Dp3n1MKCvsZAZwriEm30uyvqkTJXH
 fSvSNVEcxns7XDdW6l0HkcZY0ipO3SBW0SGTQ6MyFxk0oLPKgKcBpxRb0ck8b9jJOrGZdWHSY
 2JXqFBUdXQOsxi+9KtTAkzgdzZWwfj7vyOiUiu/QTW99sgQNsahF4D6ppMYCkUezuquXmKYPL
 omPvkZx31zxb2iCTOwjrVGj+UvgScxMZVVcDLjnIMd5FLZeb19dgt/Hf4RK4pC/CXN7tdvzh/
 hNiMISYNBZOQiKyPTSwzNptx/VyTD9zE+xtrJhyz0A==
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

(no changes since v6)

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

