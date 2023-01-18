Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4667159D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjARHyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjARHx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:28 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7315232E44;
        Tue, 17 Jan 2023 23:27:37 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MStu7-1p7y5x1Fg5-00Rrds; Wed, 18 Jan 2023 08:27:24 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH v4 03/17] arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz
Date:   Wed, 18 Jan 2023 08:26:41 +0100
Message-Id: <20230118072656.18845-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IhUQEeVbH/l4gFaRA/n2cPwKfb4490yN08djRG9UjAk+8/sLvCU
 t41LOzLB60HPHVIEZHnwCDFN2El/0qaGjXTLrKfsm2+7+bN5T66zbRZYLxzr0BpWOZ9nPYp
 2bEdR49dU1qXMHIR6XWqo1F+AnsOSjsamjHgsPWWC9QkavkUHiE2n+aCHWm6krutzK4Elu1
 8WK7AbiRl7t4CS3BbNedQ==
UI-OutboundReport: notjunk:1;M01:P0:Sb/rNCGwTWo=;aJaJwQcfAM2m1NwfhQNES01yagz
 O9Ve8jMQ456X4OQkkC1Q+fSwZJO4ZwOm+yAmnCEnpJfTR1kmOYqkjw3Mtp/0QA3U7rw9B2XtP
 Z0mzoNmqZ2CyLvgRRi6p/sRTRomdDPT8DhmXHALow/5IPqXzyKdGMNwI29u3Dc+ewGln9tB1G
 fJ44ldCUDvgyjL0z5eTF/6uUmYs2rw3/YdYwq2VsUc4ECQkfzDPua8CV9jZG4FLAbOwFuKymL
 ldOcf46zNigJMuVHKAiC+wDwF6FEVNU0TpIttc4UUfpbTtArCfpqPse2mq2+ka9FgmhEWd2Hm
 DlLKhQcWUiUeRFQMI0FqO1I+xRbPrKwxWWLyKN/9cBwVXyNratqkKYOWgjiWN1IrN/xWLiVax
 j9BkMrWMcBw5HJEv5MWQOjegVBSuPVuAQnIGdtFZGSIk6d9KVoLW/JptW75VckYsWVZoe/w+v
 L0LmWKqoDDLYmQk4tLJXRL1x/zL2q+W28fKG+dAK1COleqLF6efRtLBnk/7KDn6hWyCoA/lw9
 Jsp0gwK2h3ZBDCAel+mpJyfs1vryy6cQbBZPYwHQJ42i0bn+eWWRdS648RTH6ZWCh9MLNHwWl
 bsTlIiFrGeizTAc62ffr1Rjyt2Rx535FZ8XBnSG/UcwHOrPtCPBoPtJx1rsqSFaR55NcKqWGn
 NWVGVX6NqneYgni0/rnBckeRyI99mmXfYCmAJwQFoQ==
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
2.35.1

