Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CD369C7E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjBTJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjBTJpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:45:32 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0DE126F3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:45:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f18so933445lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0kWDJSyFXhoqhtVDryegyaMD2Gwkx9kCIIeoVusCoU=;
        b=pnLrGaFhBAUrtty4Njx7FfBEgm9LK+iQdaAGiojCSogmQ8bNSIWC7nMvkxpsr9CIB4
         C56REqRvkarzyT9SQgt2t8LJDCURyGjIqBQKeOzV7tnRmh97iAAZsQF0KrYkslzxzxil
         /tRCzBT6SPYqa6RPVJrHAeG7zCBS0DmaDn/gl9jteLeqd+EWfv9U5KT5Bnekuq4UwYXN
         8ftKN9JLPioE34pPMgfh/oFqbuChxniBLQBHl7OALYXADHkyLxEuZldzbWYDXggTciFR
         Rp94v0cOqEZrYj582Lohs13cAdVTQIGAePTQ49QP1L1wIY8nP2vODCdeo8+A//1oFZ3d
         lm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0kWDJSyFXhoqhtVDryegyaMD2Gwkx9kCIIeoVusCoU=;
        b=n3ai527nZl72iYYTpsO1RhFly7qoSvygNF1Eaq4qKH362ti5LxvUIj64o67xGx+rZp
         MF2983jeRh7stf3jrYhjcaNQIdn++guBKYNSxs0GiwdsQ4F2hvCVCRjMa6I+nR66J84q
         EN4i0XqsLqB1oJmA7K1/3jrlZTXHXdIFgRsF5fdwBEaF/iw7hsJhPA+lZJuw9tjYou1k
         kcm1dpa/9R6+53Hq6rf5jDQ1LVXDbFPQA+/5TGlkBSPiLqiWSGGsouQPRhLlxbHoySxg
         2YesmoTqg+En3TD4bNXqxGKsB1tnZ8xGdQx495QQqAfWMA8+krZ5wb+u3gC7rt/h5Y9c
         SRWQ==
X-Gm-Message-State: AO0yUKUITlHsYTeKGHXM9NzIPKCgRGSOka0tr5swdXlHZ6pd0c3fW8dz
        qwNFA8XDm5cEci1VcqvgeR4T5Q==
X-Google-Smtp-Source: AK7set9LU88u3JP+xz+mbWUX19DqWDUAD3ymljrEIU8K39bE3GFD61cSgG0T7e62aKTsVRQ+pS9XsA==
X-Received: by 2002:a19:5216:0:b0:4d8:8ad1:a05e with SMTP id m22-20020a195216000000b004d88ad1a05emr481805lfb.52.1676886327010;
        Mon, 20 Feb 2023 01:45:27 -0800 (PST)
Received: from [192.168.1.101] (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id q14-20020ac246ee000000b004d6ebbad989sm1475750lfo.1.2023.02.20.01.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 01:45:26 -0800 (PST)
Message-ID: <42f7d53b-a922-760a-4be2-7498ea0d560a@linaro.org>
Date:   Mon, 20 Feb 2023 10:45:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8996: move WCD9335 audio codec
 to boards
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220094339.47370-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230220094339.47370-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.02.2023 10:43, Krzysztof Kozlowski wrote:
> The WCD9335 audio codec on Slimbus is a property of a board, not SoC,
> thus it should not be present in MSM8996 DTSI.  Keep it in specific
> boards, so it won't appear incomplete in the boards not having it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dts   | 56 +++++++++++++----
>  .../boot/dts/qcom/msm8996-oneplus-common.dtsi | 56 +++++++++++++----
>  .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  | 60 ++++++++++++++-----
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         | 30 +---------
>  4 files changed, 135 insertions(+), 67 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> index fe6c415e8229..ce189dea2760 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> @@ -974,6 +974,50 @@ dai@2 {
>  	};
>  };
>  
> +&slim_msm {
> +	status = "okay";
> +
> +	slim@1 {
> +		reg = <1>;
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		tasha_ifd: tas-ifd@0,0 {
> +			compatible = "slim217,1a0";
> +			reg = <0 0>;
> +		};
> +
> +		wcd9335: codec@1,0 {
> +			compatible = "slim217,1a0";
> +			reg = <1 0>;
> +
> +			clock-names = "mclk", "slimbus";
> +			clocks = <&div1_mclk>,
> +				 <&rpmcc RPM_SMD_BB_CLK1>;
> +			interrupt-parent = <&tlmm>;
> +			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
> +				     <53 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "intr1", "intr2";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
> +			pinctrl-names = "default";
> +
> +			reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> +			slim-ifc-dev = <&tasha_ifd>;
> +
> +			#sound-dai-cells = <1>;
> +
> +			vdd-buck-supply = <&vreg_s4a_1p8>;
> +			vdd-buck-sido-supply = <&vreg_s4a_1p8>;
> +			vdd-tx-supply = <&vreg_s4a_1p8>;
> +			vdd-rx-supply = <&vreg_s4a_1p8>;
> +			vdd-io-supply = <&vreg_s4a_1p8>;
> +		};
> +	};
> +};
> +
>  &sound {
>  	compatible = "qcom,apq8096-sndcard";
>  	model = "DB820c";
> @@ -1101,15 +1145,3 @@ &usb3phy {
>  &venus {
>  	status = "okay";
>  };
> -
> -&wcd9335 {
> -	clock-names = "mclk", "slimbus";
> -	clocks = <&div1_mclk>,
> -		 <&rpmcc RPM_SMD_BB_CLK1>;
> -
> -	vdd-buck-supply = <&vreg_s4a_1p8>;
> -	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
> -	vdd-tx-supply = <&vreg_s4a_1p8>;
> -	vdd-rx-supply = <&vreg_s4a_1p8>;
> -	vdd-io-supply = <&vreg_s4a_1p8>;
> -};
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
> index 2994337c6046..104deaee74e5 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
> @@ -504,6 +504,50 @@ vreg_l32a_1p8: l32 {
>  	};
>  };
>  
> +&slim_msm {
> +	status = "okay";
> +
> +	slim@1 {
> +		reg = <1>;
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		tasha_ifd: tas-ifd@0,0 {
> +			compatible = "slim217,1a0";
> +			reg = <0 0>;
> +		};
> +
> +		wcd9335: codec@1,0 {
> +			compatible = "slim217,1a0";
> +			reg = <1 0>;
> +
> +			clock-names = "mclk", "slimbus";
> +			clocks = <&div1_mclk>,
> +				 <&rpmcc RPM_SMD_BB_CLK1>;
> +			interrupt-parent = <&tlmm>;
> +			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
> +				     <53 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "intr1", "intr2";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
> +			pinctrl-names = "default";
> +
> +			reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> +			slim-ifc-dev = <&tasha_ifd>;
> +
> +			#sound-dai-cells = <1>;
> +
> +			vdd-buck-supply = <&vreg_s4a_1p8>;
> +			vdd-buck-sido-supply = <&vreg_s4a_1p8>;
> +			vdd-tx-supply = <&vreg_s4a_1p8>;
> +			vdd-rx-supply = <&vreg_s4a_1p8>;
> +			vdd-io-supply = <&vreg_s4a_1p8>;
> +		};
> +	};
> +};
> +
>  &slpi_pil {
>  	status = "okay";
>  };
> @@ -772,15 +816,3 @@ &usb3_dwc3 {
>  &venus {
>  	status = "okay";
>  };
> -
> -&wcd9335 {
> -	clock-names = "mclk", "slimbus";
> -	clocks = <&div1_mclk>,
> -		 <&rpmcc RPM_SMD_BB_CLK1>;
> -
> -	vdd-buck-supply = <&vreg_s4a_1p8>;
> -	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
> -	vdd-tx-supply = <&vreg_s4a_1p8>;
> -	vdd-rx-supply = <&vreg_s4a_1p8>;
> -	vdd-io-supply = <&vreg_s4a_1p8>;
> -};
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> index 2acfed28e3cb..446b1d23dec0 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> @@ -337,6 +337,52 @@ led@3 {
>  	};
>  };
>  
> +&slim_msm {
> +	status = "okay";
> +
> +	slim@1 {
> +		reg = <1>;
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		tasha_ifd: tas-ifd@0,0 {
> +			compatible = "slim217,1a0";
> +			reg = <0 0>;
> +		};
> +
> +		wcd9335: codec@1,0 {
> +			compatible = "slim217,1a0";
> +			reg = <1 0>;
> +
> +			clock-names = "mclk", "slimbus";
> +			clocks = <&divclk1_cdc>,
> +				 <&rpmcc RPM_SMD_BB_CLK1>;
> +			interrupt-parent = <&tlmm>;
> +			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
> +				     <53 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "intr1", "intr2";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
> +			pinctrl-names = "default";
> +
> +			reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> +			slim-ifc-dev = <&tasha_ifd>;
> +
> +			#sound-dai-cells = <1>;
> +
> +			vdd-buck-supply = <&vreg_s4a_1p8>;
> +			vdd-buck-sido-supply = <&vreg_s4a_1p8>;
> +			vdd-rx-supply = <&vreg_s4a_1p8>;
> +			vdd-tx-supply = <&vreg_s4a_1p8>;
> +			vdd-vbat-supply = <&vph_pwr>;
> +			vdd-micbias-supply = <&vph_pwr_bbyp>;
> +			vdd-io-supply = <&vreg_s4a_1p8>;
> +		};
> +	};
> +};
> +
>  &slpi_pil {
>  	status = "okay";
>  
> @@ -395,20 +441,6 @@ &venus {
>  	status = "okay";
>  };
>  
> -&wcd9335 {
> -	clock-names = "mclk", "slimbus";
> -	clocks = <&divclk1_cdc>,
> -		 <&rpmcc RPM_SMD_BB_CLK1>;
> -
> -	vdd-buck-supply = <&vreg_s4a_1p8>;
> -	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
> -	vdd-rx-supply = <&vreg_s4a_1p8>;
> -	vdd-tx-supply = <&vreg_s4a_1p8>;
> -	vdd-vbat-supply = <&vph_pwr>;
> -	vdd-micbias-supply = <&vph_pwr_bbyp>;
> -	vdd-io-supply = <&vreg_s4a_1p8>;
> -};
> -
>  &rpm_requests {
>  	regulators-0 {
>  		compatible = "qcom,rpm-pm8994-regulators";
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 6f180a8efe77..dfc7153c9d8a 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -3383,36 +3383,8 @@ slim_msm: slim-ngd@91c0000 {
>  			dma-names = "rx", "tx";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			slim@1 {
> -				reg = <1>;
> -				#address-cells = <2>;
> -				#size-cells = <0>;
> -
> -				tasha_ifd: tas-ifd@0,0 {
> -					compatible = "slim217,1a0";
> -					reg = <0 0>;
> -				};
> -
> -				wcd9335: codec@1,0 {
> -					pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
> -					pinctrl-names = "default";
> -
> -					compatible = "slim217,1a0";
> -					reg = <1 0>;
>  
> -					interrupt-parent = <&tlmm>;
> -					interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
> -						     <53 IRQ_TYPE_LEVEL_HIGH>;
> -					interrupt-names = "intr1", "intr2";
> -					interrupt-controller;
> -					#interrupt-cells = <1>;
> -					reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> -
> -					slim-ifc-dev = <&tasha_ifd>;
> -
> -					#sound-dai-cells = <1>;
> -				};
> -			};
> +			status = "disabled";
>  		};
>  
>  		adsp_pil: remoteproc@9300000 {
