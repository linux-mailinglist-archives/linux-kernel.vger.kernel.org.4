Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA776EDD9F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjDYIGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjDYIGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:06:31 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA5E26A8;
        Tue, 25 Apr 2023 01:06:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2a8bb726210so51463601fa.1;
        Tue, 25 Apr 2023 01:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682409987; x=1685001987;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQRTEPrVdoWewtLFi2u6sMtlTXEBNrLBU9L2vWx25bM=;
        b=pwJo1Vuxxp52gRLjAE2yEkyUs1MZrfxa8MDcP+lMaWSptlCdVWYeJ7FcpwGnS1ap0W
         vXCElq8DVwZ+mxOUPpseW3ZFBfT8uWWuaqU/nRo5kYvDPlPDqqSpSgHDkUTX2IfYBIWr
         i7Shtfuxuf9fZtMF1HA8tGV/sVaCWqYUUcsm05k17RPjY3dewmE4QLyGNwxkfaCPY8pM
         YyD31Z2wefTdvZv6RL5V1h2u95RBbgrJkV7ZgP+BjuZUnncRtI7OH/NSlV/6vTMBpQLW
         sqat/oP78Km3mHL9K3aeAGB7Edhowfx3hHDFoxlaAMQdNV58E2i5+6drWuJRUbVSXznI
         pedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682409987; x=1685001987;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQRTEPrVdoWewtLFi2u6sMtlTXEBNrLBU9L2vWx25bM=;
        b=ZzCvDyduXELtFD3Pu9421oHd5ssZL1rX7xA2OS1XH+jLiceOGJ0bh9lLm6CGz+MyAq
         FxEap47Zmb1DZCvr9KUqf2ATSFpakO+O3eyCyvZZWElE4d2v5JGfs9gXU90zANeJw2Pe
         LedjNxJeSVja/8kgu7860yA0Znpin1MDJNxeN+HTPiQiXac90xCWOBPQXblL0SfWFeWn
         6hBfRg1I9CDvQVuEOrua2NjddSwG38gGnWScoKrGc55xSDyggJYLcXDsvL1g50VcZRel
         yXAsJkOefbNAr1zdm8ZZv6fN9ssV3uc1OJB0djB1fbVZGq5ZTAVpBl2N51bhcSL23F69
         hOzw==
X-Gm-Message-State: AAQBX9d4g0r/2jUzlbOxW78WIRJjUtw6AZNMUVIGmhtGO8ln1DJr53+6
        3Z9yExVEa/s6Irw3/tEiECk=
X-Google-Smtp-Source: AKy350Ywe8Bvk2Ckcw+UKzlhIWQ43Vw68K4nXnoz4U5qMhmfhc18XgH3Ha094e7ScziSw2vs2ZM+GQ==
X-Received: by 2002:a2e:8755:0:b0:2a7:76ab:c42 with SMTP id q21-20020a2e8755000000b002a776ab0c42mr3623736ljj.46.1682409986973;
        Tue, 25 Apr 2023 01:06:26 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id f9-20020a2e9e89000000b00298c7f21105sm1944851ljk.66.2023.04.25.01.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 01:06:26 -0700 (PDT)
Message-ID: <00905352-f9a4-a8bf-63b7-92e3b1d2a4f4@gmail.com>
Date:   Tue, 25 Apr 2023 11:06:25 +0300
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
 <593798a44c8ba45f969b86aa29e172d59065958c.1682373451.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 7/7] iio: accel: Add support for Kionix/ROHM KX132-1211
 accelerometer
In-Reply-To: <593798a44c8ba45f969b86aa29e172d59065958c.1682373451.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 01:22, Mehdi Djait wrote:
> Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
> ranges from ±2G to ±16G, digital output through I²C/SPI.
> Add support for basic accelerometer features such as reading acceleration
> via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.
> 
> Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
>   drivers/iio/accel/Kconfig             |   8 +-
>   drivers/iio/accel/kionix-kx022a-i2c.c |   2 +
>   drivers/iio/accel/kionix-kx022a-spi.c |   2 +
>   drivers/iio/accel/kionix-kx022a.c     | 147 ++++++++++++++++++++++++++
>   drivers/iio/accel/kionix-kx022a.h     |  52 +++++++++
>   5 files changed, 207 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index b6b45d359f28..d8cc6e6f2bb9 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -418,8 +418,8 @@ config IIO_KX022A_SPI
>   	select IIO_KX022A
>   	select REGMAP_SPI
>   	help
> -	  Enable support for the Kionix KX022A digital tri-axis
> -	  accelerometer connected to I2C interface.
> +	  Enable support for the Kionix KX022A, KX132-1211 digital tri-axis
> +	  accelerometers connected to SPI interface.
>   
>   config IIO_KX022A_I2C
>   	tristate "Kionix KX022A tri-axis digital accelerometer I2C interface"
> @@ -427,8 +427,8 @@ config IIO_KX022A_I2C
>   	select IIO_KX022A
>   	select REGMAP_I2C
>   	help
> -	  Enable support for the Kionix KX022A digital tri-axis
> -	  accelerometer connected to I2C interface.
> +	  Enable support for the Kionix KX022A, KX132-1211 digital tri-axis
> +	  accelerometers connected to I2C interface.
>   
>   config KXSD9
>   	tristate "Kionix KXSD9 Accelerometer Driver"
> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> index ce299d0446f7..4ea28d2482ec 100644
> --- a/drivers/iio/accel/kionix-kx022a-i2c.c
> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> @@ -39,12 +39,14 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
>   
>   static const struct i2c_device_id kx022a_i2c_id[] = {
>   	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
> +	{ .name = "kx132-1211", .driver_data = (kernel_ulong_t)&kx132_chip_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
>   
>   static const struct of_device_id kx022a_of_match[] = {
>   	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
> +	{ .compatible = "kionix,kx132-1211", .data = &kx132_chip_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, kx022a_of_match);
> diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
> index b84503e24510..b755b2b395ed 100644
> --- a/drivers/iio/accel/kionix-kx022a-spi.c
> +++ b/drivers/iio/accel/kionix-kx022a-spi.c
> @@ -39,12 +39,14 @@ static int kx022a_spi_probe(struct spi_device *spi)
>   
>   static const struct spi_device_id kx022a_id[] = {
>   	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
> +	{ .name = "kx132-1211", .driver_data = (kernel_ulong_t)&kx132_chip_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(spi, kx022a_id);
>   
>   static const struct of_device_id kx022a_of_match[] = {
>   	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
> +	{ .compatible = "kionix,kx132-1211", .data = &kx132_chip_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, kx022a_of_match);
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 4a31d17c1f22..a6808ab12162 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -150,6 +150,101 @@ static const struct regmap_config kx022a_regmap_config = {
>   	.cache_type = REGCACHE_RBTREE,
>   };
>   
> +/* Regmap configs kx132 */
> +static const struct regmap_range kx132_volatile_ranges[] = {
> +	{
> +		.range_min = KX132_REG_XADP_L,
> +		.range_max = KX132_REG_COTR,
> +	}, {
> +		.range_min = KX132_REG_TSCP,
> +		.range_max = KX132_REG_INT_REL,
> +	}, {
> +		/* The reset bit will be cleared by sensor */
> +		.range_min = KX132_REG_CNTL2,
> +		.range_max = KX132_REG_CNTL2,
> +	}, {
> +		.range_min = KX132_REG_BUF_STATUS_1,
> +		.range_max = KX132_REG_BUF_READ,
> +	},
> +};

Maybe the CNTL5 should also be added to volatile table as it has "self 
clearing" bits? I didn't go through all the registers to see if there 
are more.

> +
> +static const struct regmap_access_table kx132_volatile_regs = {
> +	.yes_ranges = &kx132_volatile_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx132_volatile_ranges),
> +};
> +
> +static const struct regmap_range kx132_precious_ranges[] = {
> +	{
> +		.range_min = KX132_REG_INT_REL,
> +		.range_max = KX132_REG_INT_REL,
> +	},
> +};
> +
> +static const struct regmap_access_table kx132_precious_regs = {
> +	.yes_ranges = &kx132_precious_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx132_precious_ranges),
> +};
> +
> +static const struct regmap_range kx132_read_only_ranges[] = {
> +	{
> +		.range_min = KX132_REG_XADP_L,
> +		.range_max = KX132_REG_INT_REL,
> +	}, {
> +		.range_min = KX132_REG_BUF_STATUS_1,
> +		.range_max = KX132_REG_BUF_STATUS_2,
> +	}, {
> +		.range_min = KX132_REG_BUF_READ,
> +		.range_max = KX132_REG_BUF_READ,
> +	},
> +};

Do you think adding the "Kionix reserved" registers to read-only ranges 
would make things safer or is there a reason to keep them writable? I 
think the data-sheet states these should not be written to.

> +
> +static const struct regmap_access_table kx132_ro_regs = {
> +	.no_ranges = &kx132_read_only_ranges[0],
> +	.n_no_ranges = ARRAY_SIZE(kx132_read_only_ranges),
> +};
> +
> +static const struct regmap_range kx132_write_only_ranges[] = {
> +	{
> +		.range_min = KX132_REG_MAN_WAKE,
> +		.range_max = KX132_REG_MAN_WAKE,

Why the WUFC is write-only? Also, I don't think the KX022A_REG_MAN_WAKE 
and KX132_REG_MAN_WAKE reflect same functionality. The naming of the 
define may be slightly misleading.

> +	}, {
> +		.range_min = KX132_REG_SELF_TEST,
> +		.range_max = KX132_REG_SELF_TEST,
> +	}, {
> +		.range_min = KX132_REG_BUF_CLEAR,
> +		.range_max = KX132_REG_BUF_CLEAR,
> +	},
> +};
> +
> +static const struct regmap_access_table kx132_wo_regs = {
> +	.no_ranges = &kx132_write_only_ranges[0],
> +	.n_no_ranges = ARRAY_SIZE(kx132_write_only_ranges),
> +};
> +
> +static const struct regmap_range kx132_noinc_read_ranges[] = {
> +	{
> +		.range_min = KX132_REG_BUF_READ,
> +		.range_max = KX132_REG_BUF_READ,
> +	},
> +};
> +
> +static const struct regmap_access_table kx132_nir_regs = {
> +	.yes_ranges = &kx132_noinc_read_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(kx132_noinc_read_ranges),
> +};
> +
> +static const struct regmap_config kx132_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.volatile_table = &kx132_volatile_regs,
> +	.rd_table = &kx132_wo_regs,
> +	.wr_table = &kx132_ro_regs,
> +	.rd_noinc_table = &kx132_nir_regs,
> +	.precious_table = &kx132_precious_regs,
> +	.max_register = KX132_MAX_REGISTER,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
>   struct kx022a_data {
>   	const struct kx022a_chip_info *chip_info;
>   	struct regmap *regmap;
> @@ -237,6 +332,13 @@ static const struct iio_chan_spec kx022a_channels[] = {
>   	IIO_CHAN_SOFT_TIMESTAMP(3),
>   };
>   
> +static const struct iio_chan_spec kx132_channels[] = {
> +	KX022A_ACCEL_CHAN(X, KX132_REG_XOUT_L, 0),
> +	KX022A_ACCEL_CHAN(Y, KX132_REG_YOUT_L, 1),
> +	KX022A_ACCEL_CHAN(Z, KX132_REG_ZOUT_L, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
>   /*
>    * The sensor HW can support ODR up to 1600 Hz, which is beyond what most of the
>    * Linux CPUs can handle without dropping samples. Also, the low power mode is
> @@ -613,6 +715,25 @@ static int kx022a_get_fifo_bytes(struct kx022a_data *data)
>   	return fifo_bytes;
>   }
>   
> +static int kx132_get_fifo_bytes(struct kx022a_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	__le16 buf_status;
> +	int ret, fifo_bytes;
> +
> +	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
> +			       &buf_status, sizeof(buf_status));
> +	if (ret) {
> +		dev_err(dev, "Error reading buffer status\n");
> +		return ret;
> +	}
> +
> +	fifo_bytes = le16_to_cpu(buf_status);
> +	fifo_bytes &= data->chip_info->buf_smp_lvl_mask;

This is probably just my limitation but I've hard time thinking how this 
works out on BE machines. It'd be much easier for me to understand this 
if the data was handled as two u8 values and mask was applied before 
endianes conversion. (Eg - untested pseudo code follows;

__le16 buf_status;
u8 *reg_data;

...

ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
			&buf_status, sizeof(buf_status));
...

reg_data = (u8 *)&buf_status;

/* Clear the unused bits form 2.nd reg */
reg_data[1] = reg_data[i] & MASK_SMP_LVL_REG_HIGH_BITS;

/* Convert to CPU endianess */
fifo_bytes = le16_to_cpu(buf_status);

Well, others may have different view on this :)


> +
> +	return fifo_bytes;
> +}
> +
>   static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>   			       bool irq)
>   {
> @@ -1036,6 +1157,32 @@ const struct kx022a_chip_info kx022a_chip_info = {
>   };
>   EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
>   
> +const struct kx022a_chip_info kx132_chip_info = {
> +	.name		  = "kx132-1211",
> +	.regmap_config	  = &kx132_regmap_config,
> +	.channels	  = kx132_channels,
> +	.num_channels	  = ARRAY_SIZE(kx132_channels),
> +	.fifo_length	  = KX132_FIFO_LENGTH,
> +	.who		  = KX132_REG_WHO,
> +	.id		  = KX132_ID,
> +	.cntl		  = KX132_REG_CNTL,
> +	.cntl2		  = KX132_REG_CNTL2,
> +	.odcntl		  = KX132_REG_ODCNTL,
> +	.buf_cntl1	  = KX132_REG_BUF_CNTL1,
> +	.buf_cntl2	  = KX132_REG_BUF_CNTL2,
> +	.buf_clear	  = KX132_REG_BUF_CLEAR,
> +	.buf_status1	  = KX132_REG_BUF_STATUS_1,
> +	.buf_smp_lvl_mask = KX132_MASK_BUF_SMP_LVL,
> +	.buf_read	  = KX132_REG_BUF_READ,
> +	.inc1		  = KX132_REG_INC1,
> +	.inc4		  = KX132_REG_INC4,
> +	.inc5		  = KX132_REG_INC5,
> +	.inc6		  = KX132_REG_INC6,
> +	.xout_l		  = KX132_REG_XOUT_L,
> +	.get_fifo_bytes	  = kx132_get_fifo_bytes,
> +};
> +EXPORT_SYMBOL_NS_GPL(kx132_chip_info, IIO_KX022A);
> +
>   int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)
>   {
>   	static const char * const regulator_names[] = {"io-vdd", "vdd"};
> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> index f043767067b7..1f4135cf20eb 100644
> --- a/drivers/iio/accel/kionix-kx022a.h
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -74,6 +74,57 @@
>   #define KX022A_REG_SELF_TEST	0x60
>   #define KX022A_MAX_REGISTER	0x60
>   
> +#define KX132_REG_WHO		0x13
> +#define KX132_ID		0x3d
> +
> +#define KX132_FIFO_LENGTH	86
> +
> +#define KX132_REG_CNTL		0x1b
> +#define KX132_REG_CNTL2		0x1c
> +#define KX132_MASK_RES		BIT(6)
> +#define KX132_GSEL_2		0x0
> +#define KX132_GSEL_4		BIT(3)
> +#define KX132_GSEL_8		BIT(4)
> +#define KX132_GSEL_16		GENMASK(4, 3)
> +
> +#define KX132_REG_INS2		0x17
> +#define KX132_MASK_INS2_WMI	BIT(5)
> +
> +#define KX132_REG_XADP_L	0x02
> +#define KX132_REG_XOUT_L	0x08
> +#define KX132_REG_YOUT_L	0x0a
> +#define KX132_REG_ZOUT_L	0x0c
> +#define KX132_REG_COTR		0x12
> +#define KX132_REG_TSCP		0x14
> +#define KX132_REG_INT_REL	0x1a
> +
> +#define KX132_REG_ODCNTL	0x21
> +
> +#define KX132_REG_BTS_WUF_TH	0x4a
> +#define KX132_REG_MAN_WAKE	0x4d

As mentioned elsewhere, I don't think this is functionally same as 
KX022A_REG_MAN_WAKE.

> +
> +#define KX132_REG_BUF_CNTL1	0x5e
> +#define KX132_REG_BUF_CNTL2	0x5f
> +#define KX132_REG_BUF_STATUS_1	0x60
> +#define KX132_REG_BUF_STATUS_2	0x61
> +#define KX132_MASK_BUF_SMP_LVL	GENMASK(9, 0)
> +#define KX132_REG_BUF_CLEAR	0x62
> +#define KX132_REG_BUF_READ	0x63
> +#define KX132_ODR_SHIFT		3
> +#define KX132_FIFO_MAX_WMI_TH	86
> +
> +#define KX132_REG_INC1		0x22
> +#define KX132_REG_INC5		0x26
> +#define KX132_REG_INC6		0x27
> +#define KX132_IPOL_LOW		0
> +#define KX132_IPOL_HIGH		KX022A_MASK_IPOL
> +#define KX132_ITYP_PULSE	KX022A_MASK_ITYP
> +
> +#define KX132_REG_INC4		0x25
> +
> +#define KX132_REG_SELF_TEST	0x5d
> +#define KX132_MAX_REGISTER	0x76
> +
>   struct device;
>   
>   struct kx022a_data;
> @@ -132,5 +183,6 @@ struct kx022a_chip_info {
>   int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
>   
>   extern const struct kx022a_chip_info kx022a_chip_info;
> +extern const struct kx022a_chip_info kx132_chip_info;
>   
>   #endif


Thanks for adding this support!

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

