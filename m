Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE53873D830
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjFZHCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjFZHC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:02:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99F012A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:02:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f9b4bf99c2so38370845e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687762940; x=1690354940;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PGWZfcI+ygYewNhDuM0SYl47YqYvcG68Xrvt5FnKs4o=;
        b=XdYtF2EvTOPk5ZDrokR/u8wGAZLqSExt8bHLEgTIYru7Rro2X10eehexpNdBHl9Wje
         Zwtpc5ea1dC93KOl4J5pP6WAJ0sgfg+Q43sHOs9uSVv6YaRXuuvPuOBa/MiX/1fgUFwQ
         ch2miYjKjT5JsrkjqyjFe3P3ecBjqIysl459ErpiM8nPNL0bzsLmEOYkqOI79gQMoctr
         U2eJnU4pTNoTLnDpzypjQgzsHvSW7Z+Y6NZQhl9MWFnvgjei+XPTls1gGFOuPKO7Au6J
         OJZF52xWj42yluQVPKUpeOtZXi0/dVuH3gFHKmXGwo0bEC9NGsZlOZr+jRwWMdrplTta
         wqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687762940; x=1690354940;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGWZfcI+ygYewNhDuM0SYl47YqYvcG68Xrvt5FnKs4o=;
        b=PLfinHwjN/dIilyZkEFXOUKwzgVVv5m5qcVIwJdbtVK/NIgzMzAFsgwLWQ/4IZcdiF
         f1VwOWk8veJzx9agDMMVojjPWFedsJjB9Fd9PHim5u/8/frdvWkvjAGRcxn7JG9KhtsP
         JwpXmaDoloOM7Bh1eiTTSRJcDfXtL6JNvdvLHvB0VRnTr8mGoTmulr0SnB2OD4YymwuW
         L2UD9ukVzrCXRenoj70oSfF0GJUzbjnlwq6QHRBSAXfW0j/px8I6WhA6ff1a0ko3BFFs
         PWmaxZFWFFqnZTYrw9F3BrR7BeI6L0nug0O6RzpjrggwRhIF5p5daObPjoM7JQbsb3RG
         PgQw==
X-Gm-Message-State: AC+VfDwrFUsw3jlfCP9fcMhzwu21p3ZQdUCnMyUZmZFh9B6PTdpTlOVc
        XsknJ/F1lPwDA6J6QjfGjR19dQ==
X-Google-Smtp-Source: ACHHUZ6dryO+h7ysP/DnH1V8ruGXuDieBUNB9D2BNiaOACtfp7vGwdgKCWTWyDnkNkYq/8nV2R1S4g==
X-Received: by 2002:a1c:4b0c:0:b0:3f9:b083:109 with SMTP id y12-20020a1c4b0c000000b003f9b0830109mr17024110wma.33.1687762940221;
        Mon, 26 Jun 2023 00:02:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:9a76:3d38:5d1f:60c? ([2a01:e0a:982:cbb0:9a76:3d38:5d1f:60c])
        by smtp.gmail.com with ESMTPSA id x26-20020a1c7c1a000000b003fa740ef99esm6590678wmc.45.2023.06.26.00.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 00:02:19 -0700 (PDT)
Message-ID: <e36a697f-a54d-7bdf-1e18-38f72ec2966c@linaro.org>
Date:   Mon, 26 Jun 2023 09:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 4/4] input: touchscreen: add SPI support for Goodix
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
References: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v3-4-f0577cead709@linaro.org>
 <ZJiXopmFr4dPbqll@nixie71>
Organization: Linaro Developer Services
In-Reply-To: <ZJiXopmFr4dPbqll@nixie71>
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

Hi Jeff,

On 25/06/2023 21:38, Jeff LaBundy wrote:
> Hi Neil,
> 
> On Thu, Jun 22, 2023 at 04:29:02PM +0200, Neil Armstrong wrote:
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
> 
> Just a few comments below, then feel free to add:
> 
> Reviewed-by: Jeff LaBundy <jeff@labundy.com>
> 
>>   drivers/input/touchscreen/Kconfig             |  13 ++
>>   drivers/input/touchscreen/Makefile            |   1 +
>>   drivers/input/touchscreen/goodix_berlin_spi.c | 172 ++++++++++++++++++++++++++
>>   3 files changed, 186 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
>> index 5e21cca6025d..2d86615e5090 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -435,6 +435,19 @@ config TOUCHSCREEN_GOODIX_BERLIN_I2C
>>   	  To compile this driver as a module, choose M here: the
>>   	  module will be called goodix_berlin_i2c.
>>   
>> +config TOUCHSCREEN_GOODIX_BERLIN_SPI
>> +	tristate "Goodix Berlin SPI touchscreen"
>> +	depends on SPI_MASTER
> 
> select REGMAP
> 
> (keep "depends on SPI_MASTER")

Ack, indeed it looks cleaner to do that

> 
>> +	select TOUCHSCREEN_GOODIX_BERLIN_CORE
>> +	help
>> +	  Say Y here if you have a Goodix Berlin IC connected to
>> +	  your system via SPI.
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
>> index 000000000000..3a1bc251b32d
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/goodix_berlin_spi.c
>> @@ -0,0 +1,172 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Goodix Berlin Touchscreen Driver
>> + *
>> + * Copyright (C) 2020 - 2021 Goodix, Inc.
>> + * Copyright (C) 2023 Linaro Ltd.
>> + *
>> + * Based on goodix_ts_berlin driver.
>> + */
>> +#include <asm/unaligned.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/spi/spi.h>
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
> 
> Please namespace all of these as you have done in the core driver.

Ack

> 
>> +
>> +static int goodix_berlin_spi_read(void *context, const void *reg_buf,
>> +				  size_t reg_size, void *val_buf,
>> +				  size_t val_size)
>> +{
>> +	struct spi_device *spi = context;
>> +	struct spi_transfer xfers;
>> +	struct spi_message spi_msg;
>> +	const u32 *reg = reg_buf; /* reg is stored as native u32 at start of buffer */
>> +	u8 *buf;
>> +	int ret;
> 
> 	int error;
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
> 
> 	error = spi_sync(...);
> 
>> +	if (ret < 0)
> 
> 	if (error)
> 
>> +		dev_err(&spi->dev, "transfer error:%d", ret);
>> +	else
>> +		memcpy(val_buf, buf + SPI_READ_PREFIX_LEN, val_size);
>> +
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
>> +	u8 *buf;
>> +	int ret;
> 
> Same comments here regarding 'error' vs. 'ret'.

Seems I forgot to do the rename here, thanks for pointing it!

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
>> +/* vendor & product left unassigned here, should probably be updated from fw info */
>> +static const struct input_id goodix_berlin_spi_input_id = {
>> +	.bustype = BUS_SPI,
>> +};
>> +
>> +static int goodix_berlin_spi_probe(struct spi_device *spi)
>> +{
>> +	struct regmap_config *regmap_config;
>> +	struct regmap *regmap;
>> +	size_t max_size;
>> +	int error = 0;
>> +
>> +	regmap_config = devm_kmemdup(&spi->dev, &goodix_berlin_spi_regmap_conf,
>> +				     sizeof(*regmap_config), GFP_KERNEL);
>> +	if (!regmap_config)
>> +		return -ENOMEM;
> 
> Is there any reason we cannot simply pass goodix_berlin_spi_regmap_conf to
> devm_regmap_init() below? Why to duplicate and pass the copy?
> 
> For reference, BMP280 in IIO is a similar example of a device with regmap
> sitting atop a bespoke SPI protocol; it does not seem to take this extra
> step.

The goodix_berlin_spi_regmap_conf copy is modified after with the correct
max raw read/write size, and I'm not a fan of modifying a global structure
that could be use for multiple probes, I can make a copy in a stack variable
if it feels simpler.

> 
>> +
>> +	spi->mode = SPI_MODE_0;
>> +	spi->bits_per_word = 8;
>> +	error = spi_setup(spi);
>> +	if (error)
>> +		return error;
>> +
>> +	max_size = spi_max_transfer_size(spi);
>> +	regmap_config->max_raw_read = max_size - SPI_READ_PREFIX_LEN;
>> +	regmap_config->max_raw_write = max_size - SPI_WRITE_PREFIX_LEN;
>> +
>> +	regmap = devm_regmap_init(&spi->dev, NULL, spi, regmap_config);
>> +	if (IS_ERR(regmap))
>> +		return PTR_ERR(regmap);
>> +
>> +	return goodix_berlin_probe(&spi->dev, spi->irq,
>> +				   &goodix_berlin_spi_input_id, regmap);
>> +}
>> +
>> +static const struct spi_device_id goodix_berlin_spi_ids[] = {
>> +	{ "gt9916" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(spi, goodix_berlin_spi_ids);
>> +
>> +static const struct of_device_id goodix_berlin_spi_of_match[] = {
>> +	{ .compatible = "goodix,gt9916", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, goodix_berlin_spi_of_match);
>> +
>> +static struct spi_driver goodix_berlin_spi_driver = {
>> +	.driver = {
>> +		.name = "goodix-berlin-spi",
>> +		.of_match_table = goodix_berlin_spi_of_match,
>> +		.pm = pm_sleep_ptr(&goodix_berlin_pm_ops),
>> +	},
>> +	.probe = goodix_berlin_spi_probe,
>> +	.id_table = goodix_berlin_spi_ids,
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

Thanks,
Neil

