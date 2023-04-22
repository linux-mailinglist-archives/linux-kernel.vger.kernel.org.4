Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B151B6EB8DA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 13:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjDVLkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 07:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVLkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 07:40:01 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD671FC8;
        Sat, 22 Apr 2023 04:39:59 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E33A2C4126;
        Sat, 22 Apr 2023 11:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682163568; bh=4ON6nYYRMHx4lFKX8BnlCFsjoxRKgmTsvbLAUz+qINs=;
        h=From:Date:Subject:To:Cc;
        b=CEYAgVaXwuQTFIx91XxjNV1nHTigel1r7l1WYjmlmfv5BOyl7OFIyTXZY5FR74Yfk
         4AajuuNOw8SzfGHcNzRXpLXiTXiitCLuu3Z4msV+qGrMGX0WUsvaXjEkArXOR4CxlC
         +H0MSxyYK6QYJ0X6Izbo0U0jP2VzXTjLIUXgTeHY=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sat, 22 Apr 2023 13:39:16 +0200
Subject: [PATCH] arm64: dts: qcom: Add BLSP DMAs for I2C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230422-msm8953-blsp-dma-v1-1-0024801bb587@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAGPHQ2QC/x2N0QqDMAwAf0XyvICNSnW/MvbQapyBtpMGx0D89
 4U93sFxJyhXYYV7c0Llj6i8i4G7NTBvobwYZTEGaqlreyLMmsdp6DAm3XHJAZ3zPXk/DtNKYFk
 MyhhrKPNmYTlSMrlXXuX7/zye1/UDrySB33cAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4530; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=4ON6nYYRMHx4lFKX8BnlCFsjoxRKgmTsvbLAUz+qINs=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkQ8drwGpA4Flz3H1qKPic0J7y+WVA0qPL4rY9V
 gTckqIVxEiJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZEPHawAKCRBy2EO4nU3X
 VmP5D/9h8dtAS/7sHgOM12VeVGV3Sexu85JWFXgPoufs6wgQF7vccOa2gboX/MF9YBmOv2yWcqp
 E0/n5qiRbV2G5xEYynqY93ktCFFrnWlGAXRuyR1PwalBd3kpGu1Avw/g1u3GuMrUuauDoqF1R+2
 13k9UoNep4mfCZ3jvdnF+8TvAhFDyqjKIwXBwgx1Gjv24u7XZUJ7mwLbP11ud1sslkA6c6FWPoU
 o+IwU7fa6Nqz3eYkurs5/rWruFCXA6Fkfygr5uoe0kNorRQo8Rwsr5xKfwmzZG0HgFIQLm8Ie0W
 sLLN8Uf9dXzZM7Y/d4m3yZJZuiAsn8/0cKds2YNpqWYodvDDC2Qy6GyQcMJk+XJjXcnMozXjO1J
 4x5oFqKZdj4NYbY6av5UK0a19H61Sd55x+iA4bQXGy57EaX1wDYpn12NthcrKHN/PfQ5rlkhw48
 4if9MiS/ow9Lw8Vjk8CBPuqR51z7//LJv/2uNNEiEzFCtMGZAlpT1htFMzd2DFGYFGjI8O0Fumq
 AmG5RGgOXgdhhilhuJZPuLha5qSuhjVrC2PTa56kfby70MuPGuGCpD2gkikWu7bz+1OQctgSviW
 2bxKMkdF/rF2970T1HnnbepftrggrQmmqeFD8rUBLypc7octzwft8NZcpLaq9UKKSmb7MtbgMbD
 ma7bZV0Po2j12sg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8953 has two DMA controllers for the various I2C, SPI and UART
busses. Add the nodes and configure all the I2C nodes so that the driver
can use the DMA.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 602cb188a635..c9b589353918 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -1274,6 +1274,19 @@ opp-200000000 {
 			};
 		};
 
+		blsp1_dma: dma-controller@7884000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07884000 0x1f000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			num-channels = <12>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			qcom,controlled-remotely;
+		};
+
 		uart_0: serial@78af000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x078af000 0x200>;
@@ -1292,6 +1305,8 @@ i2c_1: i2c@78b5000 {
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
+			dmas = <&blsp1_dma 4>, <&blsp1_dma 5>;
+			dma-names = "tx", "rx";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c_1_default>;
@@ -1310,6 +1325,8 @@ i2c_2: i2c@78b6000 {
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
+			dmas = <&blsp1_dma 6>, <&blsp1_dma 7>;
+			dma-names = "tx", "rx";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c_2_default>;
@@ -1328,6 +1345,9 @@ i2c_3: i2c@78b7000 {
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
+			dmas = <&blsp1_dma 8>, <&blsp1_dma 9>;
+			dma-names = "tx", "rx";
+
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c_3_default>;
 			pinctrl-1 = <&i2c_3_sleep>;
@@ -1345,6 +1365,9 @@ i2c_4: i2c@78b8000 {
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
+			dmas = <&blsp2_dma 10>, <&blsp2_dma 11>;
+			dma-names = "tx", "rx";
+
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c_4_default>;
 			pinctrl-1 = <&i2c_4_sleep>;
@@ -1355,6 +1378,19 @@ i2c_4: i2c@78b8000 {
 			status = "disabled";
 		};
 
+		blsp2_dma: dma-controller@7ac4000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07ac4000 0x1f000>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "bam_clk";
+			num-channels = <12>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			qcom,controlled-remotely;
+		};
+
 		i2c_5: i2c@7af5000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x07af5000 0x600>;
@@ -1362,6 +1398,9 @@ i2c_5: i2c@7af5000 {
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP2_AHB_CLK>;
+			dmas = <&blsp2_dma 4>, <&blsp2_dma 5>;
+			dma-names = "tx", "rx";
+
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c_5_default>;
 			pinctrl-1 = <&i2c_5_sleep>;
@@ -1379,6 +1418,9 @@ i2c_6: i2c@7af6000 {
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP2_AHB_CLK>;
+			dmas = <&blsp2_dma 6>, <&blsp2_dma 7>;
+			dma-names = "tx", "rx";
+
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c_6_default>;
 			pinctrl-1 = <&i2c_6_sleep>;
@@ -1396,6 +1438,9 @@ i2c_7: i2c@7af7000 {
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP2_QUP3_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP2_AHB_CLK>;
+			dmas = <&blsp2_dma 8>, <&blsp2_dma 9>;
+			dma-names = "tx", "rx";
+
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c_7_default>;
 			pinctrl-1 = <&i2c_7_sleep>;
@@ -1413,6 +1458,9 @@ i2c_8: i2c@7af8000 {
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP2_QUP4_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP2_AHB_CLK>;
+			dmas = <&blsp2_dma 10>, <&blsp2_dma 11>;
+			dma-names = "tx", "rx";
+
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c_8_default>;
 			pinctrl-1 = <&i2c_8_sleep>;

---
base-commit: 347e9b4e41bfff51993807962eb1082f6d8ab439
change-id: 20230422-msm8953-blsp-dma-1174277859f2

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

