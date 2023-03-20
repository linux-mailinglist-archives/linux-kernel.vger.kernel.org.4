Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CB66C0D70
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjCTJfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjCTJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:35:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3011F492;
        Mon, 20 Mar 2023 02:35:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q16so3214643lfe.10;
        Mon, 20 Mar 2023 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679304907;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsIPY4IovQ54bOuVpjZgz8/l7oeVHfp5VV8YQIKjzC0=;
        b=ow/fqr4/iE0lZo9GqT/fE6Ye3WB9V8pvjm0/+8h2t/0UbGaLyiP1ngNcCHlfOBUkyd
         QLF9FeBL4+697hyupXswzrFE6jcgwdZ91ghhr9OEqQOIZ7EPkguhXZO5k7Y8O5h557xw
         EIBzHzRFJ1YYY5FEOA2ff/xT1LxZYv9Wq8CxKo3aVEeGPDnmSKVwaZXAnVjf4UHJo/qg
         AAFRZfFQu2lLVB26PW9NAXr4ZO1jy4Usf0t8jLXp5CxhRB0H2/bfp5fnpLgZcZ2QEmxR
         qMUOSRWGkzKJFC6UicKO93DqYGV5ifQbG9XJG9FP9tHufEfhiZwXD4ALesosBYJmSB0T
         PBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679304907;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsIPY4IovQ54bOuVpjZgz8/l7oeVHfp5VV8YQIKjzC0=;
        b=V+qAvMg7NwUjACEwBA2jbMTK/BwulN0zHkQVRiD07vaT9sxBEYyKmftj4l11osd3Kd
         fKah6R0lfkWqKg2pZX0VTjyG9/OC8D3KjHZXnVHEwVSMvgKqwWq05Tn498aZYmc9pl8A
         53AB/GG+9XCAjSatKTRFYzEabMPEVe7HbMtXd+moco5t5sZmQdvJiXFICvPxvEAMqWea
         XTEH0jSgVZY8nlkseWnSEupexwesR9Y7AyCQIPp7QSIF+NGwMphEPAioofgzj7gz5HCI
         5wJoYVyEOosqPw2/A8lChi3J7SigS1CfcPJbD0T8gMF+SfyEmgGumAATMjBoXHCXiy2+
         4HVw==
X-Gm-Message-State: AO0yUKWl8w5BXLY3LlqOXtpKnYkIJ9wzzjY7LFFWs6YjSkDPeYoK4try
        YddrZAXwz416gYuF+JUgB6I=
X-Google-Smtp-Source: AK7set+b19xO8qrUyHEnWni4ZMjZW23+hXhKyb+fiYbtrVJ07dEU7X9JDRhhnssvS+Y0pfeey+X8eg==
X-Received: by 2002:a05:6512:218b:b0:4dc:260e:6b59 with SMTP id b11-20020a056512218b00b004dc260e6b59mr6192047lft.40.1679304907065;
        Mon, 20 Mar 2023 02:35:07 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id i10-20020a056512006a00b004cafa01ebbfsm1627540lfo.101.2023.03.20.02.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 02:35:06 -0700 (PDT)
Message-ID: <4c28925d-c07c-61b7-8863-9c00e6846687@gmail.com>
Date:   Mon, 20 Mar 2023 11:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
In-Reply-To: <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
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

On 3/17/23 01:48, Mehdi Djait wrote:
> Refactor the kx022a driver implementation to make it more
> generic and extensible.
> Add the chip_info structure will to the driver's private
> data to hold all the device specific infos.
> Move the enum, struct and constants definitions to the header
> file.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
>   drivers/iio/accel/kionix-kx022a-i2c.c |  19 +-
>   drivers/iio/accel/kionix-kx022a-spi.c |  22 +-
>   drivers/iio/accel/kionix-kx022a.c     | 289 ++++++++++++--------------
>   drivers/iio/accel/kionix-kx022a.h     | 128 ++++++++++--
>   4 files changed, 274 insertions(+), 184 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> index e6fd02d931b6..21c4c0ae1a68 100644
> --- a/drivers/iio/accel/kionix-kx022a-i2c.c
> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> @@ -15,23 +15,35 @@
>   static int kx022a_i2c_probe(struct i2c_client *i2c)
>   {
>   	struct device *dev = &i2c->dev;
> +	struct kx022a_chip_info *chip_info;
>   	struct regmap *regmap;
> +	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
>   
>   	if (!i2c->irq) {
>   		dev_err(dev, "No IRQ configured\n");
>   		return -EINVAL;
>   	}
>   
> -	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
> +	chip_info = device_get_match_data(&i2c->dev);
> +	if (!chip_info)
> +		chip_info = (const struct kx022a_chip_info *) id->driver_data;
> +
> +	regmap = devm_regmap_init_i2c(i2c, chip_info->regmap_config);
>   	if (IS_ERR(regmap))
>   		return dev_err_probe(dev, PTR_ERR(regmap),
>   				     "Failed to initialize Regmap\n");

Hm. I would like to pull the regmap_config out of the chip_info struct. 
As far as I see, the regmap_config is only needed in these bus specific 
files. On the other hand, the chip-info is only needed in the 
kionix-kx022a.c file, right?

So, maybe you could here just get the regmap_config based on the chip-id 
(enum value you added - the data pointer in match tables could be just 
the enum value indicating the IC type). Then, you could pass this enum 
value to kx022a_probe_internal() - and the chip-info struct could be 
selected in the kionix-kx022a.c based on it. That way you would not need 
the struct chip-info here or regmap_config in kionix-kx022a.c. Same in 
the *-spi.c

Something like:

enum {
	KIONIX_IC_KX022A,
	KIONIX_IC_KX132_xxx, /* xxx denotes accurate model suffix */
};
	
static const struct of_device_id kx022a_of_match[] = {
	{ .compatible = "kionix,kx022a", .data = KIONIX_IC_KX022A },
	...

chip_id = device_get_match_data(&i2c->dev);

regmap_cfg = kx022a_kx_regmap_cfg[chip_id];
regmap = devm_regmap_init_i2c(i2c, regmap_cfg);
...
return kx022a_probe_internal(dev, chip_id);

Do you think that would work?

OTOH, to really benefit from this we should probably pull out the 
regmap-configs from the kionix-kx022a.c. I am not really sure where we 
should put it then though. Hence, if there is no good ideas how to split 
the config and chip-info so they are only available/used where needed - 
then I am also Ok with the current approach.

> -
> -struct kx022a_data {
> -	struct regmap *regmap;
> -	struct iio_trigger *trig;
> -	struct device *dev;
> -	struct iio_mount_matrix orientation;
> -	int64_t timestamp, old_timestamp;
> -
> -	int irq;
> -	int inc_reg;
> -	int ien_reg;
> -
> -	unsigned int state;
> -	unsigned int odr_ns;
> -
> -	bool trigger_enabled;
> -	/*
> -	 * Prevent toggling the sensor stby/active state (PC1 bit) in the
> -	 * middle of a configuration, or when the fifo is enabled. Also,
> -	 * protect the data stored/retrieved from this structure from
> -	 * concurrent accesses.
> -	 */
> -	struct mutex mutex;
> -	u8 watermark;
> -
> -	/* 3 x 16bit accel data + timestamp */
> -	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
> -	struct {
> -		__le16 channels[3];
> -		s64 ts __aligned(8);
> -	} scan;
> -};

As mentioned by Jonathan - It'd be better to keep this struct in C-file.

>   
> +const struct kx022a_chip_info kx_chip_info[] = {
> +	[KX022A] = {
> +		.name		  = "kx022a",
> +		.type		  = KX022A,
> +		.regmap_config	  = &kx022a_regmap_config,

As mentioned above, the regmap config is not really needed after the 
regmap is initialized. Id prefer this not being part of the chip info.

> +		.channels	  = kx022a_channels,
> +		.num_channels	  = ARRAY_SIZE(kx022a_channels),
> +		.fifo_length	  = KX022A_FIFO_LENGTH,
> +		.who		  = KX022A_REG_WHO,
> +		.id		  = KX022A_ID,
> +		.cntl		  = KX022A_REG_CNTL,
> +		.cntl2		  = KX022A_REG_CNTL2,
> +		.odcntl		  = KX022A_REG_ODCNTL,
> +		.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
> +		.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
> +		.buf_clear	  = KX022A_REG_BUF_CLEAR,
> +		.buf_status1	  = KX022A_REG_BUF_STATUS_1,
> +		.buf_smp_lvl_mask = KX022A_MASK_BUF_SMP_LVL,
> +		.buf_read	  = KX022A_REG_BUF_READ,
> +		.inc1		  = KX022A_REG_INC1,
> +		.inc4		  = KX022A_REG_INC4,
> +		.inc5		  = KX022A_REG_INC5,
> +		.inc6		  = KX022A_REG_INC6,
> +		.xout_l		  = KX022A_REG_XOUT_L,
> +	},
> +};
> +EXPORT_SYMBOL_NS_GPL(kx_chip_info, IIO_KX022A);
> +
>   static int kx022a_read_avail(struct iio_dev *indio_dev,
>   			     struct iio_chan_spec const *chan,
>   			     const int **vals, int *type, int *length,
> @@ -309,19 +275,17 @@ static int kx022a_read_avail(struct iio_dev *indio_dev,
>   	}
>   }
>   
> -#define KX022A_DEFAULT_PERIOD_NS (20 * NSEC_PER_MSEC)
> -
>   static void kx022a_reg2freq(unsigned int val,  int *val1, int *val2)
>   {
> -	*val1 = kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR][0];
> -	*val2 = kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR][1];
> +	*val1 = kx022a_accel_samp_freq_table[val & KX_MASK_ODR][0];
> +	*val2 = kx022a_accel_samp_freq_table[val & KX_MASK_ODR][1];
>   }
>   

As mentioned elsewhere, doing the renaming separately from the 
functional changes will ease the reviewing.


>   
> +static int kx022a_get_fifo_bytes(struct kx022a_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	__le16 buf_status;
> +	int ret, fifo_bytes;
> +
> +	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1, &buf_status, sizeof(buf_status));
> +	if (ret) {
> +		dev_err(dev, "Error reading buffer status\n");
> +		return ret;
> +	}
> +
> +	buf_status &= data->chip_info->buf_smp_lvl_mask;
> +	fifo_bytes = le16_to_cpu(buf_status);
> +
> +	/*
> +	 * The KX022A has FIFO which can store 43 samples of HiRes data from 2
> +	 * channels. This equals to 43 (samples) * 3 (channels) * 2 (bytes/sample) to
> +	 * 258 bytes of sample data. The quirk to know is that the amount of bytes in
> +	 * the FIFO is advertised via 8 bit register (max value 255). The thing to note
> +	 * is that full 258 bytes of data is indicated using the max value 255.
> +	 */
> +	if (data->chip_info->type == KX022A && fifo_bytes == KX022A_FIFO_FULL_VALUE)
> +		fifo_bytes = KX022A_FIFO_MAX_BYTES;
> +
> +	if (fifo_bytes % KX_FIFO_SAMPLES_SIZE_BYTES)
> +		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
> +
> +	return fifo_bytes;
> +}

I like adding this function. Here I agree with Jonathan - having a 
device specific functions would clarify this a bit. The KX022A "quirk" 
is a bit confusing. You could then get rid of the buf_smp_lvl_mask.

> +
>   static int kx022a_drop_fifo_contents(struct kx022a_data *data)
>   {
>   	/*
> @@ -593,35 +588,22 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
>   	 */
>   	data->timestamp = 0;
>   
> -	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0x0);
> +	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
>   }
>   
>   static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>   			       bool irq)
>   {
>   	struct kx022a_data *data = iio_priv(idev);
> -	struct device *dev = regmap_get_device(data->regmap);
> -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
> +	__le16 buffer[data->chip_info->fifo_length * 3];

I don't like this. Having the length of an array decided at run-time is 
not something I appreciate. Maybe you could just always reserve the 
memory so that the largest FIFO gets supported. I am just wondering how 
large arrays we can safely allocate from the stack?


> @@ -812,14 +792,14 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
>   		goto unlock_out;
>   
>   	/* Enable buffer */
> -	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> -			      KX022A_MASK_BUF_EN);
> +	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
> +			      KX_MASK_BUF_EN);
>   	if (ret)
>   		goto unlock_out;
>   
> -	data->state |= KX022A_STATE_FIFO;
> +	data->state |= KX_STATE_FIFO;
>   	ret = regmap_set_bits(data->regmap, data->ien_reg,
> -			      KX022A_MASK_WMI);
> +			      KX_MASK_WMI);

I think this fits to one line now. (even on my screen)

>   	if (ret)
>   		goto unlock_out;
>   

> -int kx022a_probe_internal(struct device *dev)
> +int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)

As mentioned elsewhere, this might also work if the chip-type enum was 
passed here as parameter. That way the bus specific part would not need 
to know about the struct chip_info...

>   {
>   	static const char * const regulator_names[] = {"io-vdd", "vdd"};
>   	struct iio_trigger *indio_trig;
> @@ -1023,6 +1003,7 @@ int kx022a_probe_internal(struct device *dev)
>   		return -ENOMEM;
>   
>   	data = iio_priv(idev);
> +	data->chip_info = chip_info;

...Here you could then pick the correct chip_info based on the chip-type 
enum. In that case I'd like to get the regmap_config(s) in own file. Not 
sure how that would look like though.

All in all, I like how this looks like. Nice job!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

