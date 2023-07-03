Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308BC745860
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjGCJai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:30:35 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EC412E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:30:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so6598121e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688376627; x=1690968627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W36AD8V7qIokAbh1GeKq+01IJUQx49r60Ksbt1eElPA=;
        b=I6hYeNhz05YPQHZzgl9MlzJhHpBqYAgFsuIc/3pDuTDtQAuKv9XEvuw5Y9mjus2a/D
         40jD1P9kDs4Odhx5z47aDrsCSDj882Gy5acxtWkBo2mrBL3ffndNGE1xhSCKFKMhnb6X
         Aa/cPIFRbmBb8wJ1q/WaIoO7XUoX6oqTkkmbTadwimAcwwPBa6M8+F19IM+IHl+bEgS3
         UTMr1BjIj4NqZ7S3OC78/G903z4kjSOLYPZ7PaQSNy6GMYiVZLmzap6esczSyzsD25Kl
         x0ZFKKphv6mxScXiNMEZRMC/8TdFAqiYoHsJOh0k00y8IY3q7YcJ7jfL3ONTAlxtJ+zS
         CYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376627; x=1690968627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W36AD8V7qIokAbh1GeKq+01IJUQx49r60Ksbt1eElPA=;
        b=NBZ7G2OTtifa/RBF7qOnM2RuQRHcMIUDB5bqPn1yu6jvNIlt2HO79nvx/IyxhACMJb
         lCT8igInupViV/fjdyxBXjkU0lCw7+4perQf/sI8rklMygn/q5TDMFKTpxC0yIrqsPjE
         GOAbw+KXdUrMKjaELdRIs0YCcJHojlpt6GuiRDiqB545AedfXa15uJOQriTp5oVQQeb7
         5GrLfUSnekFi40O+U6TpQy1BgUCEVbCWQ0fFBT2JDq9QKzaIcMDXup9PT7K3CD/ZLVnR
         jF3UA0bYws8HaNRxuYamWpaPhrV4c2zFAocM1HijCx1/nunYFNvaNu6Onox5h7GnYJnl
         iTUg==
X-Gm-Message-State: ABy/qLagIIF1KQzUtG31tBI0ddnvS8n6cTvfB/mpByJphRPbPTvQWmpd
        iUEfFEPrLbkYeI2cy0yBivjwIQ==
X-Google-Smtp-Source: APBJJlFW39vBZBh6TYl0r5Bx+a1nodD78Ub3w8OV/EBuP4OH846wWlnaKkGjtVGfvQF2hHo/FAnUiA==
X-Received: by 2002:a05:6512:3494:b0:4f8:65ef:afcd with SMTP id v20-20020a056512349400b004f865efafcdmr5527346lfr.17.1688376626497;
        Mon, 03 Jul 2023 02:30:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id u4-20020ac248a4000000b004f873ca4139sm2962735lfg.71.2023.07.03.02.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 02:30:26 -0700 (PDT)
Message-ID: <e09af830-d114-7ee6-0cab-e6812bc10fd4@linaro.org>
Date:   Mon, 3 Jul 2023 11:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: minor whitespace cleanup around '='
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230702185051.43867-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230702185051.43867-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.07.2023 20:50, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi         |   8 +-
>  .../dts/qcom/msm8916-samsung-serranove.dts    |   6 +-
>  arch/arm64/boot/dts/qcom/msm8939.dtsi         |  14 +-
>  .../boot/dts/qcom/msm8953-xiaomi-daisy.dts    |   2 +-
>  .../boot/dts/qcom/msm8953-xiaomi-vince.dts    |   2 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |   6 +-
>  .../dts/qcom/msm8996pro-xiaomi-natrium.dts    |   2 +-
>  arch/arm64/boot/dts/qcom/msm8998.dtsi         |  18 +-
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/qcs404.dtsi          |   8 +-
>  arch/arm64/boot/dts/qcom/sa8540p.dtsi         |   2 +-
>  .../sc7280-herobrine-audio-rt5682-3mic.dtsi   |   2 +-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/sdm630.dtsi          |  10 +-
>  .../dts/qcom/sdm845-oneplus-enchilada.dts     |   2 +-
>  arch/arm64/boot/dts/qcom/sdx75.dtsi           |   4 +-
>  arch/arm64/boot/dts/qcom/sm6115.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          | 198 +++++++++---------
>  arch/arm64/boot/dts/qcom/sm8350.dtsi          | 196 ++++++++---------
>  arch/arm64/boot/dts/qcom/sm8450.dtsi          | 194 ++++++++---------
>  arch/arm64/boot/dts/qcom/sm8550.dtsi          | 196 ++++++++---------
>  22 files changed, 439 insertions(+), 439 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index 68839acbd613..00ed71936b47 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -794,10 +794,10 @@ frame@b128000 {
>  
>  		pcie1: pci@10000000 {
>  			compatible = "qcom,pcie-ipq8074";
> -			reg =  <0x10000000 0xf1d>,
> -			       <0x10000f20 0xa8>,
> -			       <0x00088000 0x2000>,
> -			       <0x10100000 0x1000>;
> +			reg = <0x10000000 0xf1d>,
> +			      <0x10000f20 0xa8>,
> +			      <0x00088000 0x2000>,
> +			      <0x10100000 0x1000>;
>  			reg-names = "dbi", "elbi", "parf", "config";
>  			device_type = "pci";
>  			linux,pci-domain = <1>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> index 15dc246e84e2..126e8b5cf49f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> @@ -219,9 +219,9 @@ magnetometer@2e {
>  		compatible = "yamaha,yas537";
>  		reg = <0x2e>;
>  
> -		mount-matrix =  "0",  "1",  "0",
> -				"1",  "0",  "0",
> -				"0",  "0", "-1";
> +		mount-matrix = "0",  "1",  "0",
> +			       "1",  "0",  "0",
> +			       "0",  "0", "-1";
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> index 895cafc11480..c4209e2d4b4e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> @@ -155,7 +155,7 @@ CPU7: cpu@3 {
>  
>  		idle-states {
>  			CPU_SLEEP_0: cpu-sleep-0 {
> -				compatible ="qcom,idle-state-spc", "arm,idle-state";
> +				compatible = "qcom,idle-state-spc", "arm,idle-state";
Will conflict with:

https://lore.kernel.org/linux-arm-msm/20230627-topic-more_bindings-v1-2-6b4b6cd081e5@linaro.org/

there are also a couple of entries with property =\n\t{n}[a-z]

Otherwise lgtm

Konrad
>  				entry-latency-us = <130>;
>  				exit-latency-us = <150>;
>  				min-residency-us = <2000>;
> @@ -1644,7 +1644,7 @@ sdhc_2: mmc@7864900 {
>  			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
>  				 <&gcc GCC_SDCC2_APPS_CLK>,
>  				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> -			clock-names =  "iface", "core", "xo";
> +			clock-names = "iface", "core", "xo";
>  			resets = <&gcc GCC_SDCC2_BCR>;
>  			pinctrl-0 = <&sdc2_default>;
>  			pinctrl-1 = <&sdc2_sleep>;
> @@ -1731,7 +1731,7 @@ blsp_i2c2: i2c@78b6000 {
>  			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
>  				 <&gcc GCC_BLSP1_AHB_CLK>;
> -			clock-names =  "core", "iface";
> +			clock-names = "core", "iface";
>  			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
>  			dma-names = "tx", "rx";
>  			pinctrl-0 = <&blsp_i2c2_default>;
> @@ -1765,7 +1765,7 @@ blsp_i2c3: i2c@78b7000 {
>  			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
>  				 <&gcc GCC_BLSP1_AHB_CLK>;
> -			clock-names =  "core", "iface";
> +			clock-names = "core", "iface";
>  			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
>  			dma-names = "tx", "rx";
>  			pinctrl-0 = <&blsp_i2c3_default>;
> @@ -1799,7 +1799,7 @@ blsp_i2c4: i2c@78b8000 {
>  			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
>  				 <&gcc GCC_BLSP1_AHB_CLK>;
> -			clock-names =  "core", "iface";
> +			clock-names = "core", "iface";
>  			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
>  			dma-names = "tx", "rx";
>  			pinctrl-0 = <&blsp_i2c4_default>;
> @@ -1833,7 +1833,7 @@ blsp_i2c5: i2c@78b9000 {
>  			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>,
>  				 <&gcc GCC_BLSP1_AHB_CLK>;
> -			clock-names =  "core", "iface";
> +			clock-names = "core", "iface";
>  			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
>  			dma-names = "tx", "rx";
>  			pinctrl-0 = <&blsp_i2c5_default>;
> @@ -1867,7 +1867,7 @@ blsp_i2c6: i2c@78ba000 {
>  			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
>  				 <&gcc GCC_BLSP1_AHB_CLK>;
> -			clock-names =  "core", "iface";
> +			clock-names = "core", "iface";
>  			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
>  			dma-names = "tx", "rx";
>  			pinctrl-0 = <&blsp_i2c6_default>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
> index 1d672e608653..790d19c99af1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
> @@ -17,7 +17,7 @@ / {
>  	compatible = "xiaomi,daisy", "qcom,msm8953";
>  	chassis-type = "handset";
>  	qcom,msm-id = <293 0>;
> -	qcom,board-id= <0x1000b 0x9>;
> +	qcom,board-id = <0x1000b 0x9>;
>  
>  	chosen {
>  		#address-cells = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
> index b5be55034fd3..0956c866d6cb 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
> @@ -20,7 +20,7 @@ / {
>  	compatible = "xiaomi,vince", "qcom,msm8953";
>  	chassis-type = "handset";
>  	qcom,msm-id = <293 0>;
> -	qcom,board-id= <0x1000b 0x08>;
> +	qcom,board-id = <0x1000b 0x08>;
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 0cb2d4f08c3a..f51bcd16fdca 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -1138,9 +1138,9 @@ mdss_dsi1_phy: phy@996400 {
>  
>  			mdss_hdmi: mdss_hdmi-tx@9a0000 {
>  				compatible = "qcom,mdss_hdmi-tx-8996";
> -				reg =	<0x009a0000 0x50c>,
> -					<0x00070000 0x6158>,
> -					<0x009e0000 0xfff>;
> +				reg = <0x009a0000 0x50c>,
> +				      <0x00070000 0x6158>,
> +				      <0x009e0000 0xfff>;
>  				reg-names = "core_physical",
>  					    "qfprom_physical",
>  					    "hdcp_physical";
> diff --git a/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dts b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dts
> index 7957c8823f0d..5e3fd1637f44 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dts
> @@ -106,7 +106,7 @@ &slpi_pil {
>  &sound {
>  	compatible = "qcom,apq8096-sndcard";
>  	model = "natrium";
> -	audio-routing =	"RX_BIAS", "MCLK";
> +	audio-routing = "RX_BIAS", "MCLK";
>  
>  	mm1-dai-link {
>  		link-name = "MultiMedia1";
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index f0e943ff0046..d5cb244d00d0 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -909,10 +909,10 @@ anoc2_smmu: iommu@16c0000 {
>  
>  		pcie0: pci@1c00000 {
>  			compatible = "qcom,pcie-msm8998", "qcom,pcie-msm8996";
> -			reg =	<0x01c00000 0x2000>,
> -				<0x1b000000 0xf1d>,
> -				<0x1b000f20 0xa8>,
> -				<0x1b100000 0x100000>;
> +			reg = <0x01c00000 0x2000>,
> +			      <0x1b000000 0xf1d>,
> +			      <0x1b000f20 0xa8>,
> +			      <0x1b100000 0x100000>;
>  			reg-names = "parf", "dbi", "elbi", "config";
>  			device_type = "pci";
>  			linux,pci-domain = <0>;
> @@ -2074,11 +2074,11 @@ sram@290000 {
>  
>  		spmi_bus: spmi@800f000 {
>  			compatible = "qcom,spmi-pmic-arb";
> -			reg =	<0x0800f000 0x1000>,
> -				<0x08400000 0x1000000>,
> -				<0x09400000 0x1000000>,
> -				<0x0a400000 0x220000>,
> -				<0x0800a000 0x3000>;
> +			reg = <0x0800f000 0x1000>,
> +			      <0x08400000 0x1000000>,
> +			      <0x09400000 0x1000000>,
> +			      <0x0a400000 0x220000>,
> +			      <0x0800a000 0x3000>;
>  			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>  			interrupt-names = "periph_irq";
>  			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> index 0ed11e80e5e2..1d1de156f8f0 100644
> --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> @@ -790,7 +790,7 @@ gpi_dma0: dma-controller@4a00000 {
>  				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
> -			dma-channels =  <10>;
> +			dma-channels = <10>;
>  			dma-channel-mask = <0x1f>;
>  			iommus = <&apps_smmu 0xf6 0x0>;
>  			#dma-cells = <3>;
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 972f753847e1..f2568aff14c8 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -1459,10 +1459,10 @@ glink-edge {
>  
>  		pcie: pci@10000000 {
>  			compatible = "qcom,pcie-qcs404";
> -			reg =  <0x10000000 0xf1d>,
> -			       <0x10000f20 0xa8>,
> -			       <0x07780000 0x2000>,
> -			       <0x10001000 0x2000>;
> +			reg = <0x10000000 0xf1d>,
> +			      <0x10000f20 0xa8>,
> +			      <0x07780000 0x2000>,
> +			      <0x10001000 0x2000>;
>  			reg-names = "dbi", "elbi", "parf", "config";
>  			device_type = "pci";
>  			linux,pci-domain = <0>;
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> index bacbdec56281..96b2c59ad02b 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> @@ -207,7 +207,7 @@ &pcie3a {
>  
>  	linux,pci-domain = <2>;
>  
> -	interrupts =  <GIC_SPI 567 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupts = <GIC_SPI 567 IRQ_TYPE_LEVEL_HIGH>;
>  	interrupt-names = "msi";
>  
>  	interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 541 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
> index 485f9942e128..a90c70b1b73e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
> @@ -13,7 +13,7 @@ sound: sound {
>  		compatible = "google,sc7280-herobrine";
>  		model = "sc7280-rt5682-max98360a-3mic";
>  
> -		audio-routing =	"VA DMIC0", "vdd-micb",
> +		audio-routing = "VA DMIC0", "vdd-micb",
>  				"VA DMIC1", "vdd-micb",
>  				"VA DMIC2", "vdd-micb",
>  				"VA DMIC3", "vdd-micb",
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index a0e8db8270e7..925428a5f6ae 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2449,7 +2449,7 @@ lpass_cpu: audio@3987000 {
>  				 <&apps_smmu 0x1821 0>,
>  				 <&apps_smmu 0x1832 0>;
>  
> -			power-domains =	<&rpmhpd SC7280_LCX>;
> +			power-domains = <&rpmhpd SC7280_LCX>;
>  			power-domain-names = "lcx";
>  			required-opps = <&rpmhpd_opp_nom>;
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> index be78a933d8eb..3c1314e12d08 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> @@ -2252,7 +2252,7 @@ opp-177000000 {
>  		};
>  
>  		gmu: gmu@2c6a000 {
> -			compatible="qcom,adreno-gmu-680.1", "qcom,adreno-gmu";
> +			compatible = "qcom,adreno-gmu-680.1", "qcom,adreno-gmu";
>  
>  			reg = <0 0x02c6a000 0 0x30000>,
>  			      <0 0x0b290000 0 0x10000>,
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index bba0f366ef03..759b3a5964cc 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -1196,11 +1196,11 @@ sram@290000 {
>  
>  		spmi_bus: spmi@800f000 {
>  			compatible = "qcom,spmi-pmic-arb";
> -			reg =	<0x0800f000 0x1000>,
> -				<0x08400000 0x1000000>,
> -				<0x09400000 0x1000000>,
> -				<0x0a400000 0x220000>,
> -				<0x0800a000 0x3000>;
> +			reg = <0x0800f000 0x1000>,
> +			      <0x08400000 0x1000000>,
> +			      <0x09400000 0x1000000>,
> +			      <0x0a400000 0x220000>,
> +			      <0x0800a000 0x3000>;
>  			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>  			interrupt-names = "periph_irq";
>  			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> index 623a826b18a3..62fe72ff3763 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> @@ -57,7 +57,7 @@ &pmi8998_charger {
>  
>  &sound {
>  	model = "OnePlus 6";
> -	audio-routing =	"RX_BIAS", "MCLK",
> +	audio-routing = "RX_BIAS", "MCLK",
>  			"AMIC2", "MIC BIAS2",
>  			"AMIC3", "MIC BIAS4",
>  			"AMIC4", "MIC BIAS1",
> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> index 21d5d55da5eb..7d39a615f4f7 100644
> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> @@ -484,14 +484,14 @@ qupv3_se1_2uart_active: qupv3-se1-2uart-active-state {
>  				tx-pins {
>  					pins = "gpio12";
>  					function = "qup_se1_l2_mira";
> -					drive-strength= <2>;
> +					drive-strength = <2>;
>  					bias-disable;
>  				};
>  
>  				rx-pins {
>  					pins = "gpio13";
>  					function = "qup_se1_l3_mira";
> -					drive-strength= <2>;
> +					drive-strength = <2>;
>  					bias-disable;
>  				};
>  			};
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 55118577bf92..7d30b504441a 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -1052,7 +1052,7 @@ gpi_dma0: dma-controller@4a00000 {
>  				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
> -			dma-channels =  <10>;
> +			dma-channels = <10>;
>  			dma-channel-mask = <0xf>;
>  			iommus = <&apps_smmu 0xf6 0x0>;
>  			#dma-cells = <3>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 1efa07f2caff..bd8b7b399156 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -3059,7 +3059,7 @@ in-ports {
>  				port@7 {
>  					reg = <7>;
>  					funnel_swao_in_funnel_merg: endpoint {
> -						remote-endpoint= <&funnel_merg_out_funnel_swao>;
> +						remote-endpoint = <&funnel_merg_out_funnel_swao>;
>  					};
>  				};
>  			};
> @@ -5298,104 +5298,104 @@ apps_smmu: iommu@15000000 {
>  			reg = <0 0x15000000 0 0x100000>;
>  			#iommu-cells = <2>;
>  			#global-interrupts = <2>;
> -			interrupts =    <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
>  		adsp: remoteproc@17300000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index ec451c616f3e..bdba349e0a2a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -3077,104 +3077,104 @@ apps_smmu: iommu@15000000 {
>  			reg = <0 0x15000000 0 0x100000>;
>  			#iommu-cells = <2>;
>  			#global-interrupts = <2>;
> -			interrupts =    <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
>  		adsp: remoteproc@17300000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 5cd7296c7660..1820d4327624 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -3810,103 +3810,103 @@ apps_smmu: iommu@15000000 {
>  			reg = <0 0x15000000 0 0x100000>;
>  			#iommu-cells = <2>;
>  			#global-interrupts = <1>;
> -			interrupts =    <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
>  		intc: interrupt-controller@17100000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 41d60af93692..6e8aba256931 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1600,7 +1600,7 @@ uart7: serial@a9c000 {
>  				pinctrl-0 = <&qup_uart7_default>;
>  				interrupts = <GIC_SPI 579 IRQ_TYPE_LEVEL_HIGH>;
>  				interconnect-names = "qup-core", "qup-config";
> -				interconnects =	<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
>  				status = "disabled";
>  			};
> @@ -3517,103 +3517,103 @@ apps_smmu: iommu@15000000 {
>  			reg = <0 0x15000000 0 0x100000>;
>  			#iommu-cells = <2>;
>  			#global-interrupts = <1>;
> -			interrupts =	<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
> -					<GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
>  		intc: interrupt-controller@17100000 {
