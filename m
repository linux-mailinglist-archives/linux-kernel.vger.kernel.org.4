Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5A6DC5CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjDJKiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDJKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:38:20 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CA419BC;
        Mon, 10 Apr 2023 03:38:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o1so5883856lfc.2;
        Mon, 10 Apr 2023 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681123097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dll2l+sTMO4VJjiELftnYXCcWDzHl2zd4BbWsOEtTI=;
        b=exdBcIHBzq2V7IhtWDIKJi8JQh2cX+ZwOhqX2zZzPvZadx4j6kTOXLotRPr9tfwoxT
         gWQCtJs8awcK0Yycx7AGx1YdfhMRhIi7RzZnkrfKJqS/Mk/kXWwd0YCx39slE3XByYde
         O5O5Ikx0aYSeK5bTqNhkT+/6iTyBGS1YlMlFjSnpYcmvf5YGZ4t6DIx1mGWgBv52G8Gb
         g1QwPTVbho1+qZ8FEHgm8AJIx8uQUOoE5WzrkSqPdpWEmRzgX4rswvRBQILo+Bir+3bs
         T8e8TjN7io45jCk/2iUMSjpGwKSboc1gXWfioZkZDTdCURHVtAIuFH5ruDqJPWiQbhpO
         YSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681123097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dll2l+sTMO4VJjiELftnYXCcWDzHl2zd4BbWsOEtTI=;
        b=tkXfRYFilQHRcMPf4zZzqpTXkOFqYKc/YYiIh7hyXux8oOItrvsQb3QzM0Y94WglJS
         iFbKdaALq7Ep+CRFqeTt7zoWh2KptQtC8k4zgOLl3va7GQFGxOKlqwPPA5ycrUNOu3UO
         BdnOCT3TAq6BShGDT4zB89GoNPfYLs10QUvPFuzIX4h9feetBxTQQO9E7BblV+/cPjpG
         G1sxyzzwtr7NSOoduwpbmxk6CQJSdSrn3DdIKVi0Nk5+9ySCz0OMAPoburGXcNMNCioK
         FMolwuE8ej4T7xrUQVJ8V8gVujQ3iUqaNabfXj7dgQDJ1ka/G0wsh5KmTraHbs9IGh1l
         rhpg==
X-Gm-Message-State: AAQBX9d9+UGRqDZIJJLqLlKRSs6Ue8YM/O82olJuijyHdgTlDNa1xNyd
        KVtwsSH9RpNayLtrMHO6pskXUj6hnSg=
X-Google-Smtp-Source: AKy350ZwVhhz6xuN2kA/iTZfaXk3jTs7c7lPYYvnxLhHUGCMP6wKnI+iAhPy9AqIZOO1HN0e390TKw==
X-Received: by 2002:ac2:5485:0:b0:4eb:11dc:d9a5 with SMTP id t5-20020ac25485000000b004eb11dcd9a5mr3188075lfk.32.1681123097227;
        Mon, 10 Apr 2023 03:38:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id 23-20020ac24857000000b00492c663bba2sm2045990lfy.124.2023.04.10.03.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 03:38:16 -0700 (PDT)
Message-ID: <eeb96226-2ad6-954c-7054-b4762942ac0d@gmail.com>
Date:   Mon, 10 Apr 2023 13:38:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 4/5] iio: light: ROHM BU27034 Ambient Light Sensor
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1680263956.git.mazziesaccount@gmail.com>
 <2a7efb6f335da5526fbe34b95137c5e45db5c5d3.1680263956.git.mazziesaccount@gmail.com>
 <20230408122140.25332d15@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230408122140.25332d15@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/23 14:21, Jonathan Cameron wrote:
> On Fri, 31 Mar 2023 15:41:58 +0300
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
> 
> A few trivial comments inline but nothing that stops me applying this version.
> 
>>
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
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		return bu27034_get_scale(data, chan->channel, val, val2);
>> +
>> +	case IIO_CHAN_INFO_RAW:
>> +	{
>> +		int (*result_get)(struct bu27034_data *data, int chan, int *val);
> 
> I don't care that much about this, but the function pointer dance seems
> unnecessary.

My memory is getting worse and worse over the time... It's hard for me 
to remember why I added a function pointer here - but it probably was to 
keep the if-else if-else construct out of the mutex-protected section.

> 
> You could probably also drop the paranoid checking (or default to one of the
> choices).

If this was done, then the function-pointer had no use. If you think the 
check is paranoid, then I agree, we should go with the suggestion you 
have below.

> 
> So at call sight of result_get() currently have
> 		if (chan->type == IIO_INTENSITY)
> 			ret = bu27034_get_single-result()...
> 		else
> 			ret = bu27034_get_mlux()
> 
> etc
> 
> meh. I didn't raise it earlier so I'll leave this alone.
> 
>> +
>> +		if (chan->type == IIO_INTENSITY)
>> +			result_get = bu27034_get_single_result;
>> +		else if (chan->type == IIO_LIGHT)
>> +			result_get = bu27034_get_mlux;
>> +		else
>> +			return -EINVAL;
>> +
>> +		/* Don't mess with measurement enabling while buffering */
>> +		ret = iio_device_claim_direct_mode(idev);
>> +		if (ret)
>> +			return ret;
>> +
>> +		mutex_lock(&data->mutex);
>> +		/*
>> +		 * Reading one channel at a time is inefficient but we
>> +		 * don't care here. Buffered version should be used if
>> +		 * performance is an issue.
>> +		 */
>> +		ret = result_get(data, chan->channel, val);
>> +
>> +		mutex_unlock(&data->mutex);
>> +		iio_device_release_direct_mode(idev);
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		return IIO_VAL_INT;
>> +	}
>> +	default:
>> +		return -EINVAL;
>> +
>> +	}
>> +}
> 
> I will fix the excess blank line above though.  Serves no purpose
> so gone in the version I applied.

Thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

