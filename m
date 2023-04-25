Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11996EDDB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjDYIMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjDYIMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:12:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBEE46BD;
        Tue, 25 Apr 2023 01:12:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4edc114c716so5886730e87.1;
        Tue, 25 Apr 2023 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682410333; x=1685002333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfisbPoLjz5PhUaD+ahIoRzTjg2nrG8aK3yeqZRTwxo=;
        b=gflmUaVA1Ytpl8RIq547O40wIPaQbX7mpj5zmxqbDnFCzjvjWYIbri4F4Q7aER4ry/
         sHuAugcGjD2KZifQyHmmBVCAbAlWLnaOnMeT+B//YwHCTmSf4CzcY22hRcj5JtAa2BxZ
         sEvtqBhSL1lpTHWOh4ugahjKn/vFeHP5FDNenkobDowWDkiUdN8xwuShQmFZ5fylTQGg
         ZGvE5d2uUDTxG5lcpA3MA04ryPaqo5VlwA85e7XyWScnk+Fx0QD0SzaAFBIrpZnBNZxW
         u8ZJMvZijCWVOdZ/36MjgUOQocFLhQOki/EEDdpm2u4KLdzkHHc3FfrEOAgP9Vx+sNrz
         zzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682410333; x=1685002333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfisbPoLjz5PhUaD+ahIoRzTjg2nrG8aK3yeqZRTwxo=;
        b=RS/dsKpcduZC8bcCmlpM30DgUxuIgUp2TSJrjUf0d7c0IzJTFNCDQAQDYptrhUSSmQ
         sdbR86LluUud1cHI4vlT/Mc88wlLWPUafYMq9L0pOE5pobvmux3JZFdYk+gpp7PVbVrA
         yr2UNXcKmF7mTytW5lWFillqXntwuOfkWXvZg9eMYbWA85mLgxs6K7SX0HxZSGnqQLg9
         596jNHIw5G7rRk9WZMWbYBBod8PXUi3kQvFA4Y9oG1EOrEXgFqA47tIcGlYbEjR/bIGO
         W/yobRPzkRAV/XWbKZBCE3J4BbDqkEhQGTvRCwtGfGa0tk/oOxJk4Qw3rOSQjqcPtyeG
         YDTA==
X-Gm-Message-State: AAQBX9cVRgrwLd6yboLPhl/iyeHo6evPlSFByDK3bcBWAQduie0xSebh
        xmzw8POa9qSGjyDDOjzr5nU=
X-Google-Smtp-Source: AKy350a5lIINEppltKCVp/jaxAERL6A0Q3WkARvZd72fnUjaLu+x4Uu55nnAB2SPa/h0a74EN5a61Q==
X-Received: by 2002:a19:ee17:0:b0:4e9:c327:dd81 with SMTP id g23-20020a19ee17000000b004e9c327dd81mr3957936lfb.63.1682410332581;
        Tue, 25 Apr 2023 01:12:12 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id r4-20020ac25a44000000b004edb0882ce7sm1969340lfn.133.2023.04.25.01.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 01:12:12 -0700 (PDT)
Message-ID: <c0958e31-b477-34e0-d824-b017efadd0df@gmail.com>
Date:   Tue, 25 Apr 2023 11:12:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and add
 chip_info structure
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
 <867ac7b4-b666-854f-69f7-2d7d7d92c94e@gmail.com> <ZEeAGN3TBcao3CNA@carbian>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZEeAGN3TBcao3CNA@carbian>
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

On 4/25/23 10:24, Mehdi Djait wrote:
> Hi Matti,
> 
> On Tue, Apr 25, 2023 at 09:50:11AM +0300, Matti Vaittinen wrote:
>> On 4/25/23 01:22, Mehdi Djait wrote:
>>> Add the chip_info structure to the driver's private data to hold all
>>> the device specific infos.
>>> Refactor the kx022a driver implementation to make it more generic and
>>> extensible.
>>>
>>> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
>>> ---
>>> v3:
>>> - added the change of the buffer's allocation in the __kx022a_fifo_flush
>>>     to this patch
>>> - added the chip_info to the struct kx022a_data
>>>
>>> v2:
>>> - mentioned the introduction of the i2c_device_id table in the commit
>>> - get i2c_/spi_get_device_id only when device get match fails
>>> - removed the generic KX_define
>>> - removed the kx022a_device_type enum
>>> - added comments for the chip_info struct elements
>>> - fixed errors pointed out by the kernel test robot
>>>
>>>    drivers/iio/accel/kionix-kx022a-i2c.c |  15 +++-
>>>    drivers/iio/accel/kionix-kx022a-spi.c |  15 +++-
>>>    drivers/iio/accel/kionix-kx022a.c     | 114 +++++++++++++++++---------
>>>    drivers/iio/accel/kionix-kx022a.h     |  54 +++++++++++-
>>>    4 files changed, 147 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
>>> index 8f23631a1fd3..ce299d0446f7 100644
>>> --- a/drivers/iio/accel/kionix-kx022a-i2c.c
>>> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
>>> @@ -15,6 +15,7 @@
>>
>> ...
>>
>>
>>>    static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>>> @@ -600,13 +600,17 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>>>    {
>>>    	struct kx022a_data *data = iio_priv(idev);
>>>    	struct device *dev = regmap_get_device(data->regmap);
>>> -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
>>> +	__le16 *buffer;
>>>    	uint64_t sample_period;
>>>    	int count, fifo_bytes;
>>>    	bool renable = false;
>>>    	int64_t tstamp;
>>>    	int ret, i;
>>> +	buffer = kmalloc(data->chip_info->fifo_length * KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);
>>> +	if (!buffer)
>>> +		return -ENOMEM;
>>
>> Do you think we could get rid of allocating and freeing the buffer for each
>> flush? I feel it is a bit wasteful, and with high sampling frequencies this
>> function can be called quite often. Do you think there would be a way to
>> either use stack (always reserve big enough buffer no matter which chip we
>> have - or is the buffer too big to be safely taken from the stack?), or a
>> buffer stored in private data and allocated at probe or buffer enable?
> 
> I tried using the same allocation as before but a device like the KX127
> has a fifo_length of 342 (compared to 86 for kx132, and 43 for kx022a).
> Allocating this much using the stack will result in a Warning.
> 

Right. Maybe you could then have the buffer in private-data and allocate 
it in buffer pre-enable? Do you think that would work?

>>
>> Also, please avoid such long lines. I know many people don't care about the
>> line length - but for example I tend to have 3 terminal windows open
>> side-by-side on my laptop screen. Hence long lines tend to be harder to read
>> for me.
> 
> That is the case for me also, but Jonathan asked me to change
> "fifo_length * 6" and the KX022A_FIFO_SAMPLES_SIZE_BYTES is already
> defined.

then please maybe split the line from appropriate point like:
buffer = kmalloc(data->chip_info->fifo_length *
		 KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);

> 
>>
>>> +
>>>    	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
>>>    	if (ret) {
>>>    		dev_err(dev, "Error reading buffer status\n");
>>> @@ -621,8 +625,10 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>>>    		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
>>>    	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
>>> -	if (!count)
>>> +	if (!count) {
>>> +		kfree(buffer);
>>>    		return 0;
>>> +	}
>>>    	/*
>>>    	 * If we are being called from IRQ handler we know the stored timestamp
>>> @@ -679,7 +685,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>>>    	}
>>>    	fifo_bytes = count * KX022A_FIFO_SAMPLES_SIZE_BYTES;
>>> -	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
>>> +	ret = regmap_noinc_read(data->regmap, data->chip_info->buf_read,
>>>    				&buffer[0], fifo_bytes);
>>>    	if (ret)
>>>    		goto renable_out;
>>> @@ -704,6 +710,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>>>    	if (renable)
>>>    		enable_irq(data->irq);
>>> +	kfree(buffer);
>>>    	return ret;
>>>    }
>>>
>> ...
>>
>>> -int kx022a_probe_internal(struct device *dev)
>>> +const struct kx022a_chip_info kx022a_chip_info = {
>>> +	.name		  = "kx022-accel",
>>> +	.regmap_config	  = &kx022a_regmap_config,
>>> +	.channels	  = kx022a_channels,
>>> +	.num_channels	  = ARRAY_SIZE(kx022a_channels),
>>> +	.fifo_length	  = KX022A_FIFO_LENGTH,
>>> +	.who		  = KX022A_REG_WHO,
>>> +	.id		  = KX022A_ID,
>>> +	.cntl		  = KX022A_REG_CNTL,
>>> +	.cntl2		  = KX022A_REG_CNTL2,
>>> +	.odcntl		  = KX022A_REG_ODCNTL,
>>> +	.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
>>> +	.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
>>> +	.buf_clear	  = KX022A_REG_BUF_CLEAR,
>>> +	.buf_status1	  = KX022A_REG_BUF_STATUS_1,
>>> +	.buf_read	  = KX022A_REG_BUF_READ,
>>> +	.inc1		  = KX022A_REG_INC1,
>>> +	.inc4		  = KX022A_REG_INC4,
>>> +	.inc5		  = KX022A_REG_INC5,
>>> +	.inc6		  = KX022A_REG_INC6,
>>> +	.xout_l		  = KX022A_REG_XOUT_L,
>>> +};
>>> +EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
>>
>> Do you think the fields (or at least some of them) in this struct could be
>> named based on the (main) functionality being used, not based on the
>> register name? Something like "watermark_reg", "buf_en_reg", "reset_reg",
>> "output_rate_reg", "int1_pinconf_reg", "int1_src_reg", "int2_pinconf_reg",
>> "int1_src_reg" ...
>>
>> I would not be at all surprized to see for example some IRQ control to be
>> shifted from INC<X> to INC<Y> or cntl<X> / buf_cntl<X> stuff to be moved to
>> cntl<Y> or to buf_cntl<Y> for next sensor we want to support. Especially
>> when new cool feature is added to next sensor, resulting also adding a new
>> cntl<Z> or buf_cntl<Z> or INC<Z>.
>>
>> I, however, believe the _functionality_ will be there (in some register) -
>> at least for the ICs for which we can re-use this driver. Hence, it might be
>> nice - and if you can think of better names for these fields - to rename
>> them based on the _functionality_ we use.
>>
>> Another benefit would be added clarity to the code. Writing a value to
>> "buf_en_reg", "watermark_reg" or to "int1_src_reg" is much clearer (to me)
>> than writing a value to "buf_cntl1", "buf_cntl2" or "INC4". Especially if
>> you don't have a datasheet at your hands.
>>
>> I am not "demanding" this (at least not for now :]) because it seems these
>> two Kionix sensors have been pretty consistent what comes to maintaining the
>> same functionality in the registers with same naming - but I believe this is
>> something that may in any case be lurking around the corner.
> 
> I agree, this seems to be the better solution. I will look into this.
> 

Thanks for going the extra mile :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

