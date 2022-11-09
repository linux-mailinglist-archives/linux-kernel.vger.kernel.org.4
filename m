Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08188622E16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiKIOgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiKIOgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:36:40 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AF6DE95
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:36:38 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h12so26043814ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 06:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKEIa4d4PXxZHsy+REJGIS5k0lMx2knvhKiineEouMs=;
        b=AewmfnuRfPL2XnkdjjtcalH3nWK7+1doHGbLFf1fdFnSPD1BEQHA85mD5uotVItko/
         8U0WiuVkQl+53+a5EwgdAhUbCLNRpVUGiBCoUAttQ6uOLUUxyibB33RJwvAUnbsNIBOM
         4F1l+g2rZnWhxsOWqFMGd012X9kXrlI713qlQt35QR1z+wFDzHyacL0Lgm4xZ3L9F/Cp
         hsGWAx1oB0I4h4Tr+2B4DmUX4wASO83wdyGVd3NgN/PjCM6RsumTgygkOjG0qCwDULzK
         cmBr8A3UTXm3sQ4/qZ2zdk2ZAWs5EHoVXTM2LMj92RJcPnnKH9ABjhJGnGYmUplJYtIB
         h9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKEIa4d4PXxZHsy+REJGIS5k0lMx2knvhKiineEouMs=;
        b=0QqSOtlguljB4T4eynJqUr6owOr+CljO+jWJoe04ueOlBZkXuTVpjXFnCgY7/DcMvI
         fAOPvZuJ13DCzZZmSDY+sbtW4gNDeXfk6dB4EfySI9RZR6cTcIuC8RzAMU1+neFzndRo
         O4CHixT/vRCOPvDWJNrkzLy9WTcfnO9d8/Z7bn1XbPoj/yqO7795HXgSdHat9K25w1U6
         At3sysFuWe5AT3rh5bdleTy7JdMMfvNzh+gux+BzFY28EHyk/Bbnu28vV3gR/v5zxt+t
         RIGUtRMpRO5zyyFA7R9EQ73EFeCN/ukN5QDdgfKsWDSRflCnzziPkyKnKfrX7Bva1zOC
         9mvQ==
X-Gm-Message-State: ACrzQf0y+xxBLkpxioFWxE1U8EqVVNVkmmHIqAF3+Rr1iN2P/yrmHBbH
        //q9QcMrB5ERdRTCus68N3PvcQ==
X-Google-Smtp-Source: AMsMyM5XqSNP93AqO9f4HmbeDKe1y8cIlnGgwPXoT68FvBWlJ1DOqhyHn0MmNwSjmxPcZlNvu/NYnw==
X-Received: by 2002:a2e:9819:0:b0:277:23f9:866d with SMTP id a25-20020a2e9819000000b0027723f9866dmr19664531ljj.60.1668004596628;
        Wed, 09 Nov 2022 06:36:36 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id s16-20020ac24650000000b0049aa20af00fsm2240053lfo.21.2022.11.09.06.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 06:36:35 -0800 (PST)
Message-ID: <87ff8801-0d0a-9ac3-6a9f-6b21302e3e72@linaro.org>
Date:   Wed, 9 Nov 2022 15:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm6375-pdx225: Enable SD card slot
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221109142623.53052-1-konrad.dybcio@linaro.org>
 <20221109142623.53052-4-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109142623.53052-4-konrad.dybcio@linaro.org>
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

On 09/11/2022 15:26, Konrad Dybcio wrote:
> Set SDHCI VMMC/VQMMC to <=2v96 and allow load setting by the SDHCI
> driver, as required by this use case.
> 
> Configure the SD Card Detect pin, enable the SDHCI2 controller and
> assign it the aforementioned regulators.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../qcom/sm6375-sony-xperia-murray-pdx225.dts | 34 +++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
> index 33083f18755b..c4181476f3b8 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
> @@ -153,7 +153,8 @@ pm6125_l4: l4 {
>  
>  		pm6125_l5: l5 {
>  			regulator-min-microvolt = <1650000>;
> -			regulator-max-microvolt = <3050000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-allow-set-load;
>  		};
>  
>  		pm6125_l6: l6 {
> @@ -235,7 +236,8 @@ pm6125_l21: l21 {
>  
>  		pm6125_l22: l22 {
>  			regulator-min-microvolt = <2704000>;
> -			regulator-max-microvolt = <3544000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-allow-set-load;
>  		};
>  
>  		pm6125_l23: l23 {
> @@ -302,6 +304,34 @@ &qupv3_id_1 {
>  	status = "okay";
>  };
>  
> +&sdc2_off_state {
> +	sd-cd-pins {
> +		pins = "gpio94";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> +
> +&sdc2_on_state {
> +	sd-cd-pins {
> +		pins = "gpio94";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&sdhc_2 {
> +	status = "okay";
> +
> +	vmmc-supply = <&pm6125_l22>;
> +	vqmmc-supply = <&pm6125_l5>;
> +
> +	cd-gpios = <&tlmm 94 GPIO_ACTIVE_HIGH>;
> +};
> +
> +

Just one blank line.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

