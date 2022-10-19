Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6926603A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJSGwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiJSGwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:52:19 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A8C73C18;
        Tue, 18 Oct 2022 23:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3EIE1b+W7R/DKwGmrntdlJQvmv9HO0094TJ61G0bhE8=; b=ZJTnp/sJhSqx6iyfcAfZpRaWDV
        VweMsaH7uG9M1dtlpgv5GrXR/C/PBpkSr8PtILADjO4W3dbpL7Q1+xmkadSCQnXMKLQcr/f2M37EX
        yR/CyhKwqrMeQguPG57+dbny6BEAEa1f14tfxfft2817I83CfWziIX8o4bAOS90T2YwI3dS1gOoku
        mYK1NGqBNW8ivISP1pVpNrbyK6F+Ge0QBXhQt1mHJrRzo5STghBDgX9pmtM8njku9dSWJ7dnIsq7U
        cqUOV6PRGQkpKx90OBEg5izoSY1d1NPCFFHc/PAP2A0O+rHwZkwZhDXjfy4InGNTvOrhdBg+VdJfO
        lGWH+OBg==;
Received: from p200300ccff064b001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff06:4b00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ol2vq-00045Z-Fm; Wed, 19 Oct 2022 08:52:02 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1ol2vq-0044Jg-0Y; Wed, 19 Oct 2022 08:52:02 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        j.neuschaefer@gmx.net
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/2] ARM: dts: imx6sl-tolino-shine2hd: Add backlight
Date:   Wed, 19 Oct 2022 08:51:58 +0200
Message-Id: <20221019065159.969852-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019065159.969852-1-andreas@kemnade.info>
References: <20221019065159.969852-1-andreas@kemnade.info>
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

Add backlight for Tolino Shine2 HD. It uses the PWM
of the embedded controller.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
index 663ee9df79e6..ea0ce59aa4f1 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
@@ -18,6 +18,21 @@ / {
 	model = "Tolino Shine 2 HD";
 	compatible = "kobo,tolino-shine2hd", "fsl,imx6sl";
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&ec 0 50000>;
+		power-supply = <&backlight_regulator>;
+	};
+
+	backlight_regulator: regulator-backlight {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight_power>;
+		regulator-name = "backlight";
+		gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	chosen {
 		stdout-path = &uart1;
 	};
@@ -299,6 +314,12 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
+	pinctrl_backlight_power: backlight-powergrp {
+		fsl,pins = <
+			MX6SL_PAD_EPDC_PWRCTRL3__GPIO2_IO10 0x10059
+		>;
+	};
+
 	pinctrl_gpio_keys: gpio-keysgrp {
 		fsl,pins = <
 			MX6SL_PAD_SD1_DAT1__GPIO5_IO08  0x17059
-- 
2.30.2

