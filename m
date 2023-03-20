Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8646C1163
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjCTMCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCTMCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:02:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AAF2529D;
        Mon, 20 Mar 2023 05:01:59 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 20so4672187lju.0;
        Mon, 20 Mar 2023 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679313717;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p55ioWKtf26dHJIf2CiJ75HXhLNuqT3QbOWRu6vxPW8=;
        b=dhGFuxSHUfgB9j96kuo7PFCb2TykaUBGQl/a9e4IZwqY8Gvxq5bu0ziRQkerSsETqo
         u0RLI1UcOV6h0SUpZbKakJRg5CzRQwRY5JoiqL95qlgENLkTktZqkttN+4/leLxLc461
         iYY8VpUwDwgBIyxJxuceM3MY6GQ1HwZB/f6Zy/F9V1GvgEwQMaTWn5/2Q88CO3+nIeDz
         udrQ9WnmyTdxIVOMzJLFqddJ79PrmDJYKHXCiusl5mTeJlVaNWJhX3W5gYwvN6GWagWl
         rNVUAp73GG6VeG+GLhtH1TBSrCceVGYOLqmr4cy2bk5HowiyNGscTohkHS2N67GGis+5
         M+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679313717;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p55ioWKtf26dHJIf2CiJ75HXhLNuqT3QbOWRu6vxPW8=;
        b=RV9bQ6dTxYQyqKZpve2OC0PtMJ0nuG0zjFa2jPo1XtnR/ododBXrgk9/6tX5NNJd5y
         fRxv9RHz7IxEMUVOteuIbYdLM2O/37gZraCxFzBuRzm8QzQMvs4yMIMmVo4MRSCRgKkP
         CEX7adJEA0cBo2hZDcqdyslZ9RnZ3IqWZD7186vJENvRcidaklmMrHYCQC+MIRrdyHxV
         nqVfVcF/ggVkRQjsNvYoT9g/1dEh0mXhbYPCbBS3UL9Anbp8xrDqlBLGGX6Qs8k6qEpD
         ks1it2isbukm5CkKRd8oH4MDTX0dlIR8GLYGbRjyx36jM+NTERKPDCwOlAQNmyWjf/EA
         MFJA==
X-Gm-Message-State: AO0yUKUg5Z10CRSnm7Fq/Et4t+iJyFcp/n+pNdT9GzBT9Air5OddgfpR
        qkz1gjMcnNNQXYAhy9w8zi4hEesxkwI=
X-Google-Smtp-Source: AK7set+7G2GG5ZJ4W2wd8gLb0xWkoYchcCEw451NVZ4NnPOUwA535LYBsXTa5Fo5R/X83CUnb1rjag==
X-Received: by 2002:a2e:86d7:0:b0:29c:8a05:1a38 with SMTP id n23-20020a2e86d7000000b0029c8a051a38mr1179773ljj.30.1679313716818;
        Mon, 20 Mar 2023 05:01:56 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id v22-20020a2e87d6000000b002945b04e1ebsm1728160ljj.94.2023.03.20.05.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 05:01:56 -0700 (PDT)
Message-ID: <5ba4ab3d-90ab-113e-1b95-86118d3a7392@gmail.com>
Date:   Mon, 20 Mar 2023 14:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1679062529.git.mazziesaccount@gmail.com>
 <e5b93a3d2424b16d842e847c98f05f1a9befb2e1.1679062529.git.mazziesaccount@gmail.com>
 <20230319180828.452a603c@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 4/8] iio: light: Add gain-time-scale helpers
In-Reply-To: <20230319180828.452a603c@jic23-huawei>
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

On 3/19/23 20:08, Jonathan Cameron wrote:
> On Fri, 17 Mar 2023 16:43:23 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
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
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Whilst you use it in the tests currently I'm not convinced there is a good
> reason to separate iio_init_iio_gts() from devm_iio_gts_build_avail_tables()
> as I'd expect them to be called as a pair in all drivers that use this.

I was wondering if I should only provide the:

[devm_]iio_init_iio_gts() and always unconditionally allocate and build 
the tables inside the initialization routine.

I don't really care so much about how the tests are done. In my opinion 
the testability needs should rarely be determining what the production 
code looks like. In this case it is a waste of time / resources for 
drivers which do not tell the available scales/times to user-space, or 
do need some special routine for this. This is why I did make 
build_avail_tables() optional. Still not sure what would be the best 
approach though.

> Perhaps it's worth reworking the tests to do that even if it's not strictly
> necessary for specific tests.
> 
> I think a bit more care is need with storage of time (unsigned) + decide
> whether to allow for negative gains.

My approach was just pretty simple "int is big enough for the times" 
(2000+ seconds when using usec as time units felt like more than enough 
for light sensors) and "gains are always positive".

I have not tested the negative gains at all - but I agree this should've 
been documented. Currently there is no gts-helper users who need 
negative gain (or large times for that matter) - so I was not handling them.

I'll try to check what it would mean code-wise if we converted times to 
unsigned. Negative times make no sense but allowing negative error 
values is a simple way to go.

As for the negative gains - I have no problem of someone adding a 
support for those if needed, but I don't currently see much point in 
investing time in that...

> Whilst they happen I'm not that bothered
> if that subtlety becomes a device driver problem when calling this.  I'm not
> sure I've seen a sensor that does both positive and negative gains for a single
> channel.

I agree. If driver needs negative gains, then the driver needs to deal 
with it. I have no objections if driver authors want to improve these 
helpers by adding support for negative gains, but if they don't, then 
they have the exactly same problem they would have without these helpers :)

>> ---
>> Currently it is only BU27034 using these in this series. I am however working
>> with drivers for RGB sensors BU27008 and BU27010 which have similar
>> [gain - integration time - scale] - relation. I hope sending those
>> follows soon after the BU27034 is done.
>>
>> Changes:
>> v3 => v4:
>> - doc styling
>> - use memset to zero the helper struct at init
>> - drop unnecessary min calculation at iio_find_closest_gain_low()
>> - use namespace to all exports
>> - many minor stylings
>> - make available outside iio/light (move code to drivers/iio and move the
>>    header under include
>> - rename to look like other files under drivers/iio (s/iio/industrialio)
> 
> Ah. I've always regretted not using iio_ for the prefix on those so I'm fine
> if you would prefer to stick to iio_

I do like iio better. However, I think we should have common prefix for 
these files. Having both iio- and industrialio- will be confusing for 
newcomers. If I saw just one iio- prefixed file I would have assumed it 
is for a specific use, not for common use as the other "IIO-core" files.

One option would be converting all these industrialio-*.c files to 
iio_*.c - but I am not sure if it is worth the hassle.

>> - drop unused functions
>> - don't export only internally used functions and make them static
>>    Note, I decided to keep iio_gts_total_gain_to_scale() exported as it is
>>    currently needed by the tests outside the helpers.
>>
>> v2 => v3: (mostly fixes based on review by Andy)
>> - Fix typos
>> - Styling fixes
>> - Use namespace for exported symbols
>> - Protect allocs against argument overflow
>> - Fix include protection name
>> - add types.h inclusion and struct device forward declaration
>>
>> RFCv1 => v2:
>> - fix include guardian
>> - Improve kernel doc for iio_init_iio_gts.
>> - Add iio_gts_scale_to_total_gain
>> - Add iio_gts_total_gain_to_scale
>> - Fix review comments from Jonathan
>>    - add documentation to few functions
>>    - replace 0xffffffffffffffffLLU by U64_MAX
>>    - some styling fixes
>>    - drop unnecessary NULL checks
>>    - order function arguments by  in / out purpose
>>    - drop GAIN_SCALE_ITIME_MS()
>> - Add helpers for available scales and times
>> - Rename to iio-gts-helpers
> 
>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>> new file mode 100644
>> index 000000000000..9494ea7cdbcf
>> --- /dev/null
>> +++ b/drivers/iio/industrialio-gts-helper.c
>> @@ -0,0 +1,990 @@
> ...
> 
>> +
>> +static const struct iio_itime_sel_mul *
>> +iio_gts_find_itime_by_time(struct iio_gts *gts, int time)
> 
> Time going to be positive (I hope!)
> So as below, I'd make all time values unsigned.

I'll see what this would result. But as I said below, I am not sure it's 
worth the added complexity.

> 
>> +{
>> +	int i;
>> +
>> +	if (!gts->num_itime)
>> +		return NULL;
>> +
>> +	for (i = 0; i < gts->num_itime; i++)
>> +		if (gts->itime_table[i].time_us == time)
>> +			return &gts->itime_table[i];
>> +
>> +	return NULL;
>> +}
> 
> ...
> 
>> +/**
>> + * iio_gts_purge_avail_scale_table - free-up the available scale tables
>> + * @gts:	Gain time scale descriptor
>> + *
>> + * Free the space reserved by iio_gts_build_avail_scale_table(). Please note
>> + * that the helpers for getting available scales like the
>> + * iio_gts_all_avail_scales() are not usable after this call. Thus, this should
>> + * be only called after these helpers can no longer be called (Eg. after
>> + * the iio-device has been deregistered).
> 
> Whilst I'm not that keen on the comment in general, if you really really want to
> have it we need to figure out one place to put it rather than lots of duplicates.

I have seen way too many bugs with the unwinding errors. Usually with 
the IRQs but also when user-space has access to driver stuff. I placed 
this comment here hoping it would prevent at least one such bug as those 
tend to be really nasty to debug. If we avoid one, it is well worth of 
few lines of comment (IMO).


>> +	if (!gts->avail_all_scales_table)
>> +		ret = -ENOMEM;
>> +	else
>> +		for (i = 0; !ret && i < gts->num_avail_all_scales; i++)
>> +			ret = iio_gts_total_gain_to_scale(gts, all_gains[i],
>> +					&gts->avail_all_scales_table[i * 2],
>> +					&gts->avail_all_scales_table[i * 2 + 1]);
>> +
>> +	kfree(all_gains);
>> +	if (ret)
>> +		kfree(gts->avail_all_scales_table);
> 
> This is getting too clever.  I'd have an error handling block and gotos
> even though it duplicates one line.

gah. As I discussed with Andy, I do hate changing this. Well, I guess I 
have no choice.

>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * iio_gts_build_avail_scale_table - create tables of available scales
>> + * @gts:	Gain time scale descriptor
>> + *
>> + * Build the tables which can represent the available scales based on the
>> + * originally given gain and time tables. When both time and gain tables are
>> + * given this results:
>> + * 1. A set of tables representing available scales for each supported
>> + *    integration time.
>> + * 2. A single table listing all the unique scales that any combination of
>> + *    supported gains and times can provide.
>> + *
>> + * NOTE: Space allocated for the tables must be freed using
>> + * iio_gts_purge_avail_scale_table() when the tables are no longer needed.
>> + *
>> + * Return: 0 on success.
>> + */
>> +static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
>> +{
>> +	int **per_time_gains, **per_time_scales, i, j, ret = -ENOMEM;
>> +
>> +	per_time_gains = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);
> 
> As per other thread, I much prefer reviewing code with sizeof(*per_time_gains)
> as it requires fewer brain cells.

Hm. I think it depends on whether one wants to understand how many bytes 
the sizeof() is actually referring. Well, again, I guess I have no 
choice here.

>> +	if (!per_time_gains)
>> +		return ret;
>> +
>> +	per_time_scales = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);
>> +	if (!per_time_scales)
>> +		goto free_gains;
>> +
>> +	for (i = 0; i < gts->num_itime; i++) {
>> +		per_time_scales[i] = kcalloc(gts->num_hwgain, 2 * sizeof(int),
>> +					     GFP_KERNEL);
>> +		if (!per_time_scales[i])
>> +			goto err_free_out;
>> +
>> +		per_time_gains[i] = kcalloc(gts->num_hwgain, sizeof(int),
>> +					    GFP_KERNEL);
>> +		if (!per_time_gains[i])
>> +			goto err_free_scale_out;
> 
> As below. I'd put kfree(per_time_scales[i]); here to simplify the paths to
> the error handling block.
> 
>> +
>> +
>> +		for (j = 0; j < gts->num_hwgain; j++)
>> +			per_time_gains[i][j] = gts->hwgain_table[j].gain *
>> +					       gts->itime_table[i].mul;
>> +	}
>> +
>> +	ret = gain_to_scaletables(gts, per_time_gains, per_time_scales);
>> +	if (ret)
>> +		goto err_free_out;
> 
> I'm not a fan of dancing backwards and forwards with exit paths. As such I'd move
> the kfree(per_time_scales[i]) to the one condition where it matters above.

Ok.

> 
>> +
>> +	kfree(per_time_gains);
>> +	gts->per_time_avail_scale_tables = per_time_scales;
>> +
>> +	return 0;
>> +
>> +err_free_scale_out:
>> +	kfree(per_time_scales[i]);
>> +err_free_out:
>> +	for (i--; i; i--) {
>> +		kfree(per_time_scales[i]);
>> +		kfree(per_time_gains[i]);
>> +	}
>> +	kfree(per_time_scales);
>> +free_gains:
>> +	kfree(per_time_gains);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * iio_gts_build_avail_time_table - build table of available integration times
>> + * @gts:	Gain time scale descriptor
>> + *
>> + * Build the table which can represent the available times to be returned
>> + * to users using the read_avail-callback.
>> + *
>> + * NOTE: Space allocated for the tables must be freed using
>> + * iio_gts_purge_avail_time_table() when the tables are no longer needed.
>> + *
>> + * Return: 0 on success.
>> + */
>> +static int iio_gts_build_avail_time_table(struct iio_gts *gts)
>> +{
>> +	int *times, i, j, idx = 0;
>> +
>> +	if (!gts->num_itime)
>> +		return 0;
>> +
>> +	times = kcalloc(gts->num_itime, sizeof(int), GFP_KERNEL);
>> +	if (!times)
>> +		return -ENOMEM;
>> +
>> +	for (i = gts->num_itime - 1; i >= 0; i--) {
>> +		int new = gts->itime_table[i].time_us;
>> +
> 
> This looks like a sort routine.  Don't we have something generic that will work?

I think this is "combine and sort many tables into one while dropping 
duplicates". I must admit I don't know what sort routines we have 
in-kernel. If we have one which removes duplicates, then we could 
probably copy all the tables into one array and run such sort on it.

Or then we can leave this as is and add a comment about telling is going 
on here :)

> 
>> +		if (times[idx] < new) {
>> +			times[idx++] = new;
>> +			continue;
>> +		}
>> +
>> +		for (j = 0; j <= idx; j++) {
>> +			if (times[j] > new) {
>> +				memmove(&times[j + 1], &times[j],
>> +					(idx - j) * sizeof(int));
>> +				times[j] = new;
>> +				idx++;
>> +			}
>> +		}
>> +	}
>> +	gts->avail_time_tables = times;
>> +	/*
>> +	 * This is just to survive a unlikely corner-case where times in the
>> +	 * given time table were not unique. Else we could just trust the
>> +	 * gts->num_itime.
> 
> If integration times aren't unique I'd count it as driver bug and error out
> /scream.  Papering over things like this just make code harder to review
> to deal with what is probably a driver bug.

I am not entirely sure. I don't know the sensor ICs in details, but I've 
seen plenty of other ICs where we may have different register values 
that mean same physical measure. One such example is almost all ROHM 
PMICs, where we often see voltage selection registers like:

register val 0 to <foo>:
  - 1.0V + (val * 10 mV)
register val <A> to <MAX>:
  - 3.3 V

If we have similar registers for the time, then it may be good idea to 
accept selectors A...MAX to have the same time. This allows the 
gts-helpers to be used to convert the register values to times also for 
such devices. If we don't allow same times to be in the tables, then 
there may be unknown but valid register values read from the IC.

>> +	 */
>> +	gts->num_avail_time_tables = idx;
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +/**
>> + * iio_gts_purge_avail_tables - free-up the availability tables
>> + * @gts:	Gain time scale descriptor
>> + *
>> + * Free the space reserved by iio_gts_build_avail_tables(). Frees both the
>> + * integration time and scale tables.
>> + *
>> + * Note  that the helpers for getting available integration times or scales
>> + * like the iio_gts_avail_times() are not usable after this call. Thus, this
>> + * should be only called after these helpers can no longer be called (Eg.
>> + * after the iio-device has been deregistered).
> As below, I'm not sure the note adds much over normal use after free...

It is just use-after-free indeed. But people keep making these mistakes 
- and when they involve devive removal + unfortunate timing of 
user-space action to trigger they get really nasty to debug. Hence I 
hoped we could stop the code writer for a moment and ask him/her to take 
a look at his/her rewinding routine for this type of errors... Avoiding 
even one such bug is well worth couple of lines of text don't you think ;)

> Also different formatting to the one below.
> 
>> + */
>> +static void iio_gts_purge_avail_tables(struct iio_gts *gts)
>> +{
>> +	iio_gts_purge_avail_time_table(gts);
>> +	iio_gts_purge_avail_scale_table(gts);
>> +}
>> +
>> +static void devm_iio_gts_avail_all_drop(void *res)
>> +{
>> +	iio_gts_purge_avail_tables(res);
>> +}
>> +
>> +/**
>> + * devm_iio_gts_build_avail_tables - manged add availability tables
>> + * @dev:	Pointer to the device whose lifetime tables are bound
>> + * @gts:	Gain time scale descriptor
>> + *
>> + * Build the tables which can represent the available scales and available
>> + * integration times. Availability tables are built based on the originally
>> + * given gain and given time tables.
>> + *
>> + * When both time and gain tables are
>> + * given this results:
> 
> odd line break.
> 
>> + * 1. A set of sorted tables representing available scales for each supported
>> + *    integration time.
>> + * 2. A single sorted table listing all the unique scales that any combination
>> + *    of supported gains and times can provide.
>> + * 3. A sorted table of supported integration times
>> + *
>> + * After these tables are built one can use the iio_gts_all_avail_scales(),
>> + * iio_gts_avail_scales_for_time() and iio_gts_avail_times() helpers to
>> + * implement the read_avail opeations.
>> + *
>> + * The tables are automatically released upon device detach.
>> + *
>> + * NOTE: after the tables have been purged, the helpers for getting
>> + * available scales / integration times are no longer usable. Care must be
>> + * taken that unwinding is done in correct order (iio device is deregistered
>> + * prior purging the tables).
> 
> Hmm. I think this note is calling out one potential path (even if it's the most
> common one). I'd not bother with it as a driver should use no resources after
> they've been freed and this is typically one of many.

Well, I guess we both know by now why I added the note :) Hence I won't 
repeat my reasoning. I can drop the note if you think it serves no purpose.

> 
>> + *
>> + * Return: 0 on success.
>> + */
>> +int devm_iio_gts_build_avail_tables(struct device *dev, struct iio_gts *gts)
>> +{
>> +	int ret;
>> +
>> +	ret = iio_gts_build_avail_tables(gts);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_add_action_or_reset(dev, devm_iio_gts_avail_all_drop, gts);
>> +}
>> +EXPORT_SYMBOL_GPL(devm_iio_gts_build_avail_tables);
> 
>> +/**
>> + * iio_gts_valid_time - check if given integration time is valid
>> + * @gts:	Gain time scale descriptor
>> + * @time_us:	Integration time to check
>> + *
>> + * Return:	True if given time is supported by device. False if not.
>> + */
>> +bool iio_gts_valid_time(struct iio_gts *gts, int time_us)
>> +{
>> +	return iio_gts_find_itime_by_time(gts, time_us);
> I'd make this a little more explicit as implicit casting pointer to bool is
> rather unusual.
> 	!= NULL; maybe?

I think I may have had the !! here in the beginning. Yes, I can do != NULL.

> 
> 	
>> +}
>> +EXPORT_SYMBOL_GPL(iio_gts_valid_time);
>> +
>> +int iio_gts_find_sel_by_gain(struct iio_gts *gts, int gain)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < gts->num_hwgain; i++)
>> +		if (gts->hwgain_table[i].gain == gain)
>> +			return gts->hwgain_table[i].sel;
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_gts_find_sel_by_gain);
>> +
>> +bool iio_gts_valid_gain(struct iio_gts *gts, int gain)
>> +{
>> +	return iio_gts_find_sel_by_gain(gts, gain) >= 0;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_gts_valid_gain);
> 
> For the _valid_xxx functions, I wonder if you shouldn't just
> push them to the header as static inline

Well, I guess I can. No problem.

> 
>> +
>> +int iio_gts_find_gain_by_sel(struct iio_gts *gts, int sel)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < gts->num_hwgain; i++)
>> +		if (gts->hwgain_table[i].sel == sel)
>> +			return gts->hwgain_table[i].gain;
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_gts_find_gain_by_sel);
>> +
>> +int iio_gts_get_min_gain(struct iio_gts *gts)
> 
> Could just use min = INT_MAX;
> (indirectly from linux/limits.h, it's actually in vdso/limits.h
> but should not include that directly I think)
> then I don't hink you need the special casing for the
> first entry.

Hmm. I guess you think we don't need to handle case num_hwgain == 0 here 
as it should be checked in the initialization routine. Not sure what to 
think about it.

> 
>> +{
>> +	int i, min = -EINVAL;
>> +
>> +	for (i = 0; i < gts->num_hwgain; i++) {
>> +		int gain = gts->hwgain_table[i].gain;
>> +
>> +		if (min == -EINVAL)
>> +			min = gain;
>> +		else
>> +			min = min(min, gain);
>> +	}
>> +
>> +	return min;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_gts_get_min_gain);
>> +
>> +/**
>> + * iio_find_closest_gain_low - Find the closest lower matching gain
>> + * @gts:	Gain time scale descriptor
>> + * @gain:	reference gain for which the closest match is searched
>> + * @in_range:	indicate if the reference gain was actually in the range of
>> + *		supported gains.
>> + *
>> + * Search for closest supported gain that is lower than or equal to the
>> + * gain given as a parameter. This is usable for drivers which do not require
>> + * user to request exact matching gain but rather fo rounding to a supported
>> + * gain value which is equal or lower (setting lower gain is typical for
>> + * avoiding saturation)
>> + *
>> + * Return:	The closest matching supported gain or -EINVAL is reference
> 
> Maybe just say @gain was smaller.  reference gain does not have clear meaning to me.

Ok.

> 
>> + *		gain was smaller than the smallest supported gain.
>> + */
>> +int iio_find_closest_gain_low(struct iio_gts *gts, int gain, bool *in_range)
>> +{
>> +	int i, diff = 0;
>> +	int best = -1;
>> +
>> +	*in_range = false;
>> +
>> +	for (i = 0; i < gts->num_hwgain; i++) {
>> +		/*
>> +		 * It is not expected this function is called for an exactly
>> +		 * matching gain.
> I'd not mark it unlikely even so (or comment on it).
> This is unlikely to be a particularly hot path so this unlikely() seems like a
> premature optimization which adds complexity to the code.

Hm. I don't really see the increased complexity here - but I don't also 
think this is going to be very performance critical either. So, I can 
drop this even though I personally think that small optimizations here 
and there (when not really adding extra complexity) should actually be 
encouraged.

>> +/*
>> + * iio_gts_find_gain_sel_for_scale_using_time - Fetch gain selector.
>> + * See iio_gts_find_gain_for_scale_using_time() for more information
> 
> This is exported, so I'd rather see kernel-doc style comments.

Ok.

> 
>> + */
>> +int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int time_sel,
>> +					       int scale_int, int scale_nano,
>> +					       int *gain_sel)
>> +{
>> +	int gain, ret;
>> +
>> +	ret = iio_gts_find_gain_for_scale_using_time(gts, time_sel, scale_int,
>> +						     scale_nano, &gain);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = iio_gts_find_sel_by_gain(gts, gain);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*gain_sel = ret;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_gts_find_gain_sel_for_scale_using_time);
>> +
>> +int iio_gts_find_int_time_by_sel(struct iio_gts *gts, int sel)
>> +{
>> +	const struct iio_itime_sel_mul *itime;
>> +
>> +	itime = iio_gts_find_itime_by_sel(gts, sel);
>> +	if (!itime)
>> +		return -EINVAL;
>> +
>> +	return itime->time_us;
> 
> Currently can be negative.  Even when you stop that being the case
> by makign time unsigned, you need to be careful with ranges here.
> You may be better off separating the error handling from the values
> to avoid any issues even though that makes it a little harder to use.

Yes. As I wrote above, I thought that the driver author needs to ensure 
the valid times would always be positive. I was guessing usec is going 
to be used as unit for most cases and 2000+ seconds is probably 
sufficient. But yes, I guess I should have documented this.

Hmm. Do you think we should support times larger than can be represented 
by signed int? I'd rather not support that if it is not needed as it 
will make this quite a bit more complex.

>> +}
>> +EXPORT_SYMBOL_GPL(iio_gts_find_int_time_by_sel);
>> +
>> +int iio_gts_find_sel_by_int_time(struct iio_gts *gts, int time)
>> +{
>> +	const struct iio_itime_sel_mul *itime;
>> +
>> +	itime = iio_gts_find_itime_by_time(gts, time);
>> +	if (!itime)
>> +		return -EINVAL;
>> +
>> +	return itime->sel;
> 
> itime->sel can be negative.  I wonder if you should just make that
> u16 so that you can always return it as a positive integer but
> having it as unsigned in the structure.

Here I did the same assumption of sel sizes. I don't expect we to see 32 
bit selectors. To tell the truth, I just followed the linear_ranges 
logic which is heavily used in the regulator drivers.

> Otherwise you need to add some docs on those limits and probably
> sanity check them during the _init()

I am almost certain the sanity check is going to be an overkill, but it 
sure is doable. The onlu corner case I can think of is if register 
really accepts the time itself as a "selector" - but even then having 
such large values they would use the whole 32bits would be unlikely.

>> +}
>> +EXPORT_SYMBOL_GPL(iio_gts_find_sel_by_int_time);
>> +
>> +static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
>> +{
>> +	const struct iio_itime_sel_mul *itime;
>> +
>> +	if (!iio_gts_valid_gain(gts, gain))
>> +		return -EINVAL;
>> +
>> +	if (!gts->num_itime)
>> +		return gain;
>> +
>> +	itime = iio_gts_find_itime_by_time(gts, time);
>> +	if (!itime)
>> +		return -EINVAL;
>> +
>> +	return gain * itime->mul;
> 
> Check for overflow perhaps?

I think that if we want to add the overflow checks, we should do that 
already in init. That way we can check all the combinations before they 
are used - so that the driver authors get the errors even if they did 
not test all the times/gains their HW is supporting. I am not really 
convinced it's worth though.

>> +}
>> +
>> +static int iio_gts_get_scale_linear(struct iio_gts *gts, int gain, int time,
>> +				    u64 *scale)
>> +{
>> +	int total_gain;
>> +	u64 tmp
>> +
>> +	total_gain = iio_gts_get_total_gain(gts, gain, time);
>> +	if (total_gain < 0)
>> +		return total_gain;
>> +
>> +	tmp = gts->max_scale;
>> +
>> +	do_div(tmp, total_gain);
>> +
>> +	*scale = tmp;
>> +
>> +	return 0;
>> +}
>> +
>> +int iio_gts_get_scale(struct iio_gts *gts, int gain, int time, int *scale_int,
>> +		      int *scale_nano)
>> +{
>> +	u64 lin_scale;
>> +	int ret;
>> +
>> +	ret = iio_gts_get_scale_linear(gts, gain, time, &lin_scale);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return iio_gts_delinearize(lin_scale, NANO, scale_int, scale_nano);
>> +}
>> +EXPORT_SYMBOL_GPL(iio_gts_get_scale);
> 
> It is good practice to add kernel-doc for all the exported functions,
> even if some of them will be fairly obvious.

Makes sense. I'll add docs to all exported ones.

> If you can make the units explicit in the parameter that's even better.

My very initial idea was that the driver should know the units and that 
these helpers would do no unit conversions. I am unsure what road to 
take here now. I kind of like fixing the units - but on the other hand, 
allowing driver authors to decide the units makes this more flexible (as 
units can be chosen so that times won't overflow).

OTOH, now that there is the iio_gts_avail_times() - helper, it would be 
good to have the returned times in correct units. I guess we have same 
integration-time unit specified for all types of sensors? If yes, then 
it would be cleanest to require units in this format, especially if it 
is not likely to cause problems with the overflows.

> I will note that negative times seem unlikely so maybe that should always
> be unsigned?  gain probably can be negative even if that's unusual.
> That may lead to problems though as lin_scale is in turn unsigned.

Yes. I plan to support only positive gains. At least for now.

> 
>> +
>> +/**
>> + * iio_gts_find_new_gain_sel_by_old_gain_time - compensate time change
> 
> compensate for time change

thanks :)

Oh, and by the way - I appreciate the review and suggestions even when I 
do not always agree with them. So, thanks again for all the effort!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

