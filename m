Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4175D5E686C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiIVQaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiIVQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:30:12 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515D23DF3C;
        Thu, 22 Sep 2022 09:30:03 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N6tSF-1pLISL0qD9-018HVp;
 Thu, 22 Sep 2022 18:29:38 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/8] arm64: dts: verdin-imx8mp: fix ctrl_sleep_moci
Date:   Thu, 22 Sep 2022 18:29:18 +0200
Message-Id: <20220922162925.2368577-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220922162925.2368577-1-marcel@ziswiler.com>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rCx/OIPa6XgOO7VW/1IdwU6W5BGuuyzdlYGSVYza4FCLLrCljmS
 anONKl0ZX5mJEcj0OR4gFkVDMK74OhcSjRsDfqUazp+unmfPGrNMcyJFGy4aDZiEohTpjM2
 siAyxNIAw51bL1Fb2s9fjpLRs6aGqzdXfZMxtp341v11jjnnOUuke6uO7gJT0yQVeldKL5B
 mnlYZjg5I7E0AkvXpoaRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fkA2NXvifQs=:GoxWYMVAdSujuFkmDkJwps
 HmXKyD7Z9SQsf9fjfJ9kSqf8pWALzC9XcSVMb/5KL/Uojy3tTKyt49ktmNGx6Q7agTuTjA+xS
 r3rbqdUMspTJMfJ9iNm+MccL61Xk+M2lbBUzw+4U8uY8Be7KLjeXUMfxulhY4DkfJ7+jCYU32
 RuNAGeygUKVswwslMgrkFfR421yeOCREGyoSevTXOHbnoEkFpPNpEEoJTrZAIjNwmBNcUEm1L
 ZNNA5mOL9zHe+T7ythVGj0RcKPuTRDIJzyatgQwc6Vk4musIADnG7V5n9cIme/Z06H9qLD8jn
 oHIFGOrjoDAcJycYwanENF77p81AH+aMPDGYIoYy1gTPTuQ/nzferfRdmoUYTiIcwn0jKRQss
 fI+Lc6CFwbLmAD4QWMQgMziDsZ4RuOoQNLNo4M5IVJ9aDDY8aSTC4oqoprOxxbhs3yiXTWPFa
 BpZs+upAfp08kEXplkkdN2YBoib3Bz6YwWD/bnrQSB6sXBhGvtfQNF22t0pCl1bvwbL6rOE6G
 cJMXHQudsB796RgW0/FnB2GGbTjrWgHyHdYhSGSk26Q/IyIxnMLycoYWHmZM7EWFWSoUWu+Fc
 MbRE9T7OomcB/T4lhsVc3/RPm2He1aqic/e2WBBZ1bxfp+SY9O0pPCX1bPo+UtCp0Kaefd3+f
 RVg72ax1ea2yLMabBnDjZtXAIZC3Xr8dA13wPB/VVBq0QLrISPagmk5GQzXeAov0bcTOGtcMH
 5MlAJCDpC/K6uZU7HTbP4dsJ+XReQnJxX8DfTLXzoLjorZ9qOUwY2V3WRj0xTkm0Vhkhheq0Y
 DClhvB9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

The GPIO signaling ctrl_sleep_moci is currently handled as a gpio hog.
But the gpio-hog node is made a child of the wrong gpio controller.
Move it to the node representing gpio4 so that it actually works.

Without this carrier board components jumpered to use the signal are
unconditionally switched off.

Fixes: 1d8df9c74bff ("arm64: dts: freescale: add initial support for verdin imx8m plus")
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index 1c74c6a19449..360be51a3527 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -339,16 +339,6 @@ &gpio2 {
 			  "SODIMM_82",
 			  "SODIMM_70",
 			  "SODIMM_72";
-
-	ctrl-sleep-moci-hog {
-		gpio-hog;
-		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
-		gpios = <29 GPIO_ACTIVE_HIGH>;
-		line-name = "CTRL_SLEEP_MOCI#";
-		output-high;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
-	};
 };
 
 &gpio3 {
@@ -417,6 +407,16 @@ &gpio4 {
 			  "SODIMM_256",
 			  "SODIMM_48",
 			  "SODIMM_44";
+
+	ctrl-sleep-moci-hog {
+		gpio-hog;
+		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
+		gpios = <29 GPIO_ACTIVE_HIGH>;
+		line-name = "CTRL_SLEEP_MOCI#";
+		output-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
+	};
 };
 
 /* On-module I2C */
-- 
2.36.1

