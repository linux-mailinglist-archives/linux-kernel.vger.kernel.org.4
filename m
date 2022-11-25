Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7263851C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKYITo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiKYITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:19:42 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3131FCC5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:19:41 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id t10so4374661ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5fF1VG6bE4h78zSF6XpcpCWR5JSIWlcaFzzUnV+oZc=;
        b=FPOq5FPNpVG9WdzonGxtVs1JzT5VuL40N5uRF6qExEsqmXeYENs2NRm36F/tUpL53D
         +pwk5IP9Ugtaa2jKiOsbqdpOMf3miCSWZF02mhfv8V9rb1t6qahMepYHlDaOc4OZ+uFf
         5rXJw16V4y6TjPI9g+9HU6H8Gh3jjl5gU8Q6DxrWTi24MlHz2HB2XPAM5nzDUsgh9+10
         J07/urTxyiSCZoPtJEpDMtfB05E8CKy1EwUHEveK0rsC3JQw+akV5RRdLBmjq4yCwoGc
         skKiRyBicZc6vGTYlBL6TeZJK1TtcShSY985ip59E3zVeCYRUVCiIZTd2gsSy/5VBDPJ
         zwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5fF1VG6bE4h78zSF6XpcpCWR5JSIWlcaFzzUnV+oZc=;
        b=P6JMEeMDDoOnkL0WrZIWl+sEqP9hHGfUp1EUZTq6u70D2LADiCTzam6afAw4k0gEXM
         rYs5QBCL4jDoRYe1M2XbZ+y5C7Cx7lx1udnJkEFQHiv5221qTKcW+iGzo8a/hZE7EeyS
         o0FSQ63wEr+7ttRh8cTBOXyowhzFsdZVtYnzJqSH+T94CjcLaY+dlXJSlrQzK37W8drb
         pfFN70OHMKp5T25KCS7ONvf9Z/a9jKc2uPg6hoEVHvr2Yj7sv89akSLNHu6RJdtonY1Q
         PAaWa5tcPXyQOkc3a2mv5pytAS2P/mCopJA1KhRR8Eo8xtTeZuSqspJXKhwXl7EQkR8s
         iFCg==
X-Gm-Message-State: ANoB5pl+2vGPQ/0osrGQ+JV777lEHZHTFyr+5rAiFwd9kDQtORAFLCzo
        X+V7UCQxEeXhsH1LKSQEw6wqOg==
X-Google-Smtp-Source: AA0mqf43cUIMS54O34Vhq9pPU/mS4mUl+E6LeZcrmUrIdo4O0OPsnuG7pJiWnKrQehDWZ30Iy/YrqQ==
X-Received: by 2002:a2e:990b:0:b0:277:5a8:91c8 with SMTP id v11-20020a2e990b000000b0027705a891c8mr10818289lji.173.1669364379663;
        Fri, 25 Nov 2022 00:19:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v22-20020a05651203b600b00492c663bba2sm438847lfp.124.2022.11.25.00.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:19:39 -0800 (PST)
Message-ID: <ba4918dd-309c-5e6e-dc0a-eb5f1c4b1dfa@linaro.org>
Date:   Fri, 25 Nov 2022 09:19:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 2/2] leds: add aw20xx driver
Content-Language: en-US
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel@sberdevices.ru
References: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
 <20221124204807.1593241-3-mmkurbanov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124204807.1593241-3-mmkurbanov@sberdevices.ru>
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

On 24/11/2022 21:48, Martin Kurbanov wrote:
> This commit adds support for AWINIC AW20036/AW20054/AW20072 LED driver.
> This driver supports following AW200XX features:
>   - 3 pattern controllers for auto breathing or group dimming control
>   - Individual 64-level DIM currents
>   - Interrupt output, low active
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>  Documentation/leds/leds-aw200xx.rst |  274 +++++++
>  drivers/leds/Kconfig                |   10 +
>  drivers/leds/Makefile               |    1 +
>  drivers/leds/leds-aw200xx.c         | 1113 +++++++++++++++++++++++++++
>  4 files changed, 1398 insertions(+)
>  create mode 100644 Documentation/leds/leds-aw200xx.rst
>  create mode 100644 drivers/leds/leds-aw200xx.c
> 
> diff --git a/Documentation/leds/leds-aw200xx.rst b/Documentation/leds/leds-aw200xx.rst
> new file mode 100644
> index 000000000000..a751b91dfda6
> --- /dev/null
> +++ b/Documentation/leds/leds-aw200xx.rst
> @@ -0,0 +1,274 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================================
> +Kernel driver for AW20036/AW20054/AW20072
> +=========================================
> +
> +Description
> +-----------
> +
> +The AW20036/AW20054/AW20072 is a 3x12/6x9/6x12 matrix LED driver programmed via
> +an I2C interface. The brightness of each LED is independently controlled by
> +FADE and DIM parameter.
> +
> +Three integrated pattern controllers provide auto breathing or group dimming
> +control. Each pattern controller can work in auto breathing or manual control
> +mode. All breathing parameters including rising/falling slope, on/off time,
> +repeat times, min/max brightness and so on are configurable.
> +
> +Device attribute
> +-----------------------------------
> +
> +**/sys/class/leds/<led>/dim** - 64-level DIM current. If write negative value
> +or "auto", the dim will be calculated according to the brightness.
> +
> +The configuration files for each pattern are located::
> +
> +    /sys/bus/i2c/devices/xxxx/pattern0/
> +    /sys/bus/i2c/devices/xxxx/pattern1/
> +    /sys/bus/i2c/devices/xxxx/pattern2/
> +
> +Directory layout example for pattern
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +    $ ls -l /sys/bus/i2c/devices/xxxx/pattern0/
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 clear_leds
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 fall_time
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 loop_begin
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 loop_end_on
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 max_breathing_level
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 min_breathing_level
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 mode
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 off_time
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 on_time
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 ramp
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 repeat
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 rise_time
> +    -r--r--r--    1 root     root          4096 Jan  1 00:00 running
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 select_leds
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 start
> +    -rw-r--r--    1 root     root          4096 Jan  1 00:00 toggle

sysfs documentation goes to Documentation/ABI/


(...)

> +static int aw200xx_probe(struct i2c_client *client)
> +{
> +	const struct aw200xx_chipdef *cdef;
> +	struct aw200xx *chip;
> +	int count;
> +	int ret;
> +
> +	cdef = device_get_match_data(&client->dev);
> +
> +	count = device_get_child_node_count(&client->dev);
> +	if (!count || count > cdef->channels)
> +		return dev_err_probe(&client->dev, -EINVAL,
> +				     "Incorrect number of leds (%d)", count);
> +
> +	chip = devm_kzalloc(&client->dev,
> +			    struct_size(chip, leds, count),

sizeof(*chip)

> +			    GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->cdef = cdef;
> +	chip->num_leds = count;
> +	chip->client = client;
> +	i2c_set_clientdata(client, chip);
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &aw200xx_regmap_config);
> +	if (IS_ERR(chip->regmap))
> +		return PTR_ERR(chip->regmap);
> +
> +	ret = aw200xx_chip_check(chip);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&chip->mutex);
> +
> +	/* Need a lock now since after call aw200xx_probe_dt, created sysfs nodes */
> +	mutex_lock(&chip->mutex);
> +
> +	ret = aw200xx_probe_dt(&client->dev, chip);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = aw200xx_chip_reset(chip);
> +	if (ret)
> +		goto exit;
> +
> +	ret = aw200xx_chip_init(chip);
> +	if (ret)
> +		goto exit;
> +
> +	ret = aw200xx_setup_interrupts(chip);
> +
> +exit:
> +	mutex_unlock(&chip->mutex);
> +	return ret;
> +}
> +
> +static void aw200xx_remove(struct i2c_client *client)
> +{
> +	struct aw200xx *chip = i2c_get_clientdata(client);
> +
> +	aw200xx_chip_reset(chip);
> +	mutex_destroy(&chip->mutex);
> +}
> +
> +static const struct aw200xx_chipdef aw20036_cdef = {
> +	.channels = 36,
> +	.display_size_max = 2,
> +	.display_size_columns = 12,
> +};
> +
> +static const struct aw200xx_chipdef aw20054_cdef = {
> +	.channels = 54,
> +	.display_size_max = 5,
> +	.display_size_columns = 9,
> +};
> +
> +static const struct aw200xx_chipdef aw20072_cdef = {
> +	.channels = 72,
> +	.display_size_max = 5,
> +	.display_size_columns = 12,
> +};
> +
> +static const struct i2c_device_id aw200xx_id[] = {
> +	{ "aw20036" },
> +	{ "aw20054" },
> +	{ "aw20072" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, aw200xx_id);
> +
> +static const struct of_device_id aw200xx_match_table[] = {
> +	{ .compatible = "awinic,aw20036", .data = &aw20036_cdef, },
> +	{ .compatible = "awinic,aw20054", .data = &aw20054_cdef, },
> +	{ .compatible = "awinic,aw20072", .data = &aw20072_cdef, },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, aw200xx_match_table);
> +
> +static struct i2c_driver aw200xx_driver = {
> +	.driver = {
> +		.name = "aw200xx",
> +		.of_match_table = of_match_ptr(aw200xx_match_table),

You will have warning now. of_match_ptr goes with __maybe_unused. Drop it.

> +		.dev_groups = aw200xx_pattern_groups,
> +	},
> +	.probe_new = aw200xx_probe,
> +	.remove = aw200xx_remove,
> +	.id_table = aw200xx_id,
> +};
> +
> +module_i2c_driver(aw200xx_driver);
> +
> +MODULE_AUTHOR("Martin Kurbanov <mmkurbanov@sberdevices.ru>");
> +MODULE_DESCRIPTION("AW200XX LED driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:leds-aw200xx");

Best regards,
Krzysztof

