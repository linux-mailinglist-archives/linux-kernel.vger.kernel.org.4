Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D86B9005
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjCNKbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCNKah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:30:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FCC8F738;
        Tue, 14 Mar 2023 03:29:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id br6so1159134lfb.11;
        Tue, 14 Mar 2023 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678789724;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7C1QtmVJ640L0mKoUMF31ONDgoULzcI2trSajJYK7fg=;
        b=hfy2hyw0rHUVBkr3+tMyR/t7T1tumMP/PKSVYJroe5nLFl1t4ieo4M4aW1+P23upCM
         xT3F83/b0Tnpq3YC/wNCP6HxYQjHsT7IUxbAjY7bh+rI93DJHh8z4iz/ecv2VAqY6C60
         R5+0PBLeWvmXcX3OwceFLPXX0+Pj7SpfuiT21Bw2oaqf044E+HFJeYy9T4645qg9mSJg
         tjUai48x+DDGnTm+OqkD6pnPU/JuI5Eqb0PoNx+Cq9P+n191ma1ZCaSyoiKeJAeGQXny
         CKtcwhbX8vN+OYmhp/mLKXK5g+ika0FCu58B+3cHBTQWSSLMNVdub8Hx1xVRrDn9uTK+
         jKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678789724;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7C1QtmVJ640L0mKoUMF31ONDgoULzcI2trSajJYK7fg=;
        b=hWhdQ9XQQbXnDbSn+DVeGKmf3aunAmTlJfpOJJKNGk1yCF0WvZzkVy2NE8TPn7Kh7x
         kTWuuPdnSuNLPca6/aA1QxNW7PpXv1XFWZPz6CO4Sfee3qgj906jnSUTjBOZleWIIhHG
         3lbwW0Hqkk+Gp/lz+fD0nnJTZ7Grf1LKIZG72P/HI64rmap50cjVL5WDr7eAfCYY1PzP
         2zyxESPCBCvKTf5VWITWvO9P3gcoj2FFelxVjJiH1H2kP4LYr8L+/yUdSr7NOwEE6Lmh
         4HjSETNOwZ2xVmiHDx0CA7BoF2IiIkaffAzi+/67Y/mN8LJRYVy1iF6TDcBvluW+gXs2
         KSSg==
X-Gm-Message-State: AO0yUKVhYeKqirC1ApcEs6LQaPOB3+IoF8KTXDa2UcC52112kcUwYKMJ
        fN+0NZUG/T+d2L5umIUpplhTBXZLcwk=
X-Google-Smtp-Source: AK7set/AZIv5za5RGeJ7/88wLRHKe9eh16DSVxJWVrofCD0yAKFTD+NOQYzhdMGme1xyRTurCqriew==
X-Received: by 2002:ac2:4c33:0:b0:4e0:2b8f:6004 with SMTP id u19-20020ac24c33000000b004e02b8f6004mr693332lfq.4.1678789724031;
        Tue, 14 Mar 2023 03:28:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id y4-20020ac24204000000b004d545f1e0ccsm345767lfh.187.2023.03.14.03.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 03:28:43 -0700 (PDT)
Message-ID: <9d63c161-0449-7e56-5873-2909587f17af@gmail.com>
Date:   Tue, 14 Mar 2023 12:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <9895826669118a1aa1db3f85c2610fa759426c33.1677750859.git.mazziesaccount@gmail.com>
 <ZAC7L8NQYgBcBTCF@smile.fi.intel.com>
 <7e537200-37ab-f6e6-c4e0-c3997128c01b@fi.rohmeurope.com>
 <ZAXK9Hn2NuQPJ7eo@smile.fi.intel.com>
 <1dbfc336-7d09-cd44-dfa2-9c4bedf257e1@gmail.com>
 <ZA81rpWgwvP2bigt@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/6] iio: light: Add gain-time-scale helpers
In-Reply-To: <ZA81rpWgwvP2bigt@smile.fi.intel.com>
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

On 3/13/23 16:39, Andy Shevchenko wrote:
> On Mon, Mar 13, 2023 at 01:31:42PM +0200, Matti Vaittinen wrote:
>> On 3/6/23 13:13, Andy Shevchenko wrote:
>>> On Fri, Mar 03, 2023 at 07:54:22AM +0000, Vaittinen, Matti wrote:
>>>> On 3/2/23 17:05, Andy Shevchenko wrote:
>>>>> On Thu, Mar 02, 2023 at 12:57:54PM +0200, Matti Vaittinen wrote:
> 
> ...
> 
>>>>>> +		for (i = 0; !ret && i < gts->num_avail_all_scales; i++)
>>>>>
>>>>> Much easier to read if you move this...
>>>>>
>>>>>> +			ret = iio_gts_total_gain_to_scale(gts, all_gains[i],
>>>>>> +					&gts->avail_all_scales_table[i * 2],
>>>>>> +					&gts->avail_all_scales_table[i * 2 + 1]);
>>>>>
>>>>> ...here as
>>>>>
>>>>> 		if (ret)
>>>>> 			break;
>>>>
>>>> I think the !ret in loop condition is obvious. Adding break and brackets
>>>> would not improve this.
>>>
>>> It moves it to the regular pattern. Yours is not so distributed in the kernel.
>>
>> I believe we can find examples of both patterns in kernel. I don't think the
>> "many people use different pattern" is a great reason to add break +
>> brackets which (in my eyes) give no additional value to code I am planning
>> to keep reading also in the future...
> 
> The problem is that your pattern is not so standard (distributed) and hence
> less maintainable.

I am sorry but I can't really agree with you on this one. For me adding 
the break and brackets would just complicate the flow and thus decrease 
the maintainability.

> ...
> 
>>>>>> +			if (!diff) {
>>>>>
>>>>> Why not positive conditional?
>>>>
>>>> Because !diff is a special condition and we check explicitly for it.
>>>
>>> And how my suggestion makes it different?
>>
>> In example you gave we would be checking if the value is anything else but
>> the specific value we are checking for. It is counter intuitive.
>>
>>> (Note, it's easy to miss the ! in the conditionals, that's why positive ones
>>>    are preferable.)
>>
>> Thank you for explaining me the rationale behind the "positive checks". I
>> didn't know missing '!' was seen as a thing.
>>
>> I still don't think being afraid of missing '!' is a good reason to switch
>> to counter intuitive checks. A check "if (!foo)" is a pattern in-kernel if
>> anything and in my opinion people really should be aware of it.
>>
>> (I would much more say that having a constant value on left side of a
>> "equality" check is beneficial as people do really occasionally miss one '='
>> when meaning '=='. Still, this is not strong enough reason to make
>> counter-intuitive checks. In my books 'avoiding negative checks' is much
>> less of a reason as people (in my experience) do not really miss the '!'.)
> 
> It's not a problem when it's a common pattern (like you mentioned
> if (!foo) return -ENOMEM; or alike), but in your case it's not.

I think we can find plenty of cases where the if (!foo) is used also for 
other type of checks. To me the argument about people easily missing the 
! in if () just do not sound reasonable.

> I would rather see if (diff == 0) which definitely shows the intention
> and I wouldn't tell a word against it.

I think this depends much of the corner of the kernel you have been 
working with. As far as I remember, in some parts the kernel the check
(foo == 0) was actually discouraged, and check (!foo) was preferred.

Personally I like !foo much more - but I can tolerate the (foo == 0) in 
cases where the purpose is to really see if some measure equals to zero.

Other uses where I definitely don't want to use "== 0" are for example 
checking if a flag is clear, pointer is NULL or "magic value" is zero.

In this case we are checking for a magic value. Having this check 
written as: (diff == 0), would actually falsely suggest me we are 
checking for the difference of gains being zero. That would really be a 
clever obfuscation and I am certain the code readers would fall on that 
trap quite easily.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

