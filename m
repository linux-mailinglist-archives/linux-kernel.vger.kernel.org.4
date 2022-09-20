Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4395F5BE1D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiITJXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiITJW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:22:58 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E840647F5;
        Tue, 20 Sep 2022 02:22:56 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LzuTN-1pNE023f5n-0154XD;
 Tue, 20 Sep 2022 11:22:42 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] arm: dts: colibri-imx6: specify usbh_pen gpio being active-low
Date:   Tue, 20 Sep 2022 11:22:26 +0200
Message-Id: <20220920092227.286306-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220920092227.286306-1-marcel@ziswiler.com>
References: <20220920092227.286306-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SgwljqyddRh12mGq1Vz1EfYW+zMbDrq8Al6gunZLEMdkaxRmFzD
 75+pQyYAXO7zdf9fd+V1D/R8SnvR1fnI7ApHP3KrHCb3DozaHfJ5y7swcG6DIs0K76vUiT3
 UD/BFFu9vZERQrSa53wXRa/aj33JNsNJ04T1Q3XrzR4OJWpsVO1vVOCB+bv708dFLy9Ugjo
 dJo82ur458oYcMufh/zpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9XFEwyumTwg=:0TLml73q5jogPMuxlqE0Xe
 WL0/GyhPLxbCgLDszt8GFR0Nm6kbHONvmQcwRqCmEgE4glm74LU/gTIBBvXdHePAJTYkEFMT5
 vyTkB+MUlCwCzatdA7Ezfwkko8mH29MgssMmlVISb2I7nzZXWcMkpO31dRn34ZHa5lPS6Div7
 XiH7aHTolx3hMI0pn3Ph+KzmrDlr2rHvZJ/frgI6unCZf0usfoEXDIcbutpVS7DDIG643DcQE
 5r4RaC6aQ6dV9UJXpyH2Gt0AoWvskgHPSR3TTAE2SayZtbiFV7GyVitNi97eB1ZRd/GlCXVEr
 ObzZGnreN1aqS9Wqm8fC+38Cv28AlPFeoJGhYaaepurXHKrSOifu63pEqKcyQ978H6ABijmr1
 grfc8srJzly4FYJR5fE/y/We0MVNYbIqesiL9Rbbz42x6+ckBn43KZYbFF5mdamTQw7qivMXe
 O8QgJA0ji4sfFLmjqEw57H8i9KY38YZZMfYc43fiGoGL0S4JG6f8o0wfB/DHatreXd9b7xs1H
 3sig5y4u/Mu4h4IrpuAhyfcW9ffm5LVJQqtWqbaPuQLIvdnKiphV2bD8PNZC/lqEeLZ830RS+
 Oh5aDXkwriVw+5OBhzM7/n2VZJFJrmrP1hnnDlwhvaj6YulWS33bkhmCwTK5Nq8xh7vk499KX
 w3nRH5P+NBfjyE4mQ6tKxemwGWoKSOJAkwgCjDraIr/ZU9vE4dnGSXN6RoO/sp2WfOnKXJb7o
 sn6gQFVQlFsFWy2ZN28cTHqRESb93LO80JqUoWiwnHPoA74fEt7DkQ9d5OKvp7XvsSobcUXaL
 oa4SdM6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Specify USBH_PEN GPIO being active-low rather than active-high.

Note that this should not have any functional impact as for fixed
regulators the regular GPIO polarity is ignored and a true active-high
enable GPIO would need an additional enable-active-high property which
is/was not the case here. However, this may be rather confusing which
this patch fixes.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 21c5049bda4e..d8f985f297e4 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -112,7 +112,7 @@ reg_module_3v3_audio: regulator-module-3v3-audio {
 
 	reg_usb_host_vbus: regulator-usb-host-vbus {
 		compatible = "regulator-fixed";
-		gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>; /* SODIMM 129 / USBH_PEN */
+		gpio = <&gpio3 31 GPIO_ACTIVE_LOW>; /* SODIMM 129 / USBH_PEN */
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_regulator_usbh_pwr>;
 		regulator-max-microvolt = <5000000>;
-- 
2.36.1

