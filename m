Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21F0600605
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 06:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJQEcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 00:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJQEcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 00:32:48 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0504D4EA;
        Sun, 16 Oct 2022 21:32:47 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m23so12554762lji.2;
        Sun, 16 Oct 2022 21:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yj9NxqOqFn6KrVzp0g/6v1Yy9/JzGxcQ5MpRYLIFnKA=;
        b=GDWc8XCkzjDa/twVzfj0SZmAQDa+R5BM8s0vI9DiiBIke/G0n+nFYMOb33tvy7oUAE
         TR0cWtOyRakxCrAkyM3wFhrlm7VeZ9j6HCl7YjWV0X/lhSer127CNCHIItFPfgpb6EvL
         T5wBjq+O/2QlugPyLACH0kG9VcCyN/910KD3KMWpMRlAWh4vD6802T1BmSUkudaTmskp
         e9xADJVA04J7sS0cZ1hmmLduV2Ln3pr7mlFN+XOCwSxZ3XdLqI7G4ib4Ylc8l5GjlaFa
         g0mtpuTjtNrOYrIzQhOlbYO7ZHaYWxN+7s+1qpVjpKiHwgP4n04pMaSlejxnQvI8e3z8
         Y98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yj9NxqOqFn6KrVzp0g/6v1Yy9/JzGxcQ5MpRYLIFnKA=;
        b=pMC3e7GA4LvqwfxOYTYxrodX9WrqeSBAWEIpV8ueYYAmZHHVAPhmIXUMq/esUuH3cG
         I2//iCo7jBVbAUnDA7BQwP5s3DDLUWb42mVKcIn3IUxOB9Gmki3YyY+o9HrbpyRXFPSg
         pswsw5i5fMPVJVRB/H0x/VFW4zsTqcn98J7ZTi5XbJm3P1YJkUQaOtrN3tXcO+z0wyCM
         X1hJiEu+Ct8mToatXtLn47Eu07oGW4YWqEckVqoqjSKOOzwiaQO4wkf7Y0PSzp4cIMtA
         6ElylVKhfq07zNzKkDEK04Q9N/+9GWwepoKz6cBqYq4lW5238fus8kGQiswWrK+D390L
         o+mA==
X-Gm-Message-State: ACrzQf3E8lr08nsdtBxIh2DQFhiRX1cc+gxeITgj1XhhQQQmKmRXQI+G
        doEOVOD3Duius19JewnHZ3j6q80sy/k=
X-Google-Smtp-Source: AMsMyM6DSXAgI8GHfp0skWPBRQzmbALRu71F/GWYNTEQ4sKb/p/5JLQv1L+Rva1IEyo0dyhGdjQygQ==
X-Received: by 2002:a05:651c:98a:b0:26d:fbd0:2c43 with SMTP id b10-20020a05651c098a00b0026dfbd02c43mr3534473ljq.517.1665981165574;
        Sun, 16 Oct 2022 21:32:45 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id d40-20020a0565123d2800b004a47e7b91c4sm79863lfv.195.2022.10.16.21.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 21:32:44 -0700 (PDT)
Message-ID: <eba541f3-728a-c591-dad7-5fd6d882dd73@gmail.com>
Date:   Mon, 17 Oct 2022 07:32:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 11/14] iio: ad7606: simplify using
 devm_regulator_get_enable()
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <521c52f5a9bdc2db04d5775b36df4b233ae338da.1660934107.git.mazziesaccount@gmail.com>
 <SN4PR03MB6784BE44D4A6DCECA0859C5F99799@SN4PR03MB6784.namprd03.prod.outlook.com>
 <0aaeb018-94ba-eaaa-4000-7ad082a09850@gmail.com>
 <20221016171520.07506844@jic23-huawei> <20221016172457.6637c888@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221016172457.6637c888@jic23-huawei>
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

On 10/16/22 19:24, Jonathan Cameron wrote:
> On Sun, 16 Oct 2022 17:15:29 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Tue, 30 Aug 2022 15:54:07 +0300
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> Thanks for the review(s) Nuno!
>>>
>>> On 8/30/22 14:46, Sa, Nuno wrote:
>>>>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>> Sent: Friday, August 19, 2022 9:20 PM
>>>>> To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
>>>>> <matti.vaittinen@fi.rohmeurope.com>
>>>>> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
>>>>> <Michael.Hennerich@analog.com>; Jonathan Cameron
>>>>> <jic23@kernel.org>; linux-iio@vger.kernel.org; linux-
>>>>> kernel@vger.kernel.org
>>>>> Subject: [PATCH v3 11/14] iio: ad7606: simplify using
>>>>> devm_regulator_get_enable()
>>>>>
>>>>> [External]
>>>>>
>>>>> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
>>>>> add_action_or_reset(regulator_disable)' and use the
>>>>> devm_regulator_get_enable() and drop the pointer to the regulator.
>>>>> This simplifies code and makes it less tempting to add manual control
>>>>> for the regulator which is also controlled by devm.
>>>>>
>>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>>
>>>>> ---
>>>>
>>>> The commit message could state that while doing the change, dev_err_probe()
>>>> was also introduced. Bah, anyways:
>>>>
>>>> Acked-by: Nuno Sá <nuno.sa@analog.com>
>>>
>>> Good point. I have few other changes to the series pending - and I
>>> probably need to rebase/respin when -rc1 is out (and dependency patches
>>> are merged from Mark's tree) => I may as well alter the commit message.
>>>    
>> I tweaked it and applied.
>>
>> Not I'm grabbing these early because I forgot you'd sent them and
>> found myself writing the same patches.  Memory of a goldfish :)
> 
> Tweaked a little more - you missed that the struct in the header had
> kernel-doc for the struct regulator *.  Dropped that.

Thanks a bunch!

Yours,
	Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

