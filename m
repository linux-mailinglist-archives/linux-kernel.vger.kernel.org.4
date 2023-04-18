Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA36E6AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjDRRLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjDRRLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:11:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9ED35BE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:11:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dm2so75154232ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681837859; x=1684429859;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFT9JV5GyQiNBSCe1AemNF0qZg+yfPpP2DZKZsBupIQ=;
        b=uTY1Ft02GOPK/nE7NmdYz03m5k1rE5T7q7DsFkj9wWIv9X5Nj829dMM7p3LYlSZhwp
         qoLK+zafpJgGnfuJUTYpoWjHkDgWqyg0OsCsc161Dbt60SRe3wskoW07Arxqvc+ACNPz
         qtCcgsgq/9sNPmToRVrCECVdvpLAMg7RI0mTF9M6TuXFgiYHFCpD8iekawiu1Kn5ZahR
         oaIiBKzB+TDnaeKkmlFI1w/l8qViMIwvHq1rcRDplYeOM+wqLQ/pbW9etV4Q7Pn/b+Ux
         DkATLzqkNCe1eyx8cGMDh2Rp4URG/R4AGMpb8+B5sJmsNGlXevWW3GI7O9XvTYrj8use
         zV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837859; x=1684429859;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFT9JV5GyQiNBSCe1AemNF0qZg+yfPpP2DZKZsBupIQ=;
        b=Puv6lhzaSWJXHjkx3ymnIJhsYKK7YKMxqxNXbw7nGKntAqaaqBI3Jfvq87IKtqGKEF
         F48AkKcT5jk/ezRqVL5wdsbxMIrENDGFxhEkBhuSf3I/Webr4uHhqUhmTalnX+T90F0y
         amd+ZDKCG4Hs1w7joUjtZVuxNw/TL2iGP4Bbfs+Zm9yuHioYwfkiSXr/NSBvam+4mg82
         3A4KCxjd5W3x9FvF4XCJy1bLF2oM64e0dBQwdr1IxZz+UmKB1naagaRgHQehwgHQ7Jqn
         6lgVy2s2pRq06jIYGzh5k7J3wJSV33B4vngpoLeDLJNtJwdCJ6g1rTIY/KKO7KFb7MtB
         Jccg==
X-Gm-Message-State: AAQBX9d2zl12MX7lLATGjFw33XjAJeI14dIoVK212cWix7bJiF5I5PmK
        8RD5fBuj/L1TSpjX12w/VkE96A==
X-Google-Smtp-Source: AKy350bQGNmAiNJ2cQ/83+69tDcOcUCNQ54RcQOnFePP1/Ykji8wIJQX7jULIVWk6a6vCFe34YIDKg==
X-Received: by 2002:a17:906:d8a9:b0:947:72bd:f72a with SMTP id qc9-20020a170906d8a900b0094772bdf72amr11334696ejb.72.1681837859058;
        Tue, 18 Apr 2023 10:10:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id s13-20020a1709060c0d00b0094e729d333fsm8221908ejf.222.2023.04.18.10.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 10:10:58 -0700 (PDT)
Message-ID: <30319890-353e-bf52-fa19-0cc7aeb41074@linaro.org>
Date:   Tue, 18 Apr 2023 19:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 8/9] ARM: multi_v7_defconfig: Add PSU, GPIO, and I2C
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-9-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418152824.110823-9-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 17:28, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add the CONFIG_I2C_GXP, CONFIG_GPIO_GXP, and CONFIG_SENSORS_GXP_PSU

Why?


> symbols. Make CONFIG_SENSORS_GXP_FAN_CTRL=y

Why?

Please briefly provide rationale in the commit msg.

> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 084cc612ea23..fcfbcd233fb8 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -405,6 +405,7 @@ CONFIG_I2C_DAVINCI=y
>  CONFIG_I2C_DESIGNWARE_PLATFORM=y
>  CONFIG_I2C_DIGICOLOR=m
>  CONFIG_I2C_EMEV2=m
> +CONFIG_I2C_GXP=m
>  CONFIG_I2C_IMX=y
>  CONFIG_I2C_MESON=y
>  CONFIG_I2C_MV64XXX=y
> @@ -478,6 +479,7 @@ CONFIG_GPIO_ASPEED_SGPIO=y
>  CONFIG_GPIO_DAVINCI=y
>  CONFIG_GPIO_DWAPB=y
>  CONFIG_GPIO_EM=y
> +CONFIG_GPIO_GXP=y
>  CONFIG_GPIO_MPC8XXX=y
>  CONFIG_GPIO_MXC=y
>  CONFIG_GPIO_RCAR=y
> @@ -527,7 +529,8 @@ CONFIG_SENSORS_NTC_THERMISTOR=m
>  CONFIG_SENSORS_PWM_FAN=m
>  CONFIG_SENSORS_RASPBERRYPI_HWMON=m
>  CONFIG_SENSORS_INA2XX=m
> -CONFIG_SENSORS_GXP_FAN_CTRL=m
> +CONFIG_SENSORS_GXP_FAN_CTRL=y

No, we want it to be module.

> +CONFIG_SENSORS_GXP_PSU=y

Same here.

>  CONFIG_CPU_THERMAL=y
>  CONFIG_DEVFREQ_THERMAL=y
>  CONFIG_IMX_THERMAL=y

Best regards,
Krzysztof

