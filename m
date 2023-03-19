Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6D96C02F2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCSP7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCSP7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:59:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790D18168;
        Sun, 19 Mar 2023 08:59:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o8so12162891lfo.0;
        Sun, 19 Mar 2023 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679241571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBp/WRjAiZQoToeK2pVl3jtCRBo/LJe2aiZPKWGyDaI=;
        b=C8Q/6M2fVtoVsmBICZ8J5XA4ep5Hh6BgP0WCkq6pQ6KMKSFUi9WtqzFu/w9xtXNt50
         HF9ev/bwoFQ5gQni7+RnGPhCYNgaYAbbibLL31Uwfe+SzShqc0MMkSNGHh3pD05pPHkA
         Htk/91fIH3ugey3pNMwGOA2muO5P8W4JN18tBPusK9NzmOixC/xS5sutMfoQ3C4dK9x5
         dlu85/2GTBqvYpAY9utTVubbUlpW2YRkpXPI507ZvDj85TJRr3wafsm7GIv6OKltB++2
         YyE+CvlTsgezz7E2iJ3j3kB1nIzAlwhaOkDzjOsqStfdqB9Zg9F+pB1V/XrrZJBn1Yiy
         82Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679241571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBp/WRjAiZQoToeK2pVl3jtCRBo/LJe2aiZPKWGyDaI=;
        b=000yRndxAHt9AjystflM2xn1fDvXTjtRn0MYRgFLfCvfF07FLymGhAc5BKp/OVe4G1
         k+dXV85OvhF2xG0vJBHSNODp74+Nb4gAomLMaRodaJrdnJZVI/OUgCrX7oHUsGgput8I
         DuUIP+RlvXggC9HeKBVcYA+YXGW40Tso+DyWsE4GRDct/DspG+cDEx0pWQaosF6D4QnP
         JKZaR5G/9Y60KuEXrO1iTzSrgaIIK+yi2iiqkniHBHD9cZkXT6wR0XXE21zyaUz3DnnA
         XFB8FiEbmGMGQUYLJqnBZEttqn/ydXv0LebEmh1T9aWjosKhL8ZugZrItZJIHj/275gT
         rgyA==
X-Gm-Message-State: AO0yUKWHLBJcbUHQrs0xkeRuU+TaDNGIfI4IH+WQj+KXq3b0ZZy8IZwM
        k7s9NHMaF/s0tryxokWYogU=
X-Google-Smtp-Source: AK7set+l3ymAkJ8GPkq+iPE6s6/jgP3Wko4abzbJca7t8erhrNheJ36JbKKIVbsGB+LjJEsPwJIPPQ==
X-Received: by 2002:ac2:5383:0:b0:4c0:91d0:e7ab with SMTP id g3-20020ac25383000000b004c091d0e7abmr5975607lfh.28.1679241570912;
        Sun, 19 Mar 2023 08:59:30 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id w24-20020ac24438000000b004e81edf146fsm1301255lfl.209.2023.03.19.08.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 08:59:30 -0700 (PDT)
Message-ID: <c52fb080-49ce-8eec-5c8c-efebd27417af@gmail.com>
Date:   Sun, 19 Mar 2023 17:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
 <20230304201720.2d554f07@jic23-huawei>
 <c16d372f-a122-16d6-ad08-1fbffb01d9ff@gmail.com>
 <20230312153655.052d5730@jic23-huawei>
 <1b55adf6-32ce-1fd3-78cf-b2011f023eac@gmail.com>
 <20230318165436.480f1a9a@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230318165436.480f1a9a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/23 18:54, Jonathan Cameron wrote:
> On Mon, 13 Mar 2023 11:39:06 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 3/12/23 17:36, Jonathan Cameron wrote:
>>> On Sun, 5 Mar 2023 14:22:51 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> On 3/4/23 22:17, Jonathan Cameron wrote:
>>>>> On Thu, 2 Mar 2023 12:58:59 +0200
>>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>>>       
>>
>> // snip
>>
>>>>>> +static const struct iio_chan_spec bu27034_channels[] = {
>>>>>> +	{
>>>>>> +		.type = IIO_LIGHT,
>>>>>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>>>>>> +				      BIT(IIO_CHAN_INFO_SCALE),
>>>>>
>>>>> What is this scale for?
>>>>
>>>> The scale is to inform users that we return data using milli lux.
>>>>   
>>>>> Given the channel is computed from various different inputs, is there a
>>>>> clear definition of how it is scaled?  What does a write to it mean?
>>>>
>>>> Nothing. writing anything else but milli lux scale fails with -EINVAL.
>>>>
>>>> I guess I am doing something in an unusual way here :) Do you have a
>>>> suggestion for me?
>>>
>>> Return data in lux?
>>
>> That's what I did originally have. But then I noticed we can get
>> slightly better accuracy than that. Hence I switched to mLux and added
>> the scale.
>>
>>>   Or return it as INFO_RAW - thus making it clear
>>> that the reading is not in expected units and a conversion must be
>>> applied by userspace.  SCALE is not applied to PROCESSED by userspace.
>>
>> Ah. This makes sense then. Maybe it would be worth adding a warning to
>> IIO-core if drivers set both the SCALE and PROCESSED info bits?
> 
> Hmm. I'm not sure that we don't have valid users of it even if they
> are unusual.  We also have some historical messes that do RAW + SCALE +
> PROCESSED so we can't really have a warning on it.
> 
> Warning generally is that the test tools that come with the kernel
> will give you the wrong reading. :)
> 
>>
>> So, I need to select between the simplicity or better accuracy here? :/
>> I really hate ending up making choices like this without knowing all the
>> real use-cases :( And it happens a lot for me. Well, I guess I'll drop
>> the scale, use luxes and go with the PROCESSED data. My understanding is
>> that the "thing" with the sensor is a wide-range for wavelengths, not
>> the accuracy. So, maybe luxes are just good enough - and again, users
>> needing something more accurate can utilize the raw intensity channels.
> 
> Hmm. For the sysfs case you could use VAL_INT_PLUS_MICRO but that doesn't
> then work well with the buffered path.
> 
> It is perfectly valid to just have this as _RAW and keep your _SCALE so
> that's probably the best option
> _RAW doesn't have to mean totally raw, it just means userspace is expected
> to applying a linear conversion to get a reading in the 'base' units for the channel.

Thanks for the insight!

I'll return the scale and switch to RAW for v5 :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

