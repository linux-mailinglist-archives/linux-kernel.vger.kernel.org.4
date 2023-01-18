Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A186715B8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjARH67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjARHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:30 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBFC3668E;
        Tue, 17 Jan 2023 23:28:05 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LtZ1G-1oYuRy1LIy-010vHJ; Wed, 18 Jan 2023 08:27:46 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Zhou Peng <eagle.zhou@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v4 08/17] arm64: dts: imx8qm: add vpu decoder and encoder
Date:   Wed, 18 Jan 2023 08:26:46 +0100
Message-Id: <20230118072656.18845-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TZM+4zGIh7rnmkNFmsDtvhwdDJJCHWUr9xyBsWyt4tkZc3vmLs9
 L1vVWDUYZQTYqi2ld+R43gGX1sxdlBqVxyIV7WjDWDBukqLwe4o68IGIazermtbijDIJCvx
 X70gl9ZQPbY7ma6zUad+I4l/SLRk9mnuXjrO5UX4QOsTNsMMERpErID/X10XGkz8eLVta7J
 MTMZmiKQW5Y8D+LDXg7zQ==
UI-OutboundReport: notjunk:1;M01:P0:w4VYmIof1Bo=;rJevEcB2O+hvL1BvjUWUQz1vbEI
 fZvw4UOG4qXMLTYLm3XuafaD0lp0Fi1qgImvnPS8DBOfyUNxkiXzua8f35fpH16m482x25/o4
 HAuU13clXKbOttMI/uSPHnzHZD0bz6UbBKXkv7EF+Ro1+6YJl9uHJwV+7tDmJU6qidCUf38xr
 nfQXOvzsMjMDPL0j0tIPQWjzsShhgzTLPrXvU978OK7p7xM+WDeD6FJ5QcZ2h816BaSUzdOt9
 4+JYBx31eppbvH22wmEYjO5eEZiqYX8eqNzJVorGsfgwDrtXWKdEmn55EswjgGLv5zWPaTzs+
 rrRjh7AVuVFAQR9PPKM4DLxchUVojcRpO7BZc0XJOh4MQobe9CxrSud2sw9vQmT6q5hDbHlCU
 paUwMFrsvOdFAh3jsFBT+Fy9lTfoJqk5Kl+ZPPDm2EDj0oR6Fp4Zuojygr/fRKNRCBmKn6AGS
 mB0Bdf8S6MsbTuWkSXupc6UgwzutgNWzURWkjBU2ftsujoPSUdPJJz19WJvqmU4ZLmKqpp+IJ
 eh/LdWJwIEZDYCSu9tEk95WcF0SVjkmu5iEDdecDhnldJh4AGHQ6l1tDun853dNJCuU0/HU1E
 UttY3Va6P4O6n8B/KtHM3VnxQ2pj1PABApkdceV8+DvSvlc26aDrSr1s3U3GJS+iTPLm7zIur
 5BNP4NgKRnraK+8xENNzNafgDO0i3twRHG82PK/8sg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v4:
- New patch combining the following downstream patches:
  commit 4f2147ce6f0e ("arm64: dts: imx8qm: add vpu decoder and encoder")
  commit 0c9f9b64d27d ("LF-6575: imx8q: vpu: switch to amphion upstream driver")

 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 422edd2f20fa..cd3da6de6a1f 100644
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
2.35.1

