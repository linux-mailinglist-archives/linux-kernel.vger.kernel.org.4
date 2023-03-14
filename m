Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F86B8FED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCNK0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCNKZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:29 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DE097B54
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:25:07 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4w3qJBzMqQW6;
        Tue, 14 Mar 2023 11:24:32 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4w0BJTz2N4D;
        Tue, 14 Mar 2023 11:24:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789472;
        bh=3mHH+vmW/2jGkiLn5nJ61l+JVuDF6ZCRwQPg1RNWSc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgXBmHmyN6bxsdt8G+dGlfIF+iwbYc1K7hvB/8rlenwAlD3GDq6NjX/mopfgdj0im
         TRcjfiNvw9o1r+YgfITw39xB7u94HgEvp52zClobFVoeIODxBT+We64HgJbrph16iM
         mPxIZCEVGkId72ZH7maquVdURtFxZb5MyOA5D9tQ=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/23] arm64: dts: colibri-imx8x: Add todo comments
Date:   Tue, 14 Mar 2023 11:24:05 +0100
Message-Id: <20230314102410.424773-20-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314102410.424773-1-dev@pschenker.ch>
References: <20230314102410.424773-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Highlight what is still missing.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

(no changes since v1)

 .../boot/dts/freescale/imx8x-colibri.dtsi     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index ff5ad88febc8..7cad79102e1a 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -31,6 +31,10 @@ reg_module_3v3: regulator-module-3v3 {
 	};
 };
 
+/* TODO Analogue Inputs */
+
+/* TODO Cooling maps for DX */
+
 &cpu_alert0 {
 	hysteresis = <2000>;
 	temperature = <90000>;
@@ -43,6 +47,10 @@ &cpu_crit0 {
 	type = "critical";
 };
 
+/* TODO flexcan1 - 3 */
+
+/* TODO GPU */
+
 /* On-module I2C */
 &i2c0 {
 	#address-cells = <1>;
@@ -71,6 +79,10 @@ touchscreen@2c {
 	};
 };
 
+/* TODO i2c lvds0 accessible on FFC (X2) */
+
+/* TODO i2c lvds1 accessible on FFC (X3) */
+
 /* Colibri I2C */
 &i2c1 {
 	#address-cells = <1>;
@@ -88,6 +100,8 @@ &jpegenc {
 	status = "okay";
 };
 
+/* TODO Parallel RRB */
+
 /* Colibri UART_B */
 &lpuart0 {
 	pinctrl-names = "default";
@@ -307,6 +321,14 @@ &lsio_pwm2 {
 	pinctrl-names = "default";
 };
 
+/* TODO MIPI CSI */
+
+/* TODO MIPI DSI with DSI-to-HDMI bridge lt8912 */
+
+/* TODO on-module PCIe for Wi-Fi */
+
+/* TODO On-module i2s / Audio */
+
 /* On-module eMMC */
 &usdhc1 {
 	bus-width = <8>;
@@ -334,6 +356,12 @@ &usdhc2 {
 	no-1-8-v;
 };
 
+/* TODO USB Client/Host */
+
+/* TODO USB Host */
+
+/* TODO VPU Encoder/Decoder */
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ext_io0>, <&pinctrl_hog0>, <&pinctrl_hog1>,
-- 
2.39.2

