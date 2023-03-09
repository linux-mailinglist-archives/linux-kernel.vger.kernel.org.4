Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81386B1F5F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCIJHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCIJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:06:56 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF5A42BE1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:06:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ay14so4095129edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678352790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkirvH36bz1SSzRvgM3xusCeXYm/Qa8xDADaoiNcHak=;
        b=zdCL6wDW2/4hUtJh2Vp7MC3nXNOwXxGobiz/ByMY6Hv9XZ3buLtxaZTZAzo5R2cgIl
         PTaoJBwgGcVkgoiXek4Ay72sRZGUFjxrsGoMP6pcB5P/pgY7rpXRA1VkLI81IxWefqP1
         JJApiHk+0Seevvpi6VCVQZTzXBb0EDIZpRWLsAthSvcskX6yfpofxcoEYAf66tjwofcd
         dO0xaFAOb7ZSGcmtlMTfbQZ0Cgo/Euup+mskNSExkzMUYCFzsyFkLUQ2+cFHay93Sl1G
         8pg8yLWc5BsfHpv+ffkJinZ4BjPNm7lfiiAO1+VJhoNazjeYL0BDT7iWrE1DljWF9Ljt
         ACAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678352790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkirvH36bz1SSzRvgM3xusCeXYm/Qa8xDADaoiNcHak=;
        b=pEbOa/LbMusyMtEM+tNVwxWGaCIVfVGu3bR0clHB2UHjvy1DuQ7+skjIhgEO/rOC+I
         dLUjHGUDsBIYPrSzAUsj1zd2Ob8L1k/2wcG6/6tiOG+dJ6JHs75AoXSv9DfRTsj2YbHY
         dgfnjVitFFDXfbYQfHaNAqe/82lkY0Og5CvBCmdB2GYOVas8nvefczzoB2UT9OtKFtrQ
         MLhSCT26xAfnm/QDnaIuUn92ArW8ZDqV3B/4LtYgEBrbxWJfReizd8lE6Oz0B0ezfCwI
         w/kXoLgQeI/NZgzjD6PJAB5rP5V/6Fk72LED/LWhg5KEMZC+KGlPZqoyruJm3ZjU6Psf
         hI3g==
X-Gm-Message-State: AO0yUKVLUItjuuYBUdQrFtiVo9JnMgh9svqWhV04BMgdSQsGKfxp8sR2
        Gt1T2tFJeYJ3+l9YPRs09xnWBQ==
X-Google-Smtp-Source: AK7set+rKqiVM6Gdw8qujKTDrc/Heeyue0Z8qfKwFF4hVJQshh8PWjeUgQSn+8D8eIG+0iJ1+YG+CQ==
X-Received: by 2002:a17:907:6d08:b0:88f:9445:f8df with SMTP id sa8-20020a1709076d0800b0088f9445f8dfmr24041835ejc.21.1678352789970;
        Thu, 09 Mar 2023 01:06:29 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id n21-20020a17090625d500b00905a1abecbfsm8523339ejb.47.2023.03.09.01.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:06:29 -0800 (PST)
Message-ID: <c8dc876e-eb9b-292c-213d-b8c3348cf63a@linaro.org>
Date:   Thu, 9 Mar 2023 10:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] leds: Add support for rohm,bd65b60 led driver
Content-Language: en-US
To:     Bogdan Ionescu <bogdan.ionescu.work@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.or, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308201451.11629-1-bogdan.ionescu.work@gmail.com>
 <20230308201451.11629-2-bogdan.ionescu.work@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308201451.11629-2-bogdan.ionescu.work@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 21:14, Bogdan Ionescu wrote:
> This commit adds support for ROHM BD65B60 led driver.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> The chip supports 2 outpus sharing the same current setting
> and is controlled over I2C.
> 
> Signed-off-by: Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
> ---

Thank you for your patch. There is something to discuss/improve.

> +
> +	/* Check required properties */
> +	if (!fwnode_property_present(child, "rohm,enable-outputs")) {
> +		dev_err(dev, "No rohm,enable-outputs property found");
> +		return -ENOENT;

The property is not required by your binding, so you cannot bail here.

> +	}
> +
> +	ret = fwnode_property_read_u32(child, "rohm,enable-outputs", &led->enable);
> +	if (ret || (led->enable & LEDSEL_MASK) != led->enable) {
> +		dev_err(dev, "Failed to read rohm,enable-outputs property");

No need to check for properties twice...

> +		return ret;
> +	}
> +
> +	/* Check optional properties */
> +	led->state = BD65B60_OFF;
> +	if (!fwnode_property_present(child, "default-state")) {
> +		ret = fwnode_property_read_string(child, "default-state",
> +						(const char **)&default_state);
> +		if (ret) {
> +			dev_err(dev, "Failed to read default-state property");
> +			return ret;
> +		}
> +
> +		if (strcmp(default_state, "keep") == 0) {
> +			led->state = BD65B60_KEEP;
> +		} else if (strcmp(default_state, "on") == 0) {
> +			led->state = BD65B60_ON;
> +		} else if (strcmp(default_state, "off") == 0) {
> +			led->state = BD65B60_OFF;
> +		} else {
> +			dev_err(dev, "Invalid default-state property");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	led->ovp = BD65B60_DEFAULT_OVP_VAL;
> +	if (fwnode_property_present(child, "rohm,ovp")) {
> +		ret = fwnode_property_read_u32(child, "rohm,ovp", &led->ovp);
> +
> +		if (ret || (led->ovp & OVP_MASK) != led->ovp) {
> +			dev_err(dev, "Failed to read rohm,ovp property");
> +			return ret;
> +		}
> +	}
> +
> +	*fwnode = child;
> +
> +	return 0;
> +}
> +
> +static int bd65b60_probe(struct i2c_client *client)
> +{
> +	struct bd65b60_led *led;
> +	struct led_init_data init_data = {};
> +	struct fwnode_handle *fwnode = NULL;
> +	int ret;
> +
> +	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
> +	if (!led)
> +		return -ENOMEM;
> +
> +	led->client = client;
> +	i2c_set_clientdata(client, led);
> +
> +	ret = bd65b60_parse_dt(led, &fwnode);
> +	if (ret)
> +		return ret;
> +
> +	led->cdev.name = BD65B60_DEFAULT_NAME;
> +	led->cdev.brightness_set = bd65b60_brightness_set;
> +	led->cdev.brightness = BD65B60_DEFAULT_BRIGHTNESS;
> +	led->cdev.max_brightness = BD65B60_MAX_BRIGHTNESS;
> +	led->cdev.default_trigger = BD65B60_DEFAULT_TRIGGER;
> +	led->client = client;
> +
> +	led->regmap = devm_regmap_init_i2c(client, &bd65b60_regmap_config);
> +	if (IS_ERR(led->regmap)) {
> +		ret = PTR_ERR(led->regmap);
> +		dev_err(&client->dev, "Failed to allocate register map: %d",
> +			ret);

return dev_err_probe

> +		return ret;
> +	}
> +
> +	mutex_init(&led->lock);
> +
> +	ret = bd65b60_init(led);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to initialize led: %d", ret);

return dev_err_probe

> +		mutex_destroy(&led->lock);

or ret = dev_err_probe and goto to common cleanup part

> +		return ret;
> +	}
> +
> +	init_data.fwnode = fwnode;
> +	init_data.devicename = led->client->name;
> +	init_data.default_label = ":";
> +	ret = devm_led_classdev_register_ext(&client->dev, &led->cdev,
> +					     &init_data);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to register led: %d", ret);

return dev_err_probe

> +		mutex_destroy(&led->lock);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void bd65b60_remove(struct i2c_client *client)
> +{
> +	int ret;
> +	struct bd65b60_led *led = i2c_get_clientdata(client);
> +
> +	ret = regmap_write(led->regmap, REG_PON, BD65B60_OFF);
> +	if (ret)
> +		dev_err(&client->dev, "Failed to turn off led: %d", ret);
> +
> +	mutex_destroy(&led->lock);
> +}
> +
> +static const struct i2c_device_id bd65b60_id[] = {
> +	{ "bd65b60", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, bd65b60_id);
> +
> +static const struct of_device_id of_bd65b60_leds_match[] = {
> +	{ .compatible = "rohm,bd65b60" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_bd65b60_leds_match);
> +
> +static struct i2c_driver bd65b60_i2c_driver = {
> +	.driver = {
> +		.name = "bd65b60",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(of_bd65b60_leds_match),

Drop of_match_ptr. It requires maybe_unused which you do not have, so
this will cause warnings.

Best regards,
Krzysztof

