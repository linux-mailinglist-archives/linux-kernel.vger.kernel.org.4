Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306216EF1CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbjDZKTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjDZKTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:19:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008543A8C;
        Wed, 26 Apr 2023 03:19:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4eed6ddcae1so29888180e87.0;
        Wed, 26 Apr 2023 03:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682504377; x=1685096377;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EviVw73GpY2VmW3Zoo5MqDlBDDJF6Mj2T5fwnC0rzAI=;
        b=r+/hVH2b8Bg/aQDOaryrP9T02kg8IPAo6QakGQ0nl3RIrAShUtjnTBPRkHGOljC8jQ
         YovoeIJHVWJRKr2eQDQYKz6QaE+aogpg3ctII2iCg0VANKMKiVSdJ5blEJ5wOAkNoHvf
         fRzwr809sN4dGpj3so82KcV8qjicqwjWfDtCYCTsTdrucK338hcoehVpEDqVQQUWSz3S
         ft8gPYmpgIYgGlf1QspE7/CWI/zO2JgR2Ss6y6sELVWepzwjYRPYdQbPzoKEP5x5IRKx
         B7a2VuZPk8kTJ+jM90mVZ1WjNCicUYDcq2wSDo0X0Knj6PYRnhHRx8CMk3fiJLd6L+PI
         bX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682504377; x=1685096377;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EviVw73GpY2VmW3Zoo5MqDlBDDJF6Mj2T5fwnC0rzAI=;
        b=DeyFvyHdKrBkyXy6xXx+a2DJo6WjWTHgyg3ugcMqNL1kn4w1c/3e5zht77btFe6p8o
         p5KU5Pop+tnRO32iX4tfnnAYGf15sRVieZGBech16hN5oDtz+iy7KglnFgF7p2g4bpyg
         q2kpUImp1VPvk4i4P3BBqwXT8brn3Y2tuXgTDegYXuJnAe4nv6xsBflkfy78VuGLf7Ep
         cMxSqrPW4tnJmpVYTjzAoNPYfBeunc1MNVZyNU6HUloIrHN3hZCJOwVk96DCljBJqWwn
         4Y+Qkck55cBH8D/mHce0tFs5yLl3GHm9V0xFv20nP/dpv/IAxoKG8x6cFoU8+lqQ/Gk8
         dcxw==
X-Gm-Message-State: AC+VfDyE0Dkli+NTNIltFJUGVthi5kzvM3Tb3uCJueXN9ta1AIJSGTMv
        0D9flROKlhiqg2RV5zbClRA=
X-Google-Smtp-Source: ACHHUZ7Q2i8CvzSVbu/f/dnRBGgazkT5Bj0ePzvj6146EtYtbnYxbUtqI8U5Uycl+uFY2Cq1YkyYpw==
X-Received: by 2002:a05:6512:3ba9:b0:4eb:412e:b06a with SMTP id g41-20020a0565123ba900b004eb412eb06amr589111lfv.22.1682504376933;
        Wed, 26 Apr 2023 03:19:36 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id a3-20020a056512020300b004e83fbba141sm2448301lfo.164.2023.04.26.03.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 03:19:36 -0700 (PDT)
Message-ID: <d1121acc-6300-011f-caa2-0ddc01c46e91@gmail.com>
Date:   Wed, 26 Apr 2023 13:19:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1682340947.git.mazziesaccount@gmail.com>
 <d51d5e2b3eff65fd86aeb47840db9cd413d96668.1682340947.git.mazziesaccount@gmail.com>
 <20230425164522.sljcniui5ox5yx3l@intel.intel>
 <102a1605-d6dc-80c7-2075-212569c97042@gmail.com>
 <20230426101200.7czyp6nlg44tweyb@intel.intel>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 4/5] iio: light: ROHM BU27008 color sensor
In-Reply-To: <20230426101200.7czyp6nlg44tweyb@intel.intel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 13:12, Andi Shyti wrote:
> Hi Matti,
> 
>> Thanks for the review! It's nice to see you're still keeping an eye on ROHM
>> / Kionix senor drivers ;)
> 
> yeah... this is fun... if I just had a bit more time :)
> 
>>>> +static int bu27008_read_one(struct bu27008_data *data, struct iio_dev *idev,
>>>> +			    struct iio_chan_spec const *chan, int *val, int *val2)
>>>> +{
>>>> +	int ret, int_time;
>>>> +
>>>> +	ret = bu27008_chan_cfg(data, chan);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = bu27008_meas_set(data, BU27008_MEAS_EN);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	int_time = bu27008_get_int_time(data);
>>>> +	if (int_time < 0)
>>>> +		int_time = 400000;
>>>> +
>>>> +	msleep((int_time + 500) / 1000);
>>>
>>> What is this 500 doing? Is it making a real difference? it's
>>> 0.5ms.
>>
>> Thanks for the question, having extra pairs of eyes helps spotting
>> brainfarts :)
>>
>> The 500 here is half of the value of the divider - idea was to do rounding
>> correctly upwards to prevent premature wake-up. Well, this is incorrect
>> because we should always round up the sleep time, not just 'mathematically
>> correctly' (Eg, not only upwards when value >= 0.5 but upwards always when
>> the division is not even).
>>
>> After this being said, integration times for this device are full milli
>> seconds so they can all be divided by 1000 uS.
>>
>> Nevertheless, it's good to note that the sensor is definitely not being
>> clocked by the same clock as CPU and I assume the timing for it will be
>> drifting quite a bit from the CPU clock. This means some sensors will for
>> sure complete the measurement later than this wake-up. In order to tackle
>> this we have the valid-bit polling in bu27008_chan_read_data(). So, at the
>> end of the day, this rounding correction is lkely to be just some
>> unnecessary noise.
> 
> I understand the logic of the waiting, but msleep is not the
> right function as waiting with msleep is always very approximate,
> that's why it's recommended to use it for a large waiting period,
> where the error is smaller.
> 
> If int_time is 1ms, waiting 1.5 or 2 or 1, is the same thing,
> most probably you will end up waiting more.

Well, the light sensors are slow. The shortest time with BU27008 is 55 
mS, longest being 400 mS. I think msleep fits Ok for this purpose.

>>> What's the minimum int_time? Can we set a minimum, as well, just
>>> for the sake of the msleep?
>>
>> Can you please elaborate what you mean by this? The minimum integration time
>> for bu27008 is 55 mS and this is set in the time tables for the gts-helpers.
>> The bu27008_get_int_time() should never return valid time smaller than that.
> 
> Witha minimum i mean a minimum value for the msleep to start
> working decently. E.g. what if int_time is lower than 1ms? Can we
> have msleep(0)?

As mentioned, int_time for bu27008 will be in a range of 55 ... 400 mS.

> 
> [...]
> 
>>>> +static int bu27008_chip_init(struct bu27008_data *data)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = regmap_update_bits(data->regmap, BU27008_REG_SYSTEM_CONTROL,
>>>> +			   BU27008_MASK_SW_RESET, BU27008_MASK_SW_RESET);
>>>> +	if (ret)
>>>> +		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
>>>> +
>>>> +	/*
>>>> +	 * The data-sheet does not tell how long performing the IC reset takes.
>>>> +	 * However, the data-sheet says the minimum time it takes the IC to be
>>>> +	 * able to take inputs after power is applied, is 100 uS. I'd assume
>>>> +	 * > 1 mS is enough.
>>>> +	 */
>>>> +	msleep(1);
>>>
>>> please use usleep_range().
>>
>> I prefer to not require setting up hrtimers as we have no real requirements
>> for the duration of this sleep. I know the msleep() is likely to exceed the
>> 1 mS, potentially a lot if there is things to do - but we don't really care
>> at this point. The main thing is to give the HW time to reset while allowing
>> other things to be scheduled.
> 
> For the reason above, msleep(1) is quite a meaningless
> instruction. If you need to wait around 1ms, then usleep_range is
> the function to be used.
> 
> Refer, also, to the Documentation/timers/timers-howto.rst

I know the msleep() may sleep much longer. It still is not meaningless. 
Here we use the msleep() in a purpose:

"Sleep at least 1 mS, but actually I don't care if that is 20 mS or more 
- as long as you allow scheduling other things with as little overhead 
as possible".

For that purpose msleep() works just perfectly :)

I actually had a comment clarifying this in previous IIO driver I wrote 
(just to avoid confusing reviewers) but Jonathan asked me to remove the 
comment ;)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

