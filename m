Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B181F6AC86A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCFQn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjCFQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:43:18 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F007EEB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:42:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i34so41219574eda.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 08:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678120900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBQLhMJNJwBxWCZBMKKd2ZioyWT7HHTdTuSHuSD5zeE=;
        b=RymyUxEqXDN6lqEMPjXJTgOOGQgr5jbPevWg8i40M+/MPF9dFVfBLTwCZgxRLAl46d
         Nw/KqOGzbnN3Q4Ki62BMdS7r2U3bvniAWizojRlbFsi2tCP9JpJ/kBxnPGuGrGT4q8xy
         raXXBoV2dAXAfj90iQOvAzDND8z0f2MR5DjBr5lepEWwn/d0ZzmiuL74BixrSAxBIVcH
         rREZOqtfY8LN8WH5mHd0lTO80qa/S8ovZopCCPZ1yjpC2F3ziHWty8MZ9gFFgAQhxW7n
         TZiRddDGSdircQbHifgYgGIhdIbNL5yofWgbB4LX1Qrblg8MyEt90pqodeP9mhBrnavh
         SNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678120900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBQLhMJNJwBxWCZBMKKd2ZioyWT7HHTdTuSHuSD5zeE=;
        b=rIfBoSbcamDAANilORDOUr1Skg69at6Ut0rU5/Rd2va33kTtNhh29iAzHDIWvHyB6d
         TNMHRNR1Lcl+ukomZUnowFJGQGtchKBnJhjHR9nKf5paxFClwARf/Q67HCdcPbQ5WCp4
         QoG921w9NrFPZkIhbrJvDEEY74qNTfe7VGFnjN9FWcfbYf/PWfWxe7hszkirTsgKXZUT
         RDB/7FWLkZtO7/74kojls44+db67sHOu+UCh1uOeDVzNX8N+K82+NP14uuqhx0W8Biha
         CqV/0drMsPLFh0HGtXgPUoRO/YktUuSfl1h/1jzOoKGhA6ZwMngPRoeAEyvsKavP12Fr
         eegQ==
X-Gm-Message-State: AO0yUKV7o7kZ68TiHerwdkxx6j6FF9QHF4bTGdgQ3QAPcv3Q3xzjjkvj
        zotY9Ay9XmYg5SNMjwuSTDV8IQ==
X-Google-Smtp-Source: AK7set8jxix0Za/DVd/wm3kcw43surTXMo2qOCiwMqzZSVfE/iqtn5rPhfFDjsexdGCVyoGKW4OM/Q==
X-Received: by 2002:a17:906:ee9:b0:8af:2bb3:80d7 with SMTP id x9-20020a1709060ee900b008af2bb380d7mr15158307eji.31.1678120899857;
        Mon, 06 Mar 2023 08:41:39 -0800 (PST)
Received: from [192.168.1.70] (125.62.71.86.rev.sfr.net. [86.71.62.125])
        by smtp.gmail.com with ESMTPSA id m30-20020a50d7de000000b004c13fe8fabfsm5355664edj.84.2023.03.06.08.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 08:41:39 -0800 (PST)
Message-ID: <7ade5f76-426c-297c-2809-af5f67279cf9@baylibre.com>
Date:   Mon, 6 Mar 2023 17:41:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/4] mfd: tps6594: Add driver for TI TPS6594 PMIC
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        corbet@lwn.net, hdegoede@redhat.com, eric.auger@redhat.com,
        jgg@ziepe.ca, razor@blackwall.org, suma.hegde@amd.com,
        stephen@networkplumber.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eblanc@baylibre.com,
        jneanne@baylibre.com
References: <20230216114410.183489-1-jpanis@baylibre.com>
 <20230216114410.183489-3-jpanis@baylibre.com>
 <20230303150355.GQ2420672@google.com>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20230303150355.GQ2420672@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/23 16:03, Lee Jones wrote:
> On Thu, 16 Feb 2023, Julien Panis wrote:
>
>> This patch adds support for TPS6594 PMIC MFD core. It provides
>> communication through the I2C and SPI interfaces, and supports
>> protocols with embedded CRC data fields for safety applications.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> ---

(...)

>> +
>> +static int tps6594_check_crc_mode(struct tps6594 *tps, bool primary_pmic)
>> +{
>> +	int ret;
>> +
>> +	/*
>> +	 * Ensure that CRC is enabled.
>> +	 * Once CRC is enabled, it can't be disabled until next power cycle.
>> +	 */
>> +	tps->use_crc = true;
>> +	ret = regmap_test_bits(tps->regmap, TPS6594_REG_SERIAL_IF_CONFIG,
>> +			       TPS6594_BIT_I2C1_SPI_CRC_EN);
>> +	if (ret < 0) {
>> +		tps->use_crc = false;
>> +	} else if (ret == 0) {
>> +		tps->use_crc = false;
> Will this value be used again after you return an error?

No, it is not used any more. I will remove this line in v2.

>
>> +		ret = -EIO;
>> +	} else {
>> +		dev_info(tps->dev, "CRC feature enabled on %s PMIC",
>> +			 primary_pmic ? "primary" : "secondary");
>> +		ret = 0;
> I would consider reversing the logic of the if()s, default to 'false'
> then set 'true' in here before the print.

Do you speak about 'tps->use_crc' value ?
'tps->use_crc' is used in regmap read/write callbacks, so it
must be set 'true' before calling 'regmap_test_bits()' function.
In other words, CRC_EN bit must be read with 'tps->use_crc = true'.

>
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int tps6594_set_crc_feature(struct tps6594 *tps)
>> +{
>> +	int ret;
>> +
>> +	/* Force PFSM I2C_2 trigger to enable CRC on primary PMIC */
>> +	ret = regmap_write_bits(tps->regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
>> +				TPS6594_BIT_TRIGGER_I2C(2), TPS6594_BIT_TRIGGER_I2C(2));
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Wait for PFSM to process trigger */
>> +	msleep(20);
> Is this the time specified in the datasheet?

I checked with the customer after your review and the datasheet
specifies 2 ms.
The clock specification is +/-5%. The customer recommends
using 4ms, which is a simple number providing sufficient margin.
As a consequence, I will adjust this delay in v2.

>
>> +	return tps6594_check_crc_mode(tps, true);
>> +}
>> +
>> +int tps6594_device_init(struct tps6594 *tps)
>> +{
>> +	struct device *dev = tps->dev;
>> +	unsigned int prop;
> Since this only has a single use, better to rename it to something specific.
>
>> +	unsigned long timeout = msecs_to_jiffies(TPS6594_CRC_SYNC_TIMEOUT_MS);
>> +	int n_dev = ARRAY_SIZE(tps6594_cells);
>> +	int ret;
>> +
>> +	/* Keep PMIC in ACTIVE state */
>> +	ret = regmap_set_bits(tps->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
>> +			      TPS6594_BIT_NSLEEP1B | TPS6594_BIT_NSLEEP2B);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to set PMIC state\n");
>> +
>> +	/*
>> +	 * CRC mode can be used with I2C or SPI protocols.
>> +	 * If this mode is specified for primary PMIC, it will also be applied to secondary PMICs
>> +	 * through SPMI serial interface.
>> +	 * In this multi-PMIC synchronization scheme, the primary PMIC is the controller device
>> +	 * on the SPMI bus, and the secondary PMICs are the target devices on the SPMI bus.
>> +	 */
>> +	prop = of_property_read_bool(dev->of_node, "ti,use-crc");

As discussed with Krzysztof for dt-bindings, this 'ti,use-crc'
property will be removed from the device tree, in v2.
Instead, a property will be used to identify the primary PMIC.
Moreover, since using CRC applies either to all the PMICs or
to none of them, it is a global feature. That's why a driver
parameter will be added to enable CRC feature at initialization
(something like a 'enable_crc' bool).

(...)

>> diff --git a/include/linux/mfd/tps6594.h b/include/linux/mfd/tps6594.h
>> new file mode 100644
>> index 000000000000..e2ffd4dc034d
>> --- /dev/null
>> +++ b/include/linux/mfd/tps6594.h
>> @@ -0,0 +1,1018 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Functions to access TPS6594 Power Management IC
>> + *
>> + * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
>> + */
>> +
>> +#ifndef __LINUX_MFD_TPS6594_H
>> +#define __LINUX_MFD_TPS6594_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/regmap.h>
>> +
>> +struct regmap_irq_chip_data;
>> +
>> +/* Chip id list */
>> +#define TPS6594		0
>> +#define TPS6593		1
>> +#define LP8764X		2
> enum?

Yes indeed, I will fix that in v2.

(...)

Your others suggestions will also be implemented in v2.

Thank you Lee for your time and feedback.

Julien
