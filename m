Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C6B665B19
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjAKMLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjAKMLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:11:16 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A540B1C9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:11:14 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j17so23215855lfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQ3ejIIcNy5wNB2nAKCgYVyxVsxuI4AQbfdxuKZTncs=;
        b=yzSKfAiK6TVY86KqttCyW4EQY4cuqxw12pIH2DKrHqVKzaS6B5W/DDJo19vaO/pFZj
         FlSUFtmlAdG5QdSPQJmT45aW8BAOT7SaygC+XgZEKHOv4JjmlaoIQ8lQDdML8219vYnC
         OGQO40HhaBVKYOVkZTpI0OmU/dzkx6kKQLEutjiolI6lDlnk/dfO/qEyU0IT7zKOUyGu
         2x1/15ULi/MC1sEi2MrfvQb/1IC4ZUMYPZVjuKSrwStWhyk9Qy4zv+Q7zU+4BnNr2A9c
         XPODEUFLvylGpIFeF+QPEZ7xxdOsdJSfZlF3W60pp0ndfwkrSxk7BkWVUtbXl7+tev44
         D4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ3ejIIcNy5wNB2nAKCgYVyxVsxuI4AQbfdxuKZTncs=;
        b=H4cM99QoQdUxDsSSHmPVk528I3LnwlbvuBIy55XTwfWOkB7OmXWYfQmuiizhOUUiMz
         UdkPTUqWtIr1+DZ5QTS+mreb8XBc6dKAycJlmmPLejHNEzxLAxJT1GpRkFdiMXzY8HaT
         VuTii8xqzcnddUFmCUJfra7EaD2amQZ/VSI++Bn/JqwYlEWVKIiGDTDGJ7lBUPQb3P1D
         SDs7s5k9v/dzKxj67+jQinGU9avufQWdWqCeHI85LyfMtcojmGtYvRIQQeYuhrL0XI/B
         4zo18qQ9hOt5tOYP3d4LuSlbRfyfde2tqFiP40u7w9d7vAVm72siFRJNgQSaOcHrWJEI
         pYMg==
X-Gm-Message-State: AFqh2krpbH3WuE2YuvUGQna0OfnsssyaH1fJdiNuA/nVm/eHHA/aRfP9
        1drbH/8Vc2018Z0FU+87Yo8uCA==
X-Google-Smtp-Source: AMrXdXsh19qIUk8Xn6V/5zPoR81BBWhrcSr8hpmf/IQukJLnkIBiA2tECGl5ikFvVdZLDCE+ErpoBw==
X-Received: by 2002:a05:6512:400d:b0:4b5:936e:69df with SMTP id br13-20020a056512400d00b004b5936e69dfmr23711772lfb.53.1673439072523;
        Wed, 11 Jan 2023 04:11:12 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id b4-20020a2e8484000000b00286dbab9a87sm725097ljh.91.2023.01.11.04.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 04:11:12 -0800 (PST)
Message-ID: <2bcb3e4e-9a81-73f5-7820-06432ec062c5@linaro.org>
Date:   Wed, 11 Jan 2023 13:11:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 2/4] arm64: dts: qcom: sc8280xp-crd: Enable EDP
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230111035906.2975494-1-quic_bjorande@quicinc.com>
 <20230111035906.2975494-3-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230111035906.2975494-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.2023 04:59, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The SC8280XP CRD has a EDP display on MDSS0 DP3, enable relevant nodes
> and link it together with the backlight control.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v6:
> - None
> 
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 73 ++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 551768f97729..db12d8678861 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -20,7 +20,7 @@ aliases {
>  		serial0 = &qup2_uart17;
>  	};
>  
> -	backlight {
> +	backlight: backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&pmc8280c_lpg 3 1000000>;
>  		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
> @@ -34,6 +34,22 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	vreg_edp_3p3: regulator-edp-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_EDP_3P3";
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
> @@ -228,6 +244,55 @@ vreg_l9d: ldo9 {
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
> +			power-supply = <&vreg_edp_3p3>;
> +
> +			backlight = <&backlight>;
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
> @@ -494,6 +559,12 @@ hastings_reg_en: hastings-reg-en-state {
>  &tlmm {
>  	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>  
> +	edp_reg_en: edp-reg-en-state {
> +		pins = "gpio25";
> +		function = "gpio";
> +		drive-strength = <16>;
> +	};
> +
>  	kybd_default: kybd-default-state {
>  		disable-pins {
>  			pins = "gpio102";
