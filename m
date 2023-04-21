Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAAE6EA3C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDUGUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjDUGTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:19:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E541B3;
        Thu, 20 Apr 2023 23:19:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ec81245ae1so1317787e87.0;
        Thu, 20 Apr 2023 23:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682057974; x=1684649974;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1fSLknKkJzpU75F0II2uafr+FkchlE2Kyh9Zvr0Lwo=;
        b=Z3SE5sddUdWz3vAWS8DlH6dzL4RruKgx5/i2o5L3tLyum5FyS/opwNqb1Pv6XymSS/
         b6XYk7S6zGqFsrk2gk/YBiEviG9UpuYDuPlSZ8zszTXXDjcoj1JfFcbIItlntW26JMyL
         gA7o0CO2VkXYezun7SrAZaPP4PAYSNYG6SJB/0sXaBLPnMaiNygq3QSVnmCenc9jx7ai
         l31E7bf7rNcNww8p+b//hRt+ZQRToxYmcWEWXTazVBSY1joD4o2gD3/Lbs4fvocgncV8
         iN6C0tKAw/oOEQZhK8QvGOpRWWkRC8mHfxYu2phWDG047FEvt0cuFsbWBa2hyvz6OOKz
         5vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682057974; x=1684649974;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1fSLknKkJzpU75F0II2uafr+FkchlE2Kyh9Zvr0Lwo=;
        b=ih2O1ou3zVm0jXTT2d8t4EqYH4ogxLuWz8No54p7AuupS/Fl8K7STGs5rEyQNxv0dj
         /o0/s64Bu/WNT6GfBB7yQ3Q6OWORyksGfcvo7Hht0aCMElMeKSCsFTvx3ixmdb+5W7Ul
         BAFsmP3y7l1Qr+r0x7vkB1tKC3e26XLKwcM3eVFD07Zg0pmwpS7CkZQWyemXPfPJdEfD
         zCeV/3V4lY0WXqTPzHIR/jsP8+YvXQJG7ZmktsdfxXTJWp3Dvza3JwQtoFFHBWkMqXEL
         cDyXZhF5NhMwBSV9sczduz8rvGN2f+B6r6NRRe7I904mQVmiqcjpZ5GB2pijnqyGKmcV
         9URQ==
X-Gm-Message-State: AAQBX9cOA3CTs03av9MWfzj1iHZaGHVQrBRG4eZiJod2svH1h5/CvGGn
        pVGpAeWotCcDRwpgNz1IC00=
X-Google-Smtp-Source: AKy350aJ4+i6MT0Y6Ff3H6c6d2IGjC9D6IG9JJQ5lyjRqh+9wC4TFHRxwT0kUg7sdV/EnS2/5FykbQ==
X-Received: by 2002:ac2:598d:0:b0:4eb:d8d:6c13 with SMTP id w13-20020ac2598d000000b004eb0d8d6c13mr961167lfn.9.1682057973740;
        Thu, 20 Apr 2023 23:19:33 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id l24-20020ac24318000000b004dc48d91061sm447565lfh.304.2023.04.20.23.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 23:19:33 -0700 (PDT)
Message-ID: <ffae181f-f235-2767-b8fe-e8c4f2e69ccd@gmail.com>
Date:   Fri, 21 Apr 2023 09:19:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
 <e0b599e3f1d1fe0c68e4e0083c8d51fbf0834059.1682019544.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 3/5] iio: accel: kionix-kx022a: Refactor driver and add
 chip_info structure
In-Reply-To: <e0b599e3f1d1fe0c68e4e0083c8d51fbf0834059.1682019544.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

Thanks for working on this driver :) Much appreciated!

On 4/20/23 23:22, Mehdi Djait wrote:
> Refactor the kx022a driver implementation to make it more generic and
> extensible.
> Introduce an i2c_device_id table.
> Add the chip_info structure to the driver's private data to hold all
> the device specific infos.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
> v2:
> - mentioned the introduction of the i2c_device_id table in the commit

Maybe adding the i2c_device_id table could be done in a separate patch 
with a Fixes tag? That would help backporting (and I think changes like 
this are worth it).

> - get i2c_/spi_get_device_id only with device get match fails
> - removed the generic KX_define
> - removed the kx022a_device_type enum
> - added comments for the chip_info struct elements
> - fixed errors pointed out by the kernel test robot
> 
>   drivers/iio/accel/kionix-kx022a-i2c.c |  20 ++++-
>   drivers/iio/accel/kionix-kx022a-spi.c |  21 ++++--
>   drivers/iio/accel/kionix-kx022a.c     | 102 ++++++++++++++++----------
>   drivers/iio/accel/kionix-kx022a.h     |  54 +++++++++++++-
>   4 files changed, 146 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> index e6fd02d931b6..ce299d0446f7 100644
> --- a/drivers/iio/accel/kionix-kx022a-i2c.c
> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> @@ -15,6 +15,7 @@
>   static int kx022a_i2c_probe(struct i2c_client *i2c)
>   {
>   	struct device *dev = &i2c->dev;
> +	const struct kx022a_chip_info *chip_info;
>   	struct regmap *regmap;
>   
>   	if (!i2c->irq) {
> @@ -22,16 +23,28 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
>   		return -EINVAL;
>   	}
>   
> -	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
> +	chip_info = device_get_match_data(&i2c->dev);
> +	if (!chip_info) {
> +		const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
> +		chip_info = (const struct kx022a_chip_info *)id->driver_data;
> +	}
> +
> +	regmap = devm_regmap_init_i2c(i2c, chip_info->regmap_config);
>   	if (IS_ERR(regmap))
>   		return dev_err_probe(dev, PTR_ERR(regmap),
>   				     "Failed to initialize Regmap\n");
>   
> -	return kx022a_probe_internal(dev);
> +	return kx022a_probe_internal(dev, chip_info);
>   }
>   
> +static const struct i2c_device_id kx022a_i2c_id[] = {
> +	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
> +
>   static const struct of_device_id kx022a_of_match[] = {
> -	{ .compatible = "kionix,kx022a", },
> +	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, kx022a_of_match);
> @@ -42,6 +55,7 @@ static struct i2c_driver kx022a_i2c_driver = {
>   		.of_match_table = kx022a_of_match,
>   	  },
>   	.probe_new    = kx022a_i2c_probe,
> +	.id_table     = kx022a_i2c_id,
>   };
>   module_i2c_driver(kx022a_i2c_driver);
>   
> diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
> index 9cd047f7b346..7bc81588e40e 100644
> --- a/drivers/iio/accel/kionix-kx022a-spi.c
> +++ b/drivers/iio/accel/kionix-kx022a-spi.c
> @@ -15,6 +15,7 @@
>   static int kx022a_spi_probe(struct spi_device *spi)
>   {
>   	struct device *dev = &spi->dev;
> +	const struct kx022a_chip_info *chip_info;
>   	struct regmap *regmap;
>   
>   	if (!spi->irq) {
> @@ -22,22 +23,28 @@ static int kx022a_spi_probe(struct spi_device *spi)
>   		return -EINVAL;
>   	}
>   
> -	regmap = devm_regmap_init_spi(spi, &kx022a_regmap);
> +	chip_info = device_get_match_data(&spi->dev);
> +	if (!chip_info) {
> +		const struct spi_device_id *id = spi_get_device_id(spi);
> +		chip_info = (const struct kx022a_chip_info *)id->driver_data;
> +	}
> +
> +	regmap = devm_regmap_init_spi(spi, chip_info->regmap_config);
>   	if (IS_ERR(regmap))
>   		return dev_err_probe(dev, PTR_ERR(regmap),
>   				     "Failed to initialize Regmap\n");
>   
> -	return kx022a_probe_internal(dev);
> +	return kx022a_probe_internal(dev, chip_info);
>   }
>   
> -static const struct spi_device_id kx022a_id[] = {
> -	{ "kx022a" },
> +static const struct spi_device_id kx022a_spi_id[] = {

Did you have a reason to change the struct name? Please, keep the 
original name if there is no reason to change, it helps decreasing the 
size of the patch...

> +	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
>   	{ }
>   };
> -MODULE_DEVICE_TABLE(spi, kx022a_id);
> +MODULE_DEVICE_TABLE(spi, kx022a_spi_id);

...this would not need to be changed if original name was kept...

>   
>   static const struct of_device_id kx022a_of_match[] = {
> -	{ .compatible = "kionix,kx022a", },
> +	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, kx022a_of_match);
> @@ -48,7 +55,7 @@ static struct spi_driver kx022a_spi_driver = {
>   		.of_match_table = kx022a_of_match,
>   	},
>   	.probe = kx022a_spi_probe,
> -	.id_table = kx022a_id,
> +	.id_table = kx022a_spi_id,

...and this neither.

>   };
>   module_spi_driver(kx022a_spi_driver);
>   
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 70530005cad3..7f9a2c29790b 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -48,7 +48,7 @@ enum {
>   	KX022A_STATE_FIFO,
>   };
>   
> -/* Regmap configs */
> +/* kx022a Regmap configs */
>   static const struct regmap_range kx022a_volatile_ranges[] = {
>   	{
>   		.range_min = KX022A_REG_XHP_L,
> @@ -138,7 +138,7 @@ static const struct regmap_access_table kx022a_nir_regs = {
>   	.n_yes_ranges = ARRAY_SIZE(kx022a_noinc_read_ranges),
>   };
>   
> -const struct regmap_config kx022a_regmap = {
> +static const struct regmap_config kx022a_regmap_config = {
>   	.reg_bits = 8,
>   	.val_bits = 8,
>   	.volatile_table = &kx022a_volatile_regs,
> @@ -149,7 +149,6 @@ const struct regmap_config kx022a_regmap = {
>   	.max_register = KX022A_MAX_REGISTER,
>   	.cache_type = REGCACHE_RBTREE,
>   };
> -EXPORT_SYMBOL_NS_GPL(kx022a_regmap, IIO_KX022A);
>   
>   struct kx022a_data {
>   	struct regmap *regmap;
> @@ -208,7 +207,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
>   	{ }
>   };

Does this compile? Shouldn't the chip_info be added in the struct 
kx022a_data?

>   
> -#define KX022A_ACCEL_CHAN(axis, index)				\
> +#define KX022A_ACCEL_CHAN(axis, reg, index)			\
>   {								\
>   	.type = IIO_ACCEL,					\
>   	.modified = 1,						\
> @@ -220,7 +219,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
>   				BIT(IIO_CHAN_INFO_SCALE) |	\
>   				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>   	.ext_info = kx022a_ext_info,				\
> -	.address = KX022A_REG_##axis##OUT_L,			\
> +	.address = reg,						\
>   	.scan_index = index,					\
>   	.scan_type = {                                          \
>   		.sign = 's',					\
> @@ -231,9 +230,9 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
>   }
>   
>   static const struct iio_chan_spec kx022a_channels[] = {
> -	KX022A_ACCEL_CHAN(X, 0),
> -	KX022A_ACCEL_CHAN(Y, 1),
> -	KX022A_ACCEL_CHAN(Z, 2),
> +	KX022A_ACCEL_CHAN(X, KX022A_REG_XOUT_L, 0),
> +	KX022A_ACCEL_CHAN(Y, KX022A_REG_YOUT_L, 1),
> +	KX022A_ACCEL_CHAN(Z, KX022A_REG_ZOUT_L, 2),
>   	IIO_CHAN_SOFT_TIMESTAMP(3),
>   };
>   
> @@ -332,10 +331,10 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
>   	int ret;
>   
>   	if (on)
> -		ret = regmap_set_bits(data->regmap, KX022A_REG_CNTL,
> +		ret = regmap_set_bits(data->regmap, data->chip_info->cntl,
>   				      KX022A_MASK_PC1);

Hm, do you have the "chip_info" member added in kx022a_data? I didn't 
spot it from this patch.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

