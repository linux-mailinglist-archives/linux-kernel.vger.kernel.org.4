Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5268E895
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjBHG53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBHG5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:57:20 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68069113D4;
        Tue,  7 Feb 2023 22:57:18 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.227.109]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LijEJ-1otcLy2abN-00cy4C; Wed, 08 Feb 2023 07:57:04 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v7 03/10] arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz
Date:   Wed,  8 Feb 2023 07:56:34 +0100
Message-Id: <20230208065641.23544-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230208065641.23544-1-marcel@ziswiler.com>
References: <20230208065641.23544-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xE8izTO0sxLPo5V9m6+AOLPY0T64Gw5oqyClAQIClR/9MSFaZuz
 xoICTvn/9tsBO6JlzDNcQq3FRo+kmgVnrCZR+vLuazlzVSBdCYPIJEC5fj65xEO9seL5fcd
 khFwBFQwMlWlfJ5zbyn3w09yayc41lcY2aPX6+CvX7drIQnTSTFYG9g69L2SwNXBoTuU0XT
 nAdEACrOmpMALWpSXjL1A==
UI-OutboundReport: notjunk:1;M01:P0:GGoPvCIvcq0=;RqZG8lhrrR/+CYpgiKTrLO5mBIZ
 KryUFaL3atY6BY3NxxDWZZg5ImbzJgBTcnv/dy6/Hh3PWgEmxjRgrKeody+4fNfPV3fiJLD9T
 9klh0r154Yk35FCuzNzanu1NExIoK69/0KEpKjkKRAF7nUpxSraRcrpJGPseRbP/4Lj4VzUgm
 1UC/nb0NKE7XtWGTLqM/VB8Rsy6JvLXoKPIWhgeo8Uv7BGopSyllHGFs8V/jBUa0xVh8CrtnD
 n0eoZ9xlzLEXa/g8WmiogQn66GcRYwGbOn7JO++kWSpxBDiprG0lMOxzdWT8/WrlSgVHaMslD
 suEvhOLX4QJzamLVVJFqrxD4tbLNlMTKsRv9W4HwsJn1F9LmFSTQ5beKnvVJ931lfAieDMbJ9
 Sr9gyekcI0jCj8liSnpHc0T71wk7NOZTrbUHosUYEF3RUFfeUEq1A14pcYQJp/lAU23PLH9e8
 5UsHJaSSPQnrm9xMIWf4P5GAUwboUSCMUkbhswK+9ej8J/VJy61CFar0jsthS7Cpr96QrMflh
 v53CWCnA2VpqZxt+vEWpqM1LmpvFPQf9RpdQ2Dx3N0icyWDEnwLSXYRW0ZKBpMHlNrzC0dTOL
 PpOWCPxoAl9ZKBtd7rb6UGOvNicHkVYsglZEASdtmHVXhR17dfD7c+R52fybTckAJGcNAqbLn
 TeKO6tU5p/T1z22g5e4GmPjTp5xwReooLUI3kvbeeQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

(no changes since v1)

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
2.36.1

