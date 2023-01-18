Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8911667159F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjARH4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjARHx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:29 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EF43253C;
        Tue, 17 Jan 2023 23:27:37 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LptxZ-1olA0G3Jl1-00fhWo; Wed, 18 Jan 2023 08:27:20 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH v4 02/17] arm64: dts: imx8-ss-dma: add io-channel-cells to adc nodes
Date:   Wed, 18 Jan 2023 08:26:40 +0100
Message-Id: <20230118072656.18845-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qtcyZrXQL4eUfQUxbtKRmKPYf7+xb0oIkImD3UOhsY+sfF3kcbA
 sJPbp/yXbsInYixh4lmXpj+IfG8MZUcJ/YnaVC3ELqPPtYFiBFoemtNZ0l7um90W8xqTBro
 FB22tqo+08QhEtIWYv8o6EKFl3xzPxTL9TteavEz8u2DA8U0EPtU1byn0atfmmaGbQlTa4o
 q4BEnv7W5+Pvwlbn/29Sw==
UI-OutboundReport: notjunk:1;M01:P0:RndXisrEm34=;yHrdp2rQcaf2OysPLENiYmu+Hvn
 sWDl0YyOfF4Fnzt/BbW0B8SAzOAhiCwIIG/SpZ1LlmHwj7dx0UHAz9yiFuYhVMDp840AowW7/
 pQj3Zg9uQrUunx9q8TXedER4qVZkYpB4EHHyMi0/A5FQaXxNr1XgZtvWR6qRG0++joSBfP6mE
 9ibge7+6f8KBRWdHXFAO86eQioujqjdVIasVs04k35PUyPosLs/gQMQZA+HN+8HeMoQhom/kf
 TvohYdwv+XeG43cWUG2G6wxdhIWkDD26cqzciJfl974hPFlRpzzcqb2EKt0LE2sHgdMHnAeWe
 u6DkfH1ntEESkXSz7ipDDLpIYt7ebVFgmOa9j9lKI0RjHuZwo9zSpuFxnMS5GIhXykLveXewc
 TMPohLeqCgyUyg7yM7/w8WH2vDkjuug0ymUXOrebFONBda5GmxBFes3WK/6gaY++qc4Rm3SiH
 g/HjIELD+XKrt4VXzZVG2ZGbooMeAsAxao5S6NpnOrHutKV6QclCKkfs6ivpTFD989crXF5yZ
 7BbgAerhS26YnryMAwsaBqzEDyUrdLpEypY2+ffvENaNSihNdW7/8p56R1WUNHTD3GBNHf6hS
 DCtdAsVC3yYGGXJ1H8CamgHewttI4ChojRK2Vhz6NdhT+UKVu8EGv8etGdx8Fv5yzuoXrdiug
 4TLpyq1ikQ6n+FVUfHGWhRvguHjhFrgzqxq70epv3q+QbWDFyZeeUfLal3hSeyE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.35.1

