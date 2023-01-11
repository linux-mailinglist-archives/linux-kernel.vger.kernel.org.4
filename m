Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BA6665D91
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbjAKOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbjAKOTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:19:22 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA01A395
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:19:07 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id f20so16146740lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=negcME7L5mzW504DM5wehfUKj/rBMEPX2/Ij5qP2IFA=;
        b=uWgIbQtjTcvBrKQAsUApNwxI/zw6U+NukxmgEEEdPJv+W/DkbwbxhAw08+XPvMLeJu
         GqC78oUj4KNKHRDmL1l71ogzipW3eo9vjfbdntiqgTCgERuABh0f6vp2lyNgls5DngCs
         6LHxm6eSDf5QaZAnrGCBs8qi4wxQdzKq7Rm1YX4aOBc3eQdiTBvjDfZ7+KZSnUPApvCO
         BUWVFpiF0cFiit4kXwjjlFCO3zKahVBleIojcMYAn12bBSG7JASRvTP3llCSkysUK/BX
         O+w9Yd2cRQaFX5xbaLhPvycxLvq6vzG1RFEdDENlHK99W6snHv4DZLXA/Q+05Q1e3N5E
         jDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=negcME7L5mzW504DM5wehfUKj/rBMEPX2/Ij5qP2IFA=;
        b=n/0hGFaJ+8lfR0kbNsEq4FUNmgdwAfL6v+Odz+M7CQjNO2Qlqdf7RfeuFXqKwIoDXR
         3sN8etKklhRayLq7seWx4+1k//rEFJ7ni8Txr25TFvY56EwohpSxtJk9+ofCIfJjBp/9
         HqWjTFX6mnmTlypH3Q0sZSjUah1xR/LGbMe9uJKgtk9MjpXtWTzThcU7MQn0P3lg9BRS
         Gr4wuwk6aXu/h++z1m9tPk5pOkS/T1VyriZvqDaWl3LaQfExujUvwfOncFw+b+pfkjPB
         ItGzv29otlMiGKeQpjY9BUemEDh1AyTz8yl2mvZS3hshlZDqUf87ZBOGlEzBJpEjXTxd
         dYng==
X-Gm-Message-State: AFqh2kpwz/4U7KJbEhJE50KYueSTnMB37+txHKKMJUZWSwdBqU0HLPp9
        /2g4YF5JQZHU39X5tII0XKv/xw==
X-Google-Smtp-Source: AMrXdXtgGoIZRzWYSY2YS8X6pnzeWNrP/mW9QLoFdIF6dzhxUBhZr3XkUx8xrTn8iPVc63pstUO7mg==
X-Received: by 2002:a2e:a54a:0:b0:287:4fb8:8016 with SMTP id e10-20020a2ea54a000000b002874fb88016mr2353477ljn.7.1673446745785;
        Wed, 11 Jan 2023 06:19:05 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id s9-20020a056512214900b004b5a4cf69dfsm2726216lfr.261.2023.01.11.06.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 06:19:04 -0800 (PST)
Message-ID: <3fa1968a-405c-6838-71c6-697f170b8c0a@linaro.org>
Date:   Wed, 11 Jan 2023 15:19:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: enable eDP display
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230111133128.31813-1-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230111133128.31813-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.2023 14:31, Johan Hovold wrote:
> Enable the eDP display on MDSS0 DP3, including backlight control.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> This one depends on the sc8280xp display patches:
> 
> 	https://lore.kernel.org/lkml/20230111035906.2975494-1-quic_bjorande@quicinc.com/T/#mbcdfc826df6683a71d80bab5d86645ba81b02d52
> 
> Johan
> 
> 
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 75 ++++++++++++++++++-
>  1 file changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 23c1ca44ec11..ef17ef90d1f0 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -47,7 +47,7 @@ wcd938x: audio-codec {
>  		#sound-dai-cells = <1>;
>  	};
>  
> -	backlight {
> +	backlight: backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&pmc8280c_lpg 3 1000000>;
>  		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
> @@ -72,6 +72,22 @@ switch-lid {
>  		};
>  	};
>  
> +	vreg_edp_3p3: regulator-edp-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VCC3LCD";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 25 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_reg_en>;
> +
> +		regulator-boot-on;
> +	};
> +
>  	vreg_edp_bl: regulator-edp-bl {
>  		compatible = "regulator-fixed";
>  
> @@ -259,7 +275,6 @@ vreg_l6b: ldo6 {
>  			regulator-max-microvolt = <880000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-boot-on;
> -			regulator-always-on;	/* FIXME: VDD_A_EDP_0_0P9 */
>  		};
>  	};
>  
> @@ -340,6 +355,55 @@ vreg_l9d: ldo9 {
>  	};
>  };
>  
> +&dispcc0 {
> +	status = "okay";
> +};
> +
> +&mdss0 {
> +	status = "okay";
> +};
> +
> +&mdss0_dp3 {
> +	compatible = "qcom,sc8280xp-edp";
> +
> +	data-lanes = <0 1 2 3>;
> +
> +	status = "okay";
> +
> +	aux-bus {
> +		panel {
> +			compatible = "edp-panel";
> +
> +			backlight = <&backlight>;
> +			power-supply = <&vreg_edp_3p3>;
> +
> +			ports {
> +				port {
> +					edp_panel_in: endpoint {
> +						remote-endpoint = <&mdss0_dp3_out>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss0_dp3_out: endpoint {
> +				remote-endpoint = <&edp_panel_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss0_dp3_phy {
> +	vdda-phy-supply = <&vreg_l6b>;
> +	vdda-pll-supply = <&vreg_l3b>;
> +
> +	status = "okay";
> +};
> +
>  &pcie2a {
>  	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
>  	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
> @@ -902,6 +966,13 @@ hastings_reg_en: hastings-reg-en-state {
>  &tlmm {
>  	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>  
> +	edp_reg_en: edp-reg-en-state {
> +		pins = "gpio25";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
>  	hall_int_n_default: hall-int-n-state {
>  		pins = "gpio107";
>  		function = "gpio";
