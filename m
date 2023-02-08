Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61B468FA35
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjBHWWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 17:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBHWWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:22:45 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B1E1E1F6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 14:22:44 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p9so1210227ejj.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 14:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MotCSoryy538dU4sd/kPxvSQk611e3lP3KbTp/tMf6I=;
        b=WAEy0xb6CZ9HX0fSxjBWNO3YpfUlG1EC4sjqWKhhRioOTgsftejtx4dU6u0d9COCSJ
         9ZWAEYkL8/1+Fi3/S1TF2Uohgj3GCJ0X8wo900pw+vmp99WZUyPYW8DbnBp6PBTKlhrC
         0uapyTl0x2KzhcdKiKmt8wfEk4YHVlVoC8mBkwR7bal+oP/hWSx0fBHggUo3K0tKwq9T
         MpEsZFGHKVyMzshrh6eS90qdVTUg5gvU3GZ7b880+2PR/4Vxh9Z2PCDOL7kH/VtBlUs0
         JCYgOoIeAHrnpe3ySH0iGe1R8L4Tp3KmHl1CaRtjTTNpPDqqf/X5r9W6YeJ0Kbhh9rSd
         AXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MotCSoryy538dU4sd/kPxvSQk611e3lP3KbTp/tMf6I=;
        b=NE6bAP78bBFUDgEEbxz/l2rfTfeDkrdk4hLbv7l6I4nX5UPI+G8Ie6bRbqO6BBqcz9
         iUp7aSpY4yu4iUnBfMWTzXe9pZVUv0SFXEYj8eMkxE0QeeSfcrM2tMrBSAfLj+Jo6+CN
         xKB5oQSkYn3P+OolGI5HOJxlpfv9iovTDFHy1m1be8Mf6lI5NQn/blpcbhZU66wTsvGb
         xcSUxFSTaZX92Ya8OAvdRwheGz1Tx4biw1PY3/sKs8aiCFKXdrw7nTqioUl4upq0mJfV
         nQhbZu3yB38QkxzbB1yeJV+Gk/mZU6oMhzF2sFaecM+NvuPKNwt7cQXEwEa8rQR5aZAD
         H+fg==
X-Gm-Message-State: AO0yUKVxBl+AvUFcmjo8MR2Ze2RaO1WD3UTAH9wIMfKQNhu2PG4GOKM3
        7zHrHHUO5H7nP/DV+jULDwQ=
X-Google-Smtp-Source: AK7set+BZTkMVkd8cQ484owCwlv4swQ/ZhotrgNghCkCvzTyQSH7VGC9J9jY1hYBHyznSRGnKy9THw==
X-Received: by 2002:a17:906:3009:b0:896:427b:148 with SMTP id 9-20020a170906300900b00896427b0148mr9298998ejz.1.1675894962898;
        Wed, 08 Feb 2023 14:22:42 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f20-20020a170906c09400b00872c0bccab2sm33928ejz.35.2023.02.08.14.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 14:22:42 -0800 (PST)
Message-ID: <a021950c-f3d8-8623-4b8f-76c70751c005@gmail.com>
Date:   Wed, 8 Feb 2023 23:22:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        walter.chang@mediatek.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
 <e1a89a4e-8a0d-47e1-a8fd-75ea152ef816@linaro.org>
 <ad3a5c30-5062-55ae-7908-c0a127bec5ee@gmail.com>
 <3bbc55b8-6b12-4e81-026d-75e0c9116a7b@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/3] time/sched_clock: Export sched_clock_register()
In-Reply-To: <3bbc55b8-6b12-4e81-026d-75e0c9116a7b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2023 20:45, Krzysztof Kozlowski wrote:
> On 08/02/2023 20:41, Matthias Brugger wrote:
>>
>>
>> On 08/02/2023 15:24, Krzysztof Kozlowski wrote:
>>> On 08/02/2023 10:48, walter.chang@mediatek.com wrote:
>>>> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>>>>
>>>> clocksource driver may use sched_clock_register()
>>>> to resigter itself as a sched_clock source.
>>>> Export it to support building such driver
>>>> as module, like timer-mediatek.c
>>>>
>>>> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>>>> ---
>>>>    kernel/time/sched_clock.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
>>>> index 8464c5acc913..8e49e87d1221 100644
>>>> --- a/kernel/time/sched_clock.c
>>>> +++ b/kernel/time/sched_clock.c
>>>> @@ -150,8 +150,7 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
>>>>    	return HRTIMER_RESTART;
>>>>    }
>>>>    
>>>> -void __init
>>>> -sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
>>>> +void sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
>>>
>>> Is there a non-init caller?
>>>
>>>>    {
>>>>    	u64 res, wrap, new_mask, new_epoch, cyc, ns;
>>>>    	u32 new_mult, new_shift;
>>>> @@ -223,6 +222,7 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
>>>>    
>>>>    	pr_debug("Registered %pS as sched_clock source\n", read);
>>>>    }
>>>> +EXPORT_SYMBOL_GPL(sched_clock_register);
>>>
>>> Where is the module using it?
>>>
>>> You need to bring users of these two changes, not just prepare something
>>> for your out of tree patches.
>>>
>>
>> I'd propose to add at least one driver that will need these changes, to make it
>> clear why you need that.
> 
> ... and actually test if the system works fine when booted from such
> clocksource as a module. I have doubts that and unfortunately folks
> working on GKI like to put whatever stuff from mainline into modules
> even if it does not make sense for us (see long time ago discussion
> about pinctrl drivers).
> 

Yes thinking about it twice, it makes only sense if  the Arm architecture timer 
is running. Otherwise the system will hang on boot. I know that older MediaTek 
devices had problems with that...
