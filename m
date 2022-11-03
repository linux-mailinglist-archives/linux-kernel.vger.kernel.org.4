Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D8617C95
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiKCMcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiKCMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:32:25 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15940101EF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:32:22 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id z30so942482qkz.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=89rx9VoTuC7g0qdb+V9KXopipeQYjCJGbZv00TdzOE0=;
        b=o5XhGT3dISsj0AhS0b8oU+q8yJWUjiD72PhTzij8ETk1QUUINlo6rvo8zmajQJGfo+
         zw6P6xP6WrXb3robzpR0tTKmrWWsIKPkAUAYt8KNBf0QMt8XJ/wAew8nk2YEkzz0Ddc+
         cx+lqnvGPpUEJwspAMnxEDd/i7SwSTC4eND6ks7RF1dTo7x1eDxgVrLfHhTGRhoT8xEX
         LPgHAhnHd6tLdJjnFXlre+9s5AQ7OUl4qwXGt/1X9ofKUQ420k8icdNc5gy6q/zkhJNM
         YBbSSEiITM/KxP65d9YzXQjV51o9iMAeWNAYN9T2vMZfPM4FXdoDWdTmnLOODPS+GaB2
         KC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89rx9VoTuC7g0qdb+V9KXopipeQYjCJGbZv00TdzOE0=;
        b=aEKm1s2ialcjQqDjAMQKojRssVK98ugcOo4C7sC6uXt/KH18pu/kryc/b7mbveA9J+
         /TjrgbBgzyF/vc8Oh7xI2V8mEmh9Ug/kMYlB8E0h6tuZqIGV0I0S31kqfxgg2bojksLP
         7c01aX7tmVtmvKZoBXW5MDGCeuXbilgsf5lWvDZ0mMWLTI5JHcTtGu99ZOyRZHUyLzas
         G/L6FdZEG1nTiaNBrb4ctP7GZaOCG8hTK767/tyzDjfzJCLccNv421pljdxPZhEJLtmJ
         sZBUM5AR1j+U9WsYfN8vQR3jCz9++NSSYvgwHm9G1fwM/pilD0YsNEEXMJ3TtY8L5TuH
         kWmg==
X-Gm-Message-State: ACrzQf1p/B05hFFHmvjGxJE3NFoYOVQ2NL5GJ5mAuN214PuY9uXmpvqx
        zTqWGKtThkSCE9m+zyR/Wm3ezg==
X-Google-Smtp-Source: AMsMyM7hhWYMwJIM/iYR0o/zA8dGOdK9n2c0soG1TcplmfzHJ5MkF8+DyVZ18OIDEmGq/K2JbY6Wtg==
X-Received: by 2002:a05:620a:4146:b0:6fa:c8e:b60 with SMTP id k6-20020a05620a414600b006fa0c8e0b60mr22054168qko.454.1667478741073;
        Thu, 03 Nov 2022 05:32:21 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id cn6-20020a05622a248600b0035cd6a4ba3csm450573qtb.39.2022.11.03.05.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 05:32:20 -0700 (PDT)
Message-ID: <372b6da1-62a7-6204-5d02-8a4abb22c4ab@linaro.org>
Date:   Thu, 3 Nov 2022 08:32:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/3] arm64: exynos: Add new compatible string for
 Exynos3250 SoC.
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
References: <CGME20221102125810epcas5p36e6caf41f602debe17f25f13969fd6dc@epcas5p3.samsung.com>
 <20221102130602.48969-1-aakarsh.jain@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102130602.48969-1-aakarsh.jain@samsung.com>
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

On 02/11/2022 09:06, Aakarsh Jain wrote:
> Exynos3250 uses the same compatible as Exynos5420, but both
> the MFC IPs found in these SoC are different interms of clock
> property. So using same compatible for both SoC is not correct.
> Lets have a separate compatible for Exynos3250 and Exynos5420
> to differentiate these SoCs.
> 
> Suggested-by: Alim Akhtar <alim.akhtar@samsung.com> 
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  Documentation/devicetree/bindings/media/s5p-mfc.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> 
> We are already in process of converting this txt file to yaml.
> https://patchwork.kernel.org/project/linux-media/patch/
> 20221011122516.32135-2-aakarsh.jain@samsung.com/
> modifying this txt binding for completeness.
> 
> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> index aa54c8159d9f..4ff1898e5a51 100644
> --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> @@ -11,9 +11,10 @@ Required properties:
>  	(a) "samsung,mfc-v5" for MFC v5 present in Exynos4 SoCs
>  	(b) "samsung,mfc-v6" for MFC v6 present in Exynos5 SoCs
>  	(c) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
> -	(d) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
> -	(e) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
> -	(f) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
> +	(d) "samsung,exynos3250-mfc" for MFC v7 present in Exynos3250 SoC

This should be followed by mfc-v7 fallback.

> +	(e) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
> +	(f) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
> +	(g) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
>  
>    - reg : Physical base address of the IP registers and length of memory
>  	  mapped region.

Best regards,
Krzysztof

