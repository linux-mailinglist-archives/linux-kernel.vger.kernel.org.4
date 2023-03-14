Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B122E6B8FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCNKZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjCNKZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:04 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E01A97FF2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:24:35 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4s3XKTzMqPFr;
        Tue, 14 Mar 2023 11:24:29 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4r6zXWz2N45;
        Tue, 14 Mar 2023 11:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789469;
        bh=LudF0hu2w2JADBbt/W9Ar1NM5GzhCrjnoA+Nvc91nGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jajtVam3AXdw6lYvxWAmL7cURTDlcgqhk58f87e1lEKi+XebpeMAbLSrVNF+9rvlx
         /Vgfps2mFSNKuSyOn/DUI9z0t9WlFTwAx5OqVuboWTmDPRWTMl6Djv340PfA4JaI9b
         iCVc6saS14YlazKm61QXbrx7mS3BOUpjo6fOZM08=
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
Subject: [PATCH v2 14/23] arm64: dts: colibri-imx8x: Add colibri pwm b, c, d
Date:   Tue, 14 Mar 2023 11:24:00 +0100
Message-Id: <20230314102410.424773-15-dev@pschenker.ch>
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

Add Colibri PWM_B, PWM_C, PWM_D to the module-level device-tree and set
the status to ok on the eval-board.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

(no changes since v1)

 .../dts/freescale/imx8x-colibri-eval-v3.dtsi  | 15 +++++++++++++
 .../boot/dts/freescale/imx8x-colibri.dtsi     | 21 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
index 1d0bad085ad4..68e34516961a 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
@@ -51,6 +51,21 @@ &lpuart2 {
 	status = "okay";
 };
 
+/* Colibri PWM_B */
+&lsio_pwm0 {
+	status = "okay";
+};
+
+/* Colibri PWM_C */
+&lsio_pwm1 {
+	status = "okay";
+};
+
+/* Colibri PWM_D */
+&lsio_pwm2 {
+	status = "okay";
+};
+
 /* Colibri UART_A */
 &lpuart3 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 778f2f43a8c0..61033b79e44e 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -259,6 +259,27 @@ &lsio_gpio5 {
 			  "UNUSABLE_SODIMM_184";
 };
 
+/* Colibri PWM_B */
+&lsio_pwm0 {
+	#pwm-cells = <3>;
+	pinctrl-0 = <&pinctrl_pwm_b>;
+	pinctrl-names = "default";
+};
+
+/* Colibri PWM_C */
+&lsio_pwm1 {
+	#pwm-cells = <3>;
+	pinctrl-0 = <&pinctrl_pwm_c>;
+	pinctrl-names = "default";
+};
+
+/* Colibri PWM_D */
+&lsio_pwm2 {
+	#pwm-cells = <3>;
+	pinctrl-0 = <&pinctrl_pwm_d>;
+	pinctrl-names = "default";
+};
+
 /* On-module eMMC */
 &usdhc1 {
 	bus-width = <8>;
-- 
2.39.2

