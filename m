Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BFB67C96F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbjAZLJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjAZLJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:09:18 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0188A3E0B3;
        Thu, 26 Jan 2023 03:09:17 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MFeL5-1pQmtd2P3d-00EaUN;
 Thu, 26 Jan 2023 12:09:01 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
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
Subject: [PATCH v5 03/10] arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz
Date:   Thu, 26 Jan 2023 12:08:26 +0100
Message-Id: <20230126110833.264439-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230126110833.264439-1-marcel@ziswiler.com>
References: <20230126110833.264439-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0O3VhJaVSyePoUn++IB+PUrEGOME32qE1zW8dF35vxQB2oQjevU
 4bPjXIQmXZ7ZXlHoLc0K0X3U989xOBW/BMX7w10wC0YoRmgDeHtNEWuvlHnDyI36KNE34c6
 y/NeG+QrZEoWiH4yJhbCsddVL9T1PpA8EilsT9lPcJVuBltrgM0Xlojvr3g+HPqAQF2nuL3
 lKjcIDHSTUZ5fk7gmwNNg==
UI-OutboundReport: notjunk:1;M01:P0:WhX3ROttg8g=;6uTJvxvxhcKB9CmWnyqeg+NvhsC
 6ughWjSifWQfQDnLiWFMH1I+oa7rJFL57l2diPWI5WQfohzaw7Rud08cPYFhUNVJjSowhT41D
 3flayc3M/7R+DvR9//ee5dUIz2jINqyvkn+0dXaBn1HTVeOH5CFItyzQuB8e+2Xk13XoJheoY
 SzJ5zDsuwmv1SVAfAQ//2O/7zL19+bUVQmCWmsSpIwrEi5FgxY6h5pPn/4eXorvnKSEk6Wt63
 tJtQXm80koo+r9heLyeNj+/+nt3uJS/4Qvn2c860i+D4YvEDqpW9q9gW5Z8bLgegeHVEVRO5t
 lk2aXG+TsoyHEehfo3ZcunuegWsRhHtduCqE3CH/ldixg6q0pL64rPR7H48hb/zvRfJo7swBH
 TSXzeibj66+jOKNraAX5ZvQbYBmh6ecym4wzmz+cAHP/LlrcN9yLEbPSrT59PIbbs5lxsP/wj
 G4usbTcP6AOFTvt/mj/mwmjqgmJDQxhICj4YvkOS0KzaWmv7j1w+EYk+I7Y2frxsodOQiB44H
 VPJoOelcH3kC/1aNJlOQaRka03ZOP39fz4+MhLYtxAwOh3Dcp749OiiypTEap8+KRfHLKs3d5
 dtSnbq8z7Dq5onv7nSfqxv27w8DzVF/U9NdzKRvEuVVDs9/xcUXQbVkAbOH3UfX6dnEIpDtZP
 BmylxwO7zVPRNLMqFiGgApVmInPhKaxMfEquJqQtzQ==
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

