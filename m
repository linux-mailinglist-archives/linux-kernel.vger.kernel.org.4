Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CA76B71DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCMI7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjCMI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:59:04 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E75D461;
        Mon, 13 Mar 2023 01:55:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id by8so11783218ljb.7;
        Mon, 13 Mar 2023 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678697697;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImpBHCFyrs2G1x4Xo3CA/IlfXoLAKLW5YsHHtlvy9dM=;
        b=GnfXQ4m8E4/KGwWO4+keYX8H19rnP1S4ykd8bv9YHHLF3P+MAu59ikntDmpSGhl03F
         c2foLbfFHdUoRdK7J3h6GJ4k3DXKcCZI9g4TSRamXnHZC8mm5yAN0JzFyvUDDbpQySlx
         LeIBgjg0d1jcv1/mPP6ZnW/xi0uU2kC3zBr0r6AC65+um8TqBunvHzmRmGvGEDQasaLl
         0vs7cTvowcrJrMZQqk+PJhDw6Vas9ISlLrkoymT8of+5T2usaDqrZOgrjiuozJlHncy2
         I++nTkEKKqBa+HcBooqR5iEW35ZodNpf3+0lazkHT97HC3g8C+gcbutgwdTh4nlqUdWV
         2lUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678697697;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImpBHCFyrs2G1x4Xo3CA/IlfXoLAKLW5YsHHtlvy9dM=;
        b=HwymmXrw47Vd67qf8IdbP3I72aMWWmmKKixJPs5LVRqIwq7+cEmlJKR0F/SolbUghr
         4DD6dvMe7duq5j6sHtKuR6rYa7FDsyx8s7APW1Qu27XH6YxNUzEkMQuxcanhJftO9K3C
         zk4T1RJgsAUuHjR07ZUUwMof1q4zQ72gXeX892stlDTkGrY6zNZz1wZgF4Ogn+0puetc
         B5YgvKIXqORs4+rjrOZeJQin7irpTL3+kaYSlS4+82mvKIXnyj0hOraa0txuOmpyjZvX
         TeT1WiqiI5KJM6sJaRlxchSjNn4IV1C7E65jc5uELpsPiu1Pdq2Dt01ZiMmAfJFirQpg
         igWw==
X-Gm-Message-State: AO0yUKXbvsm+DUI3rFmnlfEXoUGRGq8IXUxoiZcz/1yFub3HKRbehHBV
        uyYXdPs5JGCklEpYEd0QZwY=
X-Google-Smtp-Source: AK7set+j/EQ5f90GUBgFXJqqkc6VlDiTVTcqakExmn42c2JXJuQC7sGxxYlpveq3fFPWwRW7m44iDw==
X-Received: by 2002:a2e:be8b:0:b0:295:9626:a1fc with SMTP id a11-20020a2ebe8b000000b002959626a1fcmr2949312ljr.26.1678697696788;
        Mon, 13 Mar 2023 01:54:56 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id b18-20020a056512219200b004b550c26949sm901567lft.290.2023.03.13.01.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 01:54:56 -0700 (PDT)
Message-ID: <2ecf0596-2ccf-c760-a2a4-194c27cb74c5@gmail.com>
Date:   Mon, 13 Mar 2023 10:54:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
 <20230304201720.2d554f07@jic23-huawei>
 <4beef812-8f4f-3857-c814-efd9173d49e6@gmail.com>
 <ZAXMx9orQMoNnWr8@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
In-Reply-To: <ZAXMx9orQMoNnWr8@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 13:21, Andy Shevchenko wrote:
> On Sun, Mar 05, 2023 at 03:10:38PM +0200, Matti Vaittinen wrote:
>> On 3/4/23 22:17, Jonathan Cameron wrote:
>>> On Thu, 2 Mar 2023 12:58:59 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>
>>> As per other branch of the thread.
>>>
>>> 	ch0 = max(1, le16_to_cpu(res[0]);
>>>   > would be cleaner.
>>
>> I tried this out. Comparing u16 to literal 1 results comparison of values
>> with different sizes:
>>
>> ./include/linux/minmax.h:20:28: warning: comparison of distinct pointer
>> types lacks a cast
>>    (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>>                              ^
>> ./include/linux/minmax.h:26:4: note: in expansion of macro ‘__typecheck’
>>     (__typecheck(x, y) && __no_side_effects(x, y))
>>      ^~~~~~~~~~~
>> ./include/linux/minmax.h:36:24: note: in expansion of macro ‘__safe_cmp’
>>    __builtin_choose_expr(__safe_cmp(x, y), \
>>                          ^~~~~~~~~~
>> ./include/linux/minmax.h:74:19: note: in expansion of macro ‘__careful_cmp’
>>   #define max(x, y) __careful_cmp(x, y, >)
>>                     ^~~~~~~~~~~~~
>> drivers/iio/light/rohm-bu27034.c:1057:8: note: in expansion of macro ‘max’
>>    ch0 = max(1, ch0);
>>
>>
>> I could work around this by doing:
>>
>> const u16 min_ch_val = 1;
>>
>> ...
>>
>> ch0 = max(min_ch_val, le16_to_cpu(res[0]));
>>
>> but I think that would really be obfuscating the meaning. I assume
>>
>> ch0 = max((u16)1, le16_to_cpu(res[0]));
>>
>> might work too - but to me it's pretty ugly.
> 
> That's why we have max_t() and clamp_val().
> And you know that.

Thanks for pointing out the max_t(). I really missed that. I didn't 
think of the clamp_val() either. clamp_val() would "explain" better what 
we do here - but as we don't have the upper limit using that would (IMO) 
be slightly more confusing.

>> The more I am looking at this, the stronger I feel we should really just
>> write this as it was. Check if res[0] contains the only unsafe data
>> "!res[0]" - and if yes, set it to 1. The comment above it will clarify it to
>> a reader wondering what happens.
>>
>> I will leave it like it was in v2 for v3. If you still feel strong about it
>> then we need to continue rubbing it.
> 
> You need to convert bit ordering first, then check for 0. It would at least
> make more sense. (Today is 0 you are comparing with, tomorrow it might be
> 0xfffe, which is different to 0x7fff).

I don't think being prepared for any other check but the check for 0 is 
meaningful here. Every other value except 0 is valid for this sensor and 
can be accepted as such. Preparing for something that may never realize 
(new sensor with less than 16bits of data) is likely to just make things 
more complicated.

Well, as both You and Jonathan do think we should not just do 
if(!res[0]) - I'll try using the max_t() as you suggested. I still 
really dislike it because it makes it harder (for me) to capture what 
happens here. Well, I try to survive with this and hopefully just read 
the comment above if puzzled when I need to get back to this code.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

