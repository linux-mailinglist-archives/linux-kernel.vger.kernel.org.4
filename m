Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9767C978
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjAZLKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbjAZLJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:09:46 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFE062278;
        Thu, 26 Jan 2023 03:09:32 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MhSU8-1oyMdV2F0c-00Mf4m;
 Thu, 26 Jan 2023 12:09:16 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v5 07/10] arm64: dts: imx8qm: add vpu decoder and encoder
Date:   Thu, 26 Jan 2023 12:08:30 +0100
Message-Id: <20230126110833.264439-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230126110833.264439-1-marcel@ziswiler.com>
References: <20230126110833.264439-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HEn1QHC1PewP+ScZapGw/H0xIYiwFoIoJyuGFSZ5ayX/ulNeo9e
 V2m6P6/4M2iNvM1B5FYUUU2/iEPW5mZKWzMUelhyjekEh5EkvZuLvoXYPKdhb/X+jHk9MXQ
 pJlMwalps56ZDUXezDN/a531Isq7rNjx0fRMS3Y5IL8MvFxr5YhjSDd1Ss7v53droKfsEaI
 BA83yqfEpgbYoVuHtgA/A==
UI-OutboundReport: notjunk:1;M01:P0:Ca88Re7TIbw=;hJa4g8nlPecz7STyk8qEzHBRfGQ
 pn63Si+nDDkHQ3jkJOsHFiPSIg7HmN/zXsrfgBUqBFfW6BUVBy8G8EJs3vRM+YEeNpKdwDDm2
 ntak7TIIS0jN7pm9z02RtGy9tOzHbegHcN4HpTouloqgv2pYw/5b4rdIIsLxMwhFwOYzgmNvo
 vVaXbAlufiFq1YDdzFvHYbIAN8YDZY4UPhQi/9JiuFafI1sKbKnoN8puJDR/wLfrpANDJsj+T
 pPt7sbYNlTAUD+mgsCaxmj/Iz+UdLxMG7KwRcFb47+mKaLoMzzhJvKlOObgBLxKRrBX1Kp+WI
 DG0u1Ry/9ZpCjL+57NYQgawyG6Mtb2npSqiQvddiefuE0dhG92UMfbd4wNBk9CfBmJPfGzNPE
 rWWzWGQEGHMpk9mkZPF/FUS/cPHT5bupMp+QLJGWo5rzLPOyX7Z2L4tcoi9LTW7c2tVdQSqCW
 yFDAnN1rowvjUVa4GlsQFnMQ+Zf2y+jJJG0c1JH1ypf1TZKPdo+UlnbxZ0MgnGKIpfp/xmuBg
 QTqyONndV5NBZSoeLIZbEAHlr3Q6vX3ewHwBPTYVinQRm7vB6WFZmcgn8S169hGgCyJ4y3Bpl
 SibxnNJKuzNvz7SSgwwZH/6XdoRMCUMNzfEikqvDNHJXqnZFypYgowpX4gVcPEuyXSCa96vfk
 Jt5le+k4yfwaH4I5mViovzsJ0FZuUxd/06lYYYETgQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhou Peng <eagle.zhou@nxp.com>

Enable VPU decoder and encoder functionality.

Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

(no changes since v4)

Changes in v4:
- New patch combining the following downstream patches:
  commit 4f2147ce6f0e ("arm64: dts: imx8qm: add vpu decoder and encoder")
  commit 0c9f9b64d27d ("LF-6575: imx8q: vpu: switch to amphion upstream driver")

 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 41ce8336f29e..9fff867709f0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -23,6 +23,9 @@ aliases {
 		serial1 = &lpuart1;
 		serial2 = &lpuart2;
 		serial3 = &lpuart3;
+		vpu_core0 = &vpu_core0;
+		vpu_core1 = &vpu_core1;
+		vpu_core2 = &vpu_core2;
 	};
 
 	cpus {
@@ -212,6 +215,7 @@ rtc: rtc {
 	};
 
 	/* sorted in register address */
+	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
-- 
2.36.1

