Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2797566B1C0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 15:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjAOO6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 09:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjAOO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:58:10 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F84910408
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:58:09 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ss4so55394426ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PfWWCmg2Z6NPIwFDHOmJ9fYg7mNLT5FmitAzeljhDik=;
        b=egGGhPWNjQO6X44QNAaWTM1OkdaR5dgL2U1R39eQ13Uu8ZxxfaWlgYKAD0kKab4Jqm
         3x4ZIh8T0QLC52iRgfWx21cZwsN8ZD852M9fOxhzae1pRz7XUrzuw+JH+7KbFX28YEEq
         M4Yj0bcAryGCtAPETNPejjthYlA+gO4VzoiIJuBiUr2puTC/ATjpGMMX+HdU/p8xcC+i
         eXueIlFt4rYR+06CJuwf57VJMscBpDP/7mlpy65vRu1851gEl6sPpTWOyPRtMXkLh8WM
         8RO3x03COF8F9unt7UN7s2cow2k7T5UWApdvaiX1yiWBG7YEDOE87tBNmbz7DH38sc7D
         RwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfWWCmg2Z6NPIwFDHOmJ9fYg7mNLT5FmitAzeljhDik=;
        b=rfo6HzyBzoZ1aKAkoOVDjCMvEjQXcdGylSA+93puT9rOFrsbLtqvW+S1lY6v9Hp2Bu
         YNRYrii9FGBg76xBkI3It1mRcCW55iaVXYbWXo8ud6izlpYmDwDXuqj5qjVfmgIdyPEa
         NmMOxKYtVA6LvcUVgDrDt2AeiJDVCufVTShgnZDBYoNF+CvVwdSn+VIz3+KzWOonziXp
         GTXJ030SNH2K26ZIzJJa7OZUbPXiFCHAHNlq+DwUzlYLipfl0ndlAryCcuCw8e/HoV3Q
         DVY3NzxIXbFiIvsOuMdsfoqHpYsX0AcmvJUZiwghKFrG7zB1kJtvarIM0fogVpmNjIiB
         txUw==
X-Gm-Message-State: AFqh2krPociwu524qvs4OFSHPk/jAvluGoZKVo3am3Geeuoy9pAXgWXq
        7ZzfJJzI9FZK7m/ozECtfnFmkw==
X-Google-Smtp-Source: AMrXdXsM/Rz+u4//7jTJKSU7N4pZGKA5+3HOizlKLtnzAZ8bz+S5kLRNy78y4fpyA7DTrcnLC5yA9A==
X-Received: by 2002:a17:907:8e93:b0:7c1:7226:c936 with SMTP id tx19-20020a1709078e9300b007c17226c936mr79173818ejc.64.1673794687628;
        Sun, 15 Jan 2023 06:58:07 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090653c400b0084ca4bd745esm10802871ejo.35.2023.01.15.06.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 06:58:07 -0800 (PST)
Message-ID: <2ebbe66f-fc98-3be2-1f93-857f0025e75e@linaro.org>
Date:   Sun, 15 Jan 2023 15:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ARM: dts: omap: gta04: add BNO055 IMU chip
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230113221058.2355840-1-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113221058.2355840-1-andreas@kemnade.info>
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

On 13/01/2023 23:10, Andreas Kemnade wrote:
> There is finally a driver upstreamed, so add the
> device.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/omap3-gta04a5.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
> index 0b5bd7388877..4f56f7fc0d1b 100644
> --- a/arch/arm/boot/dts/omap3-gta04a5.dts
> +++ b/arch/arm/boot/dts/omap3-gta04a5.dts
> @@ -75,6 +75,11 @@ OMAP3_CORE1_IOPAD(0x2138, PIN_INPUT | MUX_MODE4) /* gpin114 */
>  		>;
>  	};
>  
> +	bno050_pins: pinmux-bno050-pins {
> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x2136, PIN_INPUT | MUX_MODE4) /* gpin113 */
> +		>;
> +	};
>  };
>  
>  /*
> @@ -136,4 +141,13 @@ bme280@76 {
>  		vdda-supply = <&vio>;
>  		vddd-supply = <&vio>;
>  	};
> +
> +	bno055@29 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "bosch,bno055";
> +		reg = <0x29>;

Best regards,
Krzysztof

