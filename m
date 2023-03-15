Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416A6BAE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjCOKvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCOKvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:51:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C766B44F;
        Wed, 15 Mar 2023 03:51:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f18so23752496lfa.3;
        Wed, 15 Mar 2023 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678877488;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LALIG/2cIMKNFddzvOl3aAPcJ/NBtUqUfQD3sutpjf8=;
        b=J2UEoiFZovYM/w+dz2KMHnY+GueOzkfzlo5gnpFps+sv0AK7wMC1C0mSQ0cvG0obhF
         yAVSObGK7RCyevs9seq3rzcuB1zY9rPUjmz2skrfUA+el2A3BBK8P9kJF6+mA4TJ1jjY
         lQcFOOC3MDIXdDkl74kd9eSlmmwEIkt64E2G7pNG10a9ed3hwV9j6qDqIjn/faLCUvow
         i2RYYTrsRXuXZ1LPeLMPfvLxV5rjJI7Jhov5b2RYc8iFCh4K4IYE2Q/Ifv3Tn7uw5tqE
         CzewPBXonhJj4TAK7XuWrdrBUwQxGiBg1osBngze9EqNRJYKVkquULKj8QiPrb+TuKGo
         yQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678877488;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LALIG/2cIMKNFddzvOl3aAPcJ/NBtUqUfQD3sutpjf8=;
        b=ZI4+d/KUvVC9kJkMZO1z7cQeZoRGBVwrW4TZga85OqoMvepzQWR6kTIUKMgL0nyulY
         HEsD4k+h0mYbnNGmNFK4Nf/ZFbveGVzQU04TM3FbmaC28oQZvb4p/X9jUlkOp8HaBqry
         +/6j47ECnx1e36gH1FRDykbbqn+uPjme/4vF3AACgwdkvmWgGSyu+0bjrHKxqyq+CBBv
         mFCwMldlsOCqgChmLfpYll7/UnbZF089CIPlPnpq0TKot1m/Fatij2sHLkS+/tmLW0Le
         63k7buXlBeIi/poq3rABweShpnVO7icLKTZCyBNP1f5SHBVT9C8YSumUwsE1KVDQdb+H
         aalw==
X-Gm-Message-State: AO0yUKWf4StJW7v1QmCw3f7B5tSLwOU40yPt11wmIuR7qfQcUMljC7xD
        HK4LYQ2x4ViulU7bFzCuS7AjTAWay/o=
X-Google-Smtp-Source: AK7set/dUK505zYDSv8f4uUsJ3bYMl4hf1J67RRCPTWJW6cjbHiEzkI9bQncL2xsmax1J4OkjAlOqw==
X-Received: by 2002:ac2:48b3:0:b0:4e8:46a0:b308 with SMTP id u19-20020ac248b3000000b004e846a0b308mr1747582lfg.0.1678877487595;
        Wed, 15 Mar 2023 03:51:27 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512014400b004dc6070e121sm774267lfo.83.2023.03.15.03.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 03:51:27 -0700 (PDT)
Message-ID: <a41874be-f0bd-1570-8a4a-5b28079b9fed@gmail.com>
Date:   Wed, 15 Mar 2023 12:51:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        maxime@cerno.tech, Stephen Boyd <sboyd@kernel.org>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <20230312170638.3e6807b7@jic23-huawei> <20230312170848.651b5b2c@jic23-huawei>
 <ZA8Z08U1sMOhc+V5@smile.fi.intel.com>
 <31d8bc33-eabe-9084-71c3-7d1e29f51863@gmail.com>
 <ZA8lNBPCB4BNnfUq@smile.fi.intel.com>
 <39a7b489-4856-8dc1-d0a6-f27d0c1324a2@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
In-Reply-To: <39a7b489-4856-8dc1-d0a6-f27d0c1324a2@gmail.com>
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

On 3/13/23 15:59, Matti Vaittinen wrote:
> On 3/13/23 15:29, Andy Shevchenko wrote:
>> On Mon, Mar 13, 2023 at 03:11:52PM +0200, Matti Vaittinen wrote:
>>> On 3/13/23 14:40, Andy Shevchenko wrote:
>>>> On Sun, Mar 12, 2023 at 05:08:48PM +0000, Jonathan Cameron wrote:
>>>>> On Sun, 12 Mar 2023 17:06:38 +0000
>>>>> Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> ...
>>
>>>>> Ah. I forgot the tests that don't have a device so can't use devm.
>>>>
>>>> Why not? I have seen, IIRC, test cases inside the kernel that fakes 
>>>> the device
>>>> for that.
>>>
>>> I'd appreciated any pointer for such an example if you have one at 
>>> hand. (I
>>> can do the digging if you don't though!)
>>>
>>> I am not a fan of unit tests. They add huge amount of inertia to
>>> development, and in worst case, they stop people from contributing where
>>> improving a feature requires test code modification(s). And harder 
>>> the test
>>> code is to understand, worse the unwanted side-effects. Also, harder the
>>> test code is to read, more time and effort it requires to analyze a test
>>> failure... Hence, I am _very_ conservative what comes to adding size 
>>> of test
>>> code with anything that is not strictly required.
>>>
>>> After that being said, unit tests are a great tool when carefully 
>>> used - and
>>> I assume/hope stubbing a device for devm_ tests does not add much 
>>> extra...
>>> But let me see if I can find an example :)
>>
>> drivers/gpu/drm/tests/drm_managed_test.c ?
>>
>> (somewhere underneath:
>>
>>   ret = platform_driver_register(&fake_platform_driver);
>>
>> which suggests... what exactly? :-)

Thanks to pointer from Andy I found the 
drm_kunit_helper_[alloc/free]_device() functions. I renamed them to 
test_kunit_helper_[alloc/free]_device(), move them to drivers/base, add 
declarations to include/kunit/test-helpers.h fixed KConfigs and existing 
callers + added the tests for managed interfaces. I have this in place 
in my personal playground where I am working towards the v4 of the series.

...

After that I asked from Maxime if he had a reason to not make those 
generic and available to other subsystems besides drm in the first place...

And Maxime was kind enough to point me to the fact that something like 
this was done in the CCF context:
https://lore.kernel.org/all/20230302013822.1808711-1-sboyd@kernel.org/

I like the 'single function to get the dummy device which can be passed 
to devm'-approach used in drm helpers. I do also like Stephen's idea of 
having the prototypes in kunit/platform_device.h which matches the 
linux/platform_device.h.

However, I don't know when Stephen's work will be finished and merged to 
IIO-tree so that it could be used/extended for the needs of these tests.

Meanwhile, I don't think it makes sense to go forward with my changes 
splitting the helpers out of drm until we see what Stephen's changes 
will bring us. On the other hand, I don't like delaying the gts-helpers 
or the sensor drivers.

So, any suggestions what I should do? I see following options:

1) Drop the tests for managed interfaces for now.
2) Add the tests with a yet-another duplicate implementation of the
    dummy device for devm.
3) Add the tests using the helpers from drm as they are now.

option 1):
I like it as it would be an easy way (for now) - but I hate it as it may 
be a hard way as well. In my experience, when a driver/helper lands 
upstream it will get first few fixes quite fast - and not having a test 
available upstream when this happens is bad. Bad because it means the 
out-of-tree test may get broken, and bad because there is no easy way to 
test the fixes.

option 2):
I hate it because it makes the test code more complex - and duplicates 
the kernel code which is never nice. This could be reworked later when 
Stephens work is done though.

option 3):
It's in general not nice to use functions exported for some other 
subsystem's specific purposes. This would however keep the test code at 
minimum, while leaving the same "I swear I'll fix this later when 
dependencies have settled" - possibility as option 2) did.

Oh, in theory there is option 4) to just send out the changes I did(*) 
which pull the drm_kunit_helper_[alloc/free]_device() out of the DRM - 
but I guess that would lead some extra work to merge this later with 
stuff Stephen's series does introduce.

Any suggestions which of the options to proceed with?



(*) For those interested in seeing the result of pulling the 
drm_kunit_helper_[alloc/free]_device() out of DRM tests, below are links 
to my personal playground with following remarks:
1) code one finds from there may be 100% untested
2) code one finds there may be written just for fun, or for a very
    specific purpose
3) code one finds there is generally not maintained, may be rebased, may
    vanish or turn into rabbits or turn you into a rabbit when you wear a
    top hat.

commits to look at there are
https://github.com/M-Vaittinen/linux/commit/15d07e799f7c7fddc91030b16266d4a8bbaf1cc1

https://github.com/M-Vaittinen/linux/commit/6b4c4ba38b1f838fb0074befd2ca8734604464da



-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

