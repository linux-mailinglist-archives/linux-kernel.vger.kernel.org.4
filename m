Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED59735C41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjFSQoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFSQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:44:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D39DD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:44:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so4676186e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687193056; x=1689785056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NHM0B0vYW8Moj4jOHMcKxrRBWR7x0bZGC3l3qr2YTGA=;
        b=sKgybTjikwRKb87FUK/rDmBirvzBAJ8OQsgp4ESmA/XVMMy/qpWWE9dl6SwkFbgFCA
         QSh0tTX2N+l9Gdf/Rt5rMkDPVGlnHJyVQuEU82HnAYpjQlP2tcJJk9QnXV3TrbaqGBzz
         hjCnclfEJYtIkYGoZXCDFrNJfyRJnbZ/5Zc6444ePEp2Vvj+NHYrJEu2l9Ogc1x7mBpf
         T7QI4E9gnh+8kg5aFUOEQ4ZrLmCjHrQaJGbTl0Lr+Us38KdRROKxbneCV16VXcaYNsGq
         tAWDwrzcoRFEX6/thBNZhisAxe4/jU52Cn+YZ8jpOiTVzcjCalj0rzt9clRHtaktly5l
         gasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193056; x=1689785056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHM0B0vYW8Moj4jOHMcKxrRBWR7x0bZGC3l3qr2YTGA=;
        b=SYETIpSlIigbmRKPKVEbymlfiqRY8lEJrFfZ9yVf2s3EaMii35TYItKl5lOvVeOc4U
         LVp7DItN3U/PpUJFAA/xcQPHPSGva2iGTcVK7Kt4V8ZEYR4YurTa/IGBQlXgQXWLsVT7
         GEHRlx5ecxcm+yrbHsxn7OGVcRYGHWPZJJATYLc0fowEXAxgnNQWF43hcd2k8aCXHcR9
         amYNpK5BlQ0WRPaG1XvshzICt7lueCtfWcIhgWbSjWnR05SxSH3iy6+9YYCkJErOqSh1
         MCOm7rxW0a2ZdCnlrWrvq79Vw2enl+RlG/4M/ZuRWGk+9uX2E7IpJHxptJjZPNLmbwva
         tmJA==
X-Gm-Message-State: AC+VfDwFNerMGmaJCD1MibllT18f0cbhVsKkS/QT+sM77muIn7bkfP+X
        lN5dXAM1Mr4pKTIhQYm1cqry9g==
X-Google-Smtp-Source: ACHHUZ5/Yxl3B5Pw42d+rnSvPpBcVE1TMNul4G+s47SuGjWGX7HYsBA9nvxKaHVAVJyutdH86IGrCw==
X-Received: by 2002:ac2:4647:0:b0:4f4:d324:8b14 with SMTP id s7-20020ac24647000000b004f4d3248b14mr5600175lfo.14.1687193055446;
        Mon, 19 Jun 2023 09:44:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id d22-20020a1c7316000000b003f80946116dsm11237825wmb.45.2023.06.19.09.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 09:44:15 -0700 (PDT)
Message-ID: <4c2f66f1-2623-306f-f1d3-83a32a0c2885@linaro.org>
Date:   Mon, 19 Jun 2023 18:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 0/4] Support timer drivers as loadable modules
Content-Language: en-US
To:     walter.chang@mediatek.com, Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>
Cc:     wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230517022557.24388-1-walter.chang@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230517022557.24388-1-walter.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As I already said, I'm not very comfortable with these changes and the 
potential impact it can have on the overall time framework.

I will pick the series if Thomas gives its Acked-by

Thanks


On 17/05/2023 04:25, walter.chang@mediatek.com wrote:
> From: Walter Chang <walter.chang@mediatek.com>
> 
> This set of patches aims to make SoC related timer drivers, such as
> timer-mediatek.c become loadable modules for the Generic Kernel Image
> (GKI).
> 
> This driver registers an always-on timer as tick_broadcast_device on
> MediaTek SoCs. If the system does not load this module at startup,
> system will also boot normally by using built-in `bc_hrtimer` instead.
> Besides, the previous experiment [1] indicates that the SYST/GPT, in
> combination with a loadable module, is fully operational.
> 
> The first three patches export functions and remove __init markings to
> support loadable timer modules.
> 
> The fourth patch makes timer-mediatek.c become loadable module for GKI.
> 
> [1]
> https://lore.kernel.org/all/32777456f8e0f98e4cd5b950f421d21f71b149cf.camel@mediatek.com/#t
> 
> [v5]
> - Add Signed-off-by tags in all patches
> - Add Acked-by tags and Reviewed-by tags
> 
> [v4]
> - Fix review comments pointed by Angelo
> 
> [v3]
> - Rebase on linux-next
> 
> [v2]
> - Convert timer-mediatek.c driver to loadable module
> 
> Chun-Hung Wu (4):
>    time/sched_clock: Export sched_clock_register()
>    clocksource/drivers/mmio: Export clocksource_mmio_init()
>    clocksource/drivers/timer-of: Remove __init markings
>    clocksource/drivers/timer-mediatek: Make timer-mediatek become
>      loadable module
> 
>   drivers/clocksource/Kconfig          |  2 +-
>   drivers/clocksource/mmio.c           |  8 ++++---
>   drivers/clocksource/timer-mediatek.c | 33 ++++++++++++++++++++++++++++
>   drivers/clocksource/timer-of.c       | 23 +++++++++----------
>   drivers/clocksource/timer-of.h       |  6 ++---
>   kernel/time/sched_clock.c            |  4 ++--
>   6 files changed, 56 insertions(+), 20 deletions(-)
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

