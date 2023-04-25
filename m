Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEABD6EDBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 08:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjDYGuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 02:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjDYGuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:50:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A98C129;
        Mon, 24 Apr 2023 23:50:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4efea4569f5so3154112e87.3;
        Mon, 24 Apr 2023 23:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682405413; x=1684997413;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GdvwBvD5NYG3uKiO6JeRa7qZgHPqd4gPf/F3Gkhm0M=;
        b=eXNskbNixEM+YJYGqZFjf4IWJjjYscpb4aAr8haVh31c5+9rfTXUN6oXdAExrTkXj/
         GAkQpLP548Q85mioMTGIwnQf6zGk2OALj4UDI1FuBxVNDsSt4RR5M3xuC10Q0ADoFWWr
         UPoS65SqnIQwm5ugmrgOOoT2g25BVw5c09RCCRtckmoi5xdNR8Fw1MdWbQyETrI5lKMO
         I35qMUss7AlcbsZ8NJKGDzDloE3LduwcmpY5bUWNhb/mTp2ggEP/Z7rB+7qHoS9yWvVm
         OYiDry2Tp6kOtfV4jVh4+24d5XThUDVLKzMveOeidDirRjpl3Y+VbHDbRf8ktpCWLoev
         dRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682405413; x=1684997413;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GdvwBvD5NYG3uKiO6JeRa7qZgHPqd4gPf/F3Gkhm0M=;
        b=ePUOw0iFFUlqmncsb1RYJKMygFyUlJ9cUWqVvvTsG7k88pG7FPbiB7bkBVxbwcgQyf
         jpu32EUOjOsv9nCC8/1uby0//VRwQBM8ialzjD4ntPqVPiB2xaUQOnWWGso/carJEVuq
         itTf2V66uQldE9zcHUOLlDlNajuao73RhGwllefh5PZaZ3iQm+UJxQ2SODYkcBs4MyVL
         ZgUpWbGhLK5xLEqfDbIQ9h5MttfQPStPrbLUJT9h27xe/wd+nZHc9EOUPihDkaTaMCnN
         xywRinsa+Nd0OYfqNz2ZkbrttV/cQx5CFZep4VyltppmN+86O3uX2t1ycBH1dhg651qd
         6jJA==
X-Gm-Message-State: AAQBX9fGSb+mqNTVJHScjmJcAWMN/RZYZ81KsCczoS1KG2NpLbdeZacV
        F7B4QYo3E3XV1V0FbDmVHTU=
X-Google-Smtp-Source: AKy350YoMoOBn/Q98SRGXrA41l+pe8nkV+4ibOzvxk0lGfX2uCkG5OEZkeP0WAQ4fW1Mz7Pn/Vjw9A==
X-Received: by 2002:a19:f716:0:b0:4eb:c12:df1c with SMTP id z22-20020a19f716000000b004eb0c12df1cmr4533191lfe.65.1682405413021;
        Mon, 24 Apr 2023 23:50:13 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id n21-20020a2e86d5000000b002a77792f2c5sm1923234ljj.62.2023.04.24.23.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 23:50:12 -0700 (PDT)
Message-ID: <867ac7b4-b666-854f-69f7-2d7d7d92c94e@gmail.com>
Date:   Tue, 25 Apr 2023 09:50:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and add
 chip_info structure
In-Reply-To: <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 01:22, Mehdi Djait wrote:
> Add the chip_info structure to the driver's private data to hold all
> the device specific infos.
> Refactor the kx022a driver implementation to make it more generic and
> extensible.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
> v3:
> - added the change of the buffer's allocation in the __kx022a_fifo_flush
>    to this patch
> - added the chip_info to the struct kx022a_data
> 
> v2:
> - mentioned the introduction of the i2c_device_id table in the commit
> - get i2c_/spi_get_device_id only when device get match fails
> - removed the generic KX_define
> - removed the kx022a_device_type enum
> - added comments for the chip_info struct elements
> - fixed errors pointed out by the kernel test robot
> 
>   drivers/iio/accel/kionix-kx022a-i2c.c |  15 +++-
>   drivers/iio/accel/kionix-kx022a-spi.c |  15 +++-
>   drivers/iio/accel/kionix-kx022a.c     | 114 +++++++++++++++++---------
>   drivers/iio/accel/kionix-kx022a.h     |  54 +++++++++++-
>   4 files changed, 147 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> index 8f23631a1fd3..ce299d0446f7 100644
> --- a/drivers/iio/accel/kionix-kx022a-i2c.c
> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> @@ -15,6 +15,7 @@

...


>   static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> @@ -600,13 +600,17 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>   {
>   	struct kx022a_data *data = iio_priv(idev);
>   	struct device *dev = regmap_get_device(data->regmap);
> -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
> +	__le16 *buffer;
>   	uint64_t sample_period;
>   	int count, fifo_bytes;
>   	bool renable = false;
>   	int64_t tstamp;
>   	int ret, i;
>   
> +	buffer = kmalloc(data->chip_info->fifo_length * KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;

Do you think we could get rid of allocating and freeing the buffer for 
each flush? I feel it is a bit wasteful, and with high sampling 
frequencies this function can be called quite often. Do you think there 
would be a way to either use stack (always reserve big enough buffer no 
matter which chip we have - or is the buffer too big to be safely taken 
from the stack?), or a buffer stored in private data and allocated at 
probe or buffer enable?

Also, please avoid such long lines. I know many people don't care about 
the line length - but for example I tend to have 3 terminal windows open 
side-by-side on my laptop screen. Hence long lines tend to be harder to 
read for me.

> +
>   	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
>   	if (ret) {
>   		dev_err(dev, "Error reading buffer status\n");
> @@ -621,8 +625,10 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>   		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
>   
>   	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
> -	if (!count)
> +	if (!count) {
> +		kfree(buffer);
>   		return 0;
> +	}
>   
>   	/*
>   	 * If we are being called from IRQ handler we know the stored timestamp
> @@ -679,7 +685,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>   	}
>   
>   	fifo_bytes = count * KX022A_FIFO_SAMPLES_SIZE_BYTES;
> -	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
> +	ret = regmap_noinc_read(data->regmap, data->chip_info->buf_read,
>   				&buffer[0], fifo_bytes);
>   	if (ret)
>   		goto renable_out;
> @@ -704,6 +710,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>   	if (renable)
>   		enable_irq(data->irq);
>   
> +	kfree(buffer);
>   	return ret;
>   }
> 
...

>   
> -int kx022a_probe_internal(struct device *dev)
> +const struct kx022a_chip_info kx022a_chip_info = {
> +	.name		  = "kx022-accel",
> +	.regmap_config	  = &kx022a_regmap_config,
> +	.channels	  = kx022a_channels,
> +	.num_channels	  = ARRAY_SIZE(kx022a_channels),
> +	.fifo_length	  = KX022A_FIFO_LENGTH,
> +	.who		  = KX022A_REG_WHO,
> +	.id		  = KX022A_ID,
> +	.cntl		  = KX022A_REG_CNTL,
> +	.cntl2		  = KX022A_REG_CNTL2,
> +	.odcntl		  = KX022A_REG_ODCNTL,
> +	.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
> +	.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
> +	.buf_clear	  = KX022A_REG_BUF_CLEAR,
> +	.buf_status1	  = KX022A_REG_BUF_STATUS_1,
> +	.buf_read	  = KX022A_REG_BUF_READ,
> +	.inc1		  = KX022A_REG_INC1,
> +	.inc4		  = KX022A_REG_INC4,
> +	.inc5		  = KX022A_REG_INC5,
> +	.inc6		  = KX022A_REG_INC6,
> +	.xout_l		  = KX022A_REG_XOUT_L,
> +};
> +EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);

Do you think the fields (or at least some of them) in this struct could 
be named based on the (main) functionality being used, not based on the 
register name? Something like "watermark_reg", "buf_en_reg", 
"reset_reg", "output_rate_reg", "int1_pinconf_reg", "int1_src_reg", 
"int2_pinconf_reg", "int1_src_reg" ...

I would not be at all surprized to see for example some IRQ control to 
be shifted from INC<X> to INC<Y> or cntl<X> / buf_cntl<X> stuff to be 
moved to cntl<Y> or to buf_cntl<Y> for next sensor we want to support. 
Especially when new cool feature is added to next sensor, resulting also 
adding a new cntl<Z> or buf_cntl<Z> or INC<Z>.

I, however, believe the _functionality_ will be there (in some register) 
- at least for the ICs for which we can re-use this driver. Hence, it 
might be nice - and if you can think of better names for these fields - 
to rename them based on the _functionality_ we use.

Another benefit would be added clarity to the code. Writing a value to 
"buf_en_reg", "watermark_reg" or to "int1_src_reg" is much clearer (to 
me) than writing a value to "buf_cntl1", "buf_cntl2" or "INC4". 
Especially if you don't have a datasheet at your hands.

I am not "demanding" this (at least not for now :]) because it seems 
these two Kionix sensors have been pretty consistent what comes to 
maintaining the same functionality in the registers with same naming - 
but I believe this is something that may in any case be lurking around 
the corner.



All in all, looks nice and clean to me! Good job.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

