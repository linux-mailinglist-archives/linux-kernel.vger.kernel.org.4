Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2F86B8FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjCNKZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCNKZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:04 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7414D19F1E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:24:33 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4q0k4hzMqPwM;
        Tue, 14 Mar 2023 11:24:27 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4p4Kb6z2MSL;
        Tue, 14 Mar 2023 11:24:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789467;
        bh=9EjrjkcAseiSuH4XNzAuihLCa8ybEi2XPdLoIDXTnhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7/wHODLXJJVDx7N0cvUOM8iELn1DHe2vGklOA3hoXpiQ/1UeYlOIlPsZL2XRvKpy
         ixiFmqfMhdzutVJhkFdjQG5BY+BNC0cw0OAiJEr2mtD8B1FlS0h+gBiC7IlWs/Eemd
         Os8e6dAUwD5ucSBXUGnLe8bkyIRzloaUcqVP48uA=
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
Subject: [PATCH v2 10/23] arm64: dts: colibri-imx8x: Add SPI
Date:   Tue, 14 Mar 2023 11:23:56 +0100
Message-Id: <20230314102410.424773-11-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314102410.424773-1-dev@pschenker.ch>
References: <20230314102410.424773-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add Colibri SPI to the board. lpspi2 is being exposed on the SoM edge.
Add settings to the module-level but finally enable it on the eval-board
dtsi.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi | 5 +++++
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi         | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
index dc0339b35a3c..1d0bad085ad4 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
@@ -36,6 +36,11 @@ rtc_i2c: rtc@68 {
 	};
 };
 
+/* Colibri SPI */
+&lpspi2 {
+	status = "okay";
+};
+
 /* Colibri UART_B */
 &lpuart0 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index cd7de71c6d73..a2364845e976 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -91,6 +91,13 @@ ethphy0: ethernet-phy@2 {
 	};
 };
 
+/* Colibri SPI */
+&lpspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi2>;
+	cs-gpios = <&lsio_gpio1 0 GPIO_ACTIVE_LOW>;
+};
+
 /* On-module eMMC */
 &usdhc1 {
 	bus-width = <8>;
-- 
2.39.2

