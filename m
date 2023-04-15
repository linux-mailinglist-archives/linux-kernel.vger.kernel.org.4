Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7875E6E3032
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDOJzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 05:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjDOJzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:55:48 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD903AAD
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:55:45 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ncd8pZfQEjYHDncd8piXZK; Sat, 15 Apr 2023 11:55:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681552543;
        bh=NKO9tNR3io9sjTd2FMDA22juGbn6zJdEpFITJU0OXnE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fuIBdC4W9dJfZbELlJg8VLuvFZwdjcUzcdP+QN2Ol20VNRpbOKTuyUyXeZe5gZk4q
         oyQwgrHpDUksAZ4ugYxrpzJ2KMqymulRBb1+yRwY3SjBGFqbIe1CYZ4WkPbpbIN9TC
         LZtRwygA06l0FdNialP6jW8rVYv+qlBmNKznwNcrhlf3CsoJiJN1PmcjFLgLkX4VRT
         AYTrJATbA9J07p1fbvb2KRzLjnwivcX7Z3q2zyVfLT6B5m935k+ojbF4I2cEzXE3Jz
         +7L7qSTsi7cmSm7sML8CllAvr92KN240WKJqiio7cR+lNGxP4VgwugE+uwAy3wl7qU
         3qXXRtgqPuKxA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 15 Apr 2023 11:55:43 +0200
X-ME-IP: 86.243.2.178
Message-ID: <607cb8bf-4484-b213-0f55-bfa1793144ba@wanadoo.fr>
Date:   Sat, 15 Apr 2023 11:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/5] Input: add driver for Focaltech FTS touchscreen
Content-Language: fr
To:     joelselvaraj.oss@gmail.com
Cc:     agross@kernel.org, alistair@alistair23.me, andersson@kernel.org,
        arnd@arndb.de, caleb@connolly.tech, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, hdegoede@redhat.com, jdelvare@suse.de,
        jeff@labundy.com, job@noorman.info, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        macromorgan@hotmail.com, markuss.broks@gmail.com,
        max.krummenacher@toradex.com, mripard@kernel.org,
        phone-devel@vger.kernel.org, robert.jarzmik@free.fr,
        robh+dt@kernel.org, rydberg@bitmath.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
 <20230415020222.216232-3-joelselvaraj.oss@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230415020222.216232-3-joelselvaraj.oss@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/04/2023 à 04:02, Joel Selvaraj a écrit :
> The Focaltech FTS driver supports several variants of focaltech
> touchscreens found in ~2018 era smartphones including variants found on
> the PocoPhone F1 and the SHIFT6mq which are already present in mainline.
> This driver is loosely based on the original driver from Focaltech
> but has been simplified and largely reworked.
> 
> Co-developed-by: Caleb Connolly <caleb-u60PMpPBjd35c1cvEZuMuQ@public.gmane.org>
> Signed-off-by: Caleb Connolly <caleb-u60PMpPBjd35c1cvEZuMuQ@public.gmane.org>
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   MAINTAINERS                                   |   8 +
>   drivers/input/touchscreen/Kconfig             |  12 +
>   drivers/input/touchscreen/Makefile            |   1 +
>   drivers/input/touchscreen/focaltech_fts5452.c | 432 ++++++++++++++++++
>   4 files changed, 453 insertions(+)
>   create mode 100644 drivers/input/touchscreen/focaltech_fts5452.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ec4ce64f66d..1a3ea61e1f52 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8028,6 +8028,14 @@ L:	linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>   S:	Maintained
>   F:	drivers/input/joystick/fsia6b.c
>   
> +FOCALTECH FTS5452 TOUCHSCREEN DRIVER
> +M:	Joel Selvaraj <joelselvaraj.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> +M:	Caleb Connolly <caleb-u60PMpPBjd35c1cvEZuMuQ@public.gmane.org>
> +L:	linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
> +F:	drivers/input/touchscreen/focaltech_fts5452.c
> +
>   FOCUSRITE SCARLETT GEN 2/3 MIXER DRIVER
>   M:	Geoffrey D. Bennett <g@b4.vu>
>   L:	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org (moderated for non-subscribers)
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 1feecd7ed3cb..11af91504969 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -388,6 +388,18 @@ config TOUCHSCREEN_EXC3000
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called exc3000.
>   
> +config TOUCHSCREEN_FOCALTECH_FTS5452
> +	tristate "Focaltech FTS Touchscreen"
> +	depends on I2C
> +	help
> +	  Say Y here to enable support for I2C connected Focaltech FTS
> +	  based touch panels, including the 5452 and 8917 panels.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called focaltech_fts.
focaltech_fts5452?
Or should modifications be done elsewhere so that is does not look too 
5452 specific?

> +
>   config TOUCHSCREEN_FUJITSU
>   	tristate "Fujitsu serial touchscreen"
>   	select SERIO

[...]

> +struct fts_i2c_chip_data {
> +	int max_touch_points;
> +};
> +
> +int fts_check_status(struct fts_ts_data *data)
> +{
> +	int error, i = 0, count = 0;

No need to init "i".

> +	unsigned int val, id;
> +
> +	do {
> +		error = regmap_read(data->regmap, FTS_REG_CHIP_ID_L, &id);
> +		if (error)
> +			dev_err(&data->client->dev, "I2C read failed: %d\n", error);
> +
> +		error = regmap_read(data->regmap, FTS_REG_CHIP_ID_H, &val);
> +		if (error)
> +			dev_err(&data->client->dev, "I2C read failed: %d\n", error);
> +
> +		id |= val << 8;
> +
> +		for (i = 0; i < ARRAY_SIZE(fts_chip_types); i++)
> +			if (id == fts_chip_types[i])
> +				return 0;
> +
> +		count++;
> +		msleep(FTS_INTERVAL_READ_REG_MS);
> +	} while ((count * FTS_INTERVAL_READ_REG_MS) < FTS_TIMEOUT_READ_REG_MS);
> +
> +	return -EIO;
> +}
> +
> +static int fts_report_touch(struct fts_ts_data *data)
> +{
> +	struct input_dev *input_dev = data->input_dev;
> +	int base;
> +	unsigned int x, y, z, maj;
> +	u8 slot, type;
> +	int error, i = 0;

No need to init "i".

> +
> +	u8 *buf = data->point_buf;
> +
> +	memset(buf, 0, data->point_buf_size);
> +
> +	error = regmap_bulk_read(data->regmap, 0, buf, data->point_buf_size);
> +	if (error) {
> +		dev_err(&data->client->dev, "I2C read failed: %d\n", error);
> +		return error;
> +	}
> +
> +	for (i = 0; i < data->max_touch_points; i++) {
> +		base = FTS_ONE_TOUCH_LEN * i;

[...]

> +static int fts_ts_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	const struct fts_i2c_chip_data *chip_data;
> +	struct fts_ts_data *data;
> +	int error = 0;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev, "I2C not supported");
> +		return -ENODEV;
> +	}
> +
> +	if (!client->irq) {
> +		dev_err(&client->dev, "No irq specified\n");
> +		return -EINVAL;
> +	}
> +
> +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	chip_data = device_get_match_data(&client->dev);
> +	if (!chip_data)
> +		chip_data = (const struct fts_i2c_chip_data *)id->driver_data;
> +	if (!chip_data || !chip_data->max_touch_points) {
> +		dev_err(&client->dev, "invalid or missing chip data\n");
> +		return -EINVAL;
> +	}
> +	if (chip_data->max_touch_points > FTS_MAX_POINTS_SUPPORT) {
> +		dev_err(&client->dev,
> +			"invalid chip data, max_touch_points should be less than or equal to %d\n",
> +			FTS_MAX_POINTS_SUPPORT);
> +		return -EINVAL;
> +	}
> +	data->max_touch_points = chip_data->max_touch_points;
> +
> +	data->client = client;
> +	i2c_set_clientdata(client, data);
> +
> +	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->reset_gpio)) {
> +		error = PTR_ERR(data->reset_gpio);
> +		dev_err(&client->dev, "Failed to request reset gpio, error %d\n", error);
> +		return error;
> +	}
> +
> +	data->regmap = devm_regmap_init_i2c(client, &fts_ts_i2c_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		error = PTR_ERR(data->regmap);
> +		dev_err(&client->dev, "regmap allocation failed, error %d\n", error);
> +		return error;
> +	}
> +
> +	/*
> +	 * AVDD is the analog voltage supply (2.6V to 3.3V)
> +	 * VDDIO is the digital voltage supply (1.8V)
> +	 */
> +	data->regulators[0].supply = "avdd";
> +	data->regulators[1].supply = "vddio";
> +	error = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->regulators),
> +					data->regulators);
> +	if (error) {
> +		dev_err(&client->dev, "Failed to get regulators %d\n", error);
> +		return error;
> +	}
> +
> +	error = devm_add_action_or_reset(&client->dev, fts_power_off, data);
> +	if (error) {
> +		dev_err(&client->dev, "failed to install power off handler\n");
> +		return error;
> +	}

Is it really needed?
This could lead to disable something that is not enabled. This looks 
harmless, but I wonder if it can occur?

I don't know the pm and input_dev frameworks enough to figure it myself, 
so this question is just about curiousity.

CJ

> +
> +	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					  fts_ts_interrupt, IRQF_ONESHOT,
> +					  client->name, data);
> +	if (error) {
> +		dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
> +		return error;
> +	}
> +
> +	error = fts_input_init(data);
> +	if (error)
> +		return error;
> +
> +	return 0;
> +}
[...]
