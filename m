Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BEF657604
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiL1LtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiL1LtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:49:08 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC542FCE2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:49:07 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so23312870lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIdAswb95AYARrc2vrOKujVdFE1u4lmRC2qYIaY3apw=;
        b=f55bwhGc94q1irBQ3Jl6361/Nv4prGoRA3QeucqleLYxW4zOVIkFwwfYTo+jyslT1p
         nPYi8sWM21YkX4TXWGzLe70PGKdPSUQ0nqmVPzFgLmiU9EYcBJGfrNvdHvTklo/EvyTn
         qcRGKzKNydOPCrBqLr9z2aBblFZ/9uFbEqtumpj9npZMFHCDoQ9XqNaTvbwyODXELYy/
         TS2X97+Keb/iGE8O/PH9/40IKjVz1cl5ezrLPqim4ZRlp3/anTaQ34bjm80hfVZ3iHdZ
         M9zoHO+ZX5pnWrw6ulcdmYcNFzHmRBqs1QDsG5ZbZjDAWuMKCK9KAOpc3VNpzh/v/y/I
         LxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIdAswb95AYARrc2vrOKujVdFE1u4lmRC2qYIaY3apw=;
        b=GbqKqY+498/f1Fr6Dk/rfgp33LNo+2cIEYqGBbVRcPpwUbbNicGguEHFHFkTWG+RV2
         NGjxmAGUCQK5zaouc6Q9/MohxM+iJTsTaJLTXQURb6jSx/KwCutql6GushDptSZyWfpu
         h3d+ZXGALERogJ9s0e301tCoKcbDH+x1YMzQQTpfi4zbFL9K3Nd8Oqx2Ss9RwhQi18C+
         Mpg4iosu1miaWgCLAyMv10ft/l06NVN65cENK9X1KK568EOLy/mCWrg/Yby5Y4kX7u/m
         FeONZRxady07b7hZTT2MCIzgNMdOKnjiH0dOXW7QgCLUVavgEEJGALgdvZ4yIP+7DTTO
         88+A==
X-Gm-Message-State: AFqh2kqd20yyb1dxhdSIXZyOJPHpGI3s6mtl2fAT9m5f0ROBvWXHNno3
        ajGYan90t9/IToug+dQRff7v3A==
X-Google-Smtp-Source: AMrXdXt+bGsJN6Y8DrxVVOVGXUlrshZ+hPi3h72qrABuvQKXyrpESQ0BdCJfotsDD64oOI8h/QYbgA==
X-Received: by 2002:a05:6512:3750:b0:4a4:68b9:66cc with SMTP id a16-20020a056512375000b004a468b966ccmr6645261lfs.23.1672228146214;
        Wed, 28 Dec 2022 03:49:06 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b004b5789ecdd7sm2576972lfq.274.2022.12.28.03.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 03:49:05 -0800 (PST)
Message-ID: <3434b152-20f0-83d0-7fbc-04247ce609cd@linaro.org>
Date:   Wed, 28 Dec 2022 12:49:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: move 'regulator-vph-pwr'
 node
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221228085614.15080-1-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221228085614.15080-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.12.2022 09:56, Johan Hovold wrote:
> Move the new 'regulator-vph-pwr' node before the wlan regulator node to
> restore the root-node sort order (alphabetically by node name).
> 
> While at it, add a couple of newlines to separate the properties for
> consistency with the other regulator nodes.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index aeb9e1800f71..0201c6776746 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -95,6 +95,16 @@ vreg_nvme: regulator-nvme {
>  		regulator-boot-on;
>  	};
>  
> +	vreg_vph_pwr: regulator-vph-pwr {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VPH_VCC3R9";
> +		regulator-min-microvolt = <3900000>;
> +		regulator-max-microvolt = <3900000>;
> +
> +		regulator-always-on;
> +	};
> +
>  	vreg_wlan: regulator-wlan {
>  		compatible = "regulator-fixed";
>  
> @@ -127,14 +137,6 @@ vreg_wwan: regulator-wwan {
>  		regulator-boot-on;
>  	};
>  
> -	vreg_vph_pwr: regulator-vph-pwr {
> -		compatible = "regulator-fixed";
> -		regulator-name = "VPH_VCC3R9";
> -		regulator-min-microvolt = <3900000>;
> -		regulator-max-microvolt = <3900000>;
> -		regulator-always-on;
> -	};
> -
>  	thermal-zones {
>  		skin-temp-thermal {
>  			polling-delay-passive = <250>;
