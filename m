Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF056E185E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDMXgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjDMXgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:36:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51C419AB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:36:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o1so21305530lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681429001; x=1684021001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9ajKjdjmVKYZR0o2RYS00gCwWXzx+OByS0IkZ5vWrg=;
        b=SVEjyBOGaxj1mckia8+8F4tBz1UaxMbdTgcRhw3El6pgcSSVVULIgBzGaISjFEobmy
         7Op5etGGtc7DIeL/p/C9F6/9iiyv5+0EMT9PawHnseed2spJ62pcQR3F6SxwPZVGMPBG
         JL9uX9mVXLQYa3bK+ZfNJv4rJNlH+EUBJZrT3/ck3yaJWv6py781rpgZrk4w49itUKck
         GH37nQ5NHr5WAn1z3tlVFiar3bOZrTX55x3zEm1ujXpjmrN46OFDXwhbk/yW0lNg8MST
         IrLLXnQTT8LFYMmjBLa7Bjuc5fr4PJXga0qXvOHLLFwHTtLglYDWmLGCVrTobGV9oHqW
         ixxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681429001; x=1684021001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9ajKjdjmVKYZR0o2RYS00gCwWXzx+OByS0IkZ5vWrg=;
        b=CAAY1tboBr4F/Us/Sef2W4eZHzRAZ19+K8KKKzGqbjWkbephLwvAVHQzJcQfxK+toG
         yCe4R/iK9aXQpS3dO0JyT9VoZprJlB4oocwGnL4e9qHP8C169C5pYjJdGCTcM6eT1HSc
         8uujqnx2zR3jFLLNATUQ9UnNuzvimo6gR4BG46g432S2fgFBBtLCFg4jyrmAFFUNZwsj
         ZuDaruVNEuYN/l5yALVRVy+gI4clluDepuJHce7YtTDV+ZOZ+99ko2f/a7oKEdBarZrk
         lHiTeXWXVOuBhVXqCEYy8JD7CjVV7KVGKdcv/TvDxfwRvPOFJ1QH4NTj+gOPDmNM83Nz
         fvww==
X-Gm-Message-State: AAQBX9dkxg+VGilLEx4rmCdJwVs1NwUX9E/yOBsd/7lRSSXx1R07btN+
        qxXvZ2m6+WqG6r8NPat9PRp7qQ==
X-Google-Smtp-Source: AKy350Zo99hWzMgWvX+LgY/9CK+7rZVz2nOI2ypxTsltEFwJGq7j79xeqJ8GdXR+H5DJke5A5SynGg==
X-Received: by 2002:ac2:51a2:0:b0:4de:ca63:b2d2 with SMTP id f2-20020ac251a2000000b004deca63b2d2mr1316274lfk.26.1681429000930;
        Thu, 13 Apr 2023 16:36:40 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id i15-20020ac25d2f000000b004e26bd0a533sm510735lfb.288.2023.04.13.16.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 16:36:40 -0700 (PDT)
Message-ID: <96180862-6dbf-77e1-4aca-9a3b9ee39294@linaro.org>
Date:   Fri, 14 Apr 2023 01:36:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 8/8] arm64: dts: qcom: sdm632-fairphone-fp3: Add
 notification LED
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
 <20230414-pmi632-v1-8-fe94dc414832@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230414-pmi632-v1-8-fe94dc414832@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.04.2023 01:17, Luca Weiss wrote:
> The phone features a notification LED connected to the pmi632. Configure
> the RGB led found on it.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 29 +++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> index 70e683b7e4fc..301eca9a4f31 100644
> --- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> @@ -4,8 +4,10 @@
>   */
>  /dts-v1/;
>  
> +#include <dt-bindings/leds/common.h>
>  #include "sdm632.dtsi"
>  #include "pm8953.dtsi"
> +#include "pmi632.dtsi"
>  
>  / {
>  	model = "Fairphone 3";
> @@ -83,6 +85,33 @@ &pm8953_resin {
>  	linux,code = <KEY_VOLUMEDOWN>;
>  };
>  
> +&pmi632_lpg {
qcom,power-source?

Konrad
> +	status = "okay";
> +
> +	multi-led {
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_STATUS;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@1 {
> +			reg = <1>;
> +			color = <LED_COLOR_ID_RED>;
> +		};
> +
> +		led@2 {
> +			reg = <2>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		led@3 {
> +			reg = <3>;
> +			color = <LED_COLOR_ID_BLUE>;
> +		};
> +	};
> +};
> +
>  &sdhc_1 {
>  	status = "okay";
>  	vmmc-supply = <&pm8953_l8>;
> 
