Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90372BBD2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFLJOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjFLJNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:13:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387234C1D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:07:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30ae141785bso3800379f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686560829; x=1689152829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ALIq+EfBjjDuq9C6qScccN3SzZCAcSKnABbFzkS/tA=;
        b=jUQCmi8C9INCz6PusbgHt8ozZvFHq+MkPgx7w99W4qdxMwkqzIwQrAgZX10wHogWs+
         MWqQAbhHBX+xg/ZvKkgKnt/qT2htAo0Q/Lz/giT7tXbLvrY60RsRkyJrFFx1iwBbmFIf
         7OSzNbu/aQ6B2qg3Ks4Cz8UsWIfaMACUoAW9EZEYdA9voeXu+M925i5D9RZ793o155aZ
         OYZQs5LfjoTjIYefaKaClzFCSD6CO9f4HaFBjAaZgi75KLYfS2IgTsg8Ofha0xuEqVGl
         gFUBi5OhX+evzMPkextYpITqK5+4MlD/S2nuEZYFzR/CJlbn89iAKBaEvWELDGNrN1A6
         IgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686560829; x=1689152829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ALIq+EfBjjDuq9C6qScccN3SzZCAcSKnABbFzkS/tA=;
        b=VIQrxGQZ3nQVh+yG69po8q375uS8ET2169haOXXJegPYpCe+wofx5tSPFPMdTbfXDS
         BlHx9tw/xkwc/+EAI0BbgTiVqLeSeV0MlYX3ncr3QtK0xHIBKozF/LEfWCCoAvgEmSTq
         COvAqd1QXZH7pQeh2GbiOXhoBmKXezN/qIbEibhvdIC4dqCiZOMOb/Ud21OF8B0VPTNT
         ADo/aP7zrg5VgMeq+pQph4OfmTt25wWDKr2essv+B2mJF3BBgr/Senby8PcRNL13Ms5j
         Y3qgPLG0mqexx1Gg0DTZyVC7l3YYYuBxXZdBEbJve1yzOQ8U9fzfvNDdR/Ra/DiUjeEj
         htMw==
X-Gm-Message-State: AC+VfDwligS0gbFN2jVv/Oced1hyI29u1SBH7CPzQrq4bB1LWptSLwng
        o8YXYNrBnpw8emMJMoxBByNuiw==
X-Google-Smtp-Source: ACHHUZ7zgf6EwcNan6tjDOVOTBgZ8Y8StQPZIaCrQwu+Z8SzaRmyK4CUlJlcW4Lvqec79vSW7GduCA==
X-Received: by 2002:a5d:5050:0:b0:30f:c56c:b5a6 with SMTP id h16-20020a5d5050000000b0030fc56cb5a6mr887326wrt.4.1686560828937;
        Mon, 12 Jun 2023 02:07:08 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb02:9baa:82d1:2486? ([2a05:6e02:1041:c10:bb02:9baa:82d1:2486])
        by smtp.googlemail.com with ESMTPSA id u8-20020adfeb48000000b003062b2c5255sm11875361wrn.40.2023.06.12.02.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:07:08 -0700 (PDT)
Message-ID: <3c501536-2620-0022-df93-415d490fc1a5@linaro.org>
Date:   Mon, 12 Jun 2023 11:07:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal: Allow selecting the bang-bang governor as
 default
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230609124408.3788680-1-thierry.reding@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230609124408.3788680-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thierry,

On 09/06/2023 14:44, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> For many setups the bang-bang governor is exactly what we want. Many
> ARM SoC-based devices use fans to cool down the entire SoC and that
> works well only with the bang-bang governor because it uses the
> hysteresis in order to let the fan run for a while to cool the SoC
> down below the trip point before switching it off again.

Yeah, that trip point detection is screwed up at the moment, but we are 
on the way to solve that. From there, we should be able to have the 
step_wise governor working as the bang-bang governor and remove this one.

Meanwhile, the change sounds ok for me.

Rafael, may I pick this change?



> The step-wise governor will behave strangely in these situations. It
> doesn't use the hysteresis, so it can lead to situations where the fan
> is turned on for only a very brief period and then is switched back off,
> only to get switched back on again very quickly because the SoC hasn't
> cooled down very much.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/thermal/Kconfig        | 8 ++++++++
>   drivers/thermal/thermal_core.h | 2 ++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 4cd7ab707315..19a4b33cb564 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -130,6 +130,14 @@ config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
>   	  system and device power allocation. This governor can only
>   	  operate on cooling devices that implement the power API.
>   
> +config THERMAL_DEFAULT_GOV_BANG_BANG
> +	bool "bang_bang"
> +	depends on THERMAL_GOV_BANG_BANG
> +	help
> +	  Use the bang_bang governor as default. This throttles the
> +	  devices one step at the time, taking into account the trip
> +	  point hysteresis.
> +
>   endchoice
>   
>   config THERMAL_GOV_FAIR_SHARE
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 3d4a787c6b28..17c1bbed734d 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -23,6 +23,8 @@
>   #define DEFAULT_THERMAL_GOVERNOR       "user_space"
>   #elif defined(CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR)
>   #define DEFAULT_THERMAL_GOVERNOR       "power_allocator"
> +#elif defined(CONFIG_THERMAL_DEFAULT_GOV_BANG_BANG)
> +#define DEFAULT_THERMAL_GOVERNOR       "bang_bang"
>   #endif
>   
>   /* Initial state of a cooling device during binding */

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

