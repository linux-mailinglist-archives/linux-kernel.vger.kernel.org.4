Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CBF62A053
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKOR2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiKOR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:28:39 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0522315B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:28:38 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s8so8383391lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5Zsxhl1TYkSTxNL/AaKGZ9xhkYvd+wyYJFAyYon0sM=;
        b=BMTj5Dak6W+WJH+TKdUOI2FV0SSmcOlhtNa8pLoMKG7SvhOIUFobG47saheBFT4egX
         abIUbjO5j64XvRfZbNDNZPJ5inwwZYFFrryFf5rC/ExXxi6+SdSuvfONWR3edjZFZSML
         JhS4nbHm0NAGBq71Qy909MdqoaLMuA8m+uql90no3Un+RIZBUPoU/6FL/EFI26sX17fW
         WZklZFyEiqKM69Ra9hE75X5+EHP55jo3WebwSjkVCDUkpixxcW2UBuTq1OCQb02ITFle
         sY5BBizcxCb2OlhHDatRvm/hEDPg3y2ZNS6MIsOJkJcjk/LtYJuqABIWKkfj+rygshhC
         pxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5Zsxhl1TYkSTxNL/AaKGZ9xhkYvd+wyYJFAyYon0sM=;
        b=T/bcEYG16YTnBzyGHKJh3m0m9zBuGNN3oZEJWfx5188ao1oQlp5X2A/rLrBRm8hl9a
         Mo2LnDP4MOLJL6lhjflkV0+Gq60OfsM/j+C31d5EFuY4/twOtZMwMTTt9Z70OWZyFOsJ
         1VtyfOide+/7A90zCmVBWZn+Q3GXQTt5GGF+nr6VWeXNaYg/c8YaVbUaBOFPm5A4mNLH
         Cz49PpYXBEK51z1Zpvcq9v/PNrzcamMR5W9iHHxJ2Db03GOSMyg5OAxzGP/bI3pEje/0
         UQ9oFJZ9G74xo/meQjZIRwSuSEaM5PWPVY4kUZdA6fAawu8LtA/RpiQ1VoHeJizmnWlW
         cs0Q==
X-Gm-Message-State: ANoB5pkJ9hJdPvCQDA284PWMPvt0/Hj4YFsT7NaysemTx87jDlFXBhor
        R7ZJyuplFFGqIieOnW3xcaqlVg==
X-Google-Smtp-Source: AA0mqf4HHR+TSuVMQPzoZGW2Uia1qZKNs1X6DTvzzrqBJa7wf2ZAxEgAOg8M2Hp7Xiecxvd2tj0YDw==
X-Received: by 2002:a05:6512:312c:b0:4a2:1d18:45d8 with SMTP id p12-20020a056512312c00b004a21d1845d8mr5855145lfd.330.1668533316803;
        Tue, 15 Nov 2022 09:28:36 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id b42-20020a0565120baa00b00496d3e6b131sm2261511lfv.234.2022.11.15.09.28.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 09:28:36 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH 2/4] arm64: dts: qcom: sm8350: Add SDHCI2
Date:   Tue, 15 Nov 2022 18:28:26 +0100
Message-Id: <20221115172828.14372-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221115172828.14372-1-konrad.dybcio@linaro.org>
References: <20221115172828.14372-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and configure the SDHCI host responsible for (mostly) SD Card and
its corresponding pins' sleep states.

The setup is *literally* 1:1 with 8450 (bar SDR50/104 may not be
broken).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 79 ++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 552c0da3c479..9a118112facb 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1761,6 +1761,46 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 204>;
 			wakeup-parent = <&pdc>;
 
+			sdc2_default_state: sdc2-default-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <16>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <16>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_sleep_state: sdc2-sleep-state {
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
 			qup_uart3_default_state: qup-uart3-default-state {
 				rx-pins {
 					pins = "gpio18";
@@ -2329,6 +2369,45 @@ compute-cb@8 {
 			};
 		};
 
+		sdhc_2: sdhci@8804000 {
+			compatible = "qcom,sm8350-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08804000 0 0x1000>;
+
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC2_BCR>;
+			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
+			interconnect-names = "sdhc-ddr","cpu-sdhc";
+			iommus = <&apps_smmu 0x4a0 0x0>;
+			power-domains = <&rpmhpd SM8350_CX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+			bus-width = <4>;
+			dma-coherent;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
 		usb_1_hsphy: phy@88e3000 {
 			compatible = "qcom,sm8350-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
-- 
2.38.1

