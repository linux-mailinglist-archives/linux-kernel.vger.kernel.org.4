Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403ED68F840
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjBHTpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBHTpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:45:20 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E567D98
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:45:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bk16so17913064wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 11:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcpu1yCq+3DBiPRJXefpNsm5ZTj36dGxZgbWh1zl2Wc=;
        b=OUMIe+EUTora5rHVb+d21xKIyvYPdoz406FHHrW6RSmrr1mUDgKsVQDeH0UKgh22Ql
         AtTKQpt0qbnCacxQygthd0EDmjV/qKaKc+to1IA9AfGNjW/r7gZM8fRMa4CBMeDVirVH
         G/aTyA7IVNX2EYsBQdifTzOYosyRRwM7OPiBahplZxkVL0sfEHSXmwtdOg1VqJpJn22b
         +xOE6LbTvh2BABTFmRV8ovZxc0IegFcGAMwsn9E3+wGKPtQWdvC7zscxO6ZoIsNNzJRG
         CyWVUPOn0Cr7iRhP2jBUMSziSQE7Uuu0fbuWY+PNi3E8yBqf9g4BD1q/wqwZIAaKxWGu
         c7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcpu1yCq+3DBiPRJXefpNsm5ZTj36dGxZgbWh1zl2Wc=;
        b=1iGLZdSeFJaYd7MRq9I22PtbMuG5ZwpFp5+5DcyMx4HpVRUQnKmNZ1VWMsHw7yPJSe
         LBVIL6LLsh374NnFQo0M27YbTR/iIhC6uXEI+9Tgq4vlwawMbeHt3sKBcthcaQ9FQpfz
         aDikYhQqQbPJJrXLpgrJgUMMGIqRpFaP4kH6lHSEcJ51zD7/72MuRjf9tJpzKR2WfDGO
         XztVbJjO0w+rg3ou5yNRZMapjHJ3WMzAgi7S9YD14mmsKnQew6sc74Fjt3G6t/ArRUNZ
         mr7TwyIEKH1ec2QtKGUSzNe9sDOFvOqj4mkmnQ6lWL4qcPpuQREeUVR5HMspfgeIIDKT
         RxLg==
X-Gm-Message-State: AO0yUKVQ1qq95BPU+aQWdOnFjq/lMry7W7cAeBud5cM6NQDfIhGPjZUO
        zYjtSyiJxJ4SBt9IzldzGj6tRA==
X-Google-Smtp-Source: AK7set/cLC16HbjIHc8L0GJze/Ks8KeQf93wbv9Iks6HkOhitRKQ6p3rFwPCVNyTYlGFAalDdr7o7w==
X-Received: by 2002:adf:dcd2:0:b0:2c3:db61:20ec with SMTP id x18-20020adfdcd2000000b002c3db6120ecmr7936860wrm.23.1675885517564;
        Wed, 08 Feb 2023 11:45:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a18-20020adffad2000000b002c3f280bdc7sm4802289wrs.96.2023.02.08.11.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 11:45:17 -0800 (PST)
Message-ID: <3bbc55b8-6b12-4e81-026d-75e0c9116a7b@linaro.org>
Date:   Wed, 8 Feb 2023 20:45:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] time/sched_clock: Export sched_clock_register()
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ad3a5c30-5062-55ae-7908-c0a127bec5ee@gmail.com>
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

On 08/02/2023 20:41, Matthias Brugger wrote:
> 
> 
> On 08/02/2023 15:24, Krzysztof Kozlowski wrote:
>> On 08/02/2023 10:48, walter.chang@mediatek.com wrote:
>>> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>>>
>>> clocksource driver may use sched_clock_register()
>>> to resigter itself as a sched_clock source.
>>> Export it to support building such driver
>>> as module, like timer-mediatek.c
>>>
>>> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>>> ---
>>>   kernel/time/sched_clock.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
>>> index 8464c5acc913..8e49e87d1221 100644
>>> --- a/kernel/time/sched_clock.c
>>> +++ b/kernel/time/sched_clock.c
>>> @@ -150,8 +150,7 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
>>>   	return HRTIMER_RESTART;
>>>   }
>>>   
>>> -void __init
>>> -sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
>>> +void sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
>>
>> Is there a non-init caller?
>>
>>>   {
>>>   	u64 res, wrap, new_mask, new_epoch, cyc, ns;
>>>   	u32 new_mult, new_shift;
>>> @@ -223,6 +222,7 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
>>>   
>>>   	pr_debug("Registered %pS as sched_clock source\n", read);
>>>   }
>>> +EXPORT_SYMBOL_GPL(sched_clock_register);
>>
>> Where is the module using it?
>>
>> You need to bring users of these two changes, not just prepare something
>> for your out of tree patches.
>>
> 
> I'd propose to add at least one driver that will need these changes, to make it 
> clear why you need that.

... and actually test if the system works fine when booted from such
clocksource as a module. I have doubts that and unfortunately folks
working on GKI like to put whatever stuff from mainline into modules
even if it does not make sense for us (see long time ago discussion
about pinctrl drivers).

Best regards,
Krzysztof

