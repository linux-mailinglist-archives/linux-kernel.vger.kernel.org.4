Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCC656067
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiLZG3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiLZG3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:29:06 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324922721;
        Sun, 25 Dec 2022 22:29:05 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.224.88]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M7ZR3-1oy3BU45KB-00xGnx;
 Mon, 26 Dec 2022 07:28:52 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
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
Subject: [PATCH v1 3/5] arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz
Date:   Mon, 26 Dec 2022 07:28:21 +0100
Message-Id: <20221226062824.53113-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221226062824.53113-1-marcel@ziswiler.com>
References: <20221226062824.53113-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mX+NwCoKzly8YDShwLrPiykPYlu1ZZ8hdnLoY/LvolpMjFIHtIA
 k59rkxzevjN27sip+hTpd9V1iFIcZvGom2VufJnykLEA2CQnF7ne91y0D+5RpHHfmIOWl50
 fNHz9NH789LQjrxF1puPLKcAfsaoyLioHgfDj4w/vsomOnJMLqzUJJdx/sStICIparoGxIe
 6bBSgzEdNkvhOH4HnRiaw==
UI-OutboundReport: notjunk:1;M01:P0:C5jOOl+uNDU=;DTdXVGdHU08tLOEy5cfZ2NL9II6
 xOeO5ARdr8iTCqMYzCgbI+AOtmZnxCmcsI00MgWNNV8Gvn0WvpgZqZ7VXm152t69fINsRob7I
 Zzwo8r1S2HJSItZgOqQgqH87TCsls1+WEt6fNj2buu4lDEHUqo65YRNHus6/rqYjHyssOE9zj
 A82d5bCvb8LC2scbiAqfBCIJa1fgeCcz8UXmfvVYvHqiU5MiVjq5Kbqze6fe0Ip4dRNoTL+mk
 7euAjGEWYdb67WZRu9Aa1Ufzq+eFWArExrSz8uOB4Pdsuf4Gyn4CdmIdXiuhbJYnOwT5qnoOr
 S3MaQAWybNRqhm3x6isKxZg8KFpeJNpeCerFYYVIJU5enDKMJ3ruTgglBQOVbFsxqo2TyOSvn
 BuaB5LJastXeDzpUd4llFgaHWBdleV0ViPkH2Eg4jVXGFYvj8jlQNIKTHuPDRNf8UYFgCXWYO
 kQMwh8TjzJbDy7TkNRxM88ZHZizgw6MxWeQfKR3cQ0kmkpQEhevOZu2/9sJ1bUBHqc8ID2FpT
 kdta4203X3fRAQLCxJT6NnH03hbxA4XGBmYgddK5Loy6IbJ4vnY1VDajrJImA6D2IRgfSQTlQ
 T83BeygP9/ESMs4UNOoWF6odFM3NCKN4sEwh8SulfosOGTZsVwyKredYlcbSF5KH3c+QPrqxL
 5mS241RbkL4aBGvI94ig5dT6FApHok9bCsLsvFmnAg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

60MHz is the maximum frequency mentioned in the datasheet for
master mode. Set that to 60MHz to match lpspi2.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 6e5ef8b69bf8..6ccf926b77a5 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -31,7 +31,7 @@ lpspi0: spi@5a000000 {
 			 <&spi0_lpcg 1>;
 		clock-names = "per", "ipg";
 		assigned-clocks = <&clk IMX_SC_R_SPI_0 IMX_SC_PM_CLK_PER>;
-		assigned-clock-rates = <20000000>;
+		assigned-clock-rates = <60000000>;
 		power-domains = <&pd IMX_SC_R_SPI_0>;
 		status = "disabled";
 	};
-- 
2.35.1

