Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC52F6B07D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjCHNCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjCHNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:01:15 -0500
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6074C48B6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:00:15 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsgJ1XnbzMqs7l;
        Wed,  8 Mar 2023 13:53:16 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsgH5C43zMslsF;
        Wed,  8 Mar 2023 13:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678279996;
        bh=JXingivvb7re9pagMlQsVFdFYwLAWOaPZ43ldOrpBVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hd9ky80NPbUHCYLIp5NSLNVK5GRSGqWjIra8CyYkHy8B70PC9BUiCoUbvbGIINihE
         f0/SScb8T8q1I2Uu7mLcBuzEZy/MBPNyjjLLr54smfY2xBLODmmNrcs9vGuIzRI1ke
         yqQhOO0//nWMTontZQhO+8yls45NirzOuFkKwgYg=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 16/25] arm64: dts: colibri-imx8x: Add colibri pwm b, c, d
Date:   Wed,  8 Mar 2023 13:52:50 +0100
Message-Id: <20230308125300.58244-17-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125300.58244-1-dev@pschenker.ch>
References: <20230308125300.58244-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

 .../dts/freescale/imx8x-colibri-eval-v3.dtsi  | 15 +++++++++++++
 .../boot/dts/freescale/imx8x-colibri.dtsi     | 21 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
index 77222d76bd95..625d2caaf5d1 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
@@ -56,6 +56,21 @@ &lpuart2 {
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
index b849b378b017..180a1d940b8d 100644
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
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-- 
2.39.2

