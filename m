Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2906163B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKBNSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiKBNR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:17:59 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CFC2AC41;
        Wed,  2 Nov 2022 06:17:58 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MguWM-1ocy110I8O-00M01X;
 Wed, 02 Nov 2022 14:12:15 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Peter Chen <peter.chen@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] arm64: dts: verdin-imx8mp: improve pinctrl for vbus-supplies
Date:   Wed,  2 Nov 2022 14:11:58 +0100
Message-Id: <20221102131203.35648-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221102131203.35648-1-marcel@ziswiler.com>
References: <20221102131203.35648-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6K6aIx412Q95eFSu342ICSPnePTvPJQYeqAFRnkoidvWyujjq9K
 6vi5OtmiUNulQdyMC6qWkjrrdhF6iDOrJlkwGXuLVNI+qhATNHbZuHUxx3lS0FCGU8V7Pfi
 XULk2JXoXxsdwTgISrBvkfSHLKURmWgFA8VDQBzRVVekfxW/Ow5x5BRbx5DQpeQxMGk3Ww6
 Qnoa8gdCbam4iKzm3VNwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HM2wh7f99YA=:vCsDgXYZwDio1AQPezlTOo
 FGu01QJLsr0XkcVwxJ3Ru3nOODs0jk7iw4qajbQFPaqJOte8GbzRNhImYxfuaQx+VDctoDmcG
 6FBeXYkRqFzDvONK/dpH/+JbHS6AgEOmyEZioVuq9ZzotDoa+mh+Tb4o6hZZpvhwIxS24DiaA
 RB6eUhvrb41oHAzIgKNX6hA/VwpMvR9mX/0MKn02YwgX1JqHyqgjo5M6xBgpEY8VG6hTkwcju
 0dtDhcuFn/jVbUNCjplgrCGARTJ3+tjKNL8dPvujhT53nkQrVdM6ggaq5YxTIBSoGvIncGIsP
 Qq/1PuhHqmL7U/LdO+DMP2ZMKmubBklET61U8WYpCuJ4P/pMYnI1trAIo/DmaSR+e6osqXcs2
 s1b+sAutocnh3Vixv/rmKWrWBwY89h6/eR+GHB+BkCzPXQ7Ug3A9lRdIZbCyxREp5jBVJdmoO
 J9ediKKxWxLHeVe0bJVMjUph9hp/sTT1V51rh95XR0yNjNnQy7rTSr3SdJj/vgsnl+xI0ObRB
 Q/JFZOc8izMlkmLLSMZ8iri0Bs5Ny4Bd6P6/fzpXFLew5kqOZWk+79V7JcXC587dEkshJ+ZVv
 zhw6Jq5YLZx/kdjuIjrGJXLksguzs1kfOFhWQWgKdvpZu08B88vF2friP2g3ANjd36/nF8Ggw
 u3yganNeC3FW6S76kHVaBSbH4DRW8yWWTXJ2MJdTUO+eJHv7a4STE8B8MVEm/ij9Wn/emM7ww
 8atEHC3GamQ4HM0p/B9IZbXdPS+sqlW91BqEoIuleCd8CMvdHA6e4lNREIWesMnnDBZ/wGLxo
 ZaZoJc1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

As we are using two fixed regulators for Verdin USB_1_EN (SODIMM 155)
and Verdin USB_2_EN (SODIMM 185), those should be muxed as GPIOs rather
than OTG_PWR.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index cc3b0725ce06..97e88440a251 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -1221,7 +1221,7 @@ pinctrl_uart4: uart4grp {
 
 	pinctrl_usb1_vbus: usb1vbusgrp {
 		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO12__USB1_OTG_PWR		0x19>;	/* SODIMM 155 */
+			<MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x106>;	/* SODIMM 155 */
 	};
 
 	/* USB_1_ID */
@@ -1232,7 +1232,7 @@ pinctrl_usb_1_id: usb1idgrp {
 
 	pinctrl_usb2_vbus: usb2vbusgrp {
 		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR		0x19>;	/* SODIMM 185 */
+			<MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14		0x106>;	/* SODIMM 185 */
 	};
 
 	/* On-module Wi-Fi */
-- 
2.36.1

