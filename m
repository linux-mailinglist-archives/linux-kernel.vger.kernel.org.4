Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F81468F837
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjBHTlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBHTli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:41:38 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871424C0F3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:41:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p26so53703252ejx.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 11:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7z310ECkIF8ZIDTjgg46Q2v6BcKj9bWP+Nfq0LTJRc=;
        b=Mroeh/8th/XwtYv26Sgqcd48ZPjIM1GUF974znlhRjfZMzt2NBOUrJhxf7RIgxdDkX
         cjiQSKg89WtgJMu4Vw3siG+9stoukZwpl20r0BgqVAkXaP3j9SJFMxA45X/I8ve1J9uO
         r1f3NcKfvVXNm8LkAJKQyDU3+DWG9+UFA6BLw6OGRADHQZAjHD57rUCDXjpTEGvdh/Zp
         G7OW2rvcRBH72JEzh28dr9xS0wkAO4Q0ZrbY+XL7S3q/IRRud85UNkhtxnYuW0eD29GJ
         7eqvbTm7IrMdSgHUB7g16F1Ij2ErtE6TFlkjgUSalGuQmVId08GzmKgR67kL386yhLoq
         Q1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7z310ECkIF8ZIDTjgg46Q2v6BcKj9bWP+Nfq0LTJRc=;
        b=vEEsgw2f47VcZmgf3GRMwTKX3BfS5Nmg5VJXGqR3z6bOgSGgeA3XrFyb0I4xPLvXY6
         HqwvmPvO0YhFK21iaM9BcV6MN9YajmtusPbCW792grLNkJZuGGjbaqD5kYg1/N65KGGo
         9gZRLterjTd3aTubPK23NC7b9LCakMY746Fvi9g/n6d1xDde1bb9iPVnDWBWFvLShvPP
         paSO8xv++QZfc01VfGA9Bee8GyPsXRy/0dwDk4Et+6rnWZt9gVU39I6YD0taPY8lkeMi
         McQsnFYWbtOSTbsphhwWUx2wStikNZ+wt1JBbdXXFvUM1mKSYg1S5KrOOsRZe26X5Q7V
         f5+A==
X-Gm-Message-State: AO0yUKVBJfDlbDb8Ws6v9g3/NVInKxTNc4nefVof4mEVFgImUAzalunV
        KGZQWKnRnOfBgKg1RTCka6Q=
X-Google-Smtp-Source: AK7set83+61MVaW4S6ceQAaGahYCU3F+Hgxy4cs9xFCZi6NAZ1C3uFpcRZ2vZUKegoRj8a/2D9BL8A==
X-Received: by 2002:a17:907:d19:b0:884:26ec:388b with SMTP id gn25-20020a1709070d1900b0088426ec388bmr11909072ejc.39.1675885294997;
        Wed, 08 Feb 2023 11:41:34 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g18-20020a170906595200b00878775876c5sm8759827ejr.73.2023.02.08.11.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 11:41:34 -0800 (PST)
Message-ID: <ad3a5c30-5062-55ae-7908-c0a127bec5ee@gmail.com>
Date:   Wed, 8 Feb 2023 20:41:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] time/sched_clock: Export sched_clock_register()
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
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <e1a89a4e-8a0d-47e1-a8fd-75ea152ef816@linaro.org>
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



On 08/02/2023 15:24, Krzysztof Kozlowski wrote:
> On 08/02/2023 10:48, walter.chang@mediatek.com wrote:
>> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>>
>> clocksource driver may use sched_clock_register()
>> to resigter itself as a sched_clock source.
>> Export it to support building such driver
>> as module, like timer-mediatek.c
>>
>> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>> ---
>>   kernel/time/sched_clock.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
>> index 8464c5acc913..8e49e87d1221 100644
>> --- a/kernel/time/sched_clock.c
>> +++ b/kernel/time/sched_clock.c
>> @@ -150,8 +150,7 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
>>   	return HRTIMER_RESTART;
>>   }
>>   
>> -void __init
>> -sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
>> +void sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
> 
> Is there a non-init caller?
> 
>>   {
>>   	u64 res, wrap, new_mask, new_epoch, cyc, ns;
>>   	u32 new_mult, new_shift;
>> @@ -223,6 +222,7 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
>>   
>>   	pr_debug("Registered %pS as sched_clock source\n", read);
>>   }
>> +EXPORT_SYMBOL_GPL(sched_clock_register);
> 
> Where is the module using it?
> 
> You need to bring users of these two changes, not just prepare something
> for your out of tree patches.
> 

I'd propose to add at least one driver that will need these changes, to make it 
clear why you need that.

Regards,
Matthias
