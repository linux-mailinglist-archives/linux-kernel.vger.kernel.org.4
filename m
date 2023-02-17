Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AF169A751
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjBQIr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjBQIr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:47:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A630C5F811
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:47:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ee31so3060237edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxihBAJijOKWkC1DDpICuhn4t5+4cYDnf5ZAevcjFq8=;
        b=L0aHsWYreKItVLEfbGbZWxMmtJwDTCItVW85fLIPOPtbJ0Qkp44qB5GawSf2BLcDeP
         M/2r7kxbk5gakqq+hNO3Nv8Y1j6U61SgIMfvMrZu2Y8cKsx2AL0tTwT7LhT4Hf6UjmtB
         EwiCL61tYlall0Hi+t6R7WwLQNQ8fC/AU39MQH9gBXJBSBuSU7LB8rYDIVK24hutIOge
         aWZdA4EvmMXXc6wE8eE7+oRns0auEt4T+KQq90qOrtiOJre/WkinzpzKZFrLrxV2Ek+6
         aXPAGbRrpQyeRtApfOe9HWujyJRJS3hv6IxakCISk55tBifsXWv60LAUyiM2kEuqOnMD
         yxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxihBAJijOKWkC1DDpICuhn4t5+4cYDnf5ZAevcjFq8=;
        b=rF9Yt/3I3KAIXU0NAhZSFyTqdLrHJPe6Xt09fLZUxc+zhx7OmePOsnFZtXC/Kg2Frq
         p2/VxRYf6Zp0Ze9qefuKKAglLq5PKf/uxnZ/GG6m6XDfX7A8MsE7qtGe22sT61jyCFQF
         oVXULDE08HKIvHuVgt2UZW7oXLRzhU28SeznX6WYyjqq8rxLtkuJJ3LpfuvLthFjU7th
         OM6iJyA37hRb7UvEuOOOA+kuQ09rZaBaDS4HpmGve8MJJyjOQ7kwIkOAggDd51+kqjZm
         DEIksqVvmypKhh6H3CTH548hi8BmWmktOylkZee55QeqfVM5cKOlVWUCDrM6pld0a7m6
         t0Jg==
X-Gm-Message-State: AO0yUKXZzQr9bTMtTi16dpS65ECI7Nb+eXuyHrZCzWW9ODUxlLcVrp3R
        fMtg47C+ntp+hteKPOXh6+lxcw==
X-Google-Smtp-Source: AK7set/xPaakocNl2c8BTFzyTn0kwtOGUwPF5KG2r8yqfPo4qD431YkkX8rraLHa3kMcVilYvJFzsA==
X-Received: by 2002:a17:907:a044:b0:8b1:7eda:702e with SMTP id gz4-20020a170907a04400b008b17eda702emr2241307ejc.32.1676623643174;
        Fri, 17 Feb 2023 00:47:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906a39400b008b14c5a82e7sm1840919ejz.127.2023.02.17.00.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:47:22 -0800 (PST)
Message-ID: <994c3edd-040c-5050-9c99-1e8326459d54@linaro.org>
Date:   Fri, 17 Feb 2023 09:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/2] ARM: at91: dt: adding new macros
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, ludovic.desroches@microchip.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230216222524.3107759-1-Ryan.Wanner@microchip.com>
 <20230216222524.3107759-3-Ryan.Wanner@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230216222524.3107759-3-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 23:25, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Adding macros for sama7g drive strength.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Nothing improved here.

> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
> changes from v1:
> - Fix ABI break.
> - Add some small comments to describe drive strength macros.
> 
>  include/dt-bindings/pinctrl/at91.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
> index e8e117306b1b..12f3edf2a9c4 100644
> --- a/include/dt-bindings/pinctrl/at91.h
> +++ b/include/dt-bindings/pinctrl/at91.h
> @@ -42,8 +42,16 @@
>  #define AT91_PERIPH_C		3
>  #define AT91_PERIPH_D		4
>  
> -#define ATMEL_PIO_DRVSTR_LO	1
> +/*These macros are for all other at91 pinctrl drivers*/
> +#define ATMEL_PIO_DRVSTR_LO	0
> +#define ATMEL_PIO_DRVSTR_LO_1	1
>  #define ATMEL_PIO_DRVSTR_ME	2
>  #define ATMEL_PIO_DRVSTR_HI	3
>  
> +/* These macros are for the sama7g5 pinctrl driver*/

What I mean, is the explanation of the constants. What is LO_D?

> +#define ATMEL_PIO_DRVSTR_LO_D 0

Also looks like wrong indentation between define and value.

> +#define ATMEL_PIO_DRVSTR_HI_A 1
> +#define ATMEL_PIO_DRVSTR_LO_C 2
> +#define ATMEL_PIO_DRVSTR_LO_B 3
> +
>  #endif /* __DT_BINDINGS_AT91_PINCTRL_H__ */

Best regards,
Krzysztof

