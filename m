Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F996659C4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjAKLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbjAKLGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:06:43 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA3B4AA;
        Wed, 11 Jan 2023 03:06:31 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N5mzf-1oiEWx2voB-017Cku;
 Wed, 11 Jan 2023 12:06:17 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH v3 3/6] arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz
Date:   Wed, 11 Jan 2023 12:05:54 +0100
Message-Id: <20230111110558.349460-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111110558.349460-1-marcel@ziswiler.com>
References: <20230111110558.349460-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qy/dsgsQSzn9SvqVS8CXMlAD0ZJTp4RURnFJn/cRfI0j7W/FMCu
 L0Uto/WDr2Hl6WuDAoUqLGKS5PvpgGCVtSsGBKIjIKkBMkfYc2BZQFYDgjn1B71hEpojSNp
 JgFWRp86T8RKL2hLEb7WSYScAXPnRjclwWGPyn/M9YwSLY6taBJJr9NlPV2kd06b5WwmVf5
 hokr8U1h38HBLRVH+I6nw==
UI-OutboundReport: notjunk:1;M01:P0:AlExgcL+EwE=;ArGEbgZTfW4lM7dgMiVdEYAcDcV
 oZXerDfYHxdwcezzQV62hENgoyb1zIderOdtyWrop5KjXzinebCt8g+U8gErwLLh6+sIH8bhq
 MFyK0cGlzuOkVI7e64pZbkbJmAlHOdFWDmi+wb9EWZGpcWins+ZKIOopucVBIlalU3g1GcKjS
 WnDpJD2K81lp+3lvE0H+7W4wZ2uV89oOO2rpFYdsMN1kEotR5uf0fG9Ykb0b9R7f84XJR8wIP
 +IO1/682V/reBt4Vpmay2AeMVMxDGFiXbTqKjPWKaXD4IiMU+69dYhkO1YYRu0DLJdvJ5jEs/
 ZwNW7nP18FKEjeiMOET0EjEpqx8hC/Wi959+XjQgFfBDt7seE0XGuHOxufRfVtZPrllWGpfzq
 4+WkJYF02Nzoxf3KHyfMaMWVBzXjaeQ7S3D2nUSLCYngA8Oecb6AnMSDggK2Cmj3AIynwA7Fm
 gXGQU5WGOyp10ApcCZsYmxLn/FGo+JEgLgL92FZKm7hCBHFQiCmifFhdpr5Z/LP0b5nRRJNhA
 PHs8vU47VF3SKBqfn2HCpprtZ7zn5cJ+sJm2nAYXHH7MST11Sd33tGexCMBwUM1wIwO26Sd2M
 pyAtjVerCPy92aUUbDSKA4GARNeTO/CZM7hCoj4cjjalUHaeQk0BaHPqtN29DckazdeworO9i
 Y0CU6nenqz7FJGCMxKqnhsVs48nMzwx98owyJ7J7Ag==
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

