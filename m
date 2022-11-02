Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CEC6163B2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiKBNSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiKBNR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:17:59 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EEE2AC47;
        Wed,  2 Nov 2022 06:17:58 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LtHdl-1p0yDn1v8V-012osu;
 Wed, 02 Nov 2022 14:12:28 +0100
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
Subject: [PATCH v1 5/6] arm64: dts: verdin-imx8mp: add gpio usb-b connector
Date:   Wed,  2 Nov 2022 14:12:02 +0100
Message-Id: <20221102131203.35648-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221102131203.35648-1-marcel@ziswiler.com>
References: <20221102131203.35648-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Thh1AqQcIwoSO03vPLA6TTxnuAnbPtVYneMdFj+HuDRIGQAeuRD
 NRR2h5qvlY6CkGx6t5HTh2xxFKlT/rFpu42Jk2PCvCC3DfznnxV4Ce7UVaLA0ksoJf++Yho
 TUba8ahYACbcIdtXQXX8IEdIIg5qUlkCdWepabkwGTLH0KCqyrrO7xbIpQ76Y0Eu+JkTWuo
 /3WqlN5POZL/hXjQpN3Nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3PxX5/Xx1r0=:HpeQu/2fiqp6vYV2s2CxJR
 V7tSLXtI/XjKgOSwZraif69eBZ29pGkYcTLiUFossbkiqPpyndIljVOAyMiIFb4YvlIQ2haxz
 kvLi40rnjDnBBj2zIwDhVpElQjgWMwgXtIC8BsVg0qux0xzhyR3JlvuewxYQBsWPQiubLtJ6X
 zMu0ljtP8xGF+0caGFNSzJt3o0v/+JGmRrn7KhtVfKlkNrcZdc9IHfRGv7+kM5llHd0TZ4PFR
 UMlGEWRNTItP6UqYrjTEqThsctEWd4gYGLC5pKfHzFAtOBAwB+N/wzu2V7aPrBsBIp3X2vLdC
 zuXxh8IDK73mgdDuYiVMdN++yPitGmRADSy8MOgCmMEB4xrYUS2lLJpYvuMkKT82MCMhbCFg/
 8YcRCIO0fKI+4/aKIxilronWhcGz8+5pLM3UxuN5eXfVAjIEaASXmLxAuZeGquaSMRvmOpS46
 8dKHRyl/jwQs8RDWarIgdg0sVZmhY8FCC20PWHGMK3dd/nNTWDWNyc8SmVul5ZnPw0poqdf2w
 J2HpfVoVFMRxMhc9n5PW3lmeiztpLM7qOYch748gKqKwxJS01nT21DUAsQf1LyiYnrs//3Ac4
 zZ5Mzi8q4blqqybavnpnkAf7HzpFelzg2iTcgI8OzX7kBvpF5yXpe0XvIahvLjoVz4+0w1DlU
 NXnK0ElnqXTf74SJKHIQ37TCptuK5ha036yNtlhHY3lSXtuZ5AWXMTiGz+HYwvPMN4k0EKMDq
 2fqCETQVqSh6CKJKo+JWr6rJZs7hBNNuecQvCYDk3xDgJrSs8FP05f1nREWBNm+i0EmOhEvDQ
 nuVA4ZQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add GPIO USB-B connector (gpio-usb-b-connector) functionality using
Verdin USB_1_ID.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index 795e02df9f29..6a1890a4b5d8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -814,18 +814,26 @@ &usb3_0 {
 	pinctrl-0 = <&pinctrl_usb_1_oc_n>;
 };
 
-&usb3_phy0 {
-	vbus-supply = <&reg_usb1_vbus>;
-};
-
 &usb_dwc3_0 {
+	/* dual role only, not full featured OTG */
 	adp-disable;
 	dr_mode = "otg";
 	hnp-disable;
 	maximum-speed = "high-speed";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb_1_id>;
+	role-switch-default-mode = "peripheral";
 	srp-disable;
+	usb-role-switch;
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		id-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+		label = "Type-C";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb_1_id>;
+		self-powered;
+		type = "micro";
+		vbus-supply = <&reg_usb1_vbus>;
+	};
 };
 
 /* Verdin USB_2 */
-- 
2.36.1

