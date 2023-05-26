Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591EB712B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbjEZREb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEZRE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:04:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53461AC;
        Fri, 26 May 2023 10:04:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3b5881734so1103098e87.0;
        Fri, 26 May 2023 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685120658; x=1687712658;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIFQp1DhPAtuLBnmOxxNFRJLU/SC1TmtIa9u3Buq5R0=;
        b=dISSpZRlB0UmByJy3vfBKi/y+2niZt0XRzcvQjh/7J9ISdK/74Ahs8XtqXs9YnRlvD
         xnKb4Z8wV7z+UuboePB4XKISu465kyVTkVEeWHAfGQAamddjjpPjKxm4K6qbrKtg9HTU
         hMX6v3HCxVnvzEzvixGTsGjuFlwsz6VlDSL7hHC2l/4PO+8mUfpl0VZFf16qZ0gvO7Mj
         BVP2TasGpx8iKHr9PZK037NqrMzeligivk0tAhdlnQ7yOf8qH2Q2eMcdqaPAxXbd/W8O
         BcxrDws0A6FucuVW17egzvhjrhiYUXIm2ciYLMfzo8Ue2dy8Nf9LfTOIJNOGbwV2BvRA
         2Oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685120658; x=1687712658;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIFQp1DhPAtuLBnmOxxNFRJLU/SC1TmtIa9u3Buq5R0=;
        b=csouMGFKipNPKo/+jDqBE50R8tMYVRTpAFCtdhAojYG2FGpTJiDMjPJLHV0h/1yduL
         UM+TYkraXzBGj+bi9QRzCDrB5UPL+crrkT31Sl6M6EhJ45iU3qa70AOauyJE0MqPU+iS
         WMQE+uiryuX7HcykY03AqAhiZFC8Ajelr6SruyXAdjem8g7MrKIh/lK3OJbyoDih9CdJ
         VkTl0ABXFRHG7hqDAu47mxQhFq46P0lTroeDXudydlR+X6HJwIAOtnr3bnkdDxOMhcAN
         66+A4ixiHk9VRBRemqT1anMTbwy9Vm8FT8j604D6J5xREM0lM5DHJLYway+974nlA30C
         K3rA==
X-Gm-Message-State: AC+VfDyZpSZ0khmyTSfrP6fKhk9QW8f8Xq5mAWDwpZ+jAp8MTPIrIGoH
        CLxlgbsZ+PxXbK4bChLaCuU=
X-Google-Smtp-Source: ACHHUZ6MRvBPQpGLKwNzMua7xnpIcOLB53BoS4KSakPVkKi2z9rckWFVzmY4oM1hSj8/cqXWT59qbg==
X-Received: by 2002:a05:6512:51c:b0:4ef:ef67:65c9 with SMTP id o28-20020a056512051c00b004efef6765c9mr822794lfb.23.1685120657650;
        Fri, 26 May 2023 10:04:17 -0700 (PDT)
Received: from [192.168.1.126] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id 27-20020ac2485b000000b004f24e797c58sm693234lfy.217.2023.05.26.10.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 10:04:16 -0700 (PDT)
Message-ID: <682e84b6-9912-ecb9-9ca2-9d96f511c22d@gmail.com>
Date:   Fri, 26 May 2023 20:04:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1685109507.git.mehdi.djait.k@gmail.com>
 <de588a5a3ca311f6dc3a543bfa5cea7b590ae44c.1685109507.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 5/7] iio: accel: kionix-kx022a: Refactor driver and add
 chip_info structure
In-Reply-To: <de588a5a3ca311f6dc3a543bfa5cea7b590ae44c.1685109507.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 17:30, Mehdi Djait wrote:
> Add the chip_info structure to the driver's private data to hold all
> the device specific infos.
> Refactor the kx022a driver implementation to make it more generic and
> extensible.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
> v4:
> - allocating and freeing the buffer moved to the kx022a_fifo{enable,
>    disable} functions
> - used the spi_get_device_match_data helper function
> 
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
>   drivers/iio/accel/kionix-kx022a-spi.c |  11 ++-
>   drivers/iio/accel/kionix-kx022a.c     | 118 +++++++++++++++++---------
>   drivers/iio/accel/kionix-kx022a.h     |  53 +++++++++++-
>   4 files changed, 145 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> index b5a85ce3a891..ce299d0446f7 100644
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
> @@ -22,22 +23,28 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
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
>   static const struct i2c_device_id kx022a_i2c_id[] = {
> -	{ .name = "kx022a" },
> +	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
>   
>   static const struct of_device_id kx022a_of_match[] = {
> -	{ .compatible = "kionix,kx022a", },
> +	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, kx022a_of_match);
> diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
> index 9cd047f7b346..1e4b9d4b4b8d 100644
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
> @@ -22,22 +23,24 @@ static int kx022a_spi_probe(struct spi_device *spi)
>   		return -EINVAL;
>   	}
>   
> -	regmap = devm_regmap_init_spi(spi, &kx022a_regmap);
> +	chip_info = spi_get_device_match_data(spi);
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
>   static const struct spi_device_id kx022a_id[] = {
> -	{ "kx022a" },
> +	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(spi, kx022a_id);
>   
>   static const struct of_device_id kx022a_of_match[] = {
> -	{ .compatible = "kionix,kx022a", },
> +	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, kx022a_of_match);
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 494e81ba1da9..69c22071c731 100644
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
> @@ -149,9 +149,9 @@ const struct regmap_config kx022a_regmap = {
>   	.max_register = KX022A_MAX_REGISTER,
>   	.cache_type = REGCACHE_RBTREE,
>   };
> -EXPORT_SYMBOL_NS_GPL(kx022a_regmap, IIO_KX022A);
>   
>   struct kx022a_data {
> +	const struct kx022a_chip_info *chip_info;
>   	struct regmap *regmap;
>   	struct iio_trigger *trig;
>   	struct device *dev;
> @@ -175,6 +175,8 @@ struct kx022a_data {
>   	struct mutex mutex;
>   	u8 watermark;
>   
> +	__le16 *fifo_buffer;
> +
>   	/* 3 x 16bit accel data + timestamp */
>   	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
>   	struct {
> @@ -208,7 +210,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
>   	{ }
>   };
>   
> -#define KX022A_ACCEL_CHAN(axis, index)				\
> +#define KX022A_ACCEL_CHAN(axis, reg, index)			\
>   {								\
>   	.type = IIO_ACCEL,					\
>   	.modified = 1,						\
> @@ -220,7 +222,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
>   				BIT(IIO_CHAN_INFO_SCALE) |	\
>   				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>   	.ext_info = kx022a_ext_info,				\
> -	.address = KX022A_REG_##axis##OUT_L,			\
> +	.address = reg,						\
>   	.scan_index = index,					\
>   	.scan_type = {                                          \
>   		.sign = 's',					\
> @@ -231,9 +233,9 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
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
> @@ -332,10 +334,10 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
>   	int ret;
>   
>   	if (on)
> -		ret = regmap_set_bits(data->regmap, KX022A_REG_CNTL,
> +		ret = regmap_set_bits(data->regmap, data->chip_info->cntl,
>   				      KX022A_MASK_PC1);
>   	else
> -		ret = regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
> +		ret = regmap_clear_bits(data->regmap, data->chip_info->cntl,
>   					KX022A_MASK_PC1);
>   	if (ret)
>   		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
> @@ -402,7 +404,7 @@ static int kx022a_write_raw(struct iio_dev *idev,
>   			break;
>   
>   		ret = regmap_update_bits(data->regmap,
> -					 KX022A_REG_ODCNTL,
> +					 data->chip_info->odcntl,
>   					 KX022A_MASK_ODR, n);
>   		data->odr_ns = kx022a_odrs[n];
>   		kx022a_turn_on_unlock(data);
> @@ -423,7 +425,7 @@ static int kx022a_write_raw(struct iio_dev *idev,
>   		if (ret)
>   			break;
>   
> -		ret = regmap_update_bits(data->regmap, KX022A_REG_CNTL,
> +		ret = regmap_update_bits(data->regmap, data->chip_info->cntl,
>   					 KX022A_MASK_GSEL,
>   					 n << KX022A_GSEL_SHIFT);
>   		kx022a_turn_on_unlock(data);
> @@ -445,7 +447,7 @@ static int kx022a_fifo_set_wmi(struct kx022a_data *data)
>   
>   	threshold = data->watermark;
>   
> -	return regmap_update_bits(data->regmap, KX022A_REG_BUF_CNTL1,
> +	return regmap_update_bits(data->regmap, data->chip_info->buf_cntl1,
>   				  KX022A_MASK_WM_TH, threshold);
>   }
>   
> @@ -488,7 +490,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
>   		return ret;
>   
>   	case IIO_CHAN_INFO_SAMP_FREQ:
> -		ret = regmap_read(data->regmap, KX022A_REG_ODCNTL, &regval);
> +		ret = regmap_read(data->regmap, data->chip_info->odcntl, &regval);
>   		if (ret)
>   			return ret;
>   
> @@ -503,7 +505,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
>   		return IIO_VAL_INT_PLUS_MICRO;
>   
>   	case IIO_CHAN_INFO_SCALE:
> -		ret = regmap_read(data->regmap, KX022A_REG_CNTL, &regval);
> +		ret = regmap_read(data->regmap, data->chip_info->cntl, &regval);
>   		if (ret < 0)
>   			return ret;
>   
> @@ -530,8 +532,8 @@ static int kx022a_set_watermark(struct iio_dev *idev, unsigned int val)
>   {
>   	struct kx022a_data *data = iio_priv(idev);
>   
> -	if (val > KX022A_FIFO_LENGTH)
> -		val = KX022A_FIFO_LENGTH;
> +	if (val > data->chip_info->fifo_length)
> +		val = data->chip_info->fifo_length;
>   
>   	mutex_lock(&data->mutex);
>   	data->watermark = val;
> @@ -592,7 +594,7 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
>   	 */
>   	data->timestamp = 0;
>   
> -	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0x0);
> +	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
>   }
>   
>   static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> @@ -600,7 +602,6 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>   {
>   	struct kx022a_data *data = iio_priv(idev);
>   	struct device *dev = regmap_get_device(data->regmap);
> -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
>   	uint64_t sample_period;
>   	int count, fifo_bytes;
>   	bool renable = false;
> @@ -679,13 +680,13 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>   	}
>   
>   	fifo_bytes = count * KX022A_FIFO_SAMPLES_SIZE_BYTES;
> -	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
> -				&buffer[0], fifo_bytes);
> +	ret = regmap_noinc_read(data->regmap, data->chip_info->buf_read,
> +				&data->fifo_buffer[0], fifo_bytes);
>   	if (ret)
>   		goto renable_out;
>   
>   	for (i = 0; i < count; i++) {
> -		__le16 *sam = &buffer[i * 3];
> +		__le16 *sam = &data->fifo_buffer[i * 3];
>   		__le16 *chs;
>   		int bit;
>   
> @@ -732,10 +733,10 @@ static const struct iio_info kx022a_info = {
>   static int kx022a_set_drdy_irq(struct kx022a_data *data, bool en)
>   {
>   	if (en)
> -		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
> +		return regmap_set_bits(data->regmap, data->chip_info->cntl,
>   				       KX022A_MASK_DRDY);
>   
> -	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
> +	return regmap_clear_bits(data->regmap, data->chip_info->cntl,
>   				 KX022A_MASK_DRDY);
>   }
>   
> @@ -762,6 +763,8 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
>   {
>   	int ret = 0;
>   
> +	kfree(data->fifo_buffer);

Should we have the kfree only after the sensor is disabled? I wonder if 
we in theory have here a time window where the buffer is freed but the 
measurement is still running and - with a lots of bad luck - can result 
measurement being written to a freed buffer? Perhaps move the kfree to 
be done only after the measurement has been stopped?

Other than that, this is looking good to me.

> +
>   	ret = kx022a_turn_off_lock(data);
>   	if (ret)
>   		return ret;
> @@ -770,7 +773,7 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
>   	if (ret)
>   		goto unlock_out;
>   
> -	ret = regmap_clear_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> +	ret = regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
>   				KX022A_MASK_BUF_EN);
>   	if (ret)
>   		goto unlock_out;
> @@ -801,6 +804,12 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
>   {
>   	int ret;
>   
> +	data->fifo_buffer = kmalloc(data->chip_info->fifo_length *
> +				    KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);
> +
> +	if (!data->fifo_buffer)
> +		return -ENOMEM;
> +
>   	ret = kx022a_turn_off_lock(data);
>   	if (ret)
>   		return ret;
> @@ -811,7 +820,7 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
>   		goto unlock_out;
>   
>   	/* Enable buffer */
> -	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> +	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
>   			      KX022A_MASK_BUF_EN);
>   	if (ret)
>   		goto unlock_out;
> @@ -857,7 +866,7 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
>   	struct kx022a_data *data = iio_priv(idev);
>   	int ret;
>   
> -	ret = regmap_bulk_read(data->regmap, KX022A_REG_XOUT_L, data->buffer,
> +	ret = regmap_bulk_read(data->regmap, data->chip_info->xout_l, data->buffer,
>   			       KX022A_FIFO_SAMPLES_SIZE_BYTES);
>   	if (ret < 0)
>   		goto err_read;
> @@ -905,7 +914,7 @@ static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
>   	if (data->state & KX022A_STATE_FIFO) {
>   		int ok;
>   
> -		ok = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
> +		ok = __kx022a_fifo_flush(idev, data->chip_info->fifo_length, true);
>   		if (ok > 0)
>   			ret = IRQ_HANDLED;
>   	}
> @@ -958,7 +967,7 @@ static int kx022a_chip_init(struct kx022a_data *data)
>   	int ret, val;
>   
>   	/* Reset the senor */
> -	ret = regmap_write(data->regmap, KX022A_REG_CNTL2, KX022A_MASK_SRST);
> +	ret = regmap_write(data->regmap, data->chip_info->cntl2, KX022A_MASK_SRST);
>   	if (ret)
>   		return ret;
>   
> @@ -968,7 +977,7 @@ static int kx022a_chip_init(struct kx022a_data *data)
>   	 */
>   	msleep(1);
>   
> -	ret = regmap_read_poll_timeout(data->regmap, KX022A_REG_CNTL2, val,
> +	ret = regmap_read_poll_timeout(data->regmap, data->chip_info->cntl2, val,
>   				       !(val & KX022A_MASK_SRST),
>   				       KX022A_SOFT_RESET_WAIT_TIME_US,
>   				       KX022A_SOFT_RESET_TOTAL_WAIT_TIME_US);
> @@ -978,14 +987,14 @@ static int kx022a_chip_init(struct kx022a_data *data)
>   		return ret;
>   	}
>   
> -	ret = regmap_reinit_cache(data->regmap, &kx022a_regmap);
> +	ret = regmap_reinit_cache(data->regmap, data->chip_info->regmap_config);
>   	if (ret) {
>   		dev_err(data->dev, "Failed to reinit reg cache\n");
>   		return ret;
>   	}
>   
>   	/* set data res 16bit */
> -	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> +	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
>   			      KX022A_MASK_BRES16);
>   	if (ret) {
>   		dev_err(data->dev, "Failed to set data resolution\n");
> @@ -995,7 +1004,31 @@ static int kx022a_chip_init(struct kx022a_data *data)
>   	return kx022a_prepare_irq_pin(data);
>   }
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
> +
> +int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)
>   {
>   	static const char * const regulator_names[] = {"io-vdd", "vdd"};
>   	struct iio_trigger *indio_trig;
> @@ -1022,6 +1055,7 @@ int kx022a_probe_internal(struct device *dev)
>   		return -ENOMEM;
>   
>   	data = iio_priv(idev);
> +	data->chip_info = chip_info;
>   
>   	/*
>   	 * VDD is the analog and digital domain voltage supply and
> @@ -1032,24 +1066,24 @@ int kx022a_probe_internal(struct device *dev)
>   	if (ret && ret != -ENODEV)
>   		return dev_err_probe(dev, ret, "failed to enable regulator\n");
>   
> -	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
> +	ret = regmap_read(regmap, chip_info->who, &chip_id);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to access sensor\n");
>   
> -	if (chip_id != KX022A_ID)
> +	if (chip_id != chip_info->id)
>   		dev_warn(dev, "unknown device 0x%x\n", chip_id);
>   
>   	irq = fwnode_irq_get_byname(fwnode, "INT1");
>   	if (irq > 0) {
> -		data->inc_reg = KX022A_REG_INC1;
> -		data->ien_reg = KX022A_REG_INC4;
> +		data->inc_reg = chip_info->inc1;
> +		data->ien_reg = chip_info->inc4;
>   	} else {
>   		irq = fwnode_irq_get_byname(fwnode, "INT2");
>   		if (irq <= 0)
>   			return dev_err_probe(dev, irq, "No suitable IRQ\n");
>   
> -		data->inc_reg = KX022A_REG_INC5;
> -		data->ien_reg = KX022A_REG_INC6;
> +		data->inc_reg = chip_info->inc5;
> +		data->ien_reg = chip_info->inc6;
>   	}
>   
>   	data->regmap = regmap;
> @@ -1058,9 +1092,9 @@ int kx022a_probe_internal(struct device *dev)
>   	data->odr_ns = KX022A_DEFAULT_PERIOD_NS;
>   	mutex_init(&data->mutex);
>   
> -	idev->channels = kx022a_channels;
> -	idev->num_channels = ARRAY_SIZE(kx022a_channels);
> -	idev->name = "kx022-accel";
> +	idev->channels = chip_info->channels;
> +	idev->num_channels = chip_info->num_channels;
> +	idev->name = chip_info->name;
>   	idev->info = &kx022a_info;
>   	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>   	idev->available_scan_masks = kx022a_scan_masks;
> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> index 12424649d438..c23b6f03409e 100644
> --- a/drivers/iio/accel/kionix-kx022a.h
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -76,7 +76,56 @@
>   
>   struct device;
>   
> -int kx022a_probe_internal(struct device *dev);
> -extern const struct regmap_config kx022a_regmap;
> +/**
> + * struct kx022a_chip_info - Kionix accelerometer chip specific information
> + *
> + * @name:		name of the device
> + * @regmap_config:	pointer to register map configuration
> + * @channels:		pointer to iio_chan_spec array
> + * @num_channels:	number of iio_chan_spec channels
> + * @fifo_length:	number of 16-bit samples in a full buffer
> + * @who:		WHO_AM_I register
> + * @id:			WHO_AM_I register value
> + * @cntl:		control register 1
> + * @cntl2:		control register 2
> + * @odcntl:		output data control register
> + * @buf_cntl1:		buffer control register 1
> + * @buf_cntl2:		buffer control register 2
> + * @buf_clear:		buffer clear register
> + * @buf_status1:	buffer status register 1
> + * @buf_read:		buffer read register
> + * @inc1:		interrupt control register 1
> + * @inc4:		interrupt control register 4
> + * @inc5:		interrupt control register 5
> + * @inc6:		interrupt control register 6
> + * @xout_l:		x-axis output least significant byte
> + */
> +struct kx022a_chip_info {
> +	const char *name;
> +	const struct regmap_config *regmap_config;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +	unsigned int fifo_length;
> +	u8 who;
> +	u8 id;
> +	u8 cntl;
> +	u8 cntl2;
> +	u8 odcntl;
> +	u8 buf_cntl1;
> +	u8 buf_cntl2;
> +	u8 buf_clear;
> +	u8 buf_status1;
> +	u16 buf_smp_lvl_mask;
> +	u8 buf_read;
> +	u8 inc1;
> +	u8 inc4;
> +	u8 inc5;
> +	u8 inc6;
> +	u8 xout_l;
> +};
> +
> +int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
> +
> +extern const struct kx022a_chip_info kx022a_chip_info;
>   
>   #endif

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

