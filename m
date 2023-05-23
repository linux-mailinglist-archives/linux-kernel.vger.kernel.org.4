Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1B70E695
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbjEWUhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEWUhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:37:31 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C52CA;
        Tue, 23 May 2023 13:37:30 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B748DCFB2A;
        Tue, 23 May 2023 20:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684874219; bh=R38mKTlIEZaX+EkDqWS8iS9Wk/v0TsXd/NEYgSra/8c=;
        h=From:Date:Subject:To:Cc;
        b=EOCUc0Q4qvUvFbAzxLmR603/vFPcOGFVcsl0/XcmhOpl8/b2t5Tv1zupRMhrJDLPY
         +9uQhyxaT5pZvgCNf5Ry7ZDD41OLoIIXXZY/1fx5ClH1maDda+goqVK3yYAYEkUH++
         YQs7BlbW+Vr97dgPMJTZ4quqSad3XtX0adF+t9d0=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 23 May 2023 22:36:49 +0200
Subject: [PATCH v2] arm64: dts: qcom: msm8953: Add BLSP DMAs for I2C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230422-msm8953-blsp-dma-v2-1-076134481b1b@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAOAjbWQC/32NSwqDMBQAryJv3VeSp5LYlfcoLhKNNaBREhU/e
 PemHqDLGRjmhGC8NQFeyQnerDbY0UWgRwJ1p9zHoG0iAzFKWUaEQxhkkaeo+zBhMyjkXGQkhMy
 LliBmWgWD2itXdzF0S99HOXnT2u3+vKvInQ3z6Pd7u/Kf/XNYOXJkjDLJuNa5FOWRunl5bvsB1
 XVdXwIUz1XFAAAA
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4768; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=R38mKTlIEZaX+EkDqWS8iS9Wk/v0TsXd/NEYgSra/8c=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbSPnn+FpHMtv8lr42Jv9XOxpmFE73h0zPeCJe
 Kv4kV2fpO+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0j5wAKCRBy2EO4nU3X
 VnTqEACwGAqynXAtCHIasXn6bw6QuJP2M0Qxt+tgSirPTgzTziBLIDA07RmWq30u1LYXIrDBw3X
 o49t4JME2NqNA+IUtXyq8NLoZcXBoDAa8nAdmWROBoMuHSIuUA91IcZr9MXRN7OOScw6jKMYyU9
 mwIpGl4LJEkqdl5Qu2o4toB2I6aX2YfnTrK2l2yH9g412uh6fLgXvi3QZG+44vKotM8kTDwY5Ws
 NQMbROZjo7Q1MXslpnFg1ZmFip+YgTfoL10i9zfu5VnpnVMrFWaUw6dhQkon88chvKsnXnwtFzt
 pNJlUgGwHYJ+9350Sds1Q5JUvpTPOF7pxOi8x3Vpcyn/SeUw+I2aZBnrgwgy+4Elfki9a+cKAnX
 pPZkGMO57Is4iftavakxrCT13ZJUCUUd5CdD05lz51KNef2jHQVPsjMY6i5dDVC3BeMbdhbDknc
 UM7lg8oAQ/vpCj/2GnV55/pr+d+04sQtZhlmVDWqdTFkpv7PECya1cE7xDYiA0QLjVrHNrv54lh
 u5yMnPfnQiPvdyjibsdZG7mexpukivjQac73wG3b3Bq6kv3YvZcI0mXNwd6fNBDK0JUChZyCYeJ
 Wq48VGe6RwlXTkVkQEdt6xi9pXPUJkHNhbucrRwbGsxjrFM3Tc9bOB3ep4GWr/W26eZKqm27s2T
 nAXdYhdjxjS8ltQ==
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Fix subject line, add "msm8953" (thanks Alexey)
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230422-msm8953-blsp-dma-v1-1-0024801bb587@z3ntu.xyz
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
base-commit: 99e988f2970e39d0859908c3adc2ff689172496a
change-id: 20230422-msm8953-blsp-dma-1174277859f2

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

