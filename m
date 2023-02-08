Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B6068E8AD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjBHHDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjBHHCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:02:34 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A5457DC;
        Tue,  7 Feb 2023 23:00:46 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.227.109]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MxVGn-1ofG2r0JVB-00xvE0; Wed, 08 Feb 2023 08:00:00 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: imx8mp-verdin-yavia: trivial minor updates
Date:   Wed,  8 Feb 2023 07:59:47 +0100
Message-Id: <20230208065947.24195-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230208065947.24195-1-marcel@ziswiler.com>
References: <20230208065947.24195-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cTJ6kJnf8XRJsOhc1jXKDGl7QFr8mISdwaay4+fQqDXl/YtriX+
 gFMH4hQyw/FpfgpVwML6D4XPqtG1UD4rjymQ1wrqAMKinMhfuqwGtUBJid0L9nCUE46o6ps
 2rYFVctLK7E2bwwsfoYXSaSHrioJNM16Xyf1A4r5MdgSMJbpGddGj2UQG9ImMOGubz1Nfx6
 5Y7KCGfDMLQT+FJxMmKoA==
UI-OutboundReport: notjunk:1;M01:P0:YI1IeALrQZM=;qnQeqodD42/1s4fPIHO97+LV7Dc
 qlhpKMcp86+JJwHWnZa+bUbyX4RQEOmfIRQnTsmH6YmIUMLCTygu/hc9a7ju8pMgoQ8bl7RkX
 JvkaKTXuSSADU4lV23TkDy64N/sGMey1H7ZsLJVsLwG2hlJN8YHKUAM1lruzbax8110BWaRpB
 lEmko4eGXn+SmO/+Y1ez6kmXWjCw7VZg7nNoWJ+bKfTaLMY5MQmracdEqHKuHLo4WjGKgLXVd
 mlZ3cCLC6s3yFv48109/ZshUnoAiJD4tXVNFDSBW8iSY/4GVAa2GfXqdq5ac/i50N27gwaDff
 bwWTPixQhdQCqqMy0ku2pIBzwdBl5eGZm5r0m9H7uU3bQkswQSIu26WLyHRQOtXNlNJd/0Lkz
 IoPmCMxmT6EZN5/Fnzti0IzNW/9svBf/o03BFftT1woe/kbr9jlo96UXmrZfY1aJCMrrbKmNf
 ytgcAejLY0hAXA/TXf88g+/VeBa26Q5P8xkR/q+tv52rHs2zqVNz574yxpJ69n7X/cXH3be5+
 T1mWA3BFkkASwcqOGSEn/3jClYZGF+a7Z1R6nRj4/nxBfnu9CXMx+W3soxd5izIWK66zmQpK4
 ZTEgkJQaiWT7uOtYWHwwlnkwDujlztz13bSQcCKRZOXiZK8cHPn1iZ1qz0M5UMOxLZyfXpr4Q
 pQFpzXQqocnle7J0W96RqD1wUm+i+kOb15TVi1JWPA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Capitalise Yavia in comment and add missing whitespace.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New commit with trivial minor updates.

 arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
index bd7b31cc3760..de5489c2b3e8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
@@ -87,7 +87,7 @@ &eeprom_display_adapter {
 	status = "okay";
 };
 
-/* EEPROM on Verdin yavia board */
+/* EEPROM on Verdin Yavia board */
 &eeprom_carrier_board {
 	status = "okay";
 };
@@ -122,7 +122,7 @@ &pcie {
 	status = "okay";
 };
 
-&pcie_phy{
+&pcie_phy {
 	status = "okay";
 };
 
-- 
2.36.1

