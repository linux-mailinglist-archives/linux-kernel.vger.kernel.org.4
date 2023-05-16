Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17697042CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjEPBWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEPBWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:22:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F892D66
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:22:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f38bea8be8so360863e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684200163; x=1686792163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZUmfin9A8hNGiBBOjTB9e2R9glJPnwDR5gTUtbZSiA=;
        b=JdcjEPIBnfl1YOktLWY4Dlm9DCvDYp0UjkYpMGCQEiwza0MbfhGlHlWPDAWVfD+2cW
         3pmSaNwjgqhwcu0OEQjvlCJ1G1/MzxIIXwPUjHjdk+GutfyOuQRDOzRkmKPEJ099oyae
         F+4JMeG/Hy6syDf2Xi0NF2xtB1b9F9ghTmOBFS4uAiem1I96ShIh50Z4fnfnRnFAkiEf
         k1rDRFlDuc8u3c/S7ybtNaO7dsGifbBJRcTxTnMT2jQu2idnI5hptbxIS2lCO13KkAod
         +sivemErXwjvCHnMkr0//9QQ7IStguoKtk51t7XxXNgTVDSeyB1GGyX+ehl5DgOmQvTQ
         oF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200163; x=1686792163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZUmfin9A8hNGiBBOjTB9e2R9glJPnwDR5gTUtbZSiA=;
        b=gNAfwVtPOzOyUOKz8TEo0/x9qTxMe8QgL5HEYr1VfpiFjtKTxWIxVN3Skn53pkQeXd
         vi+mORHR3CY1H1o0Y12H2A1GJ8dluHCZW15IR4Dg0eY9apwTsnaOvQEmkmm29mojGsLW
         K1q++Fr8jXtTerPByxwPw9MU0mikgZ96GnfayOj1T82q1uTE1khPYULju8c8Iv3+V9Od
         KY10Q0N6E4TjcgVUuUn80BnGbDY2MzPXcsVGdFBGOJvPUcEU4zntfvtJxT8pJHfCENB4
         5MmAWh5rFpLxRAgMeYUtCHUn7eC2fSExGC5dzCJ45dQc+0tjBFlRV4fwf/bmEo8olAzB
         X9Vw==
X-Gm-Message-State: AC+VfDxuYQCviV0PsGQ+9V2r1dANA8GaixaPFLLswQDcuGAI9nbErX1E
        QkEadgHgPyhH7b+CioFTDLzzxQ==
X-Google-Smtp-Source: ACHHUZ6zEhTpvW4dpkth4ZOToXLIvIJIWXLqONU3Vih6GcLSgDan3DxIV0QF2ktnqsHRVwEDlr4xow==
X-Received: by 2002:ac2:47f8:0:b0:4f3:78dd:8e0b with SMTP id b24-20020ac247f8000000b004f378dd8e0bmr2465642lfp.32.1684200163052;
        Mon, 15 May 2023 18:22:43 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id w20-20020a19c514000000b004f26d63f823sm1891577lfe.237.2023.05.15.18.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:22:42 -0700 (PDT)
Message-ID: <0855c1ea-2104-c7ab-e775-1340dac21c58@linaro.org>
Date:   Tue, 16 May 2023 03:22:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp: Add SDC2 and enable on
 CRD
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230509030136.1524860-1-quic_bjorande@quicinc.com>
 <20230509030136.1524860-2-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230509030136.1524860-2-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.05.2023 05:01, Bjorn Andersson wrote:
> The CRD has Micro SD slot, introduce the necessary DeviceTree nodes for
> enabling this.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 80 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi    | 39 +++++++++++
>  2 files changed, 119 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 5b25d54b9591..f83411e0e7f8 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -308,6 +308,13 @@ vreg_l1c: ldo1 {
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l6c: ldo6 {
> +			regulator-name = "vreg_l6c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>  		vreg_l7c: ldo7 {
>  			regulator-name = "vreg_l7c";
>  			regulator-min-microvolt = <2504000>;
> @@ -318,6 +325,13 @@ vreg_l7c: ldo7 {
>  						   RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l9c: ldo9 {
> +			regulator-name = "vreg_l9c";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
Generally I ask people to add the missing regulator-allow-set-load,
but in case of the RPMh driver, should we also consider allowing LPM?

> +		};
> +
>  		vreg_l13c: ldo13 {
>  			regulator-name = "vreg_l13c";
>  			regulator-min-microvolt = <3072000>;
> @@ -600,6 +614,18 @@ &remoteproc_nsp0 {
>  	status = "okay";
>  };
>  
> +&sdc2 {
> +	cd-gpios = <&tlmm 131 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default_state>;
> +	pinctrl-1 = <&sdc2_sleep_state>;
pinctrl-n
pinctrl-names

please
> +	vmmc-supply = <&vreg_l9c>;
> +	vqmmc-supply = <&vreg_l6c>;
> +	no-sdio;
> +	no-mmc;
> +	status = "okay";
> +};
> +
>  &uart17 {
>  	compatible = "qcom,geni-debug-uart";
>  
> @@ -842,6 +868,60 @@ wake-n-pins {
>  		};
>  	};
>  
> +	sdc2_default_state: sdc2-default-state {
> +		clk-pins {
> +			pins = "sdc2_clk";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +
> +		cmd-pins {
> +			pins = "sdc2_cmd";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +
> +		data-pins {
> +			pins = "sdc2_data";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +
> +		card-detect-pins {
> +			pins = "gpio131";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	sdc2_sleep_state: sdc2-sleep-state {
> +		clk-pins {
> +			pins = "sdc2_clk";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		cmd-pins {
> +			pins = "sdc2_cmd";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		data-pins {
> +			pins = "sdc2_data";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		card-detect-pins {
> +			pins = "gpio131";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
That's totally SoC-specific, modulo the CD pin which can have
its own separate node and label

> +
>  	tpad_default: tpad-default-state {
>  		int-n-pins {
>  			pins = "gpio182";
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 8fa9fbfe5d00..21dfb48d923c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -2815,6 +2815,45 @@ data-pins {
>  			};
>  		};
>  
> +		sdc2: mmc@8804000 {
> +			compatible = "qcom,sc8280xp-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface", "core", "xo";
> +			resets = <&gcc GCC_SDCC4_BCR>;
4?

> +			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
> +			interconnect-names = "sdhc-ddr","cpu-sdhc";
> +			iommus = <&apps_smmu 0x4e0 0x0>;
> +			power-domains = <&rpmhpd SC8280XP_CX>;
> +			operating-points-v2 = <&sdc2_opp_table>;
> +			bus-width = <4>;
> +			dma-coherent;
> +
> +			status = "disabled";
> +
> +			sdc2_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
You specified interconnects, but no bw values.. was that on purpose?

Other than these nits, lgtm
(generally, my dt sources don't even have sdhci to compare)

Konrad
> +				};
> +
> +				opp-202000000 {
> +					opp-hz = /bits/ 64 <202000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};
> +			};
> +		};
> +
>  		usb_0_qmpphy: phy@88eb000 {
>  			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
>  			reg = <0 0x088eb000 0 0x4000>;
