Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5B60E3A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiJZOqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiJZOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:46:17 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F08F954;
        Wed, 26 Oct 2022 07:46:16 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s206so5409384oie.3;
        Wed, 26 Oct 2022 07:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=640dLyMUCMjIlKunzEVy4WNaqFwkLIguCYAfhGHE+AE=;
        b=AVHqEVKxSyBPceT01vuHPGkTjNXI68esBbeZ1bY6be+5xvhCzivCbkclZETbQde/Hh
         yYvc8D8bBS/ktZMAFeCcOOnqBWFjTQB5ml8Q7DsVIeL1NCDTNndstQZ4LrZ1PjgmvCuP
         pAh7QBgKMYDbBkUK4+IJsh5EYKhL3ylTllqIISkEPbPmcaSGnYcJ56c89M+kGiMcdbNj
         LuZ0avqUiEj5rdcLRKGyh7XS0NGmVCmE4Nws1OBHNexi3hFHYK7cEsqQBhqCoBFpfAuR
         +gfjrDn9jYlfGp30Kzg7WhRrlUWpBU3PHFEr3YiGjCHdtTwWEHtOwQfNNolGrlb8X8AN
         89fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=640dLyMUCMjIlKunzEVy4WNaqFwkLIguCYAfhGHE+AE=;
        b=AAX2sTe3Z8ikubhd8VGauN6YncxiDk8hZzfYiwACohNrQ/VInk0sz6HrXY1mJwbdtf
         h2BSijSp8v2udKD3tVy1ESFASoWypIrKtAogg0Hr87lJdLPgWtL3rYHXEQBp/pFptpnu
         kIzsgGzrq+FDuiUj4GsZs9ci2M5hRmiGF7WjogzIxras7EwrW0uB05cJk9LVuHf2MPVa
         edojHyhsG+s/LZR4xbaJ5pvHJsVHhShn0V/GltdktxC4R6UINetoI/LoJnMRWmwwamDa
         j6ydvtdTQC36jGsXg9rLQONGnJqRZVSTt5uAqCP4anTtug91GlMRFACi6FW77D1WH890
         oGCA==
X-Gm-Message-State: ACrzQf3pz59gHe3bnxadnFjLkbgGrzIdXuwc1nEo76skZ1yc6fyrLC2Q
        K47Q3fM9Hg0r4RWwWI2nzeQ=
X-Google-Smtp-Source: AMsMyM7QS/EkPZbY3lAXH44G43Ssys1duk6sOh+Z4FTn4VnqRdYgZgK6FbZALfETkVwAzzakyigrpQ==
X-Received: by 2002:a05:6808:6c3:b0:351:45ae:7b with SMTP id m3-20020a05680806c300b0035145ae007bmr2113093oih.28.1666795575311;
        Wed, 26 Oct 2022 07:46:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v6-20020a4a5a06000000b00480dccc0c2asm2262697ooa.14.2022.10.26.07.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:46:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4f1a17fa-596e-eaf5-2dad-790b1ab95dc1@roeck-us.net>
Date:   Wed, 26 Oct 2022 07:46:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 9/9] rtc: isl12022: add support for temperature sensor
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20220921114624.3250848-10-linux@rasmusvillemoes.dk>
 <20221026133847.1193422-1-linux@rasmusvillemoes.dk>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221026133847.1193422-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 06:38, Rasmus Villemoes wrote:
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

There should be some description above. Other than that,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

 > ---
> v3: drop 0444 update_interval property.
> 
> v2 of patches 1-8 are already upstream (b1a1baa657c7 and parents).
> 
>   drivers/rtc/rtc-isl12022.c | 94 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> index ca677c4265e6..a3b0de3393f5 100644
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
> @@ -46,6 +51,93 @@ struct isl12022 {
>   	struct regmap *regmap;
>   };
>   
> +static umode_t isl12022_hwmon_is_visible(const void *data,
> +					 enum hwmon_sensor_types type,
> +					 u32 attr, int channel)
> +{
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
> +	if (type == hwmon_temp && attr == hwmon_temp_input)
> +		return isl12022_hwmon_read_temp(dev, val);
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_channel_info *isl12022_hwmon_info[] = {
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
> @@ -160,6 +252,8 @@ static int isl12022_probe(struct i2c_client *client)
>   		return PTR_ERR(isl12022->regmap);
>   	}
>   
> +	isl12022_hwmon_register(&client->dev);
> +
>   	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
>   	if (IS_ERR(isl12022->rtc))
>   		return PTR_ERR(isl12022->rtc);

