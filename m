Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217B36B79CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCMOBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjCMOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:00:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF5A6F4AA;
        Mon, 13 Mar 2023 07:00:00 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id by8so12714991ljb.7;
        Mon, 13 Mar 2023 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678715994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSz5ErZZ4x/NRLe7JN2WWQR6b9KCGMkpJUx1wnV62dU=;
        b=JMIfrOgH0MQMlYkc5oFNSSCP0sSLQapnv7/cbFNREe8eFAM2TKGtpcVNFZupArIW+I
         QvAn/N84HrNghyhmWxTzW8SrruCdIzqF4C1bbvKEv8/CvKMVzGHejKbhem5GKh3e2y+8
         b3n/eW8BRSrROq6BfERYGI+Jg+1S3HWLL6CQB7GcQ+qlf6cOX8BULslHmZsU9zf/rWMf
         l1hWm53CF6q/DJN/CzPgeKNpPmhqtm9O9fwCUyXTbAYie3+r5/+gw33OhYc0jaiay7OT
         WYj41pIsgU7MGY7fjK0R953+9Zos97aTg9I1M/2+5IbSuqRetrOI5cMhBsGSgq2HB2EF
         vhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSz5ErZZ4x/NRLe7JN2WWQR6b9KCGMkpJUx1wnV62dU=;
        b=tBSFddQPp4o5J1sPSOs36L6vNAxHj9LPcQSiRuXrziA6DFVjYf8xfSB6cnkrunWNcM
         C0XLJ0AIMFAhM5SblE4T8Fteqk8vrTA+RYw739nwUkD5i8PXje/XhXHgB7FqKnB5S9y8
         3fp0PvCLs9Rfv8g/wU44RG9eJR93Ke/ufg4+4bHkAkq9Tij5oYhhXRaTePmz5wAy6201
         kma0c16TupcC+hFqaIkzzlhaqf14AFEqV1/w3HRsIqq6h/bgRluJ//fZ23FYhQrEOTwF
         qSbRZrW6eHgCRoR8WYEUf6GPaZaDbXeggSYsD9gSPO6tHxrZD9obx7JVK6+7bzarEoFa
         TiEg==
X-Gm-Message-State: AO0yUKUccX1XQ+osaOuwDLwhjE3QDX77WO7cWR/3djNl1rV8RfoVO53p
        iT5KUia7I0elfQ8Sudcxlz8=
X-Google-Smtp-Source: AK7set+ip2QPITMQmcKMI13u5vDZflDrbwxL1G5HDy+jPmQFsEC5H6OsWYNrm/ajbPgOV1AvvCjg5g==
X-Received: by 2002:a2e:9545:0:b0:295:8fd5:da00 with SMTP id t5-20020a2e9545000000b002958fd5da00mr11925903ljh.22.1678715993746;
        Mon, 13 Mar 2023 06:59:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id m9-20020ac24249000000b004db1cd5efcesm993929lfl.241.2023.03.13.06.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 06:59:52 -0700 (PDT)
Message-ID: <39a7b489-4856-8dc1-d0a6-f27d0c1324a2@gmail.com>
Date:   Mon, 13 Mar 2023 15:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <20230312170638.3e6807b7@jic23-huawei> <20230312170848.651b5b2c@jic23-huawei>
 <ZA8Z08U1sMOhc+V5@smile.fi.intel.com>
 <31d8bc33-eabe-9084-71c3-7d1e29f51863@gmail.com>
 <ZA8lNBPCB4BNnfUq@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZA8lNBPCB4BNnfUq@smile.fi.intel.com>
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

On 3/13/23 15:29, Andy Shevchenko wrote:
> On Mon, Mar 13, 2023 at 03:11:52PM +0200, Matti Vaittinen wrote:
>> On 3/13/23 14:40, Andy Shevchenko wrote:
>>> On Sun, Mar 12, 2023 at 05:08:48PM +0000, Jonathan Cameron wrote:
>>>> On Sun, 12 Mar 2023 17:06:38 +0000
>>>> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> ...
> 
>>>> Ah. I forgot the tests that don't have a device so can't use devm.
>>>
>>> Why not? I have seen, IIRC, test cases inside the kernel that fakes the device
>>> for that.
>>
>> I'd appreciated any pointer for such an example if you have one at hand. (I
>> can do the digging if you don't though!)
>>
>> I am not a fan of unit tests. They add huge amount of inertia to
>> development, and in worst case, they stop people from contributing where
>> improving a feature requires test code modification(s). And harder the test
>> code is to understand, worse the unwanted side-effects. Also, harder the
>> test code is to read, more time and effort it requires to analyze a test
>> failure... Hence, I am _very_ conservative what comes to adding size of test
>> code with anything that is not strictly required.
>>
>> After that being said, unit tests are a great tool when carefully used - and
>> I assume/hope stubbing a device for devm_ tests does not add much extra...
>> But let me see if I can find an example :)
> 
> drivers/gpu/drm/tests/drm_managed_test.c ?
> 
> (somewhere underneath:
> 
>   ret = platform_driver_register(&fake_platform_driver);
> 
> which suggests... what exactly? :-)
> 

Thanks!

--Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

