Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622C664A165
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiLLNjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiLLNjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:39:33 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD0F14D32
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:38:27 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z26so725742lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XaoqYPcstX2vkS44Es/ogTcUNI1GuvolK6Dv6wUJUc=;
        b=XUqT3au53d6d9bBUS18grnSa04NrSeqJ4CBP9J4zSz/1Vx16d96vKWk7qC1sVh3joL
         MRPrfwWh/rglFXrc03Q+iPTN1LF8Lio+LDYO5VFbLXIbzwEu6ustI0HEj7absedxAOsA
         N81YDd/29+Ms2kleUnVxPiNoPdmxdVm/ODh0i+rfyni8UVnzo0nX//2c94vLCs36qlTm
         qKkFYiEch8OOKxGijjWeLwtGoM3SylCvN4oPS0QBFl9XnagVwhiGYKXRHvbylVGuk6qF
         d6ZmjYiPu6t+CXpDfsEQNvWrtxEv1PxY9LQRfBPb29nxQjmSl9OU9vl7D8iatdgjwr6+
         M7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XaoqYPcstX2vkS44Es/ogTcUNI1GuvolK6Dv6wUJUc=;
        b=zxDLp3SbtZVoyz7fzD/O6O9TpiX4byB6C6eSUH4KQ+eBz8YTVp3AbGHA0NZuLckJQW
         tRlCzx4mjueGUrVXhNIRmxYjHlFS2GOfS7Z7s2VgWu8PoLx+CSN1P5To+uy4e1XmMxqh
         3J3S6/xI9fkv4BP7FGLreJw0d/glXqaI7IXShOL22oC7yJJrE6Fu1zeAaMWiKlWikbyL
         d1+ZN5OJO3ljScEXgt0WETDckS1bmyxaOV1mURYQknHbN5pFY4PDGt48r/LqnWLL425c
         /BPprv3lfUlEhVLALVjjtA8g47gOmHn4BI9ZMJp5Jid+7tp/MUXid0t9ZF1FWDZXKz9d
         m8Iw==
X-Gm-Message-State: ANoB5pl6yqP4u4kI9hxD32B1VM8+blroUW5HOjeIEL2AS44VO0nsnjsN
        y6aRIG9AgdfEFejVhevmq7IkucPRsKV1iiob
X-Google-Smtp-Source: AA0mqf6/hxsy5FnJXs6wytAFIbgsQrbKOzve15vDPnggvJsgQcFq2I3Nap9smAPQG7jiiyHD5+mV0A==
X-Received: by 2002:a05:6512:21b:b0:4b5:5098:e6f7 with SMTP id a27-20020a056512021b00b004b55098e6f7mr3451086lfo.68.1670852305496;
        Mon, 12 Dec 2022 05:38:25 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512358600b00499b27a329esm1632967lfr.300.2022.12.12.05.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:38:25 -0800 (PST)
Message-ID: <20fcf298-7d91-0458-489d-4fb65cdff380@linaro.org>
Date:   Mon, 12 Dec 2022 14:38:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: rename AOSS QMP node to pmu
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221212133303.39610-1-krzysztof.kozlowski@linaro.org>
 <20221212133303.39610-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221212133303.39610-4-krzysztof.kozlowski@linaro.org>
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



On 12.12.2022 14:33, Krzysztof Kozlowski wrote:
> The Always On Subsystem (AOSS) QMP is not a power domain controller
> since commit 135780456218 ("arm64: dts: qcom: sc7180: Use QMP property
> to control load state") and few others.  In fact, it was never a power
> domain controller but rather control of power state of remote
> processors.  This power state control is know handled differently, thus
> the AOSS QMP nodes do not have power-domain-cells:
> 
>   sc7280-idp.dtb: power-controller@c300000: '#power-domain-cells' is a required property
>   From schema: Documentation/devicetree/bindings/power/power-domain.yaml
> 
> AOSS QMP is an interface to the actuall AOSS subsystem responsible for
> some of power management functions, thus let's call the nodes as "pmu" -
> Power Management Unit.
power-management@ is used on apple and rockchip and pmu is very
ambiguous (power management or performance measurement unit).

Konrad
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
> index 906fb9343bcc..7e781570b2c6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3248,7 +3248,7 @@ aoss_reset: reset-controller@c2a0000 {
>  			#reset-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: pmu@c300000 {
>  			compatible = "qcom,sc7180-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 7c24c2129800..b08ddeb7bcec 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -4257,7 +4257,7 @@ aoss_reset: reset-controller@c2a0000 {
>  			#reset-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: pmu@c300000 {
>  			compatible = "qcom,sc7280-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 3cb4ca6c53eb..e04f1f751881 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1921,7 +1921,7 @@ tsens1: thermal-sensor@c265000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: pmu@c300000 {
>  			compatible = "qcom,sc8280xp-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP IRQ_TYPE_EDGE_RISING>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 5f1f7cb52c90..2e15a003825e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4965,7 +4965,7 @@ aoss_reset: reset-controller@c2a0000 {
>  			#reset-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: pmu@c300000 {
>  			compatible = "qcom,sdm845-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index 0f01ff4feb55..bb20fed0f4f0 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1273,7 +1273,7 @@ tsens1: thermal-sensor@c265000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: pmu@c300000 {
>  			compatible = "qcom,sm6350-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x1000>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index d1b64280ab0b..ad6902b13a71 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3589,7 +3589,7 @@ pdc: interrupt-controller@b220000 {
>  			interrupt-controller;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: pmu@c300000 {
>  			compatible = "qcom,sm8150-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0x0 0x0c300000 0x0 0x400>;
>  			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index fbbbae29e0c2..6faf13ed90c1 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -3741,7 +3741,7 @@ tsens1: thermal-sensor@c265000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: pmu@c300000 {
>  			compatible = "qcom,sm8250-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 49db223a0777..519e436aeab9 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -1717,7 +1717,7 @@ tsens1: thermal-sensor@c265000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: pmu@c300000 {
>  			compatible = "qcom,sm8350-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index e0d30dadbf8b..234fe6549fe0 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2453,7 +2453,7 @@ tsens1: thermal-sensor@c265000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: pmu@c300000 {
>  			compatible = "qcom,sm8450-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
