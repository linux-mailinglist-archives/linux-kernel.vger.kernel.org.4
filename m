Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B668D68E89D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBHG6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjBHG6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:58:24 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F644588E;
        Tue,  7 Feb 2023 22:57:38 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.227.109]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M2bYp-1oZk1s1A2f-00sRaO; Wed, 08 Feb 2023 07:57:21 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v7 07/10] arm64: dts: imx8qm: add vpu decoder and encoder
Date:   Wed,  8 Feb 2023 07:56:38 +0100
Message-Id: <20230208065641.23544-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230208065641.23544-1-marcel@ziswiler.com>
References: <20230208065641.23544-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JzwJJ/Mr/emDRhGoG4LswUkHiG5In4mI5XG/eWcUTzI6SSW+H2l
 6TZTnVtQXl3SwN4ZKxW6e1SgqibZ+v3KoBCQZfDGmxeNKjtXj6il/KYxsZp5VqlPQU6qTE7
 dmpZ1gmYLLgXLnnCLyNIPkjxn25JfOQdSCU7ihHKK7N0nFqW3iw+dhNeBFtjscS634kbyEp
 1O9gnhEP3iiCtIG3Ykgkg==
UI-OutboundReport: notjunk:1;M01:P0:Qrf6HGw3b2s=;/UBTRRkJ+2CGq+fRH3RRYPdlW0s
 RwuWAFQIRHu1htkUIQbLwuC9B7+bBkHMijBtRspbZzGSaQyaXxVT4oUa4q1pbLzq7XYkUyh51
 /RWp8vKOSuIPd1t/MJSBwBlxievfmJAlgnZ4rXptVscW+DPyatqYzBy1Exp4SJOhUK/Anx7oK
 JpTHvViw0MOou3tj4fOA9jALqhit/pXF5qmr2bMOendrLNPjq0rTKPX0V9A+C0678sonFNLbI
 rpc2WS1qLn7ZPCsoTmoJUFYgdcLiVOiC3HdqFZRUKpQdHFujG2uUQsbgnQo1CwydtjvzPpXrW
 d6MXQ9RUYCHvMeHV1LwS6ofKdcZL/A0OX+blRVH0mLksE3q3l881B1FE39c/Kw/kOsaVHOJZO
 99iO6D0a7k/lR44n+nI/7NjWlEsk+82gCpYJCJy0E1ttjEZPy8jVpQtLMx0dmfIyt5sAZjw9D
 OCHd+HKSB4GuSqr63ym+I6eFsEosltZpLrLnlMPrCystW7hckZKcGRXpr/qHevpWdsTo6BFv2
 eII2Y/+OWZD+xVvMIZa1ou4NBdFu7SzILrKHVsFUmzRWSsutOhW+bI5xuqEGsT4hoBiPpZ+a4
 dsChkXuWSpInJCkViVvrxFIV7hizkkR3XRINa9/m+Qf7/MNWtq3rJnBsIJGx1PKkIWNcHvoMg
 a8jMLBORLh7mnHyAW96qsM2CZN5W0Topn0tpajoamw==
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

