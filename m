Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9846C0269
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCSO2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCSO2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:28:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E6293FF;
        Sun, 19 Mar 2023 07:28:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q16so1108057lfe.10;
        Sun, 19 Mar 2023 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679236116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06ucLjv2LW0bfQ/Mk1CUtTKw0iV9aRZCdjCSv1bO3Fk=;
        b=LNsOrqJTsODq5F1FoN0E4946GfJkRR9BPDI9myJJnLdmHnKC/sTDjSJ3XCa7CvRlnN
         vIrpZ7eIFp71MjFO6bF0vvQiElGplbiWkXkgFmLT70ZyiYZJOcnDwBqOZeY5+ehYL2LJ
         jHYJpHfOWhimgvjVRl434p7FPtvCN6oZjn9VXa68RqX0M3yogEzZ3apTs3hUmA3XSmOg
         K9L+MXF7gYUJfgiTnWzhxOkVR21J/y+FltdySdRnkZjjfFMz7Ee0MhQ4m1XAdid9/1uV
         EWVQF7cfCQwThZT2k7wO8qGHARpHf4rxjEV7uZybooFWNxmSCgdBm7OScZz7nT3BmEg/
         r6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679236116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06ucLjv2LW0bfQ/Mk1CUtTKw0iV9aRZCdjCSv1bO3Fk=;
        b=261yOdVj1tNrnC3GQ5JXAyRpWFM5Ovb9e/wogwzxCKakyXEvhyc06ZnEzO0aQ/H13o
         QELWO/tZM2Ii7l7iHrmluXH+Dz57U9OgUC0Qx4gvtKoe5kIj8960K9SucXrHx6hJnUW6
         4bCbpUTl4RtuP3s8XtrpigD4mSLigHNHQCdzH1rvyV7rgt2UUWNiSlgye/NsfGZN+hS6
         MMjAldP6Ke3VPla3MNsNuHdlI+4MTkDjV8vh8InApNrObtAnTcsYPdFPluEbBN1qrrMY
         gTF66v4G+LMEHTEhkaACI+MQTlrFGl3pxeJr7qK4jaFMRe0Jh+9sJ1T0RAg2xiy4p+g+
         krPA==
X-Gm-Message-State: AO0yUKX2fz61LLiVOM5nOBm2+bQpenPqd4huQbAhuiZFVeBvUTyT7zHU
        KKbpjYOHojVAYsQa1SGS7iY+dFdKptc=
X-Google-Smtp-Source: AK7set8uBy8PkFHbyTSX4ZnWN5EUHF/1xnL3ynzdEpaQkDfqDjV4XM3LWZr6ag+4dFLrkmYbpYyRwA==
X-Received: by 2002:a19:c20e:0:b0:4d5:ae35:b221 with SMTP id l14-20020a19c20e000000b004d5ae35b221mr5696921lfc.34.1679236116442;
        Sun, 19 Mar 2023 07:28:36 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id b25-20020ac24119000000b004db266f3978sm1266829lfi.174.2023.03.19.07.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 07:28:36 -0700 (PDT)
Message-ID: <9931f19a-31f7-d98a-1540-979e2db30eaf@gmail.com>
Date:   Sun, 19 Mar 2023 16:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com> <20230312165100.45de0c9b@jic23-huawei>
 <bad05e06-3b37-b435-bfac-962aef36cc97@gmail.com>
 <ZA8ho4YfhBkSMFxS@smile.fi.intel.com>
 <d2986a9e-c516-ea6d-8f94-5cd4723312bd@fi.rohmeurope.com>
 <20230318171751.75911d26@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230318171751.75911d26@jic23-huawei>
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

On 3/18/23 19:17, Jonathan Cameron wrote:
> On Tue, 14 Mar 2023 06:19:35 +0000
> "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> 
>> On 3/13/23 15:14, Andy Shevchenko wrote:
>>> On Mon, Mar 13, 2023 at 02:56:59PM +0200, Matti Vaittinen wrote:
>>>> On 3/12/23 18:51, Jonathan Cameron wrote:
>>>>> On Mon, 6 Mar 2023 14:52:57 +0200
>>>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>>>> On Mon, Mar 06, 2023 at 11:17:15AM +0200, Matti Vaittinen wrote:
>>>
>>> ...
>>>    
>>>>>>> +EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, IIO_GTS_HELPER);
>>>>>>
>>>>>> I would say _HELPER part is too much, but fine with me.
>>>>>
>>>>> Hmm. I think I like the HELPER bit as separates it from being a driver.
>>>>> Of course I might change my mind after a few sleeps.
>>>>
>>>> Ever considered a career as a politician? ;) (No offense intended - and feel
>>>> free to change your mind on this. I don't expect this to be done tomorrow)
>>>
>>> It will be a one liner in the provider if you use DEFAULT_SYMBOL_NAMESPACE
>>> definition.
>>
>> Oh. I didn't know about DEFAULT_SYMBOL_NAMESPACE - or if I did, I had
>> forgot it. My memory has never been great and seems to be getting worse
>> all the time...
> 
>>
>> I don't know what to think of this define though. I can imagine that
>> someone who is not familiar with it could be very confused as to why the
>> symbols are not found even though EXPORT_SYMBOL or EXPORT_SYMBOL_GPL are
>> used. OTOH, I think I once saw an error about symbols being in a
>> namespace (when trying to use one without the namespace). This should
>> probably just be a good enough hint for finding out what's going on.
>>
>> Luckily, I think all the exports in this case were oneliners even with
>> the namespace explicitly spelled. Well, I think that for one or two
>> exports the semicolon did slip to col 81 or 82 - but I am not sure if
>> fixing this weighs more than the clarity of explicitly showing the
>> namespace in export.
>>
>> Well, I guess I can go with either of these ways - do you have a strong
>> opinion on using the DEFAULT_SYMBOL_NAMESPACE?
>>
> 
> If it's in the C file, then I can cope with doing it this way.
> Don't do it in the compiler options though.  That got ripped out of CXL
> because it was considered a bad idea to hide the namespace away like that.
> 
> Personally I prefer the namespace of the symbols explicit in each export
> as they are easy to find that way.

I share the same view on this. I did use the DEFAULT_SYMBOL_NAMESPACE 
for v4 - but I'll drop that for v5 and go back with the explicit 
name-space usage.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

