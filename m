Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D6B733D70
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 03:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjFQBiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 21:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFQBiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 21:38:03 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC053AAE;
        Fri, 16 Jun 2023 18:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Wbk9IDYSWF4Vw2QT3mvTtwNf2sHy8/XMCmJhIhRyBLg=; b=apqxTv6EFhOVJRCbMooTIwgoQF
        wBN2/+nR+fFsDt3gGcAgYt1fdaBfVrIomwBhbK9fVxdr97eWv43/KU5/r/BA+0LXUY1Z/12Kl7QQV
        0Q7xLvhhy1OSRwSP9j4kx8vs/VKqlnVOyEIdgy2ueFGU53SbhycnRYoh+LTY4/UtLRk1vCdmpe4wZ
        +ctyH3RtfR2Om0BgHK/0iqdAxnULk2NXGQUglsAMhVULvtm0uDT5v6xT/+XIGAVQ9f+GZbAQtqOdc
        M63yiwJJsvpkUO8gFfSHNTDakB568P3xpFVXMoh/QZIk9lcRBPLqTsD1G/ndRgzPphf9dk/TvKLk2
        ra+hr+rQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1qAKt1-000HG2-Vy; Sat, 17 Jun 2023 03:37:56 +0200
Received: from [136.25.87.181] (helo=[192.168.86.26])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1qAKt1-000HiB-Jr; Sat, 17 Jun 2023 03:37:55 +0200
Message-ID: <682cf4f8-ba1b-d74a-c744-6aa484c1acd5@metafoo.de>
Date:   Fri, 16 Jun 2023 18:37:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] iio: Add driver for Murata IRS-D200
Content-Language: en-US
To:     Waqar Hameed <waqar.hameed@axis.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        kernel@axis.com
References: <cover.1686926857.git.waqarh@axis.com>
 <d2d8f34c09a2ba0504eaba4f451412de41db2f37.1686926857.git.waqarh@axis.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <d2d8f34c09a2ba0504eaba4f451412de41db2f37.1686926857.git.waqarh@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26941/Fri Jun 16 09:30:16 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 08:10, Waqar Hameed wrote:
> Murata IRS-D200 is a PIR sensor for human detection. It has support for
> raw data measurements and detection event notification.
>
> Add a driver with support for triggered buffer and events. Map the
> various settings to the `iio` framework, e.g. threshold values, sampling
> frequency, filter frequencies etc.
>
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Looks very good, small minor comments.

> [...]
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index cc838bb5408a..f36598380446 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -6,6 +6,7 @@
>   # When adding new entries keep the list in alphabetical order
>   obj-$(CONFIG_AS3935)		+= as3935.o
>   obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
> +obj-$(CONFIG_IRSD200)		+= irsd200.o
>   obj-$(CONFIG_ISL29501)		+= isl29501.o
>   obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
>   obj-$(CONFIG_MB1232)		+= mb1232.o
> diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
> new file mode 100644
> index 000000000000..699801d60295
> --- /dev/null
> +++ b/drivers/iio/proximity/irsd200.c
> @@ -0,0 +1,1051 @@
> [...]
> +/*
> + * The upper 4 bits in register IRS_REG_COUNT value is the upper count value
> + * (exceeding upper threshold value). The lower 4 is the lower count value
> + * (exceeding lower threshold value).
> + */
> +#define IRS_UPPER_COUNT(count)	(count >> 4)
> +#define IRS_LOWER_COUNT(count)	(count & GENMASK(3, 0))

Usually we add parenthesis around macro arguments to avoid issues in 
case the argument is a non-singular expression.

> [...]
>
> +static int irsd200_read_data(struct irsd200_data *data, s16 *val)
> +{
> +	unsigned int tmpval;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, IRS_REG_DATA_HI, &tmpval);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Could not read hi data (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	*val = (s16)(tmpval << 8);
> +
> +	ret = regmap_read(data->regmap, IRS_REG_DATA_LO, &tmpval);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Could not read lo data (%d)\n", ret);
> +		return ret;
> +	}
Is there a way to bulk read those registers in one go to avoid 
inconsistent data if they change while being read?
> +	*val |= tmpval;
> +
> +	return 0;
> +}
> [...]
> +static int irsd200_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = irsd200_write_data_rate(data, val);
> +		return ret;
Maybe just `return irsd200_write_data_rate(...)`
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>
> [...]
> +static int irsd200_probe(struct i2c_client *client)
> +{
> +	struct iio_trigger *trigger;
> +	struct irsd200_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	size_t i;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(client, &irsd200_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Could not initialize regmap\n");
dev_err_probe() is the more modern variant for error reporting in the 
probe function. Same for all the other dev_err() in this function.
> +		return PTR_ERR(regmap);
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "Could not allocate iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	data->regmap = regmap;
> +	data->dev = &client->dev;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	for (i = 0; i < IRS_REGF_MAX; ++i) {
> +		data->regfields[i] = devm_regmap_field_alloc(
> +			data->dev, data->regmap, irsd200_regfields[i]);
> +		if (IS_ERR(data->regfields[i])) {
> +			dev_err(data->dev,
> +				"Could not allocate register field %zu\n", i);
> +			return PTR_ERR(data->regfields[i]);
> +		}
> +	}
> +
> [...]


