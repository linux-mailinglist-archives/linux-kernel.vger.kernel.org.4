Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3CF660ED7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 13:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjAGMgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 07:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjAGMgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 07:36:51 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF27643E7D;
        Sat,  7 Jan 2023 04:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=16gPkfBcfkiE+p2Zk6g+QioQZiel/I6Miq/bmFFefOw=; b=ECqNVr13InrEpa2fi3VR85Fe2v
        J31Un9c86fobQVMptE8oDgx1TRuSB9UCfiMu29ibNuq0lTB2jSYJmjHCQRsPqm+nMNSgnyhy52mjU
        JZnwEdQ6sBMPKDzTrOfxpTz+E84SIp88ozrntuqNY/vAj3H7glmCMZqJ7XvfVgCdrM7GF7XUATvCS
        DAtxqVj0VDQO7gUQ5taPvaakuR3HZdexxGzHr9yLir8/3XzlXjWf2GdaoqK+ElKY9A9rZcfNW+kYN
        tne6Go02jzLe/H20iup0d50diei9KvnrtncD4+7s+2eDpVrD1Txm/H667bg3iUAgE0nmSvC0NTGN7
        YUdXHPYA==;
Received: from p200300ccff2fec001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2f:ec00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pE8R3-0004zM-Go; Sat, 07 Jan 2023 13:36:29 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pE8R2-0089qP-Qk; Sat, 07 Jan 2023 13:36:28 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: imx: e70k02: Add touchscreen
Date:   Sat,  7 Jan 2023 13:36:21 +0100
Message-Id: <20230107123621.1944420-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the touchscreen now, since the driver is available.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/e70k02.dtsi               | 11 ++++++++++-
 arch/arm/boot/dts/imx6sl-tolino-vision5.dts |  7 +++++++
 arch/arm/boot/dts/imx6sll-kobo-librah2o.dts |  7 +++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/e70k02.dtsi b/arch/arm/boot/dts/e70k02.dtsi
index 27ef9a62b23c..ace3eb8a97b8 100644
--- a/arch/arm/boot/dts/e70k02.dtsi
+++ b/arch/arm/boot/dts/e70k02.dtsi
@@ -122,7 +122,16 @@ &i2c2 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	/* TODO: CYTTSP5 touch controller at 0x24 */
+	touchscreen@24 {
+		compatible = "cypress,tt21000";
+		reg = <0x24>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_cyttsp5_gpio>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&ldo5_reg>;
+	};
 
 	/* TODO: SY7636 PMIC for E Ink at 0x62 */
 
diff --git a/arch/arm/boot/dts/imx6sl-tolino-vision5.dts b/arch/arm/boot/dts/imx6sl-tolino-vision5.dts
index ff6118df3946..6bc342035e2b 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-vision5.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-vision5.dts
@@ -52,6 +52,13 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
+	pinctrl_cyttsp5_gpio: cyttsp5-gpiogrp {
+		fsl,pins = <
+			MX6SL_PAD_FEC_TXD0__GPIO4_IO24          0x17059 /* TP_INT */
+			MX6SL_PAD_FEC_RXD1__GPIO4_IO18          0x10059 /* TP_RST */
+		>;
+	};
+
 	pinctrl_gpio_keys: gpio-keysgrp {
 		fsl,pins = <
 			MX6SL_PAD_FEC_CRS_DV__GPIO4_IO25	0x17059	/* PWR_SW */
diff --git a/arch/arm/boot/dts/imx6sll-kobo-librah2o.dts b/arch/arm/boot/dts/imx6sll-kobo-librah2o.dts
index a8b0e88064d9..7e4f38dd11e2 100644
--- a/arch/arm/boot/dts/imx6sll-kobo-librah2o.dts
+++ b/arch/arm/boot/dts/imx6sll-kobo-librah2o.dts
@@ -62,6 +62,13 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
+	pinctrl_cyttsp5_gpio: cyttsp5-gpiogrp {
+		fsl,pins = <
+			MX6SLL_PAD_GPIO4_IO24__GPIO4_IO24	0x17059 /* TP_INT */
+			MX6SLL_PAD_GPIO4_IO18__GPIO4_IO18	0x10059 /* TP_RST */
+		>;
+	};
+
 	pinctrl_gpio_keys: gpio-keysgrp {
 		fsl,pins = <
 			MX6SLL_PAD_GPIO4_IO25__GPIO4_IO25	0x17059	/* PWR_SW */
-- 
2.30.2

