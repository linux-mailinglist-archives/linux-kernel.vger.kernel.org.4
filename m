Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67B56D4F16
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjDCRgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjDCRge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:36:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2851F30DD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:36:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x17so39121731lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680543391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDSUqIgZc3vuE7G0wttUjC5sMF8eoKNUAXbG/+xBz7o=;
        b=dfpkob28ehCs6mCLIcs+gUCzOibZPsfuW0jltZQVgvqUH/lABj46t7tQ4ubT00RNqC
         Cs59c4z2mY5qbcBCGcdfOzp6wg94StRJz/kwJrSmywv+xGXj97FoQG59187+Wy2Hy9E1
         qNf5gLVkKpcUFOWZ0skJ/nr2sJImRZDpZV40wrIZuK8GZ6upwsblJ3TOomBjooLe8DgV
         SI9v4Nycp4C31UuuXtxZVq7avXTKdH00/lyUqvCkO+JawxHGLcpFaH5OKtWwYyzfjtsy
         bFvimXy642cIuranElFVXpKgdKBnmcfMyxkHQlgKczJR0PMENye3QUHt9z8uIl5n3D3B
         tYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDSUqIgZc3vuE7G0wttUjC5sMF8eoKNUAXbG/+xBz7o=;
        b=O1afES43GIicbxSU6nEH8bKBuwbxW4nKNkRC6/6QT4XHNuJdtarSOpNOcJjIbmtfow
         F+K5gZbh7LZEErubA7Kqm7/7pU2EXOAfqVVwyPWPYsfnF/SE5p7V8Qyt3qEaQXJJn+ze
         zIxhtfooG9g+tIRWosfCn+bM5huyFAfsYC77HNfaSvQRLGXnoRwQ34Sr8sz1+FJEuK+J
         AB4lrwChaV8DyrC5FAqFpP4Cn/3rzxDz0y5mJIEyvxHXsQh+ceOxCukscvZmqknZoWHQ
         IOwnbm4eHdTGHsVICJZCKC+WjmsUqyUKIUleM3zg8aK68CaOMxSeNLekThFBnzW7feIZ
         bx6Q==
X-Gm-Message-State: AAQBX9cWxMBKadlTGKkCoWHq81XSVgiAlvmCO8A4U8n45kuPYsxZH1ZW
        san+Jvw5N5mRa2fYySE3oZyCig==
X-Google-Smtp-Source: AKy350Yj8TSz7u5Oi/4rrYByiFbzPmyr8NhiHsNq4E7pq2ZJDsPx33y0mms+QSZrIkDNwgK4Ri8xRQ==
X-Received: by 2002:ac2:46fb:0:b0:4eb:20f:99ee with SMTP id q27-20020ac246fb000000b004eb020f99eemr11378912lfo.63.1680543391499;
        Mon, 03 Apr 2023 10:36:31 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512096200b004cc5f44747dsm1871094lft.220.2023.04.03.10.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:36:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Apr 2023 19:36:02 +0200
Subject: [PATCH 4/9] arm64: dts: qcom: qcm2290: Add most QUPs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-topic-rb1_qcm-v1-4-ca849b62ba07@linaro.org>
References: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
In-Reply-To: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680543384; l=9924;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=h7DNqy7zdnStNn/U/kT1rG4OFD58lx5f9HKEurJdSgg=;
 b=HU+/8bML8aHHs2aPAEF2zaGH2jMAMzXTreqe8YRJrsMTJjHv2hTqysMh2xyBtV2SCICl1mxQvKNw
 lLTC1M5wD5KC0SNLR6Dl8T0mTWLkD3nXExVlnDYp3D0Hi8GjlID2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all I2C and SPI hosts, the debug UART port and the related pinctrl.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 294 ++++++++++++++++++++++++++++++++++
 1 file changed, 294 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 27d4742cdb19..edfa18190454 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -310,6 +310,90 @@ tlmm: pinctrl@500000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
+			qup_i2c0_default: qup-i2c0-default-state {
+				pins = "gpio0", "gpio1";
+				function = "qup0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c1_default: qup-i2c1-default-state {
+				pins = "gpio4", "gpio5";
+				function = "qup1";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c2_default: qup-i2c2-default-state {
+				pins = "gpio6", "gpio7";
+				function = "qup2";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c3_default: qup-i2c3-default-state {
+				pins = "gpio8", "gpio9";
+				function = "qup3";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c4_default: qup-i2c4-default-state {
+				pins = "gpio12", "gpio13";
+				function = "qup4";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c5_default: qup-i2c5-default-state {
+				pins = "gpio14", "gpio15";
+				function = "qup5";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi0_default: qup-spi0-default-state {
+				pins = "gpio0", "gpio1","gpio2", "gpio3";
+				function = "qup0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi1_default: qup-spi1-default-state {
+				pins = "gpio4", "gpio5", "gpio69", "gpio70";
+				function = "qup1";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi2_default: qup-spi2-default-state {
+				pins = "gpio6", "gpio7", "gpio71", "gpio80";
+				function = "qup2";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi3_default: qup-spi3-default-state {
+				pins = "gpio8", "gpio9", "gpio10", "gpio11";
+				function = "qup3";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi4_default: qup-spi4-default-state {
+				pins = "gpio12", "gpio13", "gpio96", "gpio97";
+				function = "qup4";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi5_default: qup-spi5-default-state {
+				pins = "gpio14", "gpio15", "gpio16", "gpio17";
+				function = "qup5";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
 			qup_uart0_default: qup-uart0-default-state {
 				pins = "gpio0", "gpio1", "gpio2", "gpio3";
 				function = "qup0";
@@ -317,6 +401,13 @@ qup_uart0_default: qup-uart0-default-state {
 				bias-disable;
 			};
 
+			qup_uart4_default: qup-uart4-default-state {
+				pins = "gpio12", "gpio13";
+				function = "qup4";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			sdc1_state_on: sdc1-on-state {
 				clk-pins {
 					pins = "sdc1_clk";
@@ -604,6 +695,38 @@ qupv3_id_0: geniqup@4ac0000 {
 			ranges;
 			status = "disabled";
 
+			i2c0: i2c@4a80000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x04a80000 0x0 0x4000>;
+				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_i2c0_default>;
+				pinctrl-names = "default";
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi0: spi@4a80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x04a80000 0x0 0x4000>;
+				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_spi0_default>;
+				pinctrl-names = "default";
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			uart0: serial@4a80000 {
 				compatible = "qcom,geni-uart";
 				reg = <0x0 0x04a80000 0x0 0x4000>;
@@ -614,6 +737,177 @@ uart0: serial@4a80000 {
 				pinctrl-names = "default";
 				status = "disabled";
 			};
+
+			i2c1: i2c@4a84000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x04a84000 0x0 0x4000>;
+				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_i2c1_default>;
+				pinctrl-names = "default";
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi1: spi@4a84000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x04a84000 0x0 0x4000>;
+				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_spi1_default>;
+				pinctrl-names = "default";
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c2: i2c@4a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x04a88000 0x0 0x4000>;
+				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_i2c2_default>;
+				pinctrl-names = "default";
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi2: spi@4a88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x04a88000 0x0 0x4000>;
+				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_spi2_default>;
+				pinctrl-names = "default";
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c3: i2c@4a8c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x04a8c000 0x0 0x4000>;
+				interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_i2c3_default>;
+				pinctrl-names = "default";
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi3: spi@4a8c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x04a8c000 0x0 0x4000>;
+				interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_spi3_default>;
+				pinctrl-names = "default";
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c4: i2c@4a90000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x04a90000 0x0 0x4000>;
+				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_i2c4_default>;
+				pinctrl-names = "default";
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi4: spi@4a90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x04a90000 0x0 0x4000>;
+				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi4_default>;
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart4: serial@4a90000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a90000 0x0 0x4000>;
+				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_uart4_default>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			i2c5: i2c@4a94000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x04a94000 0x0 0x4000>;
+				interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_i2c5_default>;
+				pinctrl-names = "default";
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi5: spi@4a94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x04a94000 0x0 0x4000>;
+				interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_spi5_default>;
+				pinctrl-names = "default";
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		usb: usb@4ef8800 {

-- 
2.40.0

