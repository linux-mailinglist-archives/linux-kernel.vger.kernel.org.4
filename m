Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BFD64B324
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiLMKWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiLMKVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:21:13 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B481CFDE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:20:46 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x28so4133891lfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HgfJ03fylnPu1kaLui/ybL/iBydNvPLkIgg7Jofsws=;
        b=cd7vei+gPqw5MMp7Nj3Icuy20KI2qZMC36a8ZbRLMh6WwZ5IOAa/P0G/uh02XjErQd
         ArUWPdcMG3dSGzSs1KMhgRFSBuadx21RdKBvGhYmx3LXHHMDZ+JJ8IVpyT1QhNfEwyF+
         pdtB1nF+nd50fp71uisobmRrSWKqQIS5TolIH5VO3IqwmLXNORoziOusxObl2zv2sWpE
         h81naWthItI8ldOM2+Gw3aWpWg1ppHz36Y1YeydaxlZFADcuO9Xfkyh20kyQQSzGbmab
         EK6IzTYwOU/KF2VxhUPkJk667lqAuK+GQe7ZWTd0Ynj2+G5SdQAGbNybUb7QD66O3E1T
         6b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HgfJ03fylnPu1kaLui/ybL/iBydNvPLkIgg7Jofsws=;
        b=jgF6bbPdebEfUnmX4XuYAEffUo/8v6P+pRC4dxQ1TxZ6UPfJuX+aAl7nENa1837PXi
         R1LHjFlIz2V7zVAhK8LhwZZ4fpj0uTuef0lCe5JQh/VIrcQ4tHfpwrP76mjZ1y0cyTLD
         moy3Kx48gSjk5ey/94sH11pp68stnzcw0R7YpKFiu+3CgMfFcHZZFWgx+lcKvduta2PY
         OGeleT1BBZd2fmDSUKewBeeamNzNBpOR68t4f2/0fIaKSnUs0dmPK0tNPJ+q3IBmhZ2d
         UMiq8q26X4ZQfLTNphr/MnH2wlIk7cRszlLM6oYfbXzdczlWXnzTxeoyw9SF/x2+Wpw6
         rZ/Q==
X-Gm-Message-State: ANoB5plc1Mpl9bahbk6BPNcr/Kq86l2be+/16toZ5IrnYpPWeRegsC9f
        ShRcSKiIgFv9G0zTBoLPR9uSWw==
X-Google-Smtp-Source: AA0mqf5Gfk0X7UBA1VMD/Ax+odvOtySouVK99GyO7qUfbFECWbo9xjNNKrTF18kpizULo6SESEd2sA==
X-Received: by 2002:a05:6512:5c2:b0:4b4:fbf2:608b with SMTP id o2-20020a05651205c200b004b4fbf2608bmr4668994lfo.30.1670926844425;
        Tue, 13 Dec 2022 02:20:44 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id h27-20020ac2597b000000b004b578e52d81sm305848lfp.176.2022.12.13.02.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 02:20:43 -0800 (PST)
Message-ID: <1716ecf5-2c91-ba01-397f-950cbbf47409@linaro.org>
Date:   Tue, 13 Dec 2022 11:20:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: rename AOSS QMP nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221213101921.47924-1-krzysztof.kozlowski@linaro.org>
 <20221213101921.47924-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221213101921.47924-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.12.2022 11:19, Krzysztof Kozlowski wrote:
> The Always On Subsystem (AOSS) QMP is not a power domain controller
> since commit 135780456218 ("arm64: dts: qcom: sc7180: Use QMP property
> to control load state") and few others.  In fact, it was never a power
> domain controller but rather control of power state of remote
> processors.  This power state control is now handled differently, thus
> the AOSS QMP nodes do not have power-domain-cells:
> 
>   sc7280-idp.dtb: power-controller@c300000: '#power-domain-cells' is a required property
>   From schema: Documentation/devicetree/bindings/power/power-domain.yaml
> 
> AOSS QMP is an interface to the actuall AOSS subsystem responsible for
> some of power management functions, thus let's call the nodes as
> "power-management".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> 1. Call the nodes "power-management"
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi   | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi   | 2 +-
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi   | 2 +-
>  arch/arm64/boot/dts/qcom/sm6350.dtsi   | 2 +-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi   | 2 +-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi   | 2 +-
>  arch/arm64/boot/dts/qcom/sm8350.dtsi   | 2 +-
>  arch/arm64/boot/dts/qcom/sm8450.dtsi   | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 906fb9343bcc..1370b7adccd8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3248,7 +3248,7 @@ aoss_reset: reset-controller@c2a0000 {
>  			#reset-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: power-management@c300000 {
>  			compatible = "qcom,sc7180-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 7c24c2129800..4768ae74d61f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -4257,7 +4257,7 @@ aoss_reset: reset-controller@c2a0000 {
>  			#reset-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: power-management@c300000 {
>  			compatible = "qcom,sc7280-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 3cb4ca6c53eb..05086169d873 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1921,7 +1921,7 @@ tsens1: thermal-sensor@c265000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: power-management@c300000 {
>  			compatible = "qcom,sc8280xp-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP IRQ_TYPE_EDGE_RISING>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 5f1f7cb52c90..a749e6b9d5ac 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4965,7 +4965,7 @@ aoss_reset: reset-controller@c2a0000 {
>  			#reset-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: power-management@c300000 {
>  			compatible = "qcom,sdm845-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index 0f01ff4feb55..8dda257178c9 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1273,7 +1273,7 @@ tsens1: thermal-sensor@c265000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: power-management@c300000 {
>  			compatible = "qcom,sm6350-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x1000>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index d1b64280ab0b..089f730beb76 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3589,7 +3589,7 @@ pdc: interrupt-controller@b220000 {
>  			interrupt-controller;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: power-management@c300000 {
>  			compatible = "qcom,sm8150-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0x0 0x0c300000 0x0 0x400>;
>  			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index fbbbae29e0c2..a4e171a59409 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -3741,7 +3741,7 @@ tsens1: thermal-sensor@c265000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: power-management@c300000 {
>  			compatible = "qcom,sm8250-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 49db223a0777..1fd0df2e343f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -1717,7 +1717,7 @@ tsens1: thermal-sensor@c265000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: power-management@c300000 {
>  			compatible = "qcom,sm8350-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index e0d30dadbf8b..e9a835e34ad2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2453,7 +2453,7 @@ tsens1: thermal-sensor@c265000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: power-management@c300000 {
>  			compatible = "qcom,sm8450-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
