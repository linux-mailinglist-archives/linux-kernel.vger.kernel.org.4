Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA26B7609
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCMLc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCMLc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:32:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38E862B49;
        Mon, 13 Mar 2023 04:31:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f18so15293980lfa.3;
        Mon, 13 Mar 2023 04:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678707111;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdDLEwftf70e6guHEp+3UG/wJFEgtegL04KCKQWMXT4=;
        b=l/GzaqFrYa7vlPOPHfA1DzMmgxYE+G38+rHdusx8qGrJaWImYdVgJ7edKvLvE5fF2r
         MJULS+HqR++eRow8WKOQMVXYe68mHn6frnrxmyHhGL1lc3fgFyS/jfKO2GUryIDB2sn7
         5r41l8rj/3hyBoNGyQvitFKjaavl/KdmYJtGh1hnQKDhDwDpJg5stgyM8XzFTfJt4LhZ
         //U9lgqtndnKy4QgxTdW238p6BMQZP/Mys7LMrx5xKoOJyLBCp244O/0AAOW6kN1C9/j
         aEwm9YG0754plR8WS3NR0V2YKC9Tt0yTbJTOfDCrrKit7Anp6WOzPPJG+C+JOrWTsp3W
         PrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707111;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdDLEwftf70e6guHEp+3UG/wJFEgtegL04KCKQWMXT4=;
        b=v/hsS3Ye/+uIeD6l8OkUv0whqugPQWBfOOteiXycxtHZ5AEsaiSB3JGuapiYkJuEds
         dw79wbiD1TPTYlgcRUQvjWmBa7p1CjAU9g3uIGStPTRq3pEP/3i9O+Ei0GH32wlFxgQE
         oPoAZUi2s+mGlNxn9YGXF9FP9wzuuWSg9S395XL/RoEqLLyejGfGa1zoN+qK/lFBEq6N
         PBvHhwQXsq+VwlXHjB/LG7eGmg3UEpS8TNcvD4aCvfDnIZ3o2wCgNm4TnHF+qVU317k9
         8lyysUTSixBihgs0ciO4Y89XEqY81vuMhMkInn6JCN4APF2laLtYyvpi9vYowESQ3rJD
         s/cQ==
X-Gm-Message-State: AO0yUKXXFCBdjKAhfKiYOLbh7QDHykCv1Z+fNTq8mPnoViJfXoHGycJW
        fRAHP2f6aRDxpF9LlS7hu7Q=
X-Google-Smtp-Source: AK7set9rfCE6JpjNl0OUuiDR5S3E8dim9FOURCvTeeyIA3Y1ejnKCiGNsfl8tZQlHNxP+bJ7Xege9w==
X-Received: by 2002:ac2:55a1:0:b0:4cb:e53:d54b with SMTP id y1-20020ac255a1000000b004cb0e53d54bmr10095498lfg.25.1678707110834;
        Mon, 13 Mar 2023 04:31:50 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id q14-20020a19a40e000000b004b59067142bsm941100lfc.8.2023.03.13.04.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 04:31:50 -0700 (PDT)
Message-ID: <1dbfc336-7d09-cd44-dfa2-9c4bedf257e1@gmail.com>
Date:   Mon, 13 Mar 2023 13:31:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
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
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/6] iio: light: Add gain-time-scale helpers
In-Reply-To: <ZAXK9Hn2NuQPJ7eo@smile.fi.intel.com>
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

On 3/6/23 13:13, Andy Shevchenko wrote:
> On Fri, Mar 03, 2023 at 07:54:22AM +0000, Vaittinen, Matti wrote:
>> On 3/2/23 17:05, Andy Shevchenko wrote:
>>> On Thu, Mar 02, 2023 at 12:57:54PM +0200, Matti Vaittinen wrote:
> 
> ...
> 
>>>> +{
>>>> +	int tmp = 1;
>>>> +
>>>> +	if (scale > max || !scale)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (U64_MAX - max < scale) {
>>>> +		/* Risk of overflow */
>>>> +		if (max - scale < scale)
>>>> +			return 1;
>>>
>>>> +		while (max - scale > scale * (u64) tmp)
>>>
>>> Space is not required after casting.
>>>
>>>> +			tmp++;
>>>> +
>>>> +		return tmp + 1;
>>>
>>> Wondering why you can't simplify this to
>>>
>>> 		max -= scale;
>>> 		tmp++;
>>>
>>
>> Sorry, but I don't follow. Can you please show me the complete
>> suggestion? Exactly what should be replaced by the:
> 
> I don't understand. Do you see the blank lines I specifically added to show
> the piece of the code I'm commenting on?

I saw. I, however, didn't see the point so I was thinking I 
misunderstood what you wanted to replace.

> For your convenience, the while loop and return statement may be replaced with
> two simple assignments.
> 
>>   > 		max -= scale;
>>   > 		tmp++;
> 

Ah, thanks. Yes. I think that would yield the same result. Not sure if 
it makes the logic more or less obvious, but it would kill one return 
path which indeed (in my opinion) could make it look prettier.

That would require a local variable or dropping the const from max 
though. Not sure it's worth that though.

> ...
> 
>>>> +	for (i = gts->num_itime - 2; i >= 0; i--)
>>>
>>> Yeah, if you put this into temporary, like
>>>
>>> 	i = gts->num_itime - 1;
>>>
>>> this becomes
>>>
>>> 	while (i--) {
>>>
>>
>> I prefer for(). It looks clearer to me...
> 
> It has too many characters to parse. That's why I prefer while.
> Are we going to have principle disagreement on this one?
> 

I think we have disagreed whether to prefer while() or for() also in the 
past. I am reluctant to switch for()s to while()s unless there are other 
obvious benefits. Especially I dislike the change if it involves -- or 
++ in the condition. They tend to make it much more difficult (for me) 
to see what the value is when comparing and what the value is after 
exiting the loop. Yet, in this particular case I saw the value of 
re-using the temporary value in memcpy() as you suggest below.

>>   > Note, you may re-use that i (maybe renamed to something better in the
>> memcpy()
>>   > above as well).
>>
>> ...but this makes sense so Ok.
> 
> ...
> 
>>>> +		for (i = 0; !ret && i < gts->num_avail_all_scales; i++)
>>>
>>> Much easier to read if you move this...
>>>
>>>> +			ret = iio_gts_total_gain_to_scale(gts, all_gains[i],
>>>> +					&gts->avail_all_scales_table[i * 2],
>>>> +					&gts->avail_all_scales_table[i * 2 + 1]);
>>>
>>> ...here as
>>>
>>> 		if (ret)
>>> 			break;
>>
>> I think the !ret in loop condition is obvious. Adding break and brackets
>> would not improve this.
> 
> It moves it to the regular pattern. Yours is not so distributed in the kernel.

I believe we can find examples of both patterns in kernel. I don't think 
the "many people use different pattern" is a great reason to add break + 
brackets which (in my eyes) give no additional value to code I am 
planning to keep reading also in the future...

> ...
> 
>>>> +	kfree(all_gains);
>>>> +	if (ret && gts->avail_all_scales_table)
>>>> +		kfree(gts->avail_all_scales_table);
>>>> +
>>>> +	return ret;
>>>
>>> But Wouldn't be better to use goto labels?
>>
>> I don't see benefit in this case. Handling return value and goto would
>> require brackets. The current one is much simpler for me. I am just
>> considering dropping that 'else' which is not needed.
> 
> At least it would be consistent with the very same file style in another
> function. So, why there do you goto, and not here where it makes sense
> to me?
> 

Talking about the iio_gts_build_avail_scale_table()?

Difference is that the iio_gts_build_avail_scale_table() has multiple 
checks for "if this happens - error out". I think using goto has valid 
use-cases there.

To tell the truth - in the past I preferred "arrow code" pattern where I 
initialized return values to default errors and only entered deeper to 
nested code when checks were successful - changing error to succes only 
at the deepest nested level. That however seems to rub the wrong way 
most of the kernel developers. Hence I am adapted to use gotos for error 
handling when we have more than only a few failure points.

In any case, here we can just do with single if-else (and for) without 
even having the brackets. This is not a deeply nesting complex construct.

> ...
> 
>>>> +	while (i) {
>>>
>>> Instead of doing standard
>>>
>>> 	while (i--) {
>>>
>>>> +		/*
>>>> +		 * It does not matter if i'th alloc was not succesfull as
>>>> +		 * kfree(NULL) is safe.
>>>> +		 */
>>>
>>> You add this comment, ...
>>>
>>>> +		kfree(per_time_gains[i]);
>>>> +		kfree(per_time_scales[i]);
>>>
>>> ...an additional loop, ...
>>
>> The comment is there to explain what I think you missed. We have two
>> arrays there. We don't know whether the allocation of first one was
>> successful so we try freeing both.
>>
>>>
>>>> +
>>>> +		i--;
>>>
>>> ...and a line of code.
>>>
>>>> +	}
>>>
>>> Why?
>>
>> Because, as the comment says, it does not matter if allocation was
>> succesfull. kfree(NULL) is safe.
> 
> Wouldn't be better to avoid no-op kfree() by explicitly putting the call before
> hands?
> 
> 	kfree(...[i]);
> 	while (i--) {
> 		...
> 	}
> 
> ?
> 
> Much better to understand than what you wrote. I have to read comment on top of
> the code, with my proposal comment won't be needed.

True, I can add one kfree() before the loop. It still does not change 
the fact that we don't know if allocating the per_time_scales[i] was 
succesful - unless we also add another label there. Well, it is a few 
more LOC but avoids the kfree() and the comment so not really unbearable 
trade :)

> ...
> 
>>>> +	for (i = gts->num_itime - 1; i >= 0; i--) {
>>>
>>> 	i = gts->num_itime;
>>>
>>> 	while (i--) {
>>
>> I prefer for() when initializing a variable is needed. Furthermore,
>> having var-- or --var in a condition is less clear.
> 
> 	while (x--)
> 
> _is_ a pattern for cleaning up something. Your for-loop has a lot of additional
> (unnecessary) code lines that makes it harder to understand (by the people who
> are not familiar with the pattern).
> 

I do strongly disagree with you regarding

while (x--)

being simpler to understand than respective for. -- in a condition is 
terrible - and I rarely use it.

I know I used it in v3 for the

while (time_idx--) {

and I am regretting that already.

>>>> +	}
> 
> ...
> 
>>>> +void iio_gts_purge_avail_time_table(struct iio_gts *gts)
>>>> +{
>>>> +	if (gts->num_avail_time_tables) {
>>>
>>> 	if (!...)
>>> 		return;
>>
>> Does not improve this as we only have just one small conditional block
>> of code which we either execute or not. It is clear at a glance. Would
>> make sense if we had longer function.
> 
> I believe it makes sense to have like this even for this long function(s).

So, it seems like we do disagree with this too then. To me it is just 
obvious here to check if we have tables to free and free them.

> 
>>>> +		kfree(gts->avail_time_tables);
>>>> +		gts->avail_time_tables = NULL;
>>>> +		gts->num_avail_time_tables = 0;
>>>> +	}
>>>> +}
> 
> ...
> 
>>>> +			if (!diff) {
>>>
>>> Why not positive conditional?
>>
>> Because !diff is a special condition and we check explicitly for it.
> 
> And how my suggestion makes it different?

In example you gave we would be checking if the value is anything else 
but the specific value we are checking for. It is counter intuitive.

> (Note, it's easy to miss the ! in the conditionals, that's why positive ones
>   are preferable.)

Thank you for explaining me the rationale behind the "positive checks". 
I didn't know missing '!' was seen as a thing.

I still don't think being afraid of missing '!' is a good reason to 
switch to counter intuitive checks. A check "if (!foo)" is a pattern 
in-kernel if anything and in my opinion people really should be aware of it.

(I would much more say that having a constant value on left side of a 
"equality" check is beneficial as people do really occasionally miss one 
'=' when meaning '=='. Still, this is not strong enough reason to make 
counter-intuitive checks. In my books 'avoiding negative checks' is much 
less of a reason as people (in my experience) do not really miss the '!'.)

Best Regards
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

