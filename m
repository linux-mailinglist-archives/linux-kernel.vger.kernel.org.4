Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3756E7766
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjDSK2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjDSK2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:28:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F0B5FFB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:28:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ec816d64afso12952106e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681900120; x=1684492120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VybvqKxQBBjDVUhiroFfMYUdC6zzghkLtNDu/WEbXQ=;
        b=F1g1LfaupkHvYGX4hXRemCRjRdU9QpJizHsTb6EnZ7xTEl05oERKa1+MylQD+Ud17I
         3s609V08kX1xd6CeIueDdxQwHlujSJIKLLCmtbycbPoMyhi7imo87c07ekSD7YDpihwv
         gNbPYVGLXRGd008MdDx7rkJFBD7ojIgbzqt7NCAMmqtlqnyUFQrsbWXNnlk7/B6e9IN/
         PyQQ2WBqMAB1fC07FGM+vvnjRhmhuEINNqbZILQJZvCYgiWS/skaT+N7v2O4WJR4/yXU
         1Or1Om0Gg4u4fh88HKcZAUdeMTusLaV6fKMnpXghFi2yA378BoyAedaxKo3/HsqcAvid
         obKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681900120; x=1684492120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VybvqKxQBBjDVUhiroFfMYUdC6zzghkLtNDu/WEbXQ=;
        b=R5qip5FXqgvMYIl5Ep4d2wlKtyEnFV9wl1ImYsxk6OcP6LF3kmrbso/62C/YZLArsL
         JHjhLqV3N7HUcPc+q3TXTgjxgBo9YTCxVACHrXFUXGdqm7VnINkzeHntE2Ajv6oMNFPQ
         jyHFltDnDJlMBlE7vPwLnop6cq17djlOJpdjexNZylOHHal0EVtaXl11yitTqxypmR4K
         U+01tsk8cfSXyXQjg0OsgAAd7+hK7xycr8gTR9RErOCsX3QXCmKvh4ywq5PVlxDD15RP
         xdxA81p8PHZUmg4UYGMut1KXNbwrHVkimQd420cOEvZ4GVVFuw+zE542jAJCyaqef6WO
         PpOg==
X-Gm-Message-State: AAQBX9cqKlGXKvzdSnzPm6i9lBpFyil8krMj/JzmvC90FzojbsMf7+VN
        P46+5QIlY/JiTakdV5zyViaf9g==
X-Google-Smtp-Source: AKy350bR2i4Ob8duVzV3tJMTy/E3Eui8ihwuBJFLOmUXsND88vLrHCUaWPcS+3HzXFhjrd13jx5MGg==
X-Received: by 2002:ac2:55b2:0:b0:4ec:7973:1ac with SMTP id y18-20020ac255b2000000b004ec797301acmr777061lfg.22.1681900120711;
        Wed, 19 Apr 2023 03:28:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id p11-20020ac246cb000000b004edd84f4646sm194670lfo.91.2023.04.19.03.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 03:28:40 -0700 (PDT)
Message-ID: <4b9e8dba-aeb7-092b-ebec-6c1fd7bbaa12@linaro.org>
Date:   Wed, 19 Apr 2023 12:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sdm632-fairphone-fp3: Add
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
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
 <20230414-pmi632-v2-7-98bafa909c36@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230414-pmi632-v2-7-98bafa909c36@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.04.2023 18:43, Luca Weiss wrote:
> The phone features a notification LED connected to the pmi632. Configure
> the RGB led found on it.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
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
