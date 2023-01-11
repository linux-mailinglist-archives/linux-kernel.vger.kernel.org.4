Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B306659C3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjAKLIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238072AbjAKLGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:06:42 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154A46317;
        Wed, 11 Jan 2023 03:06:30 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MtwtU-1ouajp10qy-00uGJv;
 Wed, 11 Jan 2023 12:06:13 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 2/6] arm64: dts: imx8-ss-dma: add io-channel-cells to adc nodes
Date:   Wed, 11 Jan 2023 12:05:53 +0100
Message-Id: <20230111110558.349460-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111110558.349460-1-marcel@ziswiler.com>
References: <20230111110558.349460-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t0E/XjDy3Liky+emPMnXWwKdtuin1aQqbVo9/U2IDtaoBl7J0f9
 p2nyTAMA1nh8v4H6FlP4iwRp3WhPUD5cDvdKQTpUhEOVYFeru/HbB0zz8E06A9zfBBMryNM
 qH8iQSa7WoyCFkmK49DFkqRoPojN3l4jDhvA0Dx+i9c1YWEJy4TTj5z9Zz6WPR0w93g2vT5
 SweNkD88Jj2GELREkN7Lw==
UI-OutboundReport: notjunk:1;M01:P0:enmWNuao1J4=;X8tIKxnaZCNz40FEWL/vfaWE+Su
 KKvXOHqvMLc4RRLEOr/YqeFaiHTDIVwPDwHJeUMi+LrNUT6p9ueoPikY50eYTk4S1t+XH96g0
 QPgQzsXfGYXPA7cpB2CtzhIakhEum1mu/D/oT+el4lIz2PdH3xVhpfH9OnmudkW/xVgSEqKt5
 afesFrCyzYcuaJGoIrPTovNsrIJcNyjgYNGS1v9nj9G+tRgkJ7kYcD//is3JtBHOiizk4T041
 plVRLzBGS4w3h6EeyeBymzWM0zuVeMFZqBg9Ri4NutSya7HvaY0DOrftoggY3nqCZlYufmcwG
 oCHvgn10ETIlHUDNvvuARUnkOxWpSt/SIckO9f06vG+eCw3zsmUvzK+tm25EoCQ3oNBdS8l1v
 mkamKcvkdN8Fu7mmIo/n2xHO8zvdgVPOakTPk/VHMPiX0pEIaWIQj5NF+4vXB3Riu77aEw6wM
 TqND/yT82FJqp2RIKYjDhjODJf51kCCcIYopNw74AuCoP+gpO+Z4n2i6RfmWUCCswMiXsKX13
 55se8/3PxKOD8bHJD/1jxgqPx/qDU5Inhj1zO9wfyZ58sSmehXpuPhoMoHEGE4Vz50Bnm2Zae
 J1NESj1NfrGTCJ2iNPAYT1bZIjdb4uPYNXKe8Rj5NHZ57Fam2u2d8XDYsYuFMoSm5nyW686zw
 DeJhiJ4KLfPeGREtHYozFovZ0GPEjgkWSK39y/KDsA==
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

