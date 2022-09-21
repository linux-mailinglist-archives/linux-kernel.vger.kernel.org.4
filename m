Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56805BFFB0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIUONZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIUONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:13:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E615096FC2;
        Wed, 21 Sep 2022 07:13:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e5so6068364pfl.2;
        Wed, 21 Sep 2022 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=ZmoTvVl2KA6Tp4uDgSPCd4G8WNIa+LsbjT8qSpPtGdQ=;
        b=YAp1iJlL1ZY7LO5EDkWnK1pm85aaZ19p9lRQJv1ZaMymQGfXjL2t8yv6UNKJoVQcM1
         E7SMpoJcr+3NWASE71hLvJZic9XJs70IPYzkT79M8f7vodtkiEi/oMwrASZo5I0vEU11
         eA2nr2dl68XNguo5XsvJ28+506RPLuLhMBKc3PBgkLFYriwp7lK1tVXeL3gd1vHPyUOs
         3b2bCS42CBUoJVoJKUoWHUnvU5VRMddhPU897yTJrbILHRDSGpMMe9/ci3djBxKcmP3y
         GCT1XYQSKpscdL2fCkluqfM/B7dJJNsJRAPVz3cxVVEzkAr+v4CBqsysdfngPC48+VyE
         v2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZmoTvVl2KA6Tp4uDgSPCd4G8WNIa+LsbjT8qSpPtGdQ=;
        b=Mc+nO3PY2BVl1IL0js/Z5vUqXJ/mPwDR8yH8K8GOFdCEoxJAX2Wseb20wSX11uhJfL
         2Q280xKXZloj67MGqAHjVotbjZ8/b+HlYGI4IF3sS8hngj2yQ+dS/sPN4ImQdF+8k25h
         iOYlLbZ+2iSKf7cCsIbW0SOI3r4WnpjTFKhx97tx+2IS4lBwtYgd3JBpuimQK6as126B
         gZqrskdXdLlCODdlHTEmdkpJqRAM0TD8g3CXvDHyBlZyULB/t5kznzxBj098ZlnCYQ2o
         cMCi/CHxiM40NEjTNOgErN2y0XsdKaybQPfQJ3GAOyPcA8jWzROfZubM6/bN2JyrB7e7
         AMcA==
X-Gm-Message-State: ACrzQf2fKmTwuf/TzjA5Q3G/5tOJlIhbdcCNfftQUYfTer5Y4qhyZt+v
        MV4MjrCO0r12djRUp63AFeo=
X-Google-Smtp-Source: AMsMyM7+aRjESSAAXeKM4PlBuebo/J0PeoToV9KQh2Se9oy4IksmQkM3RyrHxa3sHXmeaPdeSFztHQ==
X-Received: by 2002:a63:e113:0:b0:439:e032:c879 with SMTP id z19-20020a63e113000000b00439e032c879mr17780637pgh.287.1663769601405;
        Wed, 21 Sep 2022 07:13:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79e50000000b00537d7cc774bsm2142744pfq.139.2022.09.21.07.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 07:13:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8cb2bac1-3a03-09a1-c071-96ca4a95fa44@roeck-us.net>
Date:   Wed, 21 Sep 2022 07:13:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-10-linux@rasmusvillemoes.dk>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 9/9] rtc: isl12022: add support for temperature sensor
In-Reply-To: <20220921114624.3250848-10-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 04:46, Rasmus Villemoes wrote:
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>   drivers/rtc/rtc-isl12022.c | 104 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 104 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> index ca677c4265e6..f3efe61c81e5 100644
> --- a/drivers/rtc/rtc-isl12022.c
> +++ b/drivers/rtc/rtc-isl12022.c
> @@ -17,6 +17,7 @@
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/regmap.h>
> +#include <linux/hwmon.h>
>   
>   /* ISL register offsets */
>   #define ISL12022_REG_SC		0x00
> @@ -30,6 +31,9 @@
>   #define ISL12022_REG_SR		0x07
>   #define ISL12022_REG_INT	0x08
>   
> +#define ISL12022_REG_BETA	0x0d
> +#define ISL12022_REG_TEMP_L	0x28
> +
>   /* ISL register bits */
>   #define ISL12022_HR_MIL		(1 << 7)	/* military or 24 hour time */
>   
> @@ -38,6 +42,7 @@
>   
>   #define ISL12022_INT_WRTC	(1 << 6)
>   
> +#define ISL12022_BETA_TSE	(1 << 7)
>   
>   static struct i2c_driver isl12022_driver;
>   
> @@ -46,6 +51,103 @@ struct isl12022 {
>   	struct regmap *regmap;
>   };
>   
> +static umode_t isl12022_hwmon_is_visible(const void *data,
> +					 enum hwmon_sensor_types type,
> +					 u32 attr, int channel)
> +{
> +	if (type == hwmon_chip && attr == hwmon_chip_update_interval)
> +		return 0444;
> +
> +	if (type == hwmon_temp && attr == hwmon_temp_input)
> +		return 0444;
> +
> +	return 0;
> +}
> +
> +/*
> + * A user-initiated temperature conversion is not started by this function,
> + * so the temperature is updated once every ~60 seconds.
> + */
> +static int isl12022_hwmon_read_temp(struct device *dev, long *mC)
> +{
> +	struct isl12022 *isl12022 = dev_get_drvdata(dev);
> +	struct regmap *regmap = isl12022->regmap;
> +	u8 temp_buf[2];
> +	int temp, ret;
> +
> +	ret = regmap_bulk_read(regmap, ISL12022_REG_TEMP_L,
> +			       temp_buf, sizeof(temp_buf));
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Temperature is represented as a 10-bit number, unit half-Kelvins.
> +	 */
> +	temp = (temp_buf[1] << 8) | temp_buf[0];
> +	temp *= 500;
> +	temp -= 273000;
> +
> +	*mC = temp;
> +
> +	return 0;
> +}
> +
> +static int isl12022_hwmon_read(struct device *dev,
> +			       enum hwmon_sensor_types type,
> +			       u32 attr, int channel, long *val)
> +{
> +	if (type == hwmon_chip && attr == hwmon_chip_update_interval) {
> +		*val = 60000;
> +		return 0;
> +	}

It is not the purpose of the update_interval attribute to inform the
user what the update interval of this chip happens to be. The purpose
of the attribute is to inform the chip what update interval it should use.

 From the documentation:
	Some devices have a variable update rate or interval.
	This attribute can be used to change it to the desired value.

The patch is not in the hwmon subsystem, to it is up to the maintainers
to decide if they want to accept the patch anyway. Please don't expect
a reviewed tag, though.

> +
> +	if (type == hwmon_temp && attr == hwmon_temp_input) {
> +		return isl12022_hwmon_read_temp(dev, val);
> +	}

Nit: { } is unnecessary.

Guenter

> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_channel_info *isl12022_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops isl12022_hwmon_ops = {
> +	.is_visible = isl12022_hwmon_is_visible,
> +	.read = isl12022_hwmon_read,
> +};
> +
> +static const struct hwmon_chip_info isl12022_hwmon_chip_info = {
> +	.ops = &isl12022_hwmon_ops,
> +	.info = isl12022_hwmon_info,
> +};
> +
> +static void isl12022_hwmon_register(struct device *dev)
> +{
> +	struct isl12022 *isl12022;
> +	struct device *hwmon;
> +	int ret;
> +
> +	if (!IS_REACHABLE(CONFIG_HWMON))
> +		return;
> +
> +	isl12022 = dev_get_drvdata(dev);
> +
> +	ret = regmap_update_bits(isl12022->regmap, ISL12022_REG_BETA,
> +				 ISL12022_BETA_TSE, ISL12022_BETA_TSE);
> +	if (ret) {
> +		dev_warn(dev, "unable to enable temperature sensor\n");
> +		return;
> +	}
> +
> +	hwmon = devm_hwmon_device_register_with_info(dev, "isl12022", isl12022,
> +						     &isl12022_hwmon_chip_info,
> +						     NULL);
> +	if (IS_ERR(hwmon))
> +		dev_warn(dev, "unable to register hwmon device: %pe\n", hwmon);
> +}
> +
>   /*
>    * In the routines that deal directly with the isl12022 hardware, we use
>    * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
> @@ -160,6 +262,8 @@ static int isl12022_probe(struct i2c_client *client)
>   		return PTR_ERR(isl12022->regmap);
>   	}
>   
> +	isl12022_hwmon_register(&client->dev);
> +
>   	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
>   	if (IS_ERR(isl12022->rtc))
>   		return PTR_ERR(isl12022->rtc);

