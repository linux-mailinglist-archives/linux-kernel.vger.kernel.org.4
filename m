Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC62F6B72CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCMJk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjCMJkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:40:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEB25BCAB;
        Mon, 13 Mar 2023 02:39:09 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t11so14865626lfr.1;
        Mon, 13 Mar 2023 02:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678700347;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnD5ii5QqrwfnuTZ3eHXrKCZ3PzFSXwyDbqLDEBgYGo=;
        b=gCmLvP+cWol1EMZ2Cz2gWYWjsqz4LrpIHqcj0m6wtSFsDDaRaEZCFMrH8rMRvB/gru
         Mr4cww+8vxE2LGqCZFBzKnyG5f9smg8eblYeTRkfuXLGw5QcmjhgPyR8+7IZWFGcdPKw
         RtkmZP6rI2CpqccZKkisxdfN6IMdNTCDmvDn/Botc7Xu5qKPnnTOwip8/eidj2QRU0D0
         G0b+TPpjV4MF+7fIm6aGvciJ9DWJhUZU+z1u4KlIcF4KTsTDWREzEv28qJ8rhDAGUkDs
         M37QDYuuC8OtKMxCJVvuAcJoNFJtUIlJpAoB6ICGeQKQo/mvedvVq8fzX7k7CHgwGDNi
         AtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678700347;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnD5ii5QqrwfnuTZ3eHXrKCZ3PzFSXwyDbqLDEBgYGo=;
        b=Zvtht5DM0RiLBDtFAxMrnv3boSkOqDiQsnqq5P5x+F5LMU6j3bTQ9xk1j/R6X0Kxwk
         LlrjomVqhK9Jp2d6R5f+1oVScbmBw/+FOMuQfdy1YNHmRUID887Ty/XvYoWw307O0Km/
         1ePIgxWrHUTmtskaVEEEdGRuVKgVvuB+d8mg5e4GPp9qNiRDfQmN7ulGZv3KCbFCOhfj
         W5UK+9ckVDQ5b583F+6RZy6wDkX+KX6ps+pV54qVP3Br+jovR6JbVnOkGJygFBC6Rnk2
         J/mj1vvD/63pmntZCIeid3BJlF95F0+rzRYqccnDyCaQuuZ2FxpcU2pxAIhvLgsZ5Rm9
         kzCA==
X-Gm-Message-State: AO0yUKV8YvdAqrpM/5cRA95K4CF736BMmmROvQ68JiciB+hAN08VCBLE
        c94lMOLp0I1I/pINjftLI3bRZEvNuD4=
X-Google-Smtp-Source: AK7set8g/zYcVSCI2raemsTFlW2g449xmEazvsx4lVfr/VQ++/tmPZ5KL5VeoOsTmsw8k25+dtmpGA==
X-Received: by 2002:ac2:5dc7:0:b0:4b5:7d49:4a05 with SMTP id x7-20020ac25dc7000000b004b57d494a05mr9572264lfq.0.1678700347207;
        Mon, 13 Mar 2023 02:39:07 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id o5-20020a056512050500b004d0b1327b75sm908682lfb.61.2023.03.13.02.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 02:39:06 -0700 (PDT)
Message-ID: <1b55adf6-32ce-1fd3-78cf-b2011f023eac@gmail.com>
Date:   Mon, 13 Mar 2023 11:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
In-Reply-To: <20230312153655.052d5730@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/23 17:36, Jonathan Cameron wrote:
> On Sun, 5 Mar 2023 14:22:51 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 3/4/23 22:17, Jonathan Cameron wrote:
>>> On Thu, 2 Mar 2023 12:58:59 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    

// snip

>>>> +static const struct iio_chan_spec bu27034_channels[] = {
>>>> +	{
>>>> +		.type = IIO_LIGHT,
>>>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>>>> +				      BIT(IIO_CHAN_INFO_SCALE),
>>>
>>> What is this scale for?
>>
>> The scale is to inform users that we return data using milli lux.
>>
>>> Given the channel is computed from various different inputs, is there a
>>> clear definition of how it is scaled?  What does a write to it mean?
>>
>> Nothing. writing anything else but milli lux scale fails with -EINVAL.
>>
>> I guess I am doing something in an unusual way here :) Do you have a
>> suggestion for me?
> 
> Return data in lux?

That's what I did originally have. But then I noticed we can get 
slightly better accuracy than that. Hence I switched to mLux and added 
the scale.

>  Or return it as INFO_RAW - thus making it clear
> that the reading is not in expected units and a conversion must be
> applied by userspace.  SCALE is not applied to PROCESSED by userspace.

Ah. This makes sense then. Maybe it would be worth adding a warning to 
IIO-core if drivers set both the SCALE and PROCESSED info bits?

So, I need to select between the simplicity or better accuracy here? :/ 
I really hate ending up making choices like this without knowing all the 
real use-cases :( And it happens a lot for me. Well, I guess I'll drop 
the scale, use luxes and go with the PROCESSED data. My understanding is 
that the "thing" with the sensor is a wide-range for wavelengths, not 
the accuracy. So, maybe luxes are just good enough - and again, users 
needing something more accurate can utilize the raw intensity channels.

> 
> In the rare case where you do get SCALE and PROCESSED it's there to allow
> for changes in the underlying signal measurement that are eaten up in the
> computation needed to get to PROCESSED - that is they have no visible
> affect (beyond range changes etc).

Oh, Ok. So there is a valid case for setting both SCALE and PROCESSED. 
Then we can't add teh warning I assume :(


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

