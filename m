Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C7622DD7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiKIO1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiKIO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:26:57 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7F213CF5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:26:39 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j4so25890874lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyPspQoNicHjcD9jCvm90DnQiKaOFAYO68AFEeI+Gjo=;
        b=E3COATcWr9NTlWee+vYb/aRT+T2a/w34cY4tfkG3GL4W7ELpIQ0MXNhn+seoLSnVZS
         h2Tid36bp4RkP9Hp/Bps7QtonStw0YCGuR88cgBOAaD79LEJgIbCWgjGhx8OKuycpNkc
         nNNCfGRiFgxPqSU6itzhfPzLsyP//5EdBoYQ3GHdI7tcQM06R6XST8RgHxdYJC0Na8I5
         SpYAfiSEnbkQQrWItueFoa4YTp49X7TabvqFOs5H72v3WhnjSRmGtXZPAAp+EhWfoIUY
         RYT3hN/WZBQr0Em2ZkqmmbGiV/qnN9VzwA5koLhas8RONE5eEOsDkTTt0eAV0znYzCXc
         IzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyPspQoNicHjcD9jCvm90DnQiKaOFAYO68AFEeI+Gjo=;
        b=dkiIXMWrDOahnw4g8Pc4+hSv2yCEKiXMFj/KzkH4Gm/F4c0lfByNtUyaz/hEjxvnRT
         J40kqOT8kYlojDA7OhhhRntjZmqVngnuCK4pqpuS7N6QcBKIEZyrju8lNn1EA16VSQwx
         Cm+WuhQrwTN7onf6yDZw8iSOxYj1uDPsdqJ4IaN0TF+vRQ5Was/e/p7iUlz4d3qJ9BxG
         AQ6/ZdDZbTNQiacSTp7+pvZsGh389jAzo4NcTg9dPN5FyCkCz2CAOmHljXnVoyMz8S71
         OjOiqBniy3Ys+npntk0dzcoDZkQTITnhdsqZIPZ18WMWOlrZnmSXHMD328ndgURPl3Bq
         iOmg==
X-Gm-Message-State: ACrzQf3wm/tHNR3ZCY+b4RMABVDiCht3gBXkNRnXYzVhXcM1AklPxHCg
        9quuNNRfID0GnflCpDakcAXtKA==
X-Google-Smtp-Source: AMsMyM6sPJyAQgTN9+RPxtfj2WGuEeeaL7FQNqEhRLCQKW+LanoNLoMM0oGwE1V/bu/KqPHOHhRJAg==
X-Received: by 2002:a19:f812:0:b0:4a4:1c92:2736 with SMTP id a18-20020a19f812000000b004a41c922736mr19828340lff.441.1668003997461;
        Wed, 09 Nov 2022 06:26:37 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004a2ae643b99sm2241008lfr.170.2022.11.09.06.26.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 06:26:37 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: sm6375: Add SDHCI2
Date:   Wed,  9 Nov 2022 15:26:22 +0100
Message-Id: <20221109142623.53052-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109142623.53052-1-konrad.dybcio@linaro.org>
References: <20221109142623.53052-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the second SDHCI bus controller, which usually the
interface used for SD cards.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 82 ++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 6adffd927a8e..483202e60cd7 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -540,6 +540,46 @@ tlmm: pinctrl@500000 {
 			#interrupt-cells = <2>;
 			#gpio-cells = <2>;
 
+			sdc2_off_state: sdc2-off-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_on_state: sdc2-on-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
 			qup_i2c0_default: qup-i2c0-default-state {
 				pins = "gpio0", "gpio1";
 				function = "qup00";
@@ -630,6 +670,48 @@ rpm_msg_ram: sram@45f0000 {
 			reg = <0 0x045f0000 0 0x7000>;
 		};
 
+		sdhc_2: sdhci@4784000 {
+			compatible = "qcom,sm6375-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x04784000 0 0x1000>;
+
+			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC2_BCR>;
+			iommus = <&apps_smmu 0x40 0x0>;
+
+			pinctrl-0 = <&sdc2_on_state>;
+			pinctrl-1 = <&sdc2_off_state>;
+			pinctrl-names = "default", "sleep";
+
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+			power-domains = <&rpmpd SM6375_VDDCX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+			bus-width = <4>;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+				};
+			};
+		};
+
 		gpi_dma0: dma-controller@4a00000 {
 			compatible = "qcom,sm6375-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x04a00000 0 0x60000>;
-- 
2.38.1

