Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B313765B5AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbjABRLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbjABRK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:10:58 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2101147;
        Mon,  2 Jan 2023 09:10:51 -0800 (PST)
Received: from toolbox.int.toradex.com ([104.59.205.51]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MdsFf-1pSgIX3UCL-00PZd1;
 Mon, 02 Jan 2023 18:10:32 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 3/5] arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz
Date:   Mon,  2 Jan 2023 18:10:20 +0100
Message-Id: <20230102171023.33853-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230102171023.33853-1-marcel@ziswiler.com>
References: <20230102171023.33853-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jpgyUorgs+0IidkM+eK6IH865pHwT9pfiQJkayIVCa5/d5Nhbeh
 RqTYjPVuj33YauccSM96zLCpOarNEqFpYGaaJzaAu9x+DxsPG+QyK9s++MgOyxaN7ok0Jac
 5DIcJ/VYfef08zEml457of5VRGYbfKUjLvHN4POvlAg5uv8I89oK9JbZ7BrFysgoDH7aAde
 wtR5VjVHxhocbelUfsv2Q==
UI-OutboundReport: notjunk:1;M01:P0:YH6chr/nMXM=;VuIeU5GGZbrUICdPF4S8C18uYLx
 wDeF6xSLVbnfhCFhD3lmNN3sbHwAIP3xsJudIYzo4/ekMbC3744KGND+TcwmvQwE0VrCIawBk
 WpaPDlPZBomzuHG0t1sEw5xiqpUBPj1yuTWFqM6OuDLr/FZEOmjnU3quxjQwQsCISvUuFNMb4
 yqecnvQo82CojX5Vol0Vbagn2dBmMr/noVAXxOBQF150gq73rsQrMMaBzFNcyLazD+X1tj1Fx
 8Auh9E+390gkOXZFcbMp5pN35hUY57yyPmoBuMxW6zmxURVD8xRIgKg4bZp9iOh73l/Ymb48K
 hfvJut16N8V83jvBX+ENmZllUmvE7WKc0WvxtiabjdFnj6japfXM6grHCJRLtKR6BEbBMbh5M
 NT/g2udtUJGmU8dhyGWWWLkHSKFxd5pkTPH+mhppKrPvdMOZ/IHK8M2lN9oL9tR/jABLsJL30
 X/gDZUesZS0MYfEuM4JmvU03GWqbkj7/k3otaSiBv5+apoKjHj9QgZE5zF4d2ujX1g0rsQXqD
 35Aca4Z3Mf4NxoFUERKPtVF8xOoYglGs5sWja6f6Mq9sQZaLvdGl+pwkmurLW1qFc/fyFL5zY
 SzI0npwbC3EXkHvWNnlC4lZqDS6bkau6z4kOYB344KeEl2ho+nIwlU82Tu3WY1KT+Ay4c1XpD
 ZCTeay/JH/hyiV2ZXdo5eXhZTNF6KxZjdzOb1FpToA==
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

