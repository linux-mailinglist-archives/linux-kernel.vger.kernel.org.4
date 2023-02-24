Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D442E6A1A82
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBXKnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjBXKnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:43:02 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3CC2A157;
        Fri, 24 Feb 2023 02:41:49 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f41so17324270lfv.13;
        Fri, 24 Feb 2023 02:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQw4NVJFAFLSgoZBVcMoqNPGG17Af/T/X5oeh8AkTQ0=;
        b=X6ENhphd+wZzM9gl/6cTr4GEyl2heOOInN5Fw8QqrKfFopQxA1Co3/9VBOkoLZxDae
         wF9xsUbGUUooSGnij5fjxbPzUQijeguce7/nZEtms7anoVi5sp9xrVGP8VlZFdlAAvFA
         X2oairdrWVv7VH9zCuMIl2HIDnx8yuL1iWuxTpPwouhvBksLlIOed6d8YyUId4B/Rdlm
         TxbNV84zz5JERAzq0my7e4ohF5R4SJcH/5WuKKWqtj8Vveu0ApoypTshHn6KdziEIw9P
         ulNXUR8/5tlO5uyIttIwgTjQDkeAkXgzcsou5RAnONbUcm7HLrwCHYmWKalTzF1zVLQg
         u8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQw4NVJFAFLSgoZBVcMoqNPGG17Af/T/X5oeh8AkTQ0=;
        b=ikWAkeXEpz0aPqkchHlFp54R2p6O5vLutZK1CkqWkshaau/ZNwmozSQ69BC1EbXCGF
         fh1jlQA89yHybxxTzzqdfZaJKW4BB5JptUWdy6bdzEZ4YGjz4DL3xKnf2NumyvQlPIe7
         5psVdB2keQcqeCmldIVYrbo1+8TwWMJGWKyYUrsJkag2C4ajwSbZ51ag986UC/Nq/wZI
         YL2CVGzk7jlSxTrqa0HdKSgNeTEkkm0HPsej/6KZRD8f6H913qtGAS5w+Nb2yugd/X3a
         RAU1w9WmGsFMvdLvI91XUwWErw4PHaKl5FjM+QHracoguvEaoIJD+CK/iySDlMOWOBt0
         4quQ==
X-Gm-Message-State: AO0yUKUYgE+TaPLLTr7mqBnMXBoPAWbZB+RmFcnrNq/3tzz66aJlx/lW
        htuHgRhWsZzn5W0PEs9aLbw=
X-Google-Smtp-Source: AK7set+X31MsOvhb4Gd5lEMAbTEf9y8axw33yhjVzJNDqQ7imwI3ateGBXGiuAInpl1tQ2MkOTogjQ==
X-Received: by 2002:ac2:4479:0:b0:4db:4fa6:7c0c with SMTP id y25-20020ac24479000000b004db4fa67c0cmr4864298lfl.60.1677235307868;
        Fri, 24 Feb 2023 02:41:47 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id m15-20020a19520f000000b004cb2995de37sm1628025lfb.265.2023.02.24.02.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 02:41:47 -0800 (PST)
Message-ID: <02f948ee-34ee-c15e-09e4-d0d8c5161c9b@gmail.com>
Date:   Fri, 24 Feb 2023 12:41:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
 <63a2dbedf54e2e00e3b63dd16aae190ff6596355.1677080089.git.mazziesaccount@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
In-Reply-To: <63a2dbedf54e2e00e3b63dd16aae190ff6596355.1677080089.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 18:15, Matti Vaittinen wrote:

//snip

> 	- Driver starts the measurement on the background when it is
> 	  probed. This improves the respnse time to read-requests
> 	  compared to starting the read only when data is requested.
> 	  When the most accurate 400 mS measurement time is used, data reads
> 	  would last quite long if measurement was started only on
> 	  demand. This, however, is not appealing for users who would
> 	  prefere power saving over measurement response time.

//snip

> +static bool bu27034_has_valid_sample(struct bu27034_data *data)
> +{
> +	int ret, val;
> +
> +	ret = regmap_read(data->regmap, BU27034_REG_MODE_CONTROL4, &val);
> +	if (ret)
> +		dev_err(data->dev, "Read failed %d\n", ret);
> +
> +	return (val & BU27034_MASK_VALID);
> +}
> +
> +static void bu27034_invalidate_read_data(struct bu27034_data *data)
> +{
> +	bu27034_has_valid_sample(data);
> +}
> +
> +static int _bu27034_get_result(struct bu27034_data *data, u16 *res, bool lock)
> +{
> +	int ret = 0;
> +
> +retry:
> +	if (lock)
> +		mutex_lock(&data->mutex);
> +	/* Get new value from sensor if data is ready - or use cached value */
> +	if (bu27034_has_valid_sample(data)) {
> +		ret = regmap_bulk_read(data->regmap, BU27034_REG_DATA0_LO,
> +				       &data->raw[0], sizeof(data->raw));
> +		if (ret)
> +			goto unlock_out;
> +
> +		data->cached = true;
> +		bu27034_invalidate_read_data(data);
> +	} else if (unlikely(!data->cached)) {
> +		/* No new data in sensor and no value cached. Wait and retry */
> +		if (lock)
> +			mutex_unlock(&data->mutex);
> +		msleep(25);
> +
> +		goto retry;
> +	}
> +	res[0] = le16_to_cpu(data->raw[0]);
> +	res[1] = le16_to_cpu(data->raw[1]);
> +	res[2] = le16_to_cpu(data->raw[2]);
> +
> +unlock_out:
> +	if (lock)
> +		mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int bu27034_get_result_unlocked(struct bu27034_data *data, u16 *res)
> +{
> +	return _bu27034_get_result(data, res, false);
> +}
> +
> +static int bu27034_get_result(struct bu27034_data *data, u16 *res)
> +{
> +	return _bu27034_get_result(data, res, true);
> +}

//snip

> +	case IIO_CHAN_INFO_RAW:
> +	{
> +		u16 res[3];
> +
> +		if (chan->type != IIO_INTENSITY)
> +			return -EINVAL;
> +
> +		if (chan->channel < BU27034_CHAN_DATA0 ||
> +		    chan->channel > BU27034_CHAN_DATA2)
> +			return -EINVAL;
> +		/*
> +		 * Reading one channel at a time is inefficient.
> +		 *
> +		 * Hence we run the measurement on the background and always
> +		 * read all the channels. There are following caveats:
> +		 * 1) The VALID bit handling is racy. Valid bit clearing is not
> +		 * tied to reading the data in the hardware. We clear the
> +		 * valid-bit manually _after_ we have read the data - but this
> +		 * means there is a small time-window where new result may
> +		 * arrive between read and clear. This means we can miss a
> +		 * sample. For normal use this should not be fatal because
> +		 * usually the light is changing slowly. There might be
> +		 * use-cases for measuring more rapidly changing light but this
> +		 * driver is unsuitable for those cases anyways. (Smallest
> +		 * measurement time we support is 55 mS.)
> +		 * 2) Data readings more frequent than the meas_time will return
> +		 * the same cached values. This should not be a problem for the
> +		 * very same reason 1) is not a problem.
> +		 */
> +		ret = bu27034_get_result(data, &res[0]);
> +		if (ret)
> +			return ret;
> +
> +		*val = res[chan->channel - BU27034_CHAN_DATA0];
> +
> +		return IIO_VAL_INT;
> +	}

//snip

> +static int bu27034_chip_init(struct bu27034_data *data)
> +{

//snip

> +
> +	/*
> +	 * Consider disabling the measurement (and powering off the sensor) for
> +	 * runtime pm
> +	 */
> +	ret = bu27034_meas_en(data);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(data->dev, bu27034_meas_stop, data);
> +}

Well, this "works on my machine" - but I am slightly unhappy with this. 
I have a feeling I am effectively making a poor, reduced version of data 
buffering here. I am starting to think that I should

a) Not start measurement at chip init. (saves power)
b) Start measurement at raw-read and just block for damn long for each 
raw-read. Yep, it probably means that users who want to raw-read all 
channels will be blocking 4 * measurement time when they are reading all 
channels one after another. Yes, this is in worst case 4 * 400 mS. 
Horrible. But see (c) below.
c) Implement triggered_buffer mode. Here my lack of IIO-experience shows 
up again. I have no idea if there is - or what is - the "de facto" way 
for implementing this when our device has no IRQ? I could cook-up some 
'tiny bit shorter than the measurement time' period timer which would 
kick the driver to poll the VALID-bit - or, because we need anyways to 
poll the valid bit from process context - just a kthread which polls the 
VALID-bit. Naturally the thread/timer should be only activated when the 
trigger is enabled.

Actually, my question (with this driver, the big question in the RFC is 
the gain-time-scale helper) seems to be - should I implement 
triggered_buffer and do we have some generic IIO trigger (timer or 
thread or whatever) the driver could use or should each driver (which 
needs this) implement own one?


Thanks for the patience :)
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

