Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5F72C39D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjFLMBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjFLMBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:01:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD0B0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:01:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30c4c1fd511so3861017f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686571300; x=1689163300;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G1+iPoV6ViWmToxGfVYwSS0HBq77okNMum1crJ5ZSmQ=;
        b=yyQVB8cdV1JAqx5WeYkS4eQFMgztDyalxHTTSOWBBP2X7HmdBmYnrC3EUkhbLxD+m0
         CTFHzDLOWwSncYSvNNsqicvpUnYR0VALOtOVBkleEKA5bMh0/0bvVyWhv59gXIPT9J7E
         3By8cXIJ01GITa0zN+ZUZbiha+fqW2QFcZPYXXBM0D3I4mdUtwYn4ZMxc0uz54MNtKiO
         QcYPvYVUmFg2huG9sf13Fb4MBtGbCt4andfD5NG7cPg2egfj30pSSIXfgFv//xUghKLU
         HTLN9X/ld3GMJjVGsImj96KU9S5ShRszcXllra3en3THPpUa6PGaAxt6sxnsfwenoG+O
         J/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686571300; x=1689163300;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1+iPoV6ViWmToxGfVYwSS0HBq77okNMum1crJ5ZSmQ=;
        b=XPLbQlIDgBisr4NRLjj92s2+pC3/ESJPI2ZNuK2XEIXlV8xzASq2tEby8qPtm4WUsc
         w8L/DeR8uvzjMTADYxbAOk1dhYa0/e4zRL2aylueYWbco7S6eE9MJQoBnLzOD603c7y5
         Dcu22+SnGziHbM6IG5+JqEmVgbduOWB7x4N18OnUulTL5ik7ank/c080jkjF8B3xbD8Y
         tQkoZ+AG2vdL0Im7PU8jV949YTZCt8/yCWszxp46dIJVWgaxErPIJZXRtnZic8pSYSHF
         V9ZOCSa4ogwzBCL9fB81245AVVlWDIa48Qujd5MdY4zx02XRnCmPuruprYmR46vq2d8z
         HD6A==
X-Gm-Message-State: AC+VfDxGvveh1E3r6mTf7TMqoRxhRjTTVYAcrWmpaAhq/LOvkF8nnkDf
        jBWbX/k2mqjMCLGZmI0Gqz2P0A==
X-Google-Smtp-Source: ACHHUZ5ILXgfpbIliK4rXcCJxJ9F2icWza3Xgg3La2aYBaUo3CQy/LgOZpQ0/vY+oBoY3A8vhdNf3g==
X-Received: by 2002:adf:f5d1:0:b0:309:e24:57b3 with SMTP id k17-20020adff5d1000000b003090e2457b3mr5080955wrp.4.1686571299613;
        Mon, 12 Jun 2023 05:01:39 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id n26-20020a1c721a000000b003f78fd2cf5esm11208204wmc.40.2023.06.12.05.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 05:01:39 -0700 (PDT)
Message-ID: <a87160e5-b895-3dae-bba0-94fc67c92679@linaro.org>
Date:   Mon, 12 Jun 2023 14:01:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 4/4] input: touchscreen: add SPI support for Goodix
 Berlin Touchscreen IC
Content-Language: en-US
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v1-4-4a0741b8aefd@linaro.org>
 <ZIaRoTHar/s5yZAh@nixie71>
Organization: Linaro Developer Services
In-Reply-To: <ZIaRoTHar/s5yZAh@nixie71>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/06/2023 05:31, Jeff LaBundy wrote:
> Hi Neil,
> 
> On Tue, Jun 06, 2023 at 04:31:59PM +0200, Neil Armstrong wrote:
>> Add initial support for the new Goodix "Berlin" touchscreen ICs
>> over the SPI interface.
>>
>> The driver doesn't use the regmap_spi code since the SPI messages
>> needs to be prefixed, thus this custom regmap code.
>>
>> This initial driver is derived from the Goodix goodix_ts_berlin
>> available at [1] and [2] and only supports the GT9916 IC
>> present on the Qualcomm SM8550 MTP & QRD touch panel.
>>
>> The current implementation only supports BerlinD, aka GT9916.
>>
>> [1] https://github.com/goodix/goodix_ts_berlin
>> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/input/touchscreen/Kconfig             |  14 ++
>>   drivers/input/touchscreen/Makefile            |   1 +
>>   drivers/input/touchscreen/goodix_berlin_spi.c | 183 ++++++++++++++++++++++++++
>>   3 files changed, 198 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
>> index da6d5d75c42d..ffe0c0a4cd15 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -435,6 +435,20 @@ config TOUCHSCREEN_GOODIX_BERLIN_I2C
>>   	  To compile this driver as a module, choose M here: the
>>   	  module will be called goodix_berlin_i2c.
>>   
>> +config TOUCHSCREEN_GOODIX_BERLIN_SPI
>> +	tristate "Goodix Berlin SPI touchscreen"
>> +	depends on SPI_MASTER
>> +	depends on REGMAP
> 
> As TOUCHSCREEN_GOODIX_BERLIN_CORE already depends on REGMAP; is this
> line necessary?
> 
> I was about to ask why not to select REGMAP_SPI; thank you for the
> additional information in the commit message.
> 
>> +	select TOUCHSCREEN_GOODIX_BERLIN_CORE
>> +	help
>> +	  Say Y here if you have the a touchscreen connected to your
>> +	  system using the Goodix Berlin IC connection via SPI.
> 
> Same comment here with regard to diction.
> 
>> +
>> +	  If unsure, say N.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called goodix_berlin_spi.
>> +
>>   config TOUCHSCREEN_HIDEEP
>>   	tristate "HiDeep Touch IC"
>>   	depends on I2C
>> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
>> index 921a2da0c2be..29524e8a83db 100644
>> --- a/drivers/input/touchscreen/Makefile
>> +++ b/drivers/input/touchscreen/Makefile
>> @@ -49,6 +49,7 @@ obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>>   obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
>>   obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
>>   obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)	+= goodix_berlin_i2c.o
>> +obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI)	+= goodix_berlin_spi.o
>>   obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
>>   obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
>>   obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
>> diff --git a/drivers/input/touchscreen/goodix_berlin_spi.c b/drivers/input/touchscreen/goodix_berlin_spi.c
>> new file mode 100644
>> index 000000000000..0f4f650fdf3f
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/goodix_berlin_spi.c
>> @@ -0,0 +1,183 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Goodix Berlin Touchscreen Driver
>> + *
>> + * Copyright (C) 2020 - 2021 Goodix, Inc.
>> + * Copyright (C) 2023 Linaro Ltd.
>> + *
>> + * Based on goodix_ts_berlin driver.
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/regmap.h>
> 
> Please alphabetize these to aid readability.
> 
>> +#include <asm/unaligned.h>
>> +
>> +#include "goodix_berlin.h"
>> +
>> +#define SPI_TRANS_PREFIX_LEN	1
>> +#define REGISTER_WIDTH		4
>> +#define SPI_READ_DUMMY_LEN	3
>> +#define SPI_READ_PREFIX_LEN	(SPI_TRANS_PREFIX_LEN + REGISTER_WIDTH + SPI_READ_DUMMY_LEN)
>> +#define SPI_WRITE_PREFIX_LEN	(SPI_TRANS_PREFIX_LEN + REGISTER_WIDTH)
>> +
>> +#define SPI_WRITE_FLAG		0xF0
>> +#define SPI_READ_FLAG		0xF1
>> +
>> +static int goodix_berlin_spi_read(void *context, const void *reg_buf,
>> +				  size_t reg_size, void *val_buf,
>> +				  size_t val_size)
>> +{
>> +	struct spi_device *spi = context;
>> +	struct spi_transfer xfers;
>> +	struct spi_message spi_msg;
>> +	const u32 *reg = reg_buf; /* reg is stored as native u32 at start of buffer */
>> +	u8 *buf = NULL;
>> +	int ret = 0;
> 
> No need to initialize these, only to forcibly assign them later.
> 
>> +
>> +	if (reg_size != REGISTER_WIDTH)
>> +		return -EINVAL;
>> +
>> +	buf = kzalloc(SPI_READ_PREFIX_LEN + val_size, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	spi_message_init(&spi_msg);
>> +	memset(&xfers, 0, sizeof(xfers));
>> +
>> +	/* buffer format: 0xF1 + addr(4bytes) + dummy(3bytes) + data */
>> +	buf[0] = SPI_READ_FLAG;
>> +	put_unaligned_be32(*reg, buf + SPI_TRANS_PREFIX_LEN);
>> +	memset(buf + SPI_TRANS_PREFIX_LEN + REGISTER_WIDTH, 0xff,
>> +	       SPI_READ_DUMMY_LEN);
>> +
>> +	xfers.tx_buf = buf;
>> +	xfers.rx_buf = buf;
>> +	xfers.len = SPI_READ_PREFIX_LEN + val_size;
>> +	xfers.cs_change = 0;
>> +	spi_message_add_tail(&xfers, &spi_msg);
>> +
>> +	ret = spi_sync(spi, &spi_msg);
>> +	if (ret < 0) {
>> +		dev_err(&spi->dev, "transfer error:%d", ret);
>> +		goto exit;
>> +	}
> 
> My comment is purely idiomatic, but this seems cleaner:
> 
> 	ret = ...
> 	if (ret)
> 		dev_err(...);
> 	else
> 		memcpy(...);
> 
> 	kfree(...);
> 	return ret;
> 
>> +
>> +	memcpy(val_buf, buf + SPI_READ_PREFIX_LEN, val_size);
>> +exit:
>> +	kfree(buf);
>> +	return ret;
>> +}
>> +
>> +static int goodix_berlin_spi_write(void *context, const void *data,
>> +				   size_t count)
>> +{
>> +	unsigned int len = count - REGISTER_WIDTH;
>> +	struct spi_device *spi = context;
>> +	struct spi_transfer xfers;
>> +	struct spi_message spi_msg;
>> +	const u32 *reg = data; /* reg is stored as native u32 at start of buffer */
>> +	u8 *buf = NULL;
>> +	int ret = 0;
> 
> Same comment here with regard to initialization.
> 
>> +
>> +	buf = kzalloc(SPI_WRITE_PREFIX_LEN + len, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	spi_message_init(&spi_msg);
>> +	memset(&xfers, 0, sizeof(xfers));
>> +
>> +	buf[0] = SPI_WRITE_FLAG;
>> +	put_unaligned_be32(*reg, buf + SPI_TRANS_PREFIX_LEN);
>> +	memcpy(buf + SPI_WRITE_PREFIX_LEN, data + REGISTER_WIDTH, len);
>> +
>> +	xfers.tx_buf = buf;
>> +	xfers.len = SPI_WRITE_PREFIX_LEN + len;
>> +	xfers.cs_change = 0;
>> +	spi_message_add_tail(&xfers, &spi_msg);
>> +
>> +	ret = spi_sync(spi, &spi_msg);
>> +	if (ret < 0)
>> +		dev_err(&spi->dev, "transfer error:%d", ret);
>> +
>> +	kfree(buf);
>> +	return ret;
>> +}
>> +
>> +static const struct regmap_config goodix_berlin_spi_regmap_conf = {
>> +	.reg_bits = 32,
>> +	.val_bits = 8,
>> +	.read = goodix_berlin_spi_read,
>> +	.write = goodix_berlin_spi_write,
>> +};
>> +
>> +static const struct input_id goodix_berlin_spi_input_id = {
>> +	.bustype = BUS_SPI,
>> +	.vendor = 0x0416,
>> +	.product = 0x1001,
> 
> After having seen these in the I2C counterpart; consider defining them
> in goodix_berlin.h.

To be honest, I blindly copied it from goodix.c because the vendor
driver puts random values here.

input_dev->id.product = 0xDEAD;
input_dev->id.vendor = 0xBEEF;

So what should I set ?

Neil

> 
>> +};
>> +
>> +static int goodix_berlin_spi_probe(struct spi_device *spi)
>> +{
>> +	struct regmap_config *cfg;
> 
> regmap_config
> 
>> +	struct regmap *map;
> 
> regmap
> 
> (see more examples in MFD where such dual-mode devices are common).
> 
>> +	size_t max_size;
>> +	int ret = 0;
>> +
>> +	cfg = devm_kmemdup(&spi->dev, &goodix_berlin_spi_regmap_conf,
>> +			   sizeof(*cfg), GFP_KERNEL);
>> +	if (!cfg)
>> +		return -ENOMEM;
>> +
>> +	spi->mode = SPI_MODE_0;
>> +	spi->bits_per_word = 8;
>> +	ret = spi_setup(spi);
>> +	if (ret)
>> +		return ret;
>> +
>> +	max_size = spi_max_transfer_size(spi);
>> +	cfg->max_raw_read = max_size - SPI_READ_PREFIX_LEN;
>> +	cfg->max_raw_write = max_size - SPI_WRITE_PREFIX_LEN;
>> +
>> +	map = devm_regmap_init(&spi->dev, NULL, spi, cfg);
>> +	if (IS_ERR(map))
>> +		return PTR_ERR(map);
>> +
>> +	return goodix_berlin_probe(&spi->dev, spi->irq,
>> +				   &goodix_berlin_spi_input_id, map);
>> +}
>> +
>> +static void goodix_berlin_spi_remove(struct spi_device *spi)
>> +{
>> +	goodix_berlin_remove(&spi->dev);
>> +}
>> +
>> +static const struct of_device_id goodix_berlin_spi_of_match[] = {
>> +	{
>> +		.compatible = "goodix,gt9916",
>> +	},
> 
> This format is different than its I2C counterpart.
> 
>> +	{ },
> 
> Nit: same comment with regards to trailing commas.
> 
>> +};
>> +MODULE_DEVICE_TABLE(of, goodix_berlin_spi_of_match);
>> +
>> +static const struct spi_device_id goodix_berlin_spi_ids[] = {
>> +	{ "gt9916" },
>> +	{ },
> 
> And here.
> 
>> +};
>> +MODULE_DEVICE_TABLE(spi, goodix_berlin_spi_ids);
>> +
>> +static struct spi_driver goodix_berlin_spi_driver = {
>> +	.driver = {
>> +		.name = "goodix-berlin-spi",
>> +		.of_match_table = goodix_berlin_spi_of_match,
>> +		.pm = pm_sleep_ptr(&goodix_berlin_pm_ops),
>> +	},
>> +	.id_table = goodix_berlin_spi_ids,
>> +	.probe = goodix_berlin_spi_probe,
>> +	.remove = goodix_berlin_spi_remove,
>> +};
>> +module_spi_driver(goodix_berlin_spi_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Goodix Berlin SPI Touchscreen driver");
>> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
>>
>> -- 
>> 2.34.1
>>
> 
> Kind regards,
> Jeff LaBundy

