Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF85F1B0D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJAJOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJAJOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:14:23 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F37015D123
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:14:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id p5so7049328ljc.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+kJtG2fBZDrtEv8J0UeBRQ4YdwMWoH2MpGk4JS1bGws=;
        b=jdyacvvDfjyOhIUh8+WLu2B9rsocox5Br9zBWsViD6oefALMDjq5uGg9cYL/LT6VTX
         sA0axrdsF/Sxz6e0HNDMPbX0lu9INQeR7fUbjYX2On3JZSK1vIRNAmVr54BxpDhJZquJ
         mvzzFlc0U7K+HMop1fDfHwl/qOE3AWQvtftTxOYJIyUu4FksGOj6/BmLL3c021TLSVw4
         q6/6/HhQ5k92Xq0qqKaVw08j/pU1Cspu+pR8vDBd2z0CSjrbqGsSfRMRMbKhRiI4R4jO
         vpMrQQuACqFsQ+pFs/bTrH9HSFH/KwS5fmJ8P8o27zmx8IGaBSWsge8T+tx/a93XSc22
         1hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+kJtG2fBZDrtEv8J0UeBRQ4YdwMWoH2MpGk4JS1bGws=;
        b=xNUdlHkRDVVILr3OskeCN2tGn03yojWQtAPAn8hd7VHOI1gblaOCtIfuP8vyxVCdYj
         M3emWEBUg6Oa+oapzOzlPhHK6m/Q9PihPPQLpIK3jd0TO7PfcfPcyULNtTvBj9F/jMRf
         zTMR3Pw/V1orzq1iftfTNv8ixct1oWdGvyDljCchcRTB5OVxS+7EPRUImaZemTkEXKJ9
         qTxPl55wD8c1KWYfznUkszB01oalq8rNOgYumRmdWxyWv/klknQu9aiu2BzbRO2UKI7Z
         0uvUkZTQkYvW3mQw13WTBswJzHqUJTrSXPUZZAarVB4WS03Z6eYl/CZLayDtDyPXBMdh
         bkxw==
X-Gm-Message-State: ACrzQf2kRpOH3Zu8madg3RHw10uXsYg0+JJo5oPLsZxZJp+XeLx7WAWo
        BjLSF9Us+QtORQRKyw2mJmSWMg==
X-Google-Smtp-Source: AMsMyM5iSnQ42/drGrHhe15NqtDYxL0SLeZK15Zw+i0bA1CBMf+u80ri0J/J3NcpWZAfM8XhYz+7Tw==
X-Received: by 2002:a2e:9257:0:b0:26c:350b:61d4 with SMTP id v23-20020a2e9257000000b0026c350b61d4mr3887392ljg.523.1664615657139;
        Sat, 01 Oct 2022 02:14:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x4-20020ac25dc4000000b0049313f77755sm693355lfq.213.2022.10.01.02.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:14:16 -0700 (PDT)
Message-ID: <ad743621-8e2d-23f9-8c44-53f6681aa134@linaro.org>
Date:   Sat, 1 Oct 2022 11:14:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 03/19] arm64: dts: qcom: qdru1000: Add tlmm nodes
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
 <20221001030656.29365-4-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030656.29365-4-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 05:06, Melody Olvera wrote:
> Add tlmm node for the QDU1000 and QRU1000 SoCs and the uart pin
> configuration.

The patchset should be squashed with previous. There is no point in
bringing support piece by piece. You can bring support in steps if you
submissions are separate in time. But if you have everything ready -
your patch must be complete and bisectable.

> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdru1000.dtsi | 30 ++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
> index 3610f94bef35..39b9a00d3ad8 100644
> --- a/arch/arm64/boot/dts/qcom/qdru1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
> @@ -235,6 +235,8 @@ uart7: serial@99c000 {
>  				reg = <0x0 0x99c000 0x0 0x4000>;
>  				clock-names = "se";
>  				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_uart7_default>;
>  				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> @@ -248,6 +250,34 @@ tcsr_mutex: hwlock@1f40000 {
>  			#hwlock-cells = <1>;
>  		};
>  
> +		tlmm: pinctrl@f000000 {
> +			compatible = "qcom,qdu1000-tlmm", "qcom,qru1000-tlmm";
> +			reg = <0x0 0xf000000 0x0 0x1000000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 151>;
> +			wakeup-parent = <&pdc>;
> +
> +			qup_uart7_default: qup-uart7-default {

Suffix "-state"

> +				tx {

Suffix "-pins"

> +					pins = "gpio134";
> +					function = "qup0_se7_l2";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				rx {

Suffix "-pins"


> +					pins = "gpio135";
> +					function = "qup0_se7_l3";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,pdc";
>  			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;

Best regards,
Krzysztof

