Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CF06715B1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjARH6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjARHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:32 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C439BB4;
        Tue, 17 Jan 2023 23:28:28 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0Lh8XB-1otzex3rKZ-00oSyE; Wed, 18 Jan 2023 08:28:17 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v4 16/17] arm64: dts: freescale: apalis-imx8: fix reserved-memory node names
Date:   Wed, 18 Jan 2023 08:26:54 +0100
Message-Id: <20230118072656.18845-17-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HmKRXVYH4yGPrupSIwZB9fowjSMc6Boy1FuMZBIZ7AjIstGAxks
 eznLkN13AxAMFDD2EFsIHMJdkphXtpE9jeuLLk+CaZa/2XYa18A8SSpnHd9vEEklBrkLX05
 VKvZV0BpR+a8ucqA1CGorJaI6I64BVGVEJJHsrR3d6/s+6wFDe4J5ckhYFxrUWxcJwiSrAw
 Q4AKn5XWxPK0gpoESgDdQ==
UI-OutboundReport: notjunk:1;M01:P0:7G61kjY2w4g=;1SE0RQfTPa/5VNK7/96ZQ35HFG4
 DXFMcncfjNcS+yrlWJgA/Y0OZmtW6gZkG/CZriCBbpZa8Gz/2RdWVVz2XgpqZvmJ20DTPeE8c
 3Kt4D1/gD1k8VRhDNam2m9k4MF+ftfq1tYjExTXLt54OoQAlDJqk5olAm/kdbaljWVWWA9i0f
 ee9QZXDjk4BVpDdo8C5nxJDKINIh3M9j6WR3dj4LUU1WwebkKFNnCVN8ZHQeA/Q/MBbd2z4Ox
 irlvswyv6pUad5hOCJjJSJeSLphKLQaOkumzcF9pzBFdLNDg30k7XtCha1uYlzLCIZkOVhmb2
 u10Db+DkMREOS6m8MaJgYcSUihr9FUhdueDKoiwPe6xcrwcSLKI0lzx5sVvyHK9021fYGTjGx
 xiYWVxQFIime+bGPnzRvELv8ISu/YfaUtzOyduiwqOrbGFtOtW2tuDFyx0JZwjOzCpkCidEsx
 P1ZL7fQN3ygi1rqdqWK6nfmqEgigvhkSXd5w0IOpP3FRHHpH966kOwjpJGnS1fz1nI51Kp7ns
 WZKZ/1gYAOcCOQ8wh+fkEVD/t2dWTDiX5PZ3AYkQtpAFRtSzMPreqWs1OlEp4FnHhKS4/Lcmu
 nc/MffddGSoQ6vAWAvUGGv32pdLW8YgrERKfJUTdc8kRWUTmPzexMZmexAqR1wiF5o1AQTsAg
 +DB22aiz5NOv/OfsCo2OjBkbYUCve78kxOPYEx7IrA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix reserved-memory node names using dashes rather than underscores.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- New patch fixing reserved-memory node names.

 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 70c00b92cb05..6217e0a48f96 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -133,17 +133,17 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		decoder_boot: decoder_boot@84000000 {
+		decoder_boot: decoder-boot@84000000 {
 			no-map;
 			reg = <0 0x84000000 0 0x2000000>;
 		};
 
-		encoder1_boot: encoder1_boot@86000000 {
+		encoder1_boot: encoder1-boot@86000000 {
 			no-map;
 			reg = <0 0x86000000 0 0x200000>;
 		};
 
-		encoder2_boot: encoder2_boot@86200000 {
+		encoder2_boot: encoder2-boot@86200000 {
 			no-map;
 			reg = <0 0x86200000 0 0x200000>;
 		};
@@ -170,7 +170,7 @@ vdevbuffer: vdevbuffer@90400000 {
 			no-map;
 		};
 
-		decoder_rpc: decoder_rpc@92000000 {
+		decoder_rpc: decoder-rpc@92000000 {
 			no-map;
 			reg = <0 0x92000000 0 0x200000>;
 		};
@@ -180,12 +180,12 @@ dsp_reserved: dsp@92400000 {
 			reg = <0 0x92400000 0 0x2000000>;
 		};
 
-		encoder1_rpc: encoder1_rpc@94400000 {
+		encoder1_rpc: encoder1-rpc@94400000 {
 			no-map;
 			reg = <0 0x94400000 0 0x700000>;
 		};
 
-		encoder2_rpc: encoder2_rpc@94b00000 {
+		encoder2_rpc: encoder2-rpc@94b00000 {
 			no-map;
 			reg = <0 0x94b00000 0 0x700000>;
 		};
-- 
2.35.1

