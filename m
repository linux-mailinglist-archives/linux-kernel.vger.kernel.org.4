Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9001F6AAF78
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 13:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCEMW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 07:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCEMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 07:22:56 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA85A19B9;
        Sun,  5 Mar 2023 04:22:54 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id z42so6853149ljq.13;
        Sun, 05 Mar 2023 04:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678018973;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fxa3JSdBjR11ggW+4GvWfjNtDCdDCa14Je0bJ6V+ye0=;
        b=MGVCQe3n1eOH7uafvXwqLYaGUe9gMVE32oAwU0R6AgYkBJ32ZyhE8JL85rBXS+uWtM
         tkvBv8Ws4Ie8eGx/TgOXaf0aPbvERmzggWBBbi9RLgQzZ38KsNqCbveeAN6gYPezW2px
         zgbmKjaWVNbjDXAVsuYbeQf1UrSuQYJo8aLu6ZHQxFTa6dC06M2crkeFmd6Udao6sScE
         XPyJuvyYUl8RKCjfl6XGHR6yNSvHBsepZnHCGo6Ushwl3MXbJF8xPo+WcVI/krDWAfNu
         fgN74n/22IIWVBkYV9FEha+mNohQU+VtjlksLGMM43+96lGX/evJRABAZ5+eVIcq1X6Z
         rfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678018973;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fxa3JSdBjR11ggW+4GvWfjNtDCdDCa14Je0bJ6V+ye0=;
        b=6DJrTsNz6tPYE3wtAnk8GkqcgU2BbHrh2t3bjgXMe2dnKyicsUp92rkninL/uRT8QO
         QCTK3E9D44oOwh27l4x9O/5MUbNB7QrJmi2AG4IDCDHtd8GOSvyqp3PiRPMz/2SQ9kkD
         zWqLLBlOAhSROZe8S6fNnn1A324gCXfa6a5HQIj5s8Zr9q+JLWAkP/m/uvkiLB5HOLt6
         LSwlISm+VtQrvmzVockaZZIwFtnlhLtVkVhSEr2qAOZMnbG7DBBRzTMY5b/eZvPY5rfY
         nKKkdqpVV6lGZ4prilf/RVE5PtguYXFgD9HrIxPBLpF0Ye/gc7E5gvIo3r2a42JehKgl
         tO3A==
X-Gm-Message-State: AO0yUKW1fOvMNsgWeP8qt1fiW6/BFpz1Jjgm9NgdgZ1bEgtnJG/2wgsI
        ua6Prz0SPwYvqB1O9PBIFEg=
X-Google-Smtp-Source: AK7set/3S6rVVdv63wz55P4MryjwzL61IpmXOF+dG4AmBan/kGNyis3Ixuouanc4XgBPrbJMNSnDAg==
X-Received: by 2002:a2e:9011:0:b0:295:a96d:66fa with SMTP id h17-20020a2e9011000000b00295a96d66famr1832146ljg.20.1678018972655;
        Sun, 05 Mar 2023 04:22:52 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e9ac8000000b0029353201fddsm1249539ljj.129.2023.03.05.04.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 04:22:52 -0800 (PST)
Message-ID: <c16d372f-a122-16d6-ad08-1fbffb01d9ff@gmail.com>
Date:   Sun, 5 Mar 2023 14:22:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
 <20230304201720.2d554f07@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
In-Reply-To: <20230304201720.2d554f07@jic23-huawei>
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

On 3/4/23 22:17, Jonathan Cameron wrote:
> On Thu, 2 Mar 2023 12:58:59 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> +/*
>> + * The BU27034 does not have interrupt or any other mechanism of triggering
>> + * the data read when measurement has finished. Hence we poll the VALID bit in
>> + * a thread. We will try to wake the thread BU27034_MEAS_WAIT_PREMATURE_MS
>> + * milliseconds before the expected sampling time to prevent the drifting. Eg,
>> + * If we constantly wake up a bit too late we would eventually skip a sample.
> 
> Lazier approach would be to just sent the sampling frequency at twice the
> expected frequency and you'll never miss a sample unless you the wake up is
> delayed massively for some reason.  Particularly 'fresh' data might not matter
> enough that half a cycle late is a problem.

Hmm. Do I read this right - You suggest we drop the polling loop for 
valid bit and just always sleep for int_time / 2 if data was not valid?

I don't know. That would probably make the time-stamps for buffered 
results to be jumping quite a bit - especially with the longer 
integration times.

>> + * And because the sleep can't wake up _exactly_ at given time this would be
>> + * inevitable even if the sensor clock would be perfectly phase-locked to CPU
>> + * clock - which we can't say is the case.
>> + *
>> + * This is still fragile. No matter how big advance do we have, we will still
>> + * risk of losing a sample because things can in a rainy-day skenario be
>> + * delayed a lot. Yet, more we reserve the time for polling, more we also lose
>> + * the performance by spending cycles polling the register. So, selecting this
>> + * value is a balancing dance between severity of wasting CPU time and severity
>> + * of losing samples.
>> + *
>> + * In most cases losing the samples is not _that_ crucial because light levels
>> + * tend to change slowly.
>> + */
>> +#define BU27034_MEAS_WAIT_PREMATURE_MS	5
>> +#define BU27034_DATA_WAIT_TIME_US	1000
>> +#define BU27034_TOTAL_DATA_WAIT_TIME_US (BU27034_MEAS_WAIT_PREMATURE_MS * 1000)
> 
>> +static const struct iio_chan_spec bu27034_channels[] = {
>> +	{
>> +		.type = IIO_LIGHT,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
> 
> What is this scale for?

The scale is to inform users that we return data using milli lux.

> Given the channel is computed from various different inputs, is there a
> clear definition of how it is scaled?  What does a write to it mean?

Nothing. writing anything else but milli lux scale fails with -EINVAL.

I guess I am doing something in an unusual way here :) Do you have a 
suggestion for me?


>> +			/*
>> +			 * As Jonathan put it, if caller requests for
> 
> Probably don't reference me directly in a driver.  Keep the 'blame' for the
> email threads :)  Comment is fine otherwise.

Okay, okay :) I just liked the expression and didn't want to take the 
credit for it ;)

>> +
>> +	/*
>> +	 * The new integration time can be supported while keeping the scale of
>> +	 * channels intact by tuning the gains.
> 
> This comment is in a path that is hit event if we go through the warnings
> above that say this isn't true.

Oh! Valid point! This changed when I allowed gain to be changed - need 
to drop the comment. Thanks!

>> +
>> +static int bu27034_calc_lux(struct bu27034_data *data, __le16 *res, int *val)
> 
> As you are going to put it in the buffer, make val a fixed size integer.
> The current approach of calculate in an int and copy to a u32 is a bit nasty.
> Of course if there is a chance of a large enough value you'll have to be careful
> for the unsigned to signed conversion on 32 bit platforms. I doubt there is, but
> a comment saying why not would be great in the code that is hit from read_raw()

This same ..._calc_lux() is used also from the read_raw. I'd rather keep 
this using ints so there would be no need for involving u32 in 
read_raw() path. However, you are correct in that the current calling 
from buffered read where we pass pointer to u32 here - is nasty. I'll 
add temporary int in the calling function there, and add casting with a 
comment when storing value to scan.lux. Thanks for pointing this out! 
There was also missing an error return problem - see below.

>> +
>> +	if (d1_d0_ratio_scaled < 87)
>> +		*val = bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 0);
>> +	else if (d1_d0_ratio_scaled < 100)
>> +		*val = bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 1);
>> +	else
>> +		*val = bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 2);
>> +

The bu27034_fixp_calc_lx() might return -EINVAL - which we missed here. 
I'll fix also this one.

>> +
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		if (chan->type != IIO_LIGHT)
>> +			return -EINVAL;
>> +
>> +		/* Don't mess with measurement enabling while buffering */
>> +		ret = iio_device_claim_direct_mode(idev);
>> +		if (ret)
>> +			return ret;
>> +
>> +		mutex_lock(&data->mutex);
> 
> See below. I would factor out the rest of this so that you can
> unconditionally unlock and then check the return value.

Yes. moving measurement start/stop in bu27034_get_lux() makes this much 
nicer. I wonder how I didn't see that myself - thanks.

>> +
>> +	ret = regmap_read(regmap, BU27034_REG_SYSTEM_CONTROL, &part_id);
> 
> As it's not all of the register I'd rename the temporary variable to
> val or reg or something along those lines.

I still like having the variable named part_id - as it makes the check 
obvious. What I did was adding another temporary variable 'reg' and doing:

part_id = FIELD_GET(BU27034_MASK_PART_ID, reg);

and then using the part_id in if() and dev_warn().

> 
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to access sensor\n");
>> +
>> +	part_id &= BU27034_MASK_PART_ID;
> 
> FIELD_GET() even when it's lower bits as then there is no need for
> a reviewer to confirm that it is the lower bits.
> Then you can just do
> 
> 	if (FIELD_GET(BU27034_MASK_PART_ID, reg) != BU27034_ID)
> 
>> +
>> +	if (part_id != BU27034_ID)
>> +		dev_warn(dev, "unsupported device 0x%x\n", part_id);
> 
> I'd adjust that to "unknown device" or "unrecognised device" as it might
> well be supported just fine based on the compatible fallback, we just have
> no way of knowing if it is.
> 

Hmm. Won't promise but maybe I have the time to finish v3 tonight. We 
can then continue discussions towards the v4 :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

