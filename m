Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88145F195B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiJADMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiJADHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:54 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177A1E0075;
        Fri, 30 Sep 2022 20:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664593644; x=1696129644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rlXZnS5UWrx9Pr783moEQVaT/CqHgzz8m0/A+8Fj5AA=;
  b=hkExF6XdVrLq5VtMZmw2JBpehlAEdbj4IB/cCfRcoBZ4fq38/9FE/6GQ
   TrveBZWRYZBAP52+JN0GyovY8u1t1iijtuFFPQPE/24d7qr39AIjLRSHD
   90IfjTUL72SG6uIzaxw9+0XN8gKhlVk2P0/VxKOGLu07HsYbpDKhL9aCI
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Sep 2022 20:07:18 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 20:07:18 -0700
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:07:17 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 19/19] arm64: dts: qcom: qdru1000: Add additional UART instances
Date:   Fri, 30 Sep 2022 20:06:56 -0700
Message-ID: <20221001030656.29365-20-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030656.29365-1-quic_molvera@quicinc.com>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add remaining UART instances to the QUP nodes for the QDU1000
and QRU1000 SoCs.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdru1000.dtsi | 57 +++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
index 930bb8c8ba5b..21938e3a613e 100644
--- a/arch/arm64/boot/dts/qcom/qdru1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
@@ -290,6 +290,19 @@ qupv3_id_0: geniqup@9c0000 {
 			ranges;
 			status = "disabled";
 
+			uart0: serial@980000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x980000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart0_default>;
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			uart7: serial@99c000 {
 				compatible = "qcom,geni-debug-uart";
 				reg = <0x0 0x99c000 0x0 0x4000>;
@@ -569,6 +582,33 @@ qupv3_id_1: geniqup@ac0000 {
 			ranges;
 			status = "disabled";
 
+			uart8: serial@a80000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0xa80000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart8_default>;
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart13: serial@a94000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0xa94000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart13_default>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+
 			i2c9: i2c@a84000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x0 0xa84000 0x0 0x4000>;
@@ -912,7 +952,12 @@ tlmm: pinctrl@f000000 {
 			gpio-ranges = <&tlmm 0 0 151>;
 			wakeup-parent = <&pdc>;
 
-			qup_uart7_default: qup-uart7-default {
+			qup_uart0_default: qup-uart0-default {
+				pins = "gpio6", "gpio7", "gpio8", "gpio9";
+				function = "qup0_se0_l0";
+			};
+
+			qup_uart7_default: qup-uart3-default {
 				tx {
 					pins = "gpio134";
 					function = "qup0_se7_l2";
@@ -928,6 +973,16 @@ rx {
 				};
 			};
 
+			qup_uart8_default: qup-uart8-default {
+				pins = "gpio18", "gpio19", "gpio20", "gpio21";
+				function = "qup1_se0_l0";
+			};
+
+			qup_uart13_default: qup-uart13-default {
+				pins = "gpio30", "gpio31", "gpio32", "gpio33";
+				function = "qup1_se5_l0";
+			};
+
 			qup_i2c1_data_clk: qup-i2c1-data-clk {
 				pins = "gpio10", "gpio11";
 				function = "qup0_se1_l0";
-- 
2.37.3

