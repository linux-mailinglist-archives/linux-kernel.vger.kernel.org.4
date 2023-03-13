Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7091C6B7910
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjCMNej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCMNeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:34:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E1F474DE;
        Mon, 13 Mar 2023 06:34:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t11so15748204lfr.1;
        Mon, 13 Mar 2023 06:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678714473;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKeBZQC0ZwPGTcZCyTsJLDEjndxwFQ5Gy5SpfaIti0Y=;
        b=U5YUHi1gRB2moYLUT54GA6AbyEpEwY5JwQAi9TTtmOlxv+AzrGuSvWbB9KVG+zOFWS
         Zu65qagUDgZG5o1vT+t1ezbpe5Wf4lvwgzin2PYwcLbwOhOHAWOXYFxk2tIz279gOgAt
         fIu1aBLK3Gz9KDLX7m9izk01Z59UHMf+krUo3iV9Tu27OJP9dGBA8fpz39Eyv1Vjj8mv
         KSRkqkniiiZRK2r4Yt3UvgwZhW5snHz78kY9Aac9JxVliUOlSHXaorQMP7hQzvXXaVLx
         OzbrKtSK8neP0n8rmQQgrApsEzd58zIGzBv2FBok/UVRMeB9fXchF0T87oyyuA4RTIZC
         wAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678714473;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKeBZQC0ZwPGTcZCyTsJLDEjndxwFQ5Gy5SpfaIti0Y=;
        b=7kOLpb3S9pT3NMNwZ1EHRY49ZC0z6Yq7Q5TQFFgt4hMMiJ1CwdPIu3M+9b3FUDbTP7
         MPF8mAB2J4FFT2PQ6CoE27ossaHdibZPCZJ+N+gyKqPIphMgLVcRLjcCfBWEsbDGOXvu
         dNfSqggzg0MJjTjWSWpzGlKtSdpDG+IGnvfc68xlZLYdhfK286IoSIft3ueCmoTxRJFB
         xLxC1wbIDcdT0IKwTPTl4vYkRrUkTW7xlVokgcCD/jr4FJpN9ejmyX9Px5evimw8e8IN
         sZ/NAXTFspUyeAy2C0L1W5VOftylGnqh64M/LgtPWTzRmNFIX97IN030iE6arFGnCN0m
         mA6A==
X-Gm-Message-State: AO0yUKU5lUROSmwfT1D1Vi2GXAHKJjuFeRZ8QaCGglIijegQvtbggAgx
        foiz5a2CvH4laMfQOiqI97M=
X-Google-Smtp-Source: AK7set+QLDePskxlgD9ESk1qdI3IxJ9ZtDacPaja89dDxwwKzllhiir5iv6pTeTI+xykRQ7hrg0XTg==
X-Received: by 2002:ac2:50d5:0:b0:4dd:a57e:9960 with SMTP id h21-20020ac250d5000000b004dda57e9960mr9749620lfm.5.1678714472690;
        Mon, 13 Mar 2023 06:34:32 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id p23-20020a19f017000000b004d3d44bb98asm961288lfc.270.2023.03.13.06.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 06:34:32 -0700 (PDT)
Message-ID: <4a45f777-9491-23d3-f7ed-924315c4680b@gmail.com>
Date:   Mon, 13 Mar 2023 15:34:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <286c1564216cb62cf802478ee786f2ce313df70a.1678093787.git.mazziesaccount@gmail.com>
 <20230312173940.6528ec5a@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
In-Reply-To: <20230312173940.6528ec5a@jic23-huawei>
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

On 3/12/23 19:39, Jonathan Cameron wrote:
> On Mon, 6 Mar 2023 11:23:50 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> ROHM BU27034 is an ambient light sensor with 3 channels and 3 photo diodes
>> capable of detecting a very wide range of illuminance. Typical application
>> is adjusting LCD and backlight power of TVs and mobile phones.
>>
>> Add initial  support for the ROHM BU27034 ambient light sensor.
>>
>> NOTE:
>> 	- Driver exposes 4 channels. One IIO_LIGHT channel providing the
>> 	  calculated lux values based on measured data from diodes #0 and
>> 	  #1. In addition, 3 IIO_INTENSITY channels are emitting the raw
>> 	  register data from all diodes for more intense user-space
>> 	  computations.
>> 	- Sensor has GAIN values that can be adjusted from 1x to 4096x.
>> 	- Sensor has adjustible measurement times of 5, 55, 100, 200 and
>> 	  400 mS. Driver does not support 5 mS which has special
>> 	  limitations.
>> 	- Driver exposes standard 'scale' adjustment which is
>> 	  implemented by:
>> 		1) Trying to adjust only the GAIN
>> 		2) If GAIN adjustment alone can't provide requested
>> 		   scale, adjusting both the time and the gain is
>> 		   attempted.
>> 	- Driver exposes writable INT_TIME property that can be used
>> 	  for adjusting the measurement time. Time adjustment will also
>> 	  cause the driver to try to adjust the GAIN so that the
>> 	  overall scale is kept as close to the original as possible.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>>
>> Please note: There are few "unfinished" discussions regarding at least:
>>
>> - PROCESSED channel scale.
> 
> Hopefully the reply in the other thread covered this.
> It's not PROCESSED as you need to apply the * 1000 so just
> make it _RAW.
> 

Your reply in the other thread was just fine :) I think I'll round the 
result to luxes (which should be sufficient to many users if I am not 
mistaken) - and provide the PROCESSED values to user-space for the sake 
of the ultimate simplicity for users.

>> - Implementation details when avoiding division by zero.
>>
>> I have implemented those for this version in a way that I see the best.
>> It would have been better to wait for discussions to finish - but I will
>> be away from the computer for a week - so I wanted to send out the v3
>> with fixes so that people who are interested can do a review while I am
>> away.
> 
> I'm getting behind with review anyway so a week delay on this sounds great to
> me ;)  I might get to your other series as a result though don't think I'll get there today.
> 

Oh, the week elapsed already ;) But don't sweat on it - this series grew 
quite large so spending time on reviewing makes perfect sense. I _know_ 
reviewing, and especially careful reviewing, takes time. And energy. 
Sometimes we lack of both, occasionally just the other :) Thanks for all 
the effort you and Andy have put on this so far!

> 
>> +static int bu27034_calc_mlux(struct bu27034_data *data, __le16 *res, int *val)
>> +{
>> +	unsigned int gain0, gain1, meastime;
>> +	unsigned int d1_d0_ratio_scaled;
>> +	u16  ch0, ch1;
>> +	u64 helper64;
>> +	int ret;
>> +
>> +	/*
>> +	 * We return 0 luxes if calculation fails. This should be reasonably
>> +	 * easy to spot from the buffers especially if raw-data channels show
>> +	 * valid values
>> +	 */
>> +	*val = 0;
>> +
>> +	/*  Avoid div by zero. */
>> +	if (!res[0])
>> +		ch0 = 1;
>> +	else
>> +		ch0 = le16_to_cpu(res[0]);
>> +
>> +	if (!res[1])
>> +		ch1 = 1;
>> +	else
>> +		ch1 = le16_to_cpu(res[1]);
>> +
> 
> As per other thread. Really don't like the check on 0 before
> the endian conversion.  Sure it can be done, but it's a micro optimization that
> seems unnecessary.

Ugh... Andy pointed me the max_t(). I'll use it even though I do really 
dislike that change a lot.

> 
> ...
> 
>> +
>> +static int bu27034_read_raw(struct iio_dev *idev,
>> +			   struct iio_chan_spec const *chan,
>> +			   int *val, int *val2, long mask)
>> +{
>> +	struct bu27034_data *data = iio_priv(idev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_INT_TIME:
>> +		*val = bu27034_get_int_time(data);
>> +		if (*val < 0)
>> +			return *val;
>> +
>> +		/*
>> +		 * We use 50000 uS internally for all calculations and only
>> +		 * convert it to 55000 before returning it to the user.
>> +		 *
>> +		 * This is because the data-sheet says the time is 55 mS - but
>> +		 * vendor provided computations used 50 mS.
> 
> No chance of a clarification?  would be lovely to not do this!

Actually, since the current code uses the multiplier-field in 
gts-helpers - it may be we can just use the 55000 in the tables now. I 
need to check it. So perhaps we can avoid this one now! Thanks!

> 
>> +		 */
>> +		if (*val == 50000)
>> +			*val = 55000;
>> +
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		return bu27034_get_scale(data, chan->channel, val, val2);
>> +
>> +	case IIO_CHAN_INFO_RAW:
>> +	{
>> +		if (chan->type != IIO_INTENSITY)
>> +			return -EINVAL;
>> +
>> +		if (chan->channel < BU27034_CHAN_DATA0 ||
>> +		    chan->channel > BU27034_CHAN_DATA2)
>> +			return -EINVAL;
>> +
>> +		/* Don't mess with measurement enabling while buffering */
>> +		ret = iio_device_claim_direct_mode(idev);
>> +		if (ret)
>> +			return ret;
>> +
>> +		mutex_lock(&data->mutex);
>> +		/*
>> +		 * Reading one channel at a time is ineffiecient but we don't
> 
> spell check comments.
> 
>> +		 * care here. Buffered version should be used if performance is
>> +		 * an issue.
>> +		 */
>> +		ret = bu27034_get_single_result(data, chan->channel, val);
>> +
>> +		mutex_unlock(&data->mutex);
>> +		iio_device_release_direct_mode(idev);
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		return IIO_VAL_INT;
>> +	}
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
>> +
>> +		ret = bu27034_get_mlux(data, val);
>> +
>> +		mutex_unlock(&data->mutex);
>> +		iio_device_release_direct_mode(idev);
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		return IIO_VAL_INT;
>> +
>> +	default:
>> +		return -EINVAL;
>> +
>> +	}
>> +
>> +	return ret;
> 
> I would hope you can't get here. If you can fix that so
> that the lack of return here allows the compiler to know  you didn't
> intend to get here and hence complain about it.
> 

Sigh. I personally still think functions should return from the end... 
Well, I will revise this for v4.

> 
>> +static int bu27034_probe(struct i2c_client *i2c)
>> +{
>> +	struct device *dev = &i2c->dev;
>> +	struct bu27034_data *data;
>> +	struct regmap *regmap;
>> +	struct iio_dev *idev;
>> +	unsigned int part_id, reg;
>> +	int ret;
>> +
>> +	regmap = devm_regmap_init_i2c(i2c, &bu27034_regmap);
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(dev, PTR_ERR(regmap),
>> +				     "Failed to initialize Regmap\n");
>> +
>> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!idev)
>> +		return -ENOMEM;
>> +
>> +	ret = devm_regulator_get_enable(dev, "vdd");
>> +	if (ret && ret != -ENODEV)
> 
> Why the special -ENODEV handling?
> You should get a stub regulator if one isn't provided by firmware.
> If you don't get a stub, or a real regulator that's a failure so we should
> return the error code and fail the probe.

I am actually not sure. Maybe my test setup didn't have the dummy 
regulator assigned. I will re-check this.


The comments which I just skipped are something I more or less agree with :)

Best Regards
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

