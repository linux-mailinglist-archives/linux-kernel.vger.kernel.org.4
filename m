Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFAB622617
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiKIJBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiKIJB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:01:28 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B966C1E71D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:01:27 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d6so24691759lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1a1mOukpjZMpytvxM2kXqldwAWWniF6ta8Ydmp7QzLw=;
        b=IZgM1hh+z0BQ2E3Fqj0VA1ZHvbGxq520EA2WHINZwRQLlqpXD2kX13+/82sX9lFzIW
         WnXNDmanTYda/Rh0cmt0OrQjkzjhDoC1WLXpXn7mJvQzUU1C0KEe3rztFGKSEle0o5nW
         03VLg4Wb6MA8D2033+D6r0yIkMD5qMFrgxyWryNux5McAIoe+HgRPlpG/c96N0sfXSxu
         veTEPxDuDdb1srPLPWdhg86cXdcc1oFXb4KvjsYIZTL2vOsQsFcpIlhap/GdRfSNnL/v
         QgdnjS/ZxEdqRENARJAUOqLjPuFm6qXdsWW77N/wzjPnS/1vc/A5i3r9MJZj8L5Ywuc6
         1jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1a1mOukpjZMpytvxM2kXqldwAWWniF6ta8Ydmp7QzLw=;
        b=6qp8uF8p6RR/UTSc4MWdVv7Z/UeuKxrRFPL9UlSHa9HGm4NWt0ZPxPECoEjEA5fdhk
         jedSN25s7svV4eK+aPTC8hpt5i4zsBUwpgxI8f+xVEFck9GoXB3NZPZapchOGR+eySn6
         2qvCHAInBhrJW+x78KLUJ1b08Sw8G4/ZlKg2fN+uJ7oXL4DGbMV9zL3giohtc17F+fuk
         Synu3nRcn3iWZBoaN6OfEhQmLjBdsE/V2fxAzIATK28O2Dodi7ARmZfVlhDQNl6jD0pU
         3HVtyva48erhu0hxzf6wRokO5e/8B40QgoH9Tv2/VyMe/H/52wRYHgZ6YIdpuKlthFgM
         0tWg==
X-Gm-Message-State: ANoB5pli3iE9mnZKcFenWfXIZr+IoOfiT53v7MYfRnk9MR2MUZL3b5Nc
        z/ZPyxdHh5g4PwCaC54fvQm0vA==
X-Google-Smtp-Source: AA0mqf4uoEqA8KNrUAFsRkFyLE2gNKVscNyuAqOjd26cEx666TZUqZQVuCN/Il0PGwxsYSAE3hgL4w==
X-Received: by 2002:a05:6512:2187:b0:4b3:cf9f:c20 with SMTP id b7-20020a056512218700b004b3cf9f0c20mr4281038lft.3.1667984485925;
        Wed, 09 Nov 2022 01:01:25 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id f18-20020a2ea0d2000000b0027776efa48csm2045155ljm.91.2022.11.09.01.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:01:25 -0800 (PST)
Message-ID: <10f47cb6-3632-dd1e-23a3-86c4fd5d62c8@linaro.org>
Date:   Wed, 9 Nov 2022 10:01:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v2 3/3] arm: dts: exynos: Rename compatible string
 property from version to SoC specific
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com
References: <20221109035507.69086-1-aakarsh.jain@samsung.com>
 <CGME20221109034811epcas5p4ecd94497380c5342258fc1dac7f99956@epcas5p4.samsung.com>
 <20221109035507.69086-3-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109035507.69086-3-aakarsh.jain@samsung.com>
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

On 09/11/2022 04:55, Aakarsh Jain wrote:
> commit "752d3a23d1f68de87e3c" which adds MFC codec device node
> for exynos3250 SoC. Since exynos3250.dtsi and exynos5420.dtsi are
> using same compatible string as "samsung,mfc-v7" but their
> node properties are different.As both SoCs have MFC v7 hardware
> module but with different clock hierarchy and complexity.
> So renaming compatible string from version specific to SoC based.
> 
> Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 326b9e0ed8d3..98105c64f7d9 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -485,7 +485,7 @@
>  		};
>  
>  		mfc: codec@13400000 {
> -			compatible = "samsung,mfc-v7";
> +			compatible = "samsung,exynos3250-mfc";

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Best regards,
Krzysztof

