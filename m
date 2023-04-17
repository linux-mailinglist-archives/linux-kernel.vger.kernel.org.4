Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26DD6E4D77
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjDQPmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjDQPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:42:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE115273C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:42:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f167d2941fso15555235e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1681746129; x=1684338129;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hzlswnMiGoXB1p+F9TnJvkyooz/IBar1fNaepAPNYs=;
        b=T3CK4OwOnNC+elT8N6i0jZ1zicSIeXQvFj0vk/wahuHBvgkcPiOW7MvpX871+/YUMq
         2+Tas9IVNc4Ekrk3XQIPRCYtOG5tAzuowjE9teAZ7mLOKAFTGWqn/a6tPCbuM4Sawx21
         1C5+wMDF4XcTXywGeSVz4HA5TfRVCg9fPQ40Av9NOQKJdGZoGURk/udT+T7XXyjR8HKu
         Ib4A/1QsVqIHGb+Law58vh3g+atqpSu2c4om4mz5BZlveeM6Q0rf/NBvbOHd64t+HJcA
         aUnRURsVbTD7EiLXCbneAd8fULlLLxzQfwVsiIEX1l7SlVIAVn1OorKEFTnULu4p77fe
         znvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746129; x=1684338129;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hzlswnMiGoXB1p+F9TnJvkyooz/IBar1fNaepAPNYs=;
        b=TF+KiFlImT4M/AePrFii1Oi3PWKTRBVcSADlELpwu+JKCjwTl70TM/coFXF0HvR25w
         qwQEJg3Nj8sBiblbb8y8ZpdF/yiXJ30MvsoQd7SwBeVmlatUtbHEVsavtM8gPCULrAi0
         oCeslIrKXpqWoNB9Um9BTAi2t0gCM+vRc5FxBj6PZ3h/Ftw1DVt7i32OJih+BFswY2Fc
         qRMXruK57YD/oLMBGU+wdBffwJVmwArRFdg+fhAnZrSp0W5mG9MR8g7hkdqToJUZaEVo
         r2s1cACSTKXXr6ROcLUWvi9ehhccpw9yqP28t/38GcQh5ix6YrIWqTICytVd3j73/r/E
         4d7Q==
X-Gm-Message-State: AAQBX9fgg6VWu1m4hlzf/Lnvn1lTofyoMbfmB9+puQXk3Ef9gIkRypXB
        TPu3TWb0DBIUVKVK39ODe1Yd
X-Google-Smtp-Source: AKy350ZsR/2TLPkpZkVYV14GGSd9u7PKle7GzyPwzThrprfO8AdQJO8TKQbg81n6gO8IXbwIG+7TaQ==
X-Received: by 2002:a5d:6410:0:b0:2f2:17fc:e15b with SMTP id z16-20020a5d6410000000b002f217fce15bmr5852579wru.6.1681746129285;
        Mon, 17 Apr 2023 08:42:09 -0700 (PDT)
Received: from [127.0.1.1] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d4fcc000000b002f22c44e974sm10742937wrw.102.2023.04.17.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:42:09 -0700 (PDT)
From:   Arnaud Vrac <avrac@freebox.fr>
Date:   Mon, 17 Apr 2023 17:41:18 +0200
Subject: [PATCH] arm64: dts: qcom: msm8998: add blsp spi nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-msm8998-spi-v1-1-6ea13d8a5384@freebox.fr>
X-B4-Tracking: v=1; b=H4sIAJ1oPWQC/x2NQQqDMBAAvyJ77kI0YmK/UjzEZFsXNJUsiiD+3
 cXjDAxzglBhEnhXJxTaWfifFepXBXEK+UfISRka01jT1g4XWXzfe5SV0XXJeduZaH0CLcYghGM
 JOU7a5G2eVa6Fvnw8i89wXTdOWCnwcgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnaud Vrac <avrac@freebox.fr>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9969; i=avrac@freebox.fr;
 h=from:subject:message-id; bh=CgPjylovqcl5OJuFgtl1xjV8EqwfG/LPMd0muZhCxgc=;
 b=owEBbQKS/ZANAwAIAXED/9m7NDSrAcsmYgBkPWjLngR/x0QIKwwLVlP91twpyAd0oI77juPCJ
 YffOu92onWJAjMEAAEIAB0WIQSUwb/ndwkXHdZ/QQZxA//ZuzQ0qwUCZD1oywAKCRBxA//ZuzQ0
 q+9vD/93Wj4n7t47etlIb56iDWAFcK/RxxG94FPKNjibkvPDyDhcIpxgnygmCZ/FJbuNwNLl+U5
 w6Vu1JEQUu95MaZUsxAPvRtwXJGXiG0jqAwsefNw1DWpsD+PxvorBdPhA8TnPBQM9A4dEzgPZwN
 28/m/v8yRiu3jDK5EFe+EbT1ymQRaUaWvIF/1atFNrDcLIKB53Nj49rgp7PA/BqKnDDyAmgfSQ5
 1I+7yIMVrtsCPo7RZHYgfb7eHd8bejufjOzrmic7+FHJ/C1VkTUaE39s9a6Ip7MFJLBiybAqBzE
 NDRKgQk2ji72mmFrbihgl2DRIkEvWiM7ll3gd2YLk0RdykzAEKfPz0xxNNt7Nz7zjBbyhLOHKKu
 EbtwgYmUAQGcxqwHZnpnJ5hXI3erBNpjDM27Nat2Tj3q6dHy56DkN6u2YoGUneKZl3DLbnPxKgq
 CroyO8iznFpXzqgGyocad73Cu+pqcmtNmUKxWDlSgqDUiJspC8x/cgN5yKhMKUjxzbgGAPggfCw
 Lt6Yfymgg+dyGw6m+MpxrrDl87o9yi+EkH+sY2/KnZ/OpiNHJtS7dqxxKyaEgUp/1+ztzGM0Z6t
 ZKgX3udgLDBE8tGVygcX1Ezeo67ILOmUyMNjH9biWlDu2tGvRqlbiTkzhsVxLgaiAJ8Zhu28naM
 G6wUxVftK41VoHw==
X-Developer-Key: i=avrac@freebox.fr; a=openpgp;
 fpr=6225092072BB58E3CEEC091E75392A176D952DB4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 309 ++++++++++++++++++++++++++++++++++
 1 file changed, 309 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index b150437a83558..41c8bb44d1fb1 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1228,6 +1228,57 @@ blsp1_i2c6_sleep: blsp1-i2c6-sleep-state {
 				drive-strength = <2>;
 				bias-pull-up;
 			};
+
+			blsp1_spi_b_default: blsp1-spi_b-default {
+				pins = "gpio23", "gpio28";
+				function = "blsp1_spi_b";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp1_spi1_default: blsp1-spi1-default {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "blsp_spi1";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp1_spi2_default: blsp1-spi2-default {
+				pins = "gpio31", "gpio34", "gpio32", "gpio33";
+				function = "blsp_spi2";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp1_spi3_default: blsp1-spi3-default {
+				pins = "gpio45", "gpio46", "gpio47", "gpio48";
+				function = "blsp_spi2";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp1_spi4_default: blsp1-spi4-default {
+				pins = "gpio8", "gpio9", "gpio10", "gpio11";
+				function = "blsp_spi4";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp1_spi5_default: blsp1-spi5-default {
+				pins = "gpio85", "gpio86", "gpio87", "gpio88";
+				function = "blsp_spi5";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp1_spi6_default: blsp1-spi6-default {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "blsp_spi6";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+
 			/* 6 interfaces per QUP, BLSP2 indexes are numbered (n)+6 */
 			blsp2_i2c1_default: blsp2-i2c1-default-state {
 				pins = "gpio55", "gpio56";
@@ -1312,6 +1363,48 @@ blsp2_i2c6_sleep: blsp2-i2c6-sleep-state {
 				drive-strength = <2>;
 				bias-pull-up;
 			};
+
+			blsp2_spi1_default: blsp2-spi1-default {
+				pins = "gpio53", "gpio54", "gpio55", "gpio56";
+				function = "blsp_spi7";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp2_spi2_default: blsp2-spi2-default {
+				pins = "gpio4", "gpio5", "gpio6", "gpio7";
+				function = "blsp_spi8";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp2_spi3_default: blsp2-spi3-default {
+				pins = "gpio49", "gpio50", "gpio51", "gpio52";
+				function = "blsp_spi9";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp2_spi4_default: blsp2-spi4-default {
+				pins = "gpio65", "gpio66", "gpio67", "gpio68";
+				function = "blsp_spi10";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp2_spi5_default: blsp2-spi5-default {
+				pins = "gpio58", "gpio59", "gpio60", "gpio61";
+				function = "blsp_spi11";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			blsp2_spi6_default: blsp2-spi6-default {
+				pins = "gpio81", "gpio82", "gpio83", "gpio84";
+				function = "blsp_spi12";
+				drive-strength = <6>;
+				bias-disable;
+			};
 		};
 
 		remoteproc_mss: remoteproc@4080000 {
@@ -2249,6 +2342,114 @@ blsp1_i2c6: i2c@c17a000 {
 			#size-cells = <0>;
 		};
 
+		blsp1_spi1: spi@c175000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c175000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 6>, <&blsp1_dma 7>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi1_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_spi2: spi@c176000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c176000 0x600>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 8>, <&blsp1_dma 9>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi2_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_spi3: spi@c177000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c177000 0x600>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 10>, <&blsp1_dma 11>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi3_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_spi4: spi@c178000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c178000 0x600>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 12>, <&blsp1_dma 13>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi4_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_spi5: spi@c179000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c179000 0x600>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP5_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 14>, <&blsp1_dma 15>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi5_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp1_spi6: spi@c17a000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c17a000 0x600>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP1_QUP6_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 16>, <&blsp1_dma 17>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi6_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		blsp2_dma: dma-controller@c184000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x0c184000 0x25000>;
@@ -2392,6 +2593,114 @@ blsp2_i2c6: i2c@c1ba000 {
 			#size-cells = <0>;
 		};
 
+		blsp2_spi1: spi@c1b5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c1b5000 0x600>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 6>, <&blsp2_dma 7>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi1_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_spi2: spi@c1b6000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c1b6000 0x600>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP2_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 8>, <&blsp2_dma 9>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi2_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_spi3: spi@c1b7000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c1b7000 0x600>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP3_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 10>, <&blsp2_dma 11>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi3_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_spi4: spi@c1b8000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c1b8000 0x600>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP4_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 12>, <&blsp2_dma 13>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi4_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_spi5: spi@c1b9000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c1b9000 0x600>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP5_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 14>, <&blsp2_dma 15>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi5_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		blsp2_spi6: spi@c1ba000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x0c1ba000 0x600>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_BLSP2_QUP6_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 16>, <&blsp2_dma 17>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi6_default>;
+
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		mmcc: clock-controller@c8c0000 {
 			compatible = "qcom,mmcc-msm8998";
 			#clock-cells = <1>;

---
base-commit: e3342532ecd39bbd9c2ab5b9001cec1589bc37e9
change-id: 20230417-msm8998-spi-76d78360c38d

Best regards,
-- 
Arnaud Vrac <avrac@freebox.fr>

