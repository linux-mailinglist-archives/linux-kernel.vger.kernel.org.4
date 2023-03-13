Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C56F6B79B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjCMN7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjCMN7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:59:32 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18BF11E94;
        Mon, 13 Mar 2023 06:59:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z5so12707803ljc.8;
        Mon, 13 Mar 2023 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678715945;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Br9dbZsECDN6znzio7e4ndSZQRXJUPgWqvgP0KX2jNs=;
        b=OLlTHv0I0+9OnNHoHLNUQmgBnSgLPuYOuJEBBhb0vpNO7dnSIRIG0GKws9xu55voGE
         vCID6Ka4c/6zDPuvWAQkJisw6z5YjwKoM8vfu2ACKH7KSFvjSo4HtNNN2x86lrHeCrDz
         6PstVrVaq5Bcgo16Sn1bltxXscsd2+8mEhiTsxgyqFjQg8Edwy/lRVo9oCnR+HhRPO0F
         20FJiJ302YzmI1ZBxlHh4d43v/RHlcsw5VOkX/yF7n2jagzjyTFBXWi4+MQJ2dvDvbHK
         MEQBtMFDtf8KiPRh/o3WFPWecPBaonWsaaSTeTgj4Nd/ohOr99rO9AuRlpdNpKXlZT2w
         qfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715945;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Br9dbZsECDN6znzio7e4ndSZQRXJUPgWqvgP0KX2jNs=;
        b=R5PtxiGX0Q6kQkZqTLJ5rhuF278lbfNCs2xT5DH+rRi1Cc+uT7DViBnlwmMd3jkDXq
         QbsavxIRQnvrx/b88RIDkc0CQa6yWx1kTHpI0/F0aM19TlNbiDhAv8JbhoDh2RKF6Fww
         MzJB2FBNYk6pDWOUp22kdsXaJ4Gr4+/9QeuG+C+yjAm4bckJ3MJgzzci/ERpck9vw7Ph
         RLj2vkov0xd1+GfNMSUedPSJT0wzKdnjnHRlRS3st3fyZc5X6l6P6TgOr8tE2SX06NEL
         fxoCzJeuRdywJmPgczCFt8b37SQebt+rIM/5grR2M4z9NruPhO2GWfxIJtT1FVQ4Mn0C
         zq2Q==
X-Gm-Message-State: AO0yUKVJNg8ngaAi0lAuibNpjus2E+H28Of9XwpBNZnZOP0ulmm9tiGE
        fMtbjczRbCZlH2x34NDrlO4A37EA8js=
X-Google-Smtp-Source: AK7set+AeBlk3MeVeF61/R37ov8TRcwJgzWhbOa4eNw9bTXtWV8m6SYaD2RFMz/rn7785U4IsvGZgg==
X-Received: by 2002:a05:651c:2122:b0:293:40ce:b08e with SMTP id a34-20020a05651c212200b0029340ceb08emr15833898ljq.16.1678715944850;
        Mon, 13 Mar 2023 06:59:04 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id y3-20020a197503000000b0049c29389b98sm982887lfe.151.2023.03.13.06.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 06:59:04 -0700 (PDT)
Message-ID: <b4bf8587-d3cd-ff88-0276-7e394c110757@gmail.com>
Date:   Mon, 13 Mar 2023 15:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
 <e507c171-bebc-84f6-c326-ff129b42fb7f@gmail.com>
 <ZA8kTx4exvGwUfNn@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
In-Reply-To: <ZA8kTx4exvGwUfNn@smile.fi.intel.com>
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

On 3/13/23 15:25, Andy Shevchenko wrote:
> On Mon, Mar 13, 2023 at 02:47:45PM +0200, Matti Vaittinen wrote:
>> On 3/6/23 14:52, Andy Shevchenko wrote:
>>> On Mon, Mar 06, 2023 at 11:17:15AM +0200, Matti Vaittinen wrote:
> 
> ...
> 
>>>> +/*
>>>
>>> If it's deliberately not a kernel doc, why to bother to have it looking as one?
>>> It's really a provocative to some people who will come with a patches to "fix"
>>> this...
>>
>> I just liked the kernel-doc format. It's a standard way of explaining the
>> parameters and returned value. Function however is intended to be internal
>> and thus I don't see a need to make this "official kernel doc".
> 
> The problem as I pointed out with your approach it's unmaintainable. And
> I even explained why I consider it this way.

Yes. You told me that it asks for people to turn it to kernel doc. If 
that happens, apply the patch and it is kernel doc. I don't see how 
unmaintainable it is. I think this is just creating a problem we may 
never face - and if we do, we can solve it by applying the 'problem' then.

> 
>>>> +		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
>>>> +		     NULL);
>>>
>>> One line reads better?
>>
>> I try mostly to keep the good old 80 chars as I often have 3 terminal
>> windows fitted on my laptop screen. It works best with the short lines.
> 
> With it on one line
> 
> 		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp, NULL);
> 
> You have N at the last column which quite likely suggests that it's NULL.
> So, I don't think it's a big issue to put on a single line.

Trusting suggestions like this in a kernel code would be a big problem 
to me. I would ask myself - "do you feel lucky"?

Well, my favourite editor would wrap the line - so I would see the NULL 
at the next row. Not indented properly causing it to be harder to read 
than the code which is properly manually split and indented. It is much 
less of a problem for me to "waste" a row here and see the line properly 
split.

>>>> +	if (ret && gts->avail_all_scales_table)
>>>
>>> In one case you commented that free(NULL) is okay, in the other, you add
>>> a duplicative check. Why?
>>
>> Sorry but what do you mean by dublicative check?
>>
>> Usually I avoid the kfree(NULL). That's why I commented on it in that
>> another case where it was not explicitly disallowed. I'll change that for v4
>> to avoid kfree(NULL) as you suggested.
> 
> So, and with it you put now a double check for NULL, do you think it's okay?
> I don't.

I don't see the double check. I see only one check just above the 
kfree()? Where is the other check?

> 
>>>> +		kfree(gts->avail_all_scales_table);
> 
> ...
> 
>>>> +	per_time_gains = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);
>>>
>>> sizeof(type) is error prone in comparison to sizeof(*var).
>>
>> Yes and no. In majority of cases where we see sizeof(*var) - the *var is no
>> longer a pointer as having pointers to pointers is not _that_ common. When
>> we see sizeof(type *) - we instantly know it is a size of a pointer and not
>> a size of some other type.
>>
>> So yes, while having sizeof(*var) makes us tolerant to errors caused by
>> variable type changes - it makes us prone to human reader errors. Also, if
>> someone changes type of *var from pointer to some other type - then he/she
>> is likely to in any case need to revise the array alloactions too.
>>
>> While I in general agree with you that the sizeof(variable) is better than
>> sizeof(type) - I see that in cases like this the sizeof(type *) is clearer.
> 
> Still get a fundamental disagreement on this. I would insist, but I'm not
> a maintainer, so you are lucky :-) if Jonathan will not force you to follow
> my way.

In a code you are maintaining it is good to have it in your way as 
you're responsible for it. This is also why I insist on having things in 
a way I can read best for a code I plan to maintain - unless the 
subsystem maintainers see it hard to maintain for them. So, let's see if 
Jonathan has strong opinions on this one :)

> ...
> 
>>>> +	for (i = gts->num_itime - 1; i >= 0; i--) {
>>>
>>> 	while (i--) {
>>>
>>> makes it easier to parse.
>>
>> This is also something I replied for v2. I think we have a fundamental
>> disagreement on this one :/
> 
> Yes, and I will continue insisting on while (foo--).
> That why I won't give you my tags :-)

Well, I am planning to keep reading this code when/if it is being 
patched. Hence I am so reluctant to change it to something that makes it 
harder for me to follow. Meanwhile, I understand that you don't want to 
tag something you don't agree with.

> ...
> 
>>>> +		if (!min)
>>>> +			min = gts->hwgain_table[i].gain;
>>>> +		else
>>>> +			min = min(min, gts->hwgain_table[i].gain);
>>>
>>> I was staring at this and have got no clue why it's not a dead code.
>>
>> Nor can I. It seems obvious to me that the one who wrote this had no idea
>> what he was doing XD
>>
>> Well, I must have had some initial idea of using the minimum value to
>> something - but I can't remember what would've been the use. Maybe I was
>> initially thinking that I'll return the smallest value in-range if the gain
>> given as a parameter was smaller than any of the supported ones.
>>
>> Thank you for reading this carefully and pointing it out! Well spotted!
> 
> Hint: run always `make W=1` when building kernel.

Ah. I thought I had that and sparse enabled. It seems I disabled all 
extra checks from my build scripts a while ago to speed-up compilation 
when I was bisecting...

> It will show defined but not used cases and combined with nowadays
> default -Werror won't be compilable.
> 

Thanks for the review.

--Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

