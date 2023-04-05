Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03316D825C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbjDEPq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbjDEPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:46:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F416A4C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:46:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k37so47276829lfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680709561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JzMgw/KxIFuJD1bDGN/iTTK0mFIW8/fSipuo0OLvMo=;
        b=vV5AnKvy7C6OmT0GHc7Wd17jVaT9e4C4dZIiY51QpsN4SrEWfoAt4wj/Vk/ukWS8xs
         NGKtQBpxYGPbiGlM8ay4QTaSawkPkiWbXLymQmboAlgurqMSK17iixf7pNivZCpLUScy
         PzQbg1EWOBOZ78Zc7Ij0GUyaRkMrkq4yZdkXbjP9WYIW1fFyd4Cgr1a9p7leXmK8qDtN
         BysvK4i2lPwC+yR5kRLwH5Wj78TX3VteIToKmNCOMRvPcl5zN1OvhEAlabsX/a1uDnbr
         1iyGTcY+MBKBTNcE9CU5jrRMHBOQWh6pWsAoGZSxRoH7UrcvBbgyiQwRoeDRIh+AHJ/4
         xTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680709561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JzMgw/KxIFuJD1bDGN/iTTK0mFIW8/fSipuo0OLvMo=;
        b=IGL32WvN5lFuS0VEpLqpwT8rsDLn60wy8JVPm42GrqjS+ReZfBAcriyLkExdSVGSb7
         v7MYnG5s/dAkRSfTqY+GTIKcB3HWBkFa5zS4ASSeG1RNc1MzTyMc4gQsbgAFtdlyiiDa
         rXdphNvtO3LU7N5zEJqp8h2hL6jlUwh1E1dL9+tGGdZQbnUEdzJEL0OpbPwH7VsV22Gx
         BdzEfVci9SLC2y3aNPGhngcssFwOyf2avQVz0atZcNzxzbQcmhyVVM/biZB5dQmPspTq
         aNy0rfwERSEairUqU/P9cghCCFzwvr4NSZluBh/r4mQn5AMUz8DAamOZ2x7lWY8OU6lF
         NdyQ==
X-Gm-Message-State: AAQBX9dXxPJEG8QuUA++O+MY/xWR3/FQ7CuncSHKor/6B8MNLAJp3rbv
        yxwv9U2zH7XFJXVwJwtTWUrs2g==
X-Google-Smtp-Source: AKy350bjTYshRZn4kx0HvRnINKUxdPrUxQmyITyx2Bj+QoWEURaWHKvTaLCdaBpNPcpHMbmRaerVaA==
X-Received: by 2002:ac2:5482:0:b0:4e9:9c76:1b85 with SMTP id t2-20020ac25482000000b004e99c761b85mr1574656lfk.3.1680709561239;
        Wed, 05 Apr 2023 08:46:01 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id x11-20020a19f60b000000b004eaf2291dcdsm2880736lfe.102.2023.04.05.08.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:46:00 -0700 (PDT)
Message-ID: <fcfaccb2-bf93-091d-d3d7-81fed6fb62fe@linaro.org>
Date:   Wed, 5 Apr 2023 17:45:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3] arm64: dts: qcom: sm8550: add Soundwire controllers
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230405061129.143553-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230405061129.143553-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.04.2023 08:11, Krzysztof Kozlowski wrote:
> Add nodes for LPASS Soundwire v2.0.0 controllers.  Use labels with
> indices matching downstream DTS, to make any comparisons easier.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v2:
> 1. Use labels instead of comments (Konrad).
> 2. Use interrupts instead of interupts-extended (Konrad)
> 
> Changes since v1:
> 1. Correct IO range length.
> 
> The bindings and driver are here:
> https://lore.kernel.org/linux-arm-msm/20230403132503.62090-1-krzysztof.kozlowski@linaro.org/T/#t
> 
> Cc: Patrick Lai <quic_plai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 109 +++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index dc6150e97d46..f9eaede39b5b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2004,6 +2004,33 @@ lpass_wsa2macro: codec@6aa0000 {
>  			#sound-dai-cells = <1>;
>  		};
>  
> +		swr3: soundwire-controller@6ab0000 {
> +			compatible = "qcom,soundwire-v2.0.0";
> +			reg = <0 0x06ab0000 0 0x10000>;
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&lpass_wsa2macro>;
> +			clock-names = "iface";
> +			label = "WSA2";
> +
> +			qcom,din-ports = <4>;
> +			qcom,dout-ports = <9>;
> +
> +			qcom,ports-sinterval =		<0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x18f 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x01 0x03 0x05 0x02 0x04 0x15 0x00 0xff 0xff 0x06 0x0d 0xff 0x00>;
> +			qcom,ports-offset2 =		/bits/ 8 <0xff 0x07 0x1f 0xff 0x07 0x1f 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
> +			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x18>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0x00 0x01 0x01 0x00 0x01 0x01 0x00 0x00 0x00 0x01 0x01 0x00 0x00>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			#sound-dai-cells = <1>;
> +			status = "disabled";
> +		};
> +
>  		lpass_rxmacro: codec@6ac0000 {
>  			compatible = "qcom,sm8550-lpass-rx-macro";
>  			reg = <0 0x06ac0000 0 0x1000>;
> @@ -2023,6 +2050,33 @@ lpass_rxmacro: codec@6ac0000 {
>  			#sound-dai-cells = <1>;
>  		};
>  
> +		swr1: soundwire-controller@6ad0000 {
> +			compatible = "qcom,soundwire-v2.0.0";
> +			reg = <0 0x06ad0000 0 0x10000>;
> +			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&lpass_rxmacro>;
> +			clock-names = "iface";
> +			label = "RX";
> +
> +			qcom,din-ports = <0>;
> +			qcom,dout-ports = <10>;
> +
> +			qcom,ports-sinterval =		<0x03 0x3f 0x1f 0x07 0x00 0x18f 0xff 0xff 0xff 0xff>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x00 0x00 0xff 0xff 0xff 0xff>;
> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00 0x00 0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff>;
> +			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff 0x0f 0xff 0xff 0xff 0xff>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff 0x00 0xff 0xff 0xff 0xff>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00 0x00 0xff 0xff 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00 0x00 0xff 0xff 0xff 0xff>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			#sound-dai-cells = <1>;
> +			status = "disabled";
> +		};
> +
>  		lpass_txmacro: codec@6ae0000 {
>  			compatible = "qcom,sm8550-lpass-tx-macro";
>  			reg = <0 0x06ae0000 0 0x1000>;
> @@ -2061,6 +2115,61 @@ lpass_wsamacro: codec@6b00000 {
>  			#sound-dai-cells = <1>;
>  		};
>  
> +		swr0: soundwire-controller@6b10000 {
> +			compatible = "qcom,soundwire-v2.0.0";
> +			reg = <0 0x06b10000 0 0x10000>;
> +			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&lpass_wsamacro>;
> +			clock-names = "iface";
> +			label = "WSA";
> +
> +			qcom,din-ports = <4>;
> +			qcom,dout-ports = <9>;
> +
> +			qcom,ports-sinterval =		<0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x18f 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x01 0x03 0x05 0x02 0x04 0x15 0x00 0xff 0xff 0x06 0x0d 0xff 0x00>;
> +			qcom,ports-offset2 =		/bits/ 8 <0xff 0x07 0x1f 0xff 0x07 0x1f 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
> +			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x18>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0x00 0x01 0x01 0x00 0x01 0x01 0x00 0x00 0x00 0x01 0x01 0x00 0x00>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			#sound-dai-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		swr2: soundwire-controller@6d30000 {
> +			compatible = "qcom,soundwire-v2.0.0";
> +			reg = <0 0x06d30000 0 0x10000>;
> +			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "core", "wakeup";
> +			clocks = <&lpass_vamacro>;
> +			clock-names = "iface";
> +			label = "TX";
> +
> +			qcom,din-ports = <4>;
> +			qcom,dout-ports = <0>;
> +			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x01 0x03 0x03>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x01 0x01>;
> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00 0x00>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x01 0x02 0x00 0x00>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			#sound-dai-cells = <1>;
> +			status = "disabled";
> +		};
> +
>  		lpass_vamacro: codec@6d44000 {
>  			compatible = "qcom,sm8550-lpass-va-macro";
>  			reg = <0 0x06d44000 0 0x1000>;
