Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74F867D0AE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjAZPzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAZPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:55:06 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7D62BF39;
        Thu, 26 Jan 2023 07:55:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h12so2208638wrv.10;
        Thu, 26 Jan 2023 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGV6/SH7Wgigrc7TfBBO4pYmyGciuNb6xAad1w8dDc8=;
        b=Zwtnrv1VEuMxZFJb25MGV69RZN20QSn0TORt9VTPCAjkXtchUan0VVrsOYmSfXLuch
         nKQLqlYg70yOJYXXNvR+MhKxW4sLeSO2Nk4fizyGexqpCnOUIpDFzfW+e1WjVVOLel/l
         UHybtcjp5srhLPiBHoseaIWHKWhi3mmAEka34OJXBfaTnb1Cz4GC6thOxs0zdjwb5AQq
         YpxbNvfxqf4NIaMPfffRFWkJzOUFSynmN2iiJAE/QKa2RDX8F8nrfE3UyDKAsQ/F4C5d
         F1dqRAmJ2+61peigFVzxMuMTUzKR0GbX51x/fhkhheHoPoLz8fXVZIxcktIs1No6DGk7
         Lf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGV6/SH7Wgigrc7TfBBO4pYmyGciuNb6xAad1w8dDc8=;
        b=IJwXzt2LuS5cx4XfQ/iy7hecwdIKQiZVEa8hr7oNzYYyuMcEvyoYTCJ3J65u6Jidxb
         9zLbM9JJvI8VkngM+yVMyZqK1P1Ir3S9rPqCvb5sxPEyvbKvV8DGMgCMM/4cVOZYeQqM
         iqkaHGxz0C/cJlj7iccgqUpuYM+EzxziqYj2goeARn/OlUxC85xPucU7zqkPrnzJ2SWU
         F2jZup6t+trEHDFZu5gpzF2nuFooNcjoCq6gZaABQYUtFt1mplo74wSv4K/Nh24u1fiR
         +mavvhDEZId7mD8VFbq2AJfRCQshJXS1PO6xHPPEsKZ/hBbmWW5nNwoloJPFDErbq4Dv
         7kHA==
X-Gm-Message-State: AO0yUKUa3ZDAdLiMGIH2gdMPOTFdvTruGpb6VbJ7bVehS8Cpsw5V52El
        zrPSzF31mU8MCODy2jb1kI0s7MpsniLSpdO3
X-Google-Smtp-Source: AK7set8dhf4itSkSVXSB8ydeXzNGDm3rbkdtGL2/TF0vvFaQAXKRiyXHDZb9/R5ophTYgEZC43ZSrQ==
X-Received: by 2002:adf:b101:0:b0:2bf:bf27:2dd2 with SMTP id l1-20020adfb101000000b002bfbf272dd2mr4065583wra.45.1674748503703;
        Thu, 26 Jan 2023 07:55:03 -0800 (PST)
Received: from [192.168.247.142] ([46.211.236.58])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002be2f18938csm1560563wrt.41.2023.01.26.07.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:55:03 -0800 (PST)
Message-ID: <a782a0d9-c47e-4328-774f-6bef78161d81@gmail.com>
Date:   Thu, 26 Jan 2023 17:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] iio: light: Add support for AMS TCS3490 light sensor
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20230123231028.26073-1-markuss.broks@gmail.com>
 <20230123231028.26073-3-markuss.broks@gmail.com>
 <Y8+xamtH/U4vK75e@smile.fi.intel.com>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <Y8+xamtH/U4vK75e@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 1/24/23 12:22, Andy Shevchenko wrote:
> On Tue, Jan 24, 2023 at 01:10:25AM +0200, Markuss Broks wrote:
>> Add a driver for AMS TCS3490 Color Light-to-Digital Converter. This
>> device provides color and IR (red, green, blue, clear and IR) light
>> sensing. The color sensing can be used for light source detection and
>> color temperature measurements.
> ...
>
>> +AMS TCS3490 DRIVER
>> +M:	Markuss Broks <markuss.broks@gmail.com>
>> +L:	linux-iio@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/iio/light/ams,tcs3490.yaml
> Shouldn't actually be added with the schema patch?
>
>> +F:	drivers/iio/light/tcs3490.c
> I dunno what's the rules but it feels a bit inconsistent in case the schema
> will leave while driver got, for example, rewritten (as brand new) and reverted
> (as old one). In such (quite unlikely) circumstances we may end up with the
> dangling file.
>
> Rob, Krzysztof, Jonathan, what is yours take from this?
>
> ...
>
>> +config TCS3490
>> +	tristate "AMS TCS3490 color light-to-digital converter"
>> +	depends on I2C
> Hmm... Where is the select REGMAP_I2C?
>
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>> +	help
>> +	  Say Y here if you have an AMS TCS3490 color light-to digital converter
>> +	  which provides RGB color and IR light sensing.
>> +
>> +	  This driver can also be built as a module.  If so, the module
>> +	  will be called tcs3490.
> ...
>
>> +struct tcs3490 {
>> +	struct i2c_client *client;
> Why do you need this?
>
>> +	struct regmap *regmap;
>> +	struct regulator *vdd_supply;
>> +};
> ...
>
>> +static const struct regmap_config tcs3490_regmap_config = {
>> +	.reg_bits	= 8,
>> +	.val_bits	= 8,
> Seems you are using regmap internal serialization, but does it guarantee the
> serialization on the transaction level? Or why is it not a problem?
Well, other drivers seem to have it this way too. I don't really 
understand why it should be a problem, could you please clarify?
>
>> +};
> ...
>
>> +	do {
>> +		usleep_range(3000, 4000);
>> +
>> +		ret = regmap_read(data->regmap, TCS3490_STATUS, &status);
>> +		if (ret)
>> +			return ret;
>> +		if (status & TCS3490_STATUS_RGBC_VALID)
>> +			break;
>> +	} while (--tries);
>> +
>> +	if (!tries)
>> +		return -ETIMEDOUT;
> regmap_read_poll_timeout()?
>
> ...
>
>> +	ret = regmap_read(data->regmap, chan->address, &val_l);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_read(data->regmap, chan->address + 1, &val_h);
>> +	if (ret)
>> +		return ret;
> Why not a bulk read into __le16 val?
>
>> +	*val = (val_h << 8) | val_l;
> Use le16_to_cpu().
>
>> +	ret = regmap_write(data->regmap, TCS3490_ENABLE, TCS3490_SUSPEND);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
> Can be simply
>
> 	return regmap_write(...);
>
>> +}
> ...
>
>> +static int tcs3490_read_raw(struct iio_dev *indio_dev,
>> +			    const struct iio_chan_spec *chan,
>> +			    int *val, int *val2, long mask)
>> +{
>> +	struct tcs3490 *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = tcs3490_read_channel(data, chan, val);
>> +		if (ret < 0)
>> +			return ret;
>> +		ret = IIO_VAL_INT;
>> +		break;
> return directly.
>
>> +	case IIO_CHAN_INFO_CALIBSCALE:
>> +		ret = tcs3490_get_gain(data, val);
> Missing error check.
>
>> +		ret = IIO_VAL_INT;
>> +		break;
> Return directly.
>
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
> Ditto.
>
>> +	}
>> +	if (ret < 0)
>> +		return ret;
>> +	return IIO_VAL_INT;
> Redundant, see above.
>
>> +}
> ...
>
>> +static const struct of_device_id tcs3490_of_match[] = {
>> +	{ .compatible = "ams,tcs3490", },
> Inner comma is not needed.
>
>> +	{ },
> Terminator entries should go without a comma.
>
>> +};
> ...
>
>> +static struct i2c_driver tcs3490_driver = {
>> +	.driver = {
>> +		.name = "tcs3490",
>> +		.of_match_table = of_match_ptr(tcs3490_of_match),
> Kill of_match_ptr(). Its usage is wrong in 99% of the cases.
>
>> +	},
>> +	.probe_new = tcs3490_probe,
>> +};
>> +
> Redundant blank line.
>
>> +module_i2c_driver(tcs3490_driver);
- Markuss
