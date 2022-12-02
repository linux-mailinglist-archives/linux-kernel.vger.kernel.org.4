Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578D8640696
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiLBMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbiLBMSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:18:03 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587CA8327B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:18:01 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id h4-20020a1c2104000000b003d0760654d3so4926396wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHgNmHDnA5SD633JPxirW6UGDGW4b+HyfSkSWUsXE/E=;
        b=KJVXuoKaLTKZljvCA91urJo025OVAQF+sp5bccUJMcwMgzhzOR39lOngLzAZVAo1BT
         ddSvxq2KGqvF5557gD2VB0jcTsiAeb9j0rWLxV3IDX7vSHmSuxk9G4QqeagVPQofxUza
         xrMorV+jPGtbgnqM/TBBlWLTALprVW3rabVh1PGy9lYBIGuF5vCIBH1umx4nEk4raQJr
         Dk95EVopsztZTiHAXKlq4NSJwRM26XpCSJa84PmE4NWfpFq9GDZbAeUgmaA+gD9vebyg
         zIxvLmxWjb9eNURuN/rGm/HYcnnQY35fB+4Hzh97fHtPsKLqrEVU9UeOIgv8+bBlbQDv
         Qrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHgNmHDnA5SD633JPxirW6UGDGW4b+HyfSkSWUsXE/E=;
        b=E1WEb2W6Ka+GvdFumc7Q68xjGecOejP9V3STGKecjoz2+BWo3wJI/Wd4byRS/uFGym
         OoRz1Yp8H/isbaAwgj00fFBUpZyaT0IYZq8lSpUauvLEGPjpBrz8KsNQvjJUzKqdjvqL
         7Iou7fL+1D/4JKFJMjcbMuklhyXxSV8pdcEYkyvkSfW6uj/DiCmmvJ2pM6h5iOoTnF4Q
         Zn3EbfSJJH6gmxeTvWVntaM5xx/lpgtFgnl+kSZAeFX+0Ndxo5GOAuSMSEsYd4QCaBHy
         AHchPyBkmhrD4LRLWgKhZ5gZGsoWrWhui5+yLmac7BNKPEXUhv/EvI5ZfLfwX+5TXuIM
         8XNA==
X-Gm-Message-State: ANoB5plu8nokNTaZ/+PzCz/FNkTJwIGDEcongypyMhX4dDydgqwXbK1h
        r5lWOOjgFwT1DBzJ0fwE74C2cQ==
X-Google-Smtp-Source: AA0mqf6bG8bjYAbK9gnIWuOEfLW6MEdpMIqGt4avKEBpHoyAmGuSFJUbIbzVYVU/RrmbQ+LTIQDuuw==
X-Received: by 2002:a05:600c:3b0c:b0:3cf:8df2:63b7 with SMTP id m12-20020a05600c3b0c00b003cf8df263b7mr37844470wms.11.1669983479724;
        Fri, 02 Dec 2022 04:17:59 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id he10-20020a05600c540a00b003b4a699ce8esm11605840wmb.6.2022.12.02.04.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 04:17:59 -0800 (PST)
Message-ID: <7b42f6ec-cb8c-f2b5-e92b-3ee00230214e@linaro.org>
Date:   Fri, 2 Dec 2022 13:17:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 10/30] clocksource/drivers/arm_arch_timer: Use
 kstrtobool() instead of strtobool()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <f430bb12e12eb225ab1206db0be64b755ddafbdc.1667336095.git.christophe.jaillet@wanadoo.fr>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <f430bb12e12eb225ab1206db0be64b755ddafbdc.1667336095.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2022 22:13, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is part of a serie that axes all usages of strtobool().
> Each patch can be applied independently from the other ones.
> 
> The last patch of the serie removes the definition of strtobool().
> 
> You may not be in copy of the cover letter. So, if needed, it is available
> at [1].
> 
> [1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
> ---
>   drivers/clocksource/arm_arch_timer.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index a7ff77550e17..1af045b231fd 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -18,6 +18,7 @@
>   #include <linux/clocksource.h>
>   #include <linux/clocksource_ids.h>
>   #include <linux/interrupt.h>
> +#include <linux/kstrtox.h>
>   #include <linux/of_irq.h>
>   #include <linux/of_address.h>
>   #include <linux/io.h>
> @@ -97,7 +98,7 @@ static bool evtstrm_enable __ro_after_init = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EV
>   
>   static int __init early_evtstrm_cfg(char *buf)
>   {
> -	return strtobool(buf, &evtstrm_enable);
> +	return kstrtobool(buf, &evtstrm_enable);
>   }
>   early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
>   

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

