Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567AB62F395
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiKRLW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241743AbiKRLVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:21:48 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882F09370E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:21:15 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b3so7731853lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/8Glo0B7GLFHjGhKgNuXxk0fVKZ1GFqQt1D0PZgSFk=;
        b=W0FmKs1IxxSRY4uYGE1KlbSGSZtsG4wYij2zJQXeOwTP6OfE58Iq4P3mAC0YxQ/JkP
         JaVybbRNymnANLJSME49WYO5zm0PRLflPYRVEg3CrlXSIvBajy6fWOCvPN+J00eT84dp
         h3LsU53N35y+jX1zr01KYqp1CmjgT9XV3qOvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/8Glo0B7GLFHjGhKgNuXxk0fVKZ1GFqQt1D0PZgSFk=;
        b=F46QhGsWHd4GfAlPe1HXbHXDoBiwip78OxOXyvaaUIj0vAStyBzvg7jjn9TNMHIpv6
         PeiZI7INWpOWEzcofu2OaNFAE1YbJgrcoMVDfRgXUYAOmMZr6tcjvQEZ8coCcqrrelCZ
         Md2xitC/o959AP90AhYiYLoGjYXp6SbddEyBfEZotyk9VBD6IkXsTOlO8xi5Rf00098o
         f83su7HMmL4XrgVe4hhIhp3gFO9OA+6eyGnqdedw+0HeEOJTl5IfR/xNrHOAk2uthM+j
         m04inCxnf7v8hUzogfrkVzLOOElWzBBOLzhigvQGgzb6HGlwTsdkGF6XLZ10WLe/GIH7
         h4Mg==
X-Gm-Message-State: ANoB5pkW5HBV18s312W5qmqxNW7wGHF4R8WgMRryiE99hS6ljpLdCCRS
        eCe3MJJtgIqCvOlfInDzlbNqCQ==
X-Google-Smtp-Source: AA0mqf6WO6xKOPxr9oiTjOxwCD0UQ9pWZj6V6JHpiKjb11MUIa+d3WeJB7bPKeCqMVYjxKKsMO2CDQ==
X-Received: by 2002:a05:6512:1051:b0:4b0:a51e:2b3 with SMTP id c17-20020a056512105100b004b0a51e02b3mr2584162lfb.636.1668770473260;
        Fri, 18 Nov 2022 03:21:13 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a18-20020ac25e72000000b004b0a1e77cb2sm622936lfr.137.2022.11.18.03.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 03:21:12 -0800 (PST)
Message-ID: <730ef480-8f10-6a38-b78a-13600a805dea@rasmusvillemoes.dk>
Date:   Fri, 18 Nov 2022 12:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
Content-Language: en-US, da
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
 <20221111143921.742194-6-linux@rasmusvillemoes.dk>
 <20221112170705.7efe1673@jic23-huawei>
 <095a454b55cf497392a621649f24e067@analog.com>
 <20221114194447.2528f699@jic23-huawei>
 <0d6b3e4047df9f560079a562bc167bd7a0bf2d28.camel@gmail.com>
 <20221115161052.00002633@Huawei.com>
 <6d76cc6d-9db7-5b18-e4f1-dc220b3929a3@rasmusvillemoes.dk>
 <20221116102200.00003d16@Huawei.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221116102200.00003d16@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 11.22, Jonathan Cameron wrote:
> On Tue, 15 Nov 2022 20:10:53 +0100
> Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
>> On 15/11/2022 17.10, Jonathan Cameron wrote:
>>> On Tue, 15 Nov 2022 15:49:46 +0100
>>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>>   
>>>> On Mon, 2022-11-14 at 19:44 +0000, Jonathan Cameron wrote:  
>>>>> On Mon, 14 Nov 2022 13:52:26 +0000
>>>>> "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com> wrote:
>>>>>     
>>>>>>>
>>>>>>> I'm a little confused on polarity here.  The pin is a !reset so
>>>>>>> we need to drive it low briefly to trigger a reset.
>>>>>>> I'm guessing for your board the pin is set to active low? (an
>>>>>>> example
>>>>>>> in the dt would have made that clearer) Hence the pulse
>>>>>>> in here to 1 is actually briefly driving it low before restoring
>>>>>>> to high?
>>>>>>>
>>>>>>> For a pin documented as !reset that seems backwards though you
>>>>>>> have
>>>>>>> called it reset so that is fine, but this description doesn't
>>>>>>> make that
>>>>>>> celar.      
>>>>>>
>>>>>> My opinion is that the driver shouldn't exactly know the polarity
>>>>>> of the reset,
>>>>>> and just assume that setting the reset GPIO to 1 means putting it
>>>>>> in reset,
>>>>>> and setting it to 0 means bringing out of reset.    
>>>>>
>>>>> Agreed. I'd just like a comment + example in the dt-binding to make
>>>>> the point
>>>>> that the pin is !reset.
>>>>>
>>>>> Preferably with an example in the dt binding of the common case of it
>>>>> being wired
>>>>> up to an active low pin.
>>>>>
>>>>> The main oddity here is the need to pulse it rather than request it
>>>>> directly as
>>>>> in the reset state and then just set that to off.
>>>>>
>>>>>     
>>>>
>>>> Agreed... In theory we should be able to request the gpio with
>>>> GPIOD_OUT_HIGH and then just bring the device out of reset  
>>>
>>> If I recall correctly the datasheet specifically calls out that a pulse
>>> should be used.  No idea if that's actually true, or if it was meant
>>> to be there just to say it needs to be set for X nsecs.  
>>
>> So the data sheet says
>>
>>   The hardware reset is initiated by pulsing the RESET pin low. The
>> RESET pulse width must comply with the specifications in Table 11.
>>
>> and table 11 says that the pulse must be min 50us, max 1ms. We don't
>> really have any way whatsoever to ensure that we're not rescheduled
>> right before pulling the gpio high again (deasserting the reset), so the
>> pulse could effectively be much more than 1ms. But I have a hard time
>> believing that that actually matters (i.e., what state would the chip be
>> in if we happen to make a pulse 1234us wide?).
> 
> Test it maybe?  Otherwise we'd have to play games to do it again if the
> timing was too long to ensure after a couple of goes we do get a suitable
> width pulse.

So I've booted quite a number of times with various large sleep values
(between 1 and 10ms), and never seen a problem. Our hardware guys also
confirm that there should be no such thing as a "too long" pulse.

So do you want me to respin, moving the gpio request into the reset
function (i.e. not storing the descriptor in the ad74413r_state as Nuno
pointed out), requesting it in asserted state, and then, if the gpio was
found, just do the fsleep(50) and then deassert it?

Rasmus

