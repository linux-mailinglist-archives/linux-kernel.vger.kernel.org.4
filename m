Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93357688301
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjBBPro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjBBPrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:47:37 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAED7D92;
        Thu,  2 Feb 2023 07:47:16 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.17]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LsjTb-1ocy6N1e5R-012IwY;
 Thu, 02 Feb 2023 16:32:51 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-imx@nxp.com,
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
Subject: [PATCH v6 03/10] arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz
Date:   Thu,  2 Feb 2023 16:32:13 +0100
Message-Id: <20230202153221.197308-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230202153221.197308-1-marcel@ziswiler.com>
References: <20230202153221.197308-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UEju7fpsrTFCYj/8VIuncvaN6WJgPchFyUe0AeEBoPpES/rU9NN
 2mLB+TSqZ7Q/sytfmGqB2oaZlDVE0Afwhb2GEYKCZfwhUZCPdsa8yoPP8fTtZ02L/9Vpqd6
 Sl6hv9RWuERo9jpLFPuPKmmwmwhWU8JkFzmGLhR3ljj2I8YWq5ldGi4FC3ATd/vfZVy+mcf
 LJyse0Qaow0UjbX7gbW3w==
UI-OutboundReport: notjunk:1;M01:P0:J60Ozqt3xtU=;Ko2EJeFAQ/jFqxkl88lDVbzuHRm
 n9x3y/oHvaHF70L8waypqWcXnskgdVg0pH9hscBxiHlQCQEIWwalcy8a9+wET+vExSFwATiJb
 zK4DP+oey0xUGLYPBY7lfIBPyIwiVfQTdpEjizDeGlaDYC3Rx8iwTHaGf6vSrAt/VVjQKRxbG
 hIxyNoY3xDRrCvSw8ycdCo9OIakNWxjECWKLbA6Yn1ainQupf4PpQ6ed8Vth2ZXiYjmoQ3LqK
 hIMvANkTcEvfI6QaV8c6dw29SDdQk6hNWFcv3D/78zl9qd6Ps9zLGgcw9wRoLy9dWKDQLopqA
 5QpAXDbb3/ZB4UWQfiQNCb50g9qzc+yUra+lBYbrMm/ThQAlHimDraFK4dsGJKg0EfeAhj1DU
 XHhGAhblFRcK/q0lrbQRXQnJgPxdP74aFSDyDWCxFCj+C2HclKMhFNo+zQALrRZOGrRAUtadm
 73XX569YPh4OU4DWhLh9UA1W8H9EEdUtMmowX/K+GVPPtbN047f8cBqbfXbYOdk19RVK34jPv
 cy1Gx8ePymD148QCWyXvyWZ47QWwu75IbH7gXYcpCjc9lGrshyjkeGw9BmLuK7eSr386XjB5T
 jFgv3JuaYCLzg2hLQwrIZIoTzbAKAghX+q9iqi6pAUekPdEw3DPg7+B1E9CaTPAJR/i/cwFNY
 zxbXGpqxNrgig86BU8GNX2kmWXRp7ZichZsRWxinZw==
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
2.36.1

