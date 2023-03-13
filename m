Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A256B77F0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCMMrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCMMru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:47:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF58659E1;
        Mon, 13 Mar 2023 05:47:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d36so15540840lfv.8;
        Mon, 13 Mar 2023 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678711667;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAOn9COur79NFzJnUagWr25Iv/aoUtc8Gd38YMs62Qg=;
        b=AdSPaau21SmAaxS6gn1hHjNIg29MJ3J8GnQCMDUu4SNbjL8G1eDtyz6h2nqn6KC2Xy
         LkrNKkUuM2JU5qCcb2LjKJYqOQsr3l90QJgjiNDsQUdYEa24SyHVq76mpnm6aiiYrLSP
         +Ps7ydu2pE7g432M3o18Zte6P2uL9QleYChl9wwCfoCQlkkQe9QSdyxUpsNVzyqbU9n2
         5VOVzCakPgmmupasF2cuIfnFbBz7oQUHayEwqgtBvoZdyXTwzi3a/LagfqO1wlusawoI
         GNpeezCbGn6wTVGgokJa3hPkcy7SQg35KUPC1IMY7wtcwzr1V67P2IlS2qXsb0owTP9w
         LsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678711667;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAOn9COur79NFzJnUagWr25Iv/aoUtc8Gd38YMs62Qg=;
        b=YhtaArtfCs9t3QkNr7In+9Oz+3nW8iwABwu1Hg+VXlHgs3S9r1IaHfF7qnYvyCcXKn
         W5pGEerY2KALbcSyhBfNYpQ4UAtQkIsVnovcPeFDObSwnNKvXK6jU0IyTYbp6q9laEUp
         cQ7ek2H0hFXWDPPZGCmDKSKUGsO8Ua4EGx75o6LY+VXCkYxf4jtyvvp7JhywfHOxj9S3
         /xRySCuWgiUM2C+bMflXsJEXvQ9r0JiXmefBQ35d4oKfyu+xq8/UgOxcVIsqmDWNHDYJ
         z9heaA8HEI7Hmqdsxi6WHnw4JZPNZPEpSFhOrJdib/AQmb80KtcaThszj8QsHwnd6qXE
         keyA==
X-Gm-Message-State: AO0yUKXAuwBUckxWGmDAC5WNhC8G7YmybihHYBNtBulYjO5HkEegWO3g
        qlLYR2eHFOnfTjDmoXiciyU=
X-Google-Smtp-Source: AK7set8xgyPA1NMyv3ZsjUa+PIsT/has3GNxQd9jsUITStjS/HUe/Lidlfy7RWWqsXdqeF6S23SIeA==
X-Received: by 2002:a05:6512:1319:b0:4e8:3d0:84b4 with SMTP id x25-20020a056512131900b004e803d084b4mr2826107lfu.24.1678711666777;
        Mon, 13 Mar 2023 05:47:46 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004db25f2c103sm965490lfl.86.2023.03.13.05.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:47:46 -0700 (PDT)
Message-ID: <e507c171-bebc-84f6-c326-ff129b42fb7f@gmail.com>
Date:   Mon, 13 Mar 2023 14:47:45 +0200
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
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
In-Reply-To: <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
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

On 3/6/23 14:52, Andy Shevchenko wrote:
> On Mon, Mar 06, 2023 at 11:17:15AM +0200, Matti Vaittinen wrote:
>> Some light sensors can adjust both the HW-gain and integration time.
>> There are cases where adjusting the integration time has similar impact
>> to the scale of the reported values as gain setting has.
>>
>> IIO users do typically expect to handle scale by a single writable 'scale'
>> entry. Driver should then adjust the gain/time accordingly.
>>
>> It however is difficult for a driver to know whether it should change
>> gain or integration time to meet the requested scale. Usually it is
>> preferred to have longer integration time which usually improves
>> accuracy, but there may be use-cases where long measurement times can be
>> an issue. Thus it can be preferable to allow also changing the
>> integration time - but mitigate the scale impact by also changing the gain
>> underneath. Eg, if integration time change doubles the measured values,
>> the driver can reduce the HW-gain to half.
>>
>> The theory of the computations of gain-time-scale is simple. However,
>> some people (undersigned) got that implemented wrong for more than once.
>>
>> Add some gain-time-scale helpers in order to not dublicate errors in all
>> drivers needing these computations.
> 
> ...
> 
>> +/*
> 
> If it's deliberately not a kernel doc, why to bother to have it looking as one?
> It's really a provocative to some people who will come with a patches to "fix"
> this...

I just liked the kernel-doc format. It's a standard way of explaining 
the parameters and returned value. Function however is intended to be 
internal and thus I don't see a need to make this "official kernel doc".

> 
>> + * iio_gts_get_gain - Convert scale to total gain
>> + *
>> + * Internal helper for converting scale to total gain.
>> + *
>> + * @max:	Maximum linearized scale. As an example, when scale is created
>> + *		in magnitude of NANOs and max scale is 64.1 - The linearized
>> + *		scale is 64 100 000 000.
>> + * @scale:	Linearized scale to compte the gain for.
>> + *
>> + * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
>> + *		is invalid.
>> + */
>> +static int iio_gts_get_gain(const u64 max, const u64 scale)
>> +{
>> +	int tmp = 1;
>> +
>> +	if (scale > max || !scale)
>> +		return -EINVAL;
>> +
>> +	if (U64_MAX - max < scale) {
>> +		/* Risk of overflow */
>> +		if (max - scale < scale)
>> +			return 1;
> 
>> +		while (max - scale > scale * (u64)tmp)
>> +			tmp++;
>> +
>> +		return tmp + 1;
> 
> Can you wait for the comments to appear a bit longer, please?
> I have answered to your query in the previous discussion.
> 

Yep. Sorry for that. I just wanted to get the v3 out before I left the 
computer for a week to allow potential reviewers to check the quite a 
bit reworked series.

>> +	}
>> +
>> +	while (max > scale * (u64) tmp)
> 
> No space for castings?

Thanks,

> 
>> +		tmp++;
>> +
>> +	return tmp;
>> +}
> 
> ...
> 
>> +	/*
>> +	 * Expect scale to be (mostly) NANO or MICRO. Divide divider instead of
>> +	 * multiplication followed by division to avoid overflow
> 
> Missing period.
> 
>> +	 */
>> +	if (scaler > NANO || !scaler)
>> +		return -EINVAL;
> 
> Shouldn't be OVERFLOW for the first one?

-EOVERFLOW? I guess it could be. Thanks.

> ...
> 
>> +	*lin_scale = (u64) scale_whole * (u64)scaler +
> 
> No space for casting?

Yes. Thanks

> ...
> 
>> +	ret = iio_gts_linearize(max_scale_int, max_scale_nano, NANO,
>> +				   &gts->max_scale);
>> +	if (ret)
>> +		return ret;
>> +
>> +	gts->hwgain_table = gain_tbl;
>> +	gts->num_hwgain = num_gain;
>> +	gts->itime_table = tim_tbl;
>> +	gts->num_itime = num_times;
>> +	gts->per_time_avail_scale_tables = NULL;
>> +	gts->avail_time_tables = NULL;
>> +	gts->avail_all_scales_table = NULL;
>> +	gts->num_avail_all_scales = 0;
> 
> Just wondering why we can't simply
> 
> 	memset(0)
> 
> beforehand and drop all these 0 assignments?
> 

I guess we can :)

> ...
> 
>> +		/*
>> +		 * Sort the tables for nice output and for easier finding of
>> +		 * unique values
> 
> Missing period. Please, check the style of multi-line comments. I believe it's
> even mentioned in the documentation.
> 
>> +		 */
> 
> ...
> 
>> +		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
>> +		     NULL);
> 
> One line reads better?

I try mostly to keep the good old 80 chars as I often have 3 terminal 
windows fitted on my laptop screen. It works best with the short lines.

> 
> ...
> 
>> +	if (ret && gts->avail_all_scales_table)
> 
> In one case you commented that free(NULL) is okay, in the other, you add
> a duplicative check. Why?

Sorry but what do you mean by dublicative check?

Usually I avoid the kfree(NULL). That's why I commented on it in that 
another case where it was not explicitly disallowed. I'll change that 
for v4 to avoid kfree(NULL) as you suggested.

> 
>> +		kfree(gts->avail_all_scales_table);
> 
> ...
> 
>> +	per_time_gains = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);
> 
> sizeof(type) is error prone in comparison to sizeof(*var).

Yes and no. In majority of cases where we see sizeof(*var) - the *var is 
no longer a pointer as having pointers to pointers is not _that_ common. 
When we see sizeof(type *) - we instantly know it is a size of a pointer 
and not a size of some other type.

So yes, while having sizeof(*var) makes us tolerant to errors caused by 
variable type changes - it makes us prone to human reader errors. Also, 
if someone changes type of *var from pointer to some other type - then 
he/she is likely to in any case need to revise the array alloactions too.

While I in general agree with you that the sizeof(variable) is better 
than sizeof(type) - I see that in cases like this the sizeof(type *) is 
clearer.

> 
>> +	if (!per_time_gains)
>> +		return ret;
>> +
>> +	per_time_scales = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);
> 
> Ditto.
> 
>> +	if (!per_time_scales)
>> +		goto free_gains;
> 
> ...
> 
>> +err_free_out:
>> +	while (i) {
>> +		/*
>> +		 * It does not matter if i'th alloc was not succesfull as
>> +		 * kfree(NULL) is safe.
>> +		 */
> 
> Instead, can be just a free of the known allocated i:th member first followed
> by traditional pattern. In that case comment will become redundant.
>

I replied to this in your comments regarding the v2. Sorry for splitting 
the discussion by sending v3 so soon.


>> +		kfree(per_time_scales[i]);
>> +		kfree(per_time_gains[i]);
>> +
>> +		i--;
>> +	}
> 
> ...
> 
>> +	for (i = gts->num_itime - 1; i >= 0; i--) {
> 
> 	while (i--) {
> 
> makes it easier to parse.

This is also something I replied for v2. I think we have a fundamental 
disagreement on this one :/

> 
>> +/**
>> + * iio_gts_all_avail_scales - helper for listing all available scales
>> + * @gts:	Gain time scale descriptor
>> + * @vals:	Returned array of supported scales
>> + * @type:	Type of returned scale values
>> + * @length:	Amount of returned values in array
>> + *
>> + * Returns a value suitable to be returned from read_avail or a negative error
> 
> Missing a return section. Have you run kernel doc to validate this?
No. I think I have never run the kernel doc - probably time to do so :) 
Thanks.

> Missing period.
> 
> Seems these problems occur in many function descriptions.
> 
>> + */
> 
> ...
> 
>> +	/*
>> +	 * Using this function prior building the tables is a driver-error
>> +	 * which should be fixed when the driver is tested for a first time
> 
> Missing period.
> 
>> +	 */
>> +	if (WARN_ON(!gts->num_avail_all_scales))
> 
> Does this justify panic? Note, that any WARN() can become an Oops followed by
> panic and reboot.

No. My initial thinking was that this could only happen if a driver 
which do not build the tables tries to use the helpers. That, in my 
books, would have been 100% reproducible driver error, happening when 
ever the available scales were read.

I did overlook the case where freeing of tables is done in wrong order. 
That type of bug could well escape the initial testing and no - it 
should not bring down the machine. I'll drop the WARN. Thanks.

> 
>> +		return -EINVAL;
> 
> ...
> 
>> +	for (i = 0; i < gts->num_hwgain; i++) {
>> +		/*
>> +		 * It is not expected this function is called for an exactly
>> +		 * matching gain.
>> +		 */
>> +		if (unlikely(gain == gts->hwgain_table[i].gain)) {
>> +			*in_range = true;
>> +			return gain;
>> +		}
> 
>> +		if (!min)
>> +			min = gts->hwgain_table[i].gain;
>> +		else
>> +			min = min(min, gts->hwgain_table[i].gain);
> 
> I was staring at this and have got no clue why it's not a dead code.

Nor can I. It seems obvious to me that the one who wrote this had no 
idea what he was doing XD

Well, I must have had some initial idea of using the minimum value to 
something - but I can't remember what would've been the use. Maybe I was 
initially thinking that I'll return the smallest value in-range if the 
gain given as a parameter was smaller than any of the supported ones.

Thank you for reading this carefully and pointing it out! Well spotted!

> 
>> +		if (gain > gts->hwgain_table[i].gain) {
>> +			if (!diff) {
>> +				diff = gain - gts->hwgain_table[i].gain;
>> +				best = i;
>> +			} else {
>> +				int tmp = gain - gts->hwgain_table[i].gain;
>> +
>> +				if (tmp < diff) {
>> +					diff = tmp;
>> +					best = i;
>> +				}
>> +			}
> 
> 			int tmp = gain - gts->hwgain_table[i].gain;
> 
> 			if (!diff || tmp < diff) {
> 				diff = tmp;
> 				best = i;
> 			}
> 
> ?
> 
> Or did you miss using 'min'? (And I'm wondering how variable name and min()
> macro are not conflicting with each other.
> 
>> +		} else {
>> +			/*
>> +			 * We found valid hwgain which is greater than
>> +			 * reference. So, unless we return a failure below we
>> +			 * will have found an in-range gain
>> +			 */
>> +			*in_range = true;
>> +		}
>> +	}
>> +	/* The requested gain was smaller than anything we support */
>> +	if (!diff) {
>> +		*in_range = false;
>> +
>> +		return -EINVAL;
>> +	}
>> +
>> +	return gts->hwgain_table[best].gain;
> 
> ...
> 
>> +	ret = iio_gts_get_scale_linear(gts, old_gain, itime_old->time_us,
>> +				       &scale);
> 
> Still can be one line.
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = gain_get_scale_fraction(gts->max_scale, scale, itime_new->mul,
>> +				      new_gain);
> 
> Ditto.

I still prefer the 80-chars when it does not mean some terribly awkward 
split - or really many rows of arguments.


>> +	if (ret)
>> +		return -EINVAL;
> 
> ...
> 
>> +++ b/drivers/iio/light/iio-gts-helper.h
> 
> Is it _only_ for a Light type of sensors?

This is a very good question. I was asking this from myself but as I 
don't know better I just decided to put it under the light where I'll 
have the use-cases. We can move it to drivers/iio if there will be users 
outside the light sensors.

> 
> ...
> 
>> +#ifndef __IIO_GTS_HELPER__
>> +#define __IIO_GTS_HELPER__
> 
> If yes, perhaps adding LIGHT here?

I'd like to keep this matching the file name, especially when I don't 
know for sure this can't be used elsewhere.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

