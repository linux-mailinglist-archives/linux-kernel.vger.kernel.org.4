Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB56D0C17
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjC3RAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjC3RAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:00:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4592E068;
        Thu, 30 Mar 2023 09:59:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x17so25389153lfu.5;
        Thu, 30 Mar 2023 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680195591;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12WR67ooJF81OZQeKCoxlNUBvjjGAOYVM0kVS9eWd20=;
        b=W3S5Ch9DwUNVySk1GhIOrdDGGexkYwoHqzNGukPqkau8gFx1yT+baaYlqvb/mHen0h
         zX9vD/2luv+46qI/RW8tyucqXO4H6+Z6OYYs3ocwva/660C1TpPuwr6G0fWhs325Ay3v
         o60YM63LrSHdZfVgrC8UrsyCJJUxoY8COcQPKFAV+bErzAhJjU9SP1BUi9FeOamCsvRA
         aoZMk9OOhMVktJ7mvVLk6qv0CI243ctK+oIqZjvPLJo8VwReBiludTqKLmAiLlmrlWjY
         WygEDBCyDfLbn+3Qe1kgv3TDwxUBdeulJUVcbMrzYUiBfDVSQavvwaXCCqY0M8cxmZW9
         TQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680195591;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12WR67ooJF81OZQeKCoxlNUBvjjGAOYVM0kVS9eWd20=;
        b=SjyMzAgVR3LT2PuHVqIY5lTSezYLVwX0eyFAevjZNtLuquyeakIH0NDo5KVOUsnsjX
         ejr8kpeqvIgF5O0hH4RPbu9/t0JHz/jWs542La6Ah/iDlnGxmuJ9Jbxq4oZM7g+fRRqY
         iu3dSNkqQTCJge7LqvJKOGqXLAK78+mvQiAa2NKD7uQFc8QOxhV1P9l/YIq6jKENQJfP
         +2PVWajwe6Oz3qGKTdZsIe/FsxdVKLvaWckASRw3tEjL8QdqsV/PQE9zKlO7lD+sUZXZ
         SpX9X7ZHISRKpIXCFxT0G2y4KghBM4moNi393pSktapx1VdKgSiMnT2Dk8P9sUcutRb2
         Iy6w==
X-Gm-Message-State: AAQBX9dp32X5iHSwgGkCvnHmopanukj6iyO7VYOZKMqiGfRadVMiH+zN
        rK21lUYxM2mnUBimQAsZ7b4=
X-Google-Smtp-Source: AKy350aQFlapuhvdeCRtC+pOHk8IscekD1wMpGzYr3bd4M2rnuvpPpR8rNJg64TMGOzBH814cIpR1g==
X-Received: by 2002:ac2:41c2:0:b0:4eb:d8d:6c11 with SMTP id d2-20020ac241c2000000b004eb0d8d6c11mr4975876lfi.5.1680195590751;
        Thu, 30 Mar 2023 09:59:50 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id j25-20020ac25519000000b004dc2dae457asm13707lfk.119.2023.03.30.09.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:59:50 -0700 (PDT)
Message-ID: <1b7f1c34-1c98-be1c-5a22-e154ae5443aa@gmail.com>
Date:   Thu, 30 Mar 2023 19:59:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <cover.1679915278.git.mazziesaccount@gmail.com>
 <1b7d3725bf5ae829b12eaf96362204edd29c6966.1679915278.git.mazziesaccount@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v6 6/7] iio: light: ROHM BU27034 Ambient Light Sensor
In-Reply-To: <1b7d3725bf5ae829b12eaf96362204edd29c6966.1679915278.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/23 14:34, Matti Vaittinen wrote:
> ROHM BU27034 is an ambient light sensor with 3 channels and 3 photo diodes
> capable of detecting a very wide range of illuminance. Typical application
> is adjusting LCD and backlight power of TVs and mobile phones.
> 
> Add initial  support for the ROHM BU27034 ambient light sensor.
> 
> NOTE:
> 	- Driver exposes 4 channels. One IIO_LIGHT channel providing the
> 	  calculated lux values based on measured data from diodes #0 and
> 	  #1. In addition, 3 IIO_INTENSITY channels are emitting the raw
> 	  register data from all diodes for more intense user-space
> 	  computations.
> 	- Sensor has GAIN values that can be adjusted from 1x to 4096x.
> 	- Sensor has adjustible measurement times of 5, 55, 100, 200 and
> 	  400 mS. Driver does not support 5 mS which has special
> 	  limitations.
> 	- Driver exposes standard 'scale' adjustment which is
> 	  implemented by:
> 		1) Trying to adjust only the GAIN
> 		2) If GAIN adjustment alone can't provide requested
> 		   scale, adjusting both the time and the gain is
> 		   attempted.
> 	- Driver exposes writable INT_TIME property that can be used
> 	  for adjusting the measurement time. Time adjustment will also
> 	  cause the driver to try to adjust the GAIN so that the
> 	  overall scale is kept as close to the original as possible.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---

...

> +/*
> + * We try to change the time in such way that the scale is maintained for
> + * given channels by adjusting gain so that it compensates the time change.
> + */
> +static int bu27034_try_set_int_time(struct bu27034_data *data, int time_us)
> +{
> +	struct bu27034_gain_check gains[] = {
> +		{ .chan = BU27034_CHAN_DATA0 },
> +		{ .chan = BU27034_CHAN_DATA1 },
> +	};
> +	int numg = ARRAY_SIZE(gains);
> +	int ret, int_time_old, i;
> +
> +	mutex_lock(&data->mutex);
> +	ret = bu27034_get_int_time(data);
> +	if (ret < 0)
> +		goto unlock_out;
> +
> +	int_time_old = ret;
> +
> +	if (!iio_gts_valid_time(&data->gts, time_us)) {
> +		dev_err(data->dev, "Unsupported integration time %u\n",
> +			time_us);
> +		ret = -EINVAL;
> +
> +		goto unlock_out;
> +	}
> +
> +	if (time_us == int_time_old) {
> +		ret = 0;
> +		goto unlock_out;
> +	}
> +
> +	for (i = 0; i < numg; i++) {
> +		ret = bu27034_get_gain(data, gains[i].chan, &gains[i].old_gain);
> +		if (ret)
> +			goto unlock_out;
> +
> +		ret = iio_gts_find_new_gain_by_old_gain_time(&data->gts,
> +							     gains[i].old_gain,
> +							     int_time_old, time_us,
> +							     &gains[i].new_gain);
> +		if (ret) {

As mentioned in my comment to the helper patch, we should have different 
returnvalue here depending on if the given times were invalid (and new 
gain was not computed) or if the new_gain was computed but not 
supported. I plan to use -ERANGE to denote "new gain computed but not 
supported" and add...

> +			int scale1, scale2;
> +			bool ok;
> +
> +			_bu27034_get_scale(data, gains[i].chan, &scale1, &scale2);
> +			dev_dbg(data->dev,
> +				"chan %u, can't support time %u with scale %u %u\n",
> +				gains[i].chan, time_us, scale1, scale2);

+                       if (ret != -ERANGE)
+                               goto unlock_out;

... here at v7.

> +
> +			/*
> +			 * If caller requests for integration time change and we
> +			 * can't support the scale - then the caller should be
> +			 * prepared to 'pick up the pieces and deal with the
> +			 * fact that the scale changed'.
> +			 */
> +			ret = iio_find_closest_gain_low(&data->gts,
> +							gains[i].new_gain, &ok);
> +
> +			if (!ok) {
> +				dev_dbg(data->dev,
> +					"optimal gain out of range for chan %u\n",
> +					gains[i].chan);
> +			}
> +			if (ret < 0) {
> +				dev_dbg(data->dev,
> +					 "Total gain increase. Risk of saturation");
> +				ret = iio_gts_get_min_gain(&data->gts);
> +				if (ret < 0)
> +					goto unlock_out;
> +			}
> +			dev_dbg(data->dev, "chan %u scale changed\n",
> +				 gains[i].chan);
> +			gains[i].new_gain = ret;
> +			dev_dbg(data->dev, "chan %u new gain %u\n",
> +				gains[i].chan, gains[i].new_gain);
> +		}
> +	}
> +
> +	for (i = 0; i < numg; i++) {
> +		ret = bu27034_set_gain(data, gains[i].chan, gains[i].new_gain);
> +		if (ret)
> +			goto unlock_out;
> +	}
> +
> +	ret = bu27034_set_int_time(data, time_us);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

