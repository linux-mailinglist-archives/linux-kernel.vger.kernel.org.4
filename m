Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8803369DBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjBUILz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjBUILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:11:53 -0500
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Feb 2023 00:11:51 PST
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5F61E5F5;
        Tue, 21 Feb 2023 00:11:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 774F1EC2E4;
        Tue, 21 Feb 2023 00:05:25 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q0nct-RgHC_R; Tue, 21 Feb 2023 00:05:24 -0800 (PST)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1676966724; bh=Se6F2YYJAtfbSGMooDyWStbwzcGMZ2eMxI1WSnKB1CA=;
        h=From:Date:Subject:To:Cc:From;
        b=kvRhYjRHtGOak/iUWEzUAkJFm3o1zeiiDzpIqcUJkHOsvGvELWxqC7N1mUhcfkgcV
         yHnVd0KWfHKkrsZtkipyrnd6QCPaDqQWVPnDh/ucXrsDjlFCLX9rYq+4aYOR65ecSM
         vPnsvRMWtW14DZifSMYJGWddPPDntgdjlAqs+U64b5sawIsyZRVH4rsCj4Pt9ghmIp
         6x7/9syDHQd+TzOPgaKVS3Jx+sN+lFpSOSu1Qh9Un2gYSZWpgPxmooVBxIYV2f+Td5
         fx/jI2w6MpuNSA95S39sLItFPG88GAXQEM5/fMnMzJW++iOxsyLjNrARmH7hqK36bA
         1BfYgS/n7g/BA==
Date:   Tue, 21 Feb 2023 09:04:08 +0100
Subject: [PATCH] arm64: dts: imx8mq: Add UART DMA support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-uart-dma-v1-1-d20483bbd49d@puri.sm>
X-B4-Tracking: v=1; b=H4sIAPd69GMC/x2MQQqDQAxFryJZN6DTOq29iriIM1EDOi0ZLQXx7
 gaX7/P+2yGzCmd4Fzso/yTLJxlUtwLCRGlklGgMrnT30rkKN9IV40IYh9fD+zp4ap5gek+ZsVd
 KYbJD2ubZxq/yIP+r33bHcQIRojjebwAAAA==
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804;
 i=sebastian.krzyszkowiak@puri.sm; h=from:subject:message-id;
 bh=Se6F2YYJAtfbSGMooDyWStbwzcGMZ2eMxI1WSnKB1CA=;
 b=owEBbQKS/ZANAwAIAejyNc8728P/AcsmYgBj9HtAbFL8kqhRhjJB746FxPa/Rj8cmeBTkcxvv
 054XRHXIy6JAjMEAAEIAB0WIQQi3Z+uAGoRQ1g2YXzo8jXPO9vD/wUCY/R7QAAKCRDo8jXPO9vD
 //rcD/9IsO3DwKBbrUAyfUH0VdPnDH3WcLPz+zCIL0FX3NkHkFyBcGAzijfBe+f75mVUFcjQzhp
 bDFUUJUNLIdX/rZsXFD0D1j8tzdoNp+qVPCaaT+6/i8vHkEu+z6i32EoC0v1lxB4K/B1V0QOuhe
 Z4euA1z1wvyYPYeilublNcjxNbOTHPv4J8ioh81KJ/yuhZ5hl8zGe18G9hFMAiSworsuqqb7laW
 HPoxi3VAm3qrBYY6qlIcIpyP9CiyhVG60Np1/DA2DzWJA/qmPLxxYZc6z3KBkV0CcJk9mtriXm5
 aciCAgo0Rwkut+Z9Gu92sxlxXr2zAR3You59Illc9zfZANbHVzCEGS1LCeMQvepopgGvMRdLCvk
 Fb9z8H1eVAuadEVclmFLtvsRkD+zHMEFbIQEHVjzAy7wKwf+Any2nvWx+J4DOeXfnMuR9hpyEZf
 3NUT53OLGwbYdBYIMhBIzEmTGYuxEoD8gBAI2XavOJBShuDrH7OiVMgE30q282deule0dxIjceX
 JDd8ByKjA/g3NxXACUP2zo6yunOiqjqspIUKlSphc5wOUtMJ5dYcJJ/JHVsJTivV2DZDVfIYJuQ
 jaCQ3gx/NavlWHfCCqmK77GPtO3wmNlDrIMDrkWKJq6JerSkCcMX6M59p3Afv6g2125nFjmlhC8
 yL4LojDT7lO52rQ==
X-Developer-Key: i=sebastian.krzyszkowiak@puri.sm; a=openpgp;
 fpr=22DD9FAE006A11435836617CE8F235CF3BDBC3FF
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART ports have DMA capability. Describe the UART DMA properties.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 98fbba4c99a9..142a5c894e1e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -940,6 +940,8 @@ uart1: serial@30860000 {
 				clocks = <&clk IMX8MQ_CLK_UART1_ROOT>,
 				         <&clk IMX8MQ_CLK_UART1_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -951,6 +953,8 @@ uart3: serial@30880000 {
 				clocks = <&clk IMX8MQ_CLK_UART3_ROOT>,
 				         <&clk IMX8MQ_CLK_UART3_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -962,6 +966,8 @@ uart2: serial@30890000 {
 				clocks = <&clk IMX8MQ_CLK_UART2_ROOT>,
 				         <&clk IMX8MQ_CLK_UART2_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -1157,6 +1163,8 @@ uart4: serial@30a60000 {
 				clocks = <&clk IMX8MQ_CLK_UART4_ROOT>,
 				         <&clk IMX8MQ_CLK_UART4_ROOT>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma1 28 4 0>, <&sdma1 29 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 

---
base-commit: 89f5349e0673322857bd432fa23113af56673739
change-id: 20230221-uart-dma-df84665c6a97

Best regards,
-- 
Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

