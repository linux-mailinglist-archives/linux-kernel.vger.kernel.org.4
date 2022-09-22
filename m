Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB155E686D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiIVQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiIVQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:30:12 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268FF2F3B1;
        Thu, 22 Sep 2022 09:30:02 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MgOMF-1pCOWK1SPf-00hzCb;
 Thu, 22 Sep 2022 18:29:47 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/8] arm64: dts: verdin-imx8mm: verdin-imx8mp: rename sn65dsi83 to sn65dsi84
Date:   Thu, 22 Sep 2022 18:29:21 +0200
Message-Id: <20220922162925.2368577-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220922162925.2368577-1-marcel@ziswiler.com>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ug2gCoJJM4DA8j2Oz1EgmVT9U9WFgmXm/T5pGPstsuZNBvOxy0e
 8r3WrOTlCtg/hVE6b+xoHpyt3Mqrdg33b7YBAiI98KaBvT86grP4SSpdlwrAa9tzTbIBasv
 g8afb03ldjwkN/BnbFS5zlNXUImf9i4Yvphetwx+sbTAY0VgkV8h5hHsZRHrPCzF0fEsnYw
 KJ+Zdm/sfMMo4hgVGv44g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vNIIiwwnaV4=:cIHMC5zbLAa5fDGJlBVCQw
 lWoBfJEXXWYUH237MOdYjYwc3idmYMlVgfupy3JrlSintffTRV5dHHollhRFBtfGU9F9772K5
 LsZ1IHNcEpFgU5nQtu9FLBFyRkoszC74NsU15LsaEp+B73ZVEdCE0PVBwTRXV2V7nWAaB88Ts
 dwicrFki7mwQ6pvXRCIIn3/z3ZNdiSVEA7XRD8fgOfMFRJ/qs0GpnFnZvA7zxa1AYBfx/stTj
 Ap1dqRuOOkaXsZei4hAgmxt0ep0YK/MGQfOA+P8fkubpCgqbYU4tefPn5TJMkt4LSvZbfrrFe
 pUdy2Li/H62GDhiBYDRIrA+U5jNs+C4zKU/NPjPBwEa4qNspFL44pXxegr6hrZIRVKLhR4IbB
 6khiBcD4RAnybgfwjvu4yqY+JZfudRuWZf46cStCkCywfSDiXFHv0tzzUsxb//Xz+Wn/DX13a
 TRRNr6ClZ503OiMpPIr0vC8Ifiua4dt5KUFRjc5PQHDCZVuciqgWEglvb6ZoNG2hJftRtfrgQ
 yaunt7ebXNGcBRlTdNtlnjj3PPSfsbXoP2fqHx/3j2/ZgWKtuu84xOiE6JW+PMj+kd5VhWoi9
 Sb7E2w+BSw2boe/m47rl0cKyqNXhV9qXTDY7YFS7QDUZJBvhMgzuOPAvS1q6mrWL9PHiKQU4g
 U5B22OxY8rKotbaT9uBbpfeRnifMS3hW62AM84rj5nKEwmJ+Vs8YYHuBJn3ld++VRY6XokzIg
 BM9shUkc/EWqbAMS7X7+/ze+zSxP8qpzz5sK5cJIcv2OCrlxaOfZvYe0nMmT7w4rLiY4soZf5
 xoWynf3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename sn65dsi83 to sn65dsi84 as that is the exact chip used on the
Verdin DSI to LVDS Adapter.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index a749d063c367..0c2582402087 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -595,7 +595,7 @@ atmel_mxt_ts: touch@4a {
 		compatible = "atmel,maxtouch";
 		/*
 		 * Verdin GPIO_9_DSI
-		 * (TOUCH_INT#, SODIMM 17, also routed to SN65DSI83 IRQ albeit currently unused)
+		 * (TOUCH_INT#, SODIMM 17, also routed to SN65DSI84 IRQ albeit currently unused)
 		 */
 		interrupt-parent = <&gpio3>;
 		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index ee4231d138fe..7be7e922927b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -664,8 +664,8 @@ gpio_expander_21: gpio-expander@21 {
 		status = "disabled";
 	};
 
-	lvds_ti_sn65dsi83: bridge@2c {
-		compatible = "ti,sn65dsi83";
+	lvds_ti_sn65dsi84: bridge@2c {
+		compatible = "ti,sn65dsi84";
 		/* Verdin GPIO_9_DSI (SN65DSI84 IRQ, SODIMM 17, unused) */
 		/* Verdin GPIO_10_DSI (SODIMM 21) */
 		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
@@ -698,7 +698,7 @@ atmel_mxt_ts: touch@4a {
 		compatible = "atmel,maxtouch";
 		/*
 		 * Verdin GPIO_9_DSI
-		 * (TOUCH_INT#, SODIMM 17, also routed to SN65DSI83 IRQ albeit currently unused)
+		 * (TOUCH_INT#, SODIMM 17, also routed to SN65DSI84 IRQ albeit currently unused)
 		 */
 		interrupt-parent = <&gpio4>;
 		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-- 
2.36.1

