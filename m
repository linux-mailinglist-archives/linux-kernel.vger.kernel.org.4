Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9A56C8DE0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjCYMKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjCYMKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:10:37 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09721448E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:10:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o20so1362851ljp.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679746229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVGqt6VEyJGwz3htg/C68+1h2NnUjj4RaZCRVsv0IAA=;
        b=Q9EVR+hO4aQ+2vUQMj7C18tdf43Tc6vOvpy+207V3Fo6TPUIo/nt9GNWWFjp5qrFt/
         tiLFrfCFLw+j3ao8ZUvSdpxYue10hnzoXmX6G+LbhoqFOu1uB4joxXxVl/Vx3i7R9QHq
         8hbKjgj5l2pT+DhM9rVKwVvn3x+ChJkAmC64wompE51A+YjCuv0VXZGw0gVb7oad8MoV
         InLKYP1NyedGeJf9kmkutGtoFCKtDzedDmQs/W0WbrNHl4xBd+afUswdFKzFugY0erXq
         8/JgsdzGXtpY7pNR60lYLH6i5No6tygNhkc+2rxSScur4kSRInp3RNPR3QDZ3niRV67r
         0tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679746229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVGqt6VEyJGwz3htg/C68+1h2NnUjj4RaZCRVsv0IAA=;
        b=OnAtFv/dBwbv3lxUepWo+IJ2kcsrqGaOIcw9vzQJKAGj6wSH/YaGli6XlgMpzBgNbY
         ugeZfoywfBeFAMN0kB2MgmnMctrOGKb4n/ozAPQC0bHL7RGDdQTrQZXzfS6MwBj8hEJo
         U3BWu6a7aEnFVSM5l4vkO9lc4+SkjWaZDag3ssV6wiq+mLDk/CD+eO7dtcZB/w8QrlOH
         bUXiow95MwlgDr1Oe8kyfHrzgPF6G+MSY7Sl6U1cuyV5Q3PeuDDJB+2UsbDhY6oKwM2J
         dMvH+rRSLHVEwJX3ivqBRs6xOfXSf03BqXtuMYm5DbH7q7d/0JrTbCfPt1navxxOls+K
         Wq+g==
X-Gm-Message-State: AAQBX9dDFui5K9XVt+bAZ4ezX1MWRlqT/UCUYJjzZvkt+bsMQLmdUziU
        UUqusMM+yTBkkd0VaXY5zlyXGA==
X-Google-Smtp-Source: AKy350YLQk9DqR3b7EcLAJZSBsKtulaFFSmc9tvltIXasa9ZUyDknBcGIS4ZKN8lSvJiZOV2uOa2ew==
X-Received: by 2002:a2e:860b:0:b0:299:ac49:46da with SMTP id a11-20020a2e860b000000b00299ac4946damr1901871lji.42.1679746229050;
        Sat, 25 Mar 2023 05:10:29 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id u14-20020a2e854e000000b00299ab2475ebsm3808685ljj.1.2023.03.25.05.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 05:10:28 -0700 (PDT)
Message-ID: <95a3957a-5f6a-4a6b-1a5b-e2d3b8c81c2b@linaro.org>
Date:   Sat, 25 Mar 2023 13:10:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/4] arm64: dts: msm8953: Pad regs to 8 digits
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230325112852.18841-1-a39.skl@gmail.com>
 <20230325112852.18841-4-a39.skl@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230325112852.18841-4-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.03.2023 12:28, Adam Skladowski wrote:
> Follow other dtses and pad regs to 8 digits.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 98 +++++++++++++--------------
>  1 file changed, 49 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 0a1bf1058cbf..684668170353 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -350,12 +350,12 @@ soc: soc@0 {
>  
>  		rpm_msg_ram: sram@60000 {
>  			compatible = "qcom,rpm-msg-ram";
> -			reg = <0x60000 0x8000>;
> +			reg = <0x00060000 0x8000>;
>  		};
>  
>  		hsusb_phy: phy@79000 {
>  			compatible = "qcom,msm8953-qusb2-phy";
> -			reg = <0x79000 0x180>;
> +			reg = <0x00079000 0x180>;
>  			#phy-cells = <0>;
>  
>  			clocks = <&gcc GCC_USB_PHY_CFG_AHB_CLK>,
> @@ -378,8 +378,8 @@ rng@e3000 {
>  
>  		tsens0: thermal-sensor@4a9000 {
>  			compatible = "qcom,msm8953-tsens", "qcom,tsens-v2";
> -			reg = <0x4a9000 0x1000>, /* TM */
> -			      <0x4a8000 0x1000>; /* SROT */
> +			reg = <0x004a9000 0x1000>, /* TM */
> +			      <0x004a8000 0x1000>; /* SROT */
>  			#qcom,sensors = <16>;
>  			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>;
> @@ -389,12 +389,12 @@ tsens0: thermal-sensor@4a9000 {
>  
>  		restart@4ab000 {
>  			compatible = "qcom,pshold";
> -			reg = <0x4ab000 0x4>;
> +			reg = <0x004ab000 0x4>;
>  		};
>  
>  		tlmm: pinctrl@1000000 {
>  			compatible = "qcom,msm8953-pinctrl";
> -			reg = <0x1000000 0x300000>;
> +			reg = <0x01000000 0x300000>;
>  			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			gpio-ranges = <&tlmm 0 0 142>;
> @@ -634,7 +634,7 @@ i2c_8_sleep: i2c-8-sleep-state {
>  
>  		gcc: clock-controller@1800000 {
>  			compatible = "qcom,gcc-msm8953";
> -			reg = <0x1800000 0x80000>;
> +			reg = <0x01800000 0x80000>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> @@ -654,25 +654,25 @@ gcc: clock-controller@1800000 {
>  
>  		tcsr_mutex: hwlock@1905000 {
>  			compatible = "qcom,tcsr-mutex";
> -			reg = <0x1905000 0x20000>;
> +			reg = <0x01905000 0x20000>;
>  			#hwlock-cells = <1>;
>  		};
>  
>  		tcsr: syscon@1937000 {
>  			compatible = "qcom,tcsr-msm8953", "syscon";
> -			reg = <0x1937000 0x30000>;
> +			reg = <0x01937000 0x30000>;
>  		};
>  
>  		tcsr_phy_clk_scheme_sel: syscon@193f044 {
>  			compatible = "qcom,tcsr-msm8953", "syscon";
> -			reg = <0x193f044 0x4>;
> +			reg = <0x0193f044 0x4>;
>  		};
>  
>  		mdss: display-subsystem@1a00000 {
>  			compatible = "qcom,mdss";
>  
> -			reg = <0x1a00000 0x1000>,
> -			      <0x1ab0000 0x1040>;
> +			reg = <0x01a00000 0x1000>,
> +			      <0x01ab0000 0x1040>;
>  			reg-names = "mdss_phys",
>  				    "vbif_phys";
>  
> @@ -699,7 +699,7 @@ mdss: display-subsystem@1a00000 {
>  
>  			mdp: display-controller@1a01000 {
>  				compatible = "qcom,msm8953-mdp5", "qcom,mdp5";
> -				reg = <0x1a01000 0x89000>;
> +				reg = <0x01a01000 0x89000>;
>  				reg-names = "mdp_phys";
>  
>  				interrupt-parent = <&mdss>;
> @@ -740,7 +740,7 @@ mdp5_intf2_out: endpoint {
>  
>  			dsi0: dsi@1a94000 {
>  				compatible = "qcom,msm8953-dsi-ctrl", "qcom,mdss-dsi-ctrl";
> -				reg = <0x1a94000 0x400>;
> +				reg = <0x01a94000 0x400>;
>  				reg-names = "dsi_ctrl";
>  
>  				interrupt-parent = <&mdss>;
> @@ -792,9 +792,9 @@ dsi0_out: endpoint {
>  
>  			dsi0_phy: phy@1a94400 {
>  				compatible = "qcom,dsi-phy-14nm-8953";
> -				reg = <0x1a94400 0x100>,
> -				      <0x1a94500 0x300>,
> -				      <0x1a94800 0x188>;
> +				reg = <0x01a94400 0x100>,
> +				      <0x01a94500 0x300>,
> +				      <0x01a94800 0x188>;
>  				reg-names = "dsi_phy",
>  					    "dsi_phy_lane",
>  					    "dsi_pll";
> @@ -810,7 +810,7 @@ dsi0_phy: phy@1a94400 {
>  
>  			dsi1: dsi@1a96000 {
>  				compatible = "qcom,msm8953-dsi-ctrl", "qcom,mdss-dsi-ctrl";
> -				reg = <0x1a96000 0x400>;
> +				reg = <0x01a96000 0x400>;
>  				reg-names = "dsi_ctrl";
>  
>  				interrupt-parent = <&mdss>;
> @@ -859,9 +859,9 @@ dsi1_out: endpoint {
>  
>  			dsi1_phy: phy@1a96400 {
>  				compatible = "qcom,dsi-phy-14nm-8953";
> -				reg = <0x1a96400 0x100>,
> -				      <0x1a96500 0x300>,
> -				      <0x1a96800 0x188>;
> +				reg = <0x01a96400 0x100>,
> +				      <0x01a96500 0x300>,
> +				      <0x01a96800 0x188>;
>  				reg-names = "dsi_phy",
>  					    "dsi_phy_lane",
>  					    "dsi_pll";
> @@ -878,7 +878,7 @@ dsi1_phy: phy@1a96400 {
>  
>  		apps_iommu: iommu@1e00000 {
>  			compatible = "qcom,msm8953-iommu", "qcom,msm-iommu-v1";
> -			ranges  = <0 0x1e20000 0x20000>;
> +			ranges  = <0 0x01e20000 0x20000>;
>  
>  			clocks = <&gcc GCC_SMMU_CFG_CLK>,
>  				 <&gcc GCC_APSS_TCU_ASYNC_CLK>;
> @@ -914,11 +914,11 @@ iommu-ctx@16000 {
>  
>  		spmi_bus: spmi@200f000 {
>  			compatible = "qcom,spmi-pmic-arb";
> -			reg = <0x200f000 0x1000>,
> -			      <0x2400000 0x800000>,
> -			      <0x2c00000 0x800000>,
> -			      <0x3800000 0x200000>,
> -			      <0x200a000 0x2100>;
> +			reg = <0x0200f000 0x1000>,
> +			      <0x02400000 0x800000>,
> +			      <0x02c00000 0x800000>,
> +			      <0x03800000 0x200000>,
> +			      <0x0200a000 0x2100>;
>  			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>  			interrupt-names = "periph_irq";
>  			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> @@ -933,7 +933,7 @@ spmi_bus: spmi@200f000 {
>  
>  		usb3: usb@70f8800 {
>  			compatible = "qcom,msm8953-dwc3", "qcom,dwc3";
> -			reg = <0x70f8800 0x400>;
> +			reg = <0x070f8800 0x400>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -983,7 +983,7 @@ usb3_dwc3: usb@7000000 {
>  		sdhc_1: mmc@7824900 {
>  			compatible = "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4";
>  
> -			reg = <0x7824900 0x500>, <0x7824000 0x800>;
> +			reg = <0x07824900 0x500>, <0x07824000 0x800>;
>  			reg-names = "hc", "core";
>  
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> @@ -1043,7 +1043,7 @@ opp-384000000 {
>  		sdhc_2: mmc@7864900 {
>  			compatible = "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4";
>  
> -			reg = <0x7864900 0x500>, <0x7864000 0x800>;
> +			reg = <0x07864900 0x500>, <0x07864000 0x800>;
>  			reg-names = "hc", "core";
>  
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> @@ -1098,7 +1098,7 @@ opp-200000000 {
>  
>  		uart_0: serial@78af000 {
>  			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> -			reg = <0x78af000 0x200>;
> +			reg = <0x078af000 0x200>;
>  			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
>  				 <&gcc GCC_BLSP1_AHB_CLK>;
> @@ -1109,7 +1109,7 @@ uart_0: serial@78af000 {
>  
>  		i2c_1: i2c@78b5000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
> -			reg = <0x78b5000 0x600>;
> +			reg = <0x078b5000 0x600>;
>  			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "iface";
>  			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>,
> @@ -1127,7 +1127,7 @@ i2c_1: i2c@78b5000 {
>  
>  		i2c_2: i2c@78b6000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
> -			reg = <0x78b6000 0x600>;
> +			reg = <0x078b6000 0x600>;
>  			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "iface";
>  			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
> @@ -1145,7 +1145,7 @@ i2c_2: i2c@78b6000 {
>  
>  		i2c_3: i2c@78b7000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
> -			reg = <0x78b7000 0x600>;
> +			reg = <0x078b7000 0x600>;
>  			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "iface";
>  			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
> @@ -1162,7 +1162,7 @@ i2c_3: i2c@78b7000 {
>  
>  		i2c_4: i2c@78b8000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
> -			reg = <0x78b8000 0x600>;
> +			reg = <0x078b8000 0x600>;
>  			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "iface";
>  			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
> @@ -1179,7 +1179,7 @@ i2c_4: i2c@78b8000 {
>  
>  		i2c_5: i2c@7af5000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
> -			reg = <0x7af5000 0x600>;
> +			reg = <0x07af5000 0x600>;
>  			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "iface";
>  			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
> @@ -1196,7 +1196,7 @@ i2c_5: i2c@7af5000 {
>  
>  		i2c_6: i2c@7af6000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
> -			reg = <0x7af6000 0x600>;
> +			reg = <0x07af6000 0x600>;
>  			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "iface";
>  			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>,
> @@ -1213,7 +1213,7 @@ i2c_6: i2c@7af6000 {
>  
>  		i2c_7: i2c@7af7000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
> -			reg = <0x7af7000 0x600>;
> +			reg = <0x07af7000 0x600>;
>  			interrupts = <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "iface";
>  			clocks = <&gcc GCC_BLSP2_QUP3_I2C_APPS_CLK>,
> @@ -1230,7 +1230,7 @@ i2c_7: i2c@7af7000 {
>  
>  		i2c_8: i2c@7af8000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
> -			reg = <0x7af8000 0x600>;
> +			reg = <0x07af8000 0x600>;
>  			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "iface";
>  			clocks = <&gcc GCC_BLSP2_QUP4_I2C_APPS_CLK>,
> @@ -1254,13 +1254,13 @@ intc: interrupt-controller@b000000 {
>  
>  		apcs: mailbox@b011000 {
>  			compatible = "qcom,msm8953-apcs-kpss-global", "syscon";
> -			reg = <0xb011000 0x1000>;
> +			reg = <0x0b011000 0x1000>;
>  			#mbox-cells = <1>;
>  		};
>  
>  		timer@b120000 {
>  			compatible = "arm,armv7-timer-mem";
> -			reg = <0xb120000 0x1000>;
> +			reg = <0x0b120000 0x1000>;
>  			#address-cells = <0x01>;
>  			#size-cells = <0x01>;
>  			ranges;
> @@ -1269,49 +1269,49 @@ frame@b121000 {
>  				frame-number = <0>;
>  				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0xb121000 0x1000>,
> -				      <0xb122000 0x1000>;
> +				reg = <0x0b121000 0x1000>,
> +				      <0x0b122000 0x1000>;
>  			};
>  
>  			frame@b123000 {
>  				frame-number = <1>;
>  				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0xb123000 0x1000>;
> +				reg = <0x0b123000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@b124000 {
>  				frame-number = <2>;
>  				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0xb124000 0x1000>;
> +				reg = <0x0b124000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@b125000 {
>  				frame-number = <3>;
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0xb125000 0x1000>;
> +				reg = <0x0b125000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@b126000 {
>  				frame-number = <4>;
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0xb126000 0x1000>;
> +				reg = <0x0b126000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@b127000 {
>  				frame-number = <5>;
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0xb127000 0x1000>;
> +				reg = <0x0b127000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@b128000 {
>  				frame-number = <6>;
>  				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0xb128000 0x1000>;
> +				reg = <0x0b128000 0x1000>;
>  				status = "disabled";
>  			};
>  		};
