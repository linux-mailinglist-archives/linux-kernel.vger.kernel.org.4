Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5622C68F0AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBHOZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBHOZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:25:15 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623164A223
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:25:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1603274wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CtqUutiexK1fE8rvThH+wZLHHl6K4XsD4uDvkh7n1Y=;
        b=GnDIdcwIDW2t6wPFamBykqJGiJ4n5Zz094w5Bovgac5OrpK0bl1pH9AG+xFbtp6qTP
         Z7HDOBjm1CfPXUOfYND42vjWMbm4Pfku9fqjEYrC/4cyB9YafE9moGWQHRCsgFMVsl/g
         H8er034sSndNUBClfg392ziWuqe27ItqjfydBLlu5Ruj/S5Z3I7HhHOpSGlAEmM+t840
         yJFLFnDQj8EaMimFWUTmClBCcR5A26b+y8i0HFK8ZIeTxMHyrV0om5q5fp0oB6o7Lgk6
         96GOIHBIYDSmGqMiKDn6sETcPmJyhutOX+3rIjjWjX+dNbYJKlPcDXNm0yV4w9MJheC1
         6UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CtqUutiexK1fE8rvThH+wZLHHl6K4XsD4uDvkh7n1Y=;
        b=MStO63hxWlmDpxqjLPs7riO/iGknMhDX9Fwze2QpNYkHOKFpHCXttXURK2pzPPuQyG
         1s1wXWEBRS8Fm5lGOoG+8OuBR8tMCezayT2YvJ/yXi4CZiA2+7xpao4A3wyPAH+1y1g7
         xPHxuCx/uirSBB7S83Dua5o/pQei8BRYamKDaX21+U7byVBATcSqPDhnVgFuP0s+gXy+
         smmDupMD7aswBU2BnVTh9RkzI1DcK5MRXRPlwvyIP5pDdR6vyT6+2EYLRkn64/JeDUng
         DbSQPzurejtMeqk31ddjvp9vNc02SmR5uUhwlyGygxMHM0uJmNIogYsxF45zdpsfGVTT
         ZYlw==
X-Gm-Message-State: AO0yUKX07jLj0KUdq8ZLpcQhSstkWz5PFjndncw1cTO7+y1a1FyYMdbe
        ciZfgHcjYw2ahl7D1q5G1nzXe0UDsuADYPzv
X-Google-Smtp-Source: AK7set8oQQPSSCVq3i/XNX+CokxHBvSTn4BCLWVR+YPp+jCeWNWC5WKvAcN55g7PhhSrYlvIBwBPAQ==
X-Received: by 2002:a05:600c:4d21:b0:3de:e447:8025 with SMTP id u33-20020a05600c4d2100b003dee4478025mr6617024wmp.21.1675866301950;
        Wed, 08 Feb 2023 06:25:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c63-20020a1c3542000000b003df14531724sm2181890wma.21.2023.02.08.06.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 06:25:01 -0800 (PST)
Message-ID: <e1a89a4e-8a0d-47e1-a8fd-75ea152ef816@linaro.org>
Date:   Wed, 8 Feb 2023 15:24:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] time/sched_clock: Export sched_clock_register()
Content-Language: en-US
To:     walter.chang@mediatek.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>
Cc:     wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230208094813.20874-1-walter.chang@mediatek.com>
 <20230208094813.20874-2-walter.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208094813.20874-2-walter.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 10:48, walter.chang@mediatek.com wrote:
> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> 
> clocksource driver may use sched_clock_register()
> to resigter itself as a sched_clock source.
> Export it to support building such driver
> as module, like timer-mediatek.c
> 
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> ---
>  kernel/time/sched_clock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> index 8464c5acc913..8e49e87d1221 100644
> --- a/kernel/time/sched_clock.c
> +++ b/kernel/time/sched_clock.c
> @@ -150,8 +150,7 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
>  	return HRTIMER_RESTART;
>  }
>  
> -void __init
> -sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
> +void sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)

Is there a non-init caller?

>  {
>  	u64 res, wrap, new_mask, new_epoch, cyc, ns;
>  	u32 new_mult, new_shift;
> @@ -223,6 +222,7 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
>  
>  	pr_debug("Registered %pS as sched_clock source\n", read);
>  }
> +EXPORT_SYMBOL_GPL(sched_clock_register);

Where is the module using it?

You need to bring users of these two changes, not just prepare something
for your out of tree patches.


Best regards,
Krzysztof

