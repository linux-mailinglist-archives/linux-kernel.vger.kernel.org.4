Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF1D605481
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 02:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiJTAbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 20:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJTAbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 20:31:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1A112501B;
        Wed, 19 Oct 2022 17:31:08 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h8so24273588lja.11;
        Wed, 19 Oct 2022 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94WcgxukPF6gv4pDOFyGQ6vmA1VsSrDLSZYCmZeRwZE=;
        b=hMMng2873LOYHjPWBufkIHKX2xniBXhoodFpR4Sy2b1L3b0XWVrhBq2M6NFvemrTvv
         u/6dzXIZevldyktqipZDxPF0Fa/gwVTrivhfjhHfSMYPV5qzth6pUhxtOe0A8wdNPbjH
         D2chnySbz8ate2IMB4CRoq33aD9Jfl5gQuEG8xamr1MyCFua9wcBnnyTJiptaGDdp05p
         R5UyNPyQCCWweEAjNBUahSfzifedFBpC0ZlZ3NuTXy2GDZIybPMLuaPXky/cRt/hjffi
         cPLc2BC9IJ452XEKMS4n7QXnAq5nKM43z/gTMFwIRA9R3yxjjD+lY0ZgL3P03IaWgsxY
         dr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=94WcgxukPF6gv4pDOFyGQ6vmA1VsSrDLSZYCmZeRwZE=;
        b=H8ksVVTD8qzfIDkceZQmiH792JQOpSVR0jsMrIB+ME8A3+JbKelVmIY+cmUlY4mRxw
         /TM2SMEHgpwjMsr+Vh2IcBYrKL4EZIW/qvw25OnDDqE8UNc1RUlNHdK6aZ7D05v0ZFsn
         hnKBr7U6UIByrVqaZSgBTaXy43NOhNPmXzhVZG0I+G/1l1a4RT0M+GsvqE4vh+UgzAfN
         aculFWOOyv+ch54I2ypMGVYMIUgzl6slHtux9JH+kKulselB2YeTKGhrC8dTMT7+1eis
         7aX9Y7oRIW8Dt0wNqDb71iOLbLLWfE/Bl2ZjJ9OAWsW5QZU1L6A2Yyg1ZWcqlbmg3hxv
         sg3A==
X-Gm-Message-State: ACrzQf0Wc8x+CGZOXBgjL15sowKA8uKAhRrybb8uJ993lxRwoRHV6+sk
        A+P1rH0Qp9evheou8s8k6XQ=
X-Google-Smtp-Source: AMsMyM69j2GE8wVFWhJF4YgJtyaMWeBwu1z6rDhGxdfcgUUUt9VDRqT/gfGlxvJuJuVx5qSO94ugGw==
X-Received: by 2002:a05:651c:242:b0:26d:fb4b:9c8 with SMTP id x2-20020a05651c024200b0026dfb4b09c8mr3836993ljn.353.1666225866785;
        Wed, 19 Oct 2022 17:31:06 -0700 (PDT)
Received: from razdolb (95-31-187-187.broadband.corbina.ru. [95.31.187.187])
        by smtp.gmail.com with ESMTPSA id q9-20020a19a409000000b00498f871f33fsm2503088lfc.86.2022.10.19.17.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 17:31:06 -0700 (PDT)
References: <20220927222152.132951-1-mike.rudenko@gmail.com>
 <20220927222152.132951-3-mike.rudenko@gmail.com>
 <15ebc256-1855-7720-05e1-6673b1da7d93@wanadoo.fr>
User-agent: mu4e 1.9.0; emacs 28.2
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arec.kao@intel.com, c.hemp@phytec.de,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        hverkuil@xs4all.nl, jimmy.su@intel.com,
        krzysztof.kozlowski+dt@linaro.org,
        laurent.pinchart+renesas@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        marex@denx.de, mchehab@kernel.org, rdunlap@infradead.org,
        robh+dt@kernel.org, sakari.ailus@linux.intel.com,
        shawnx.tu@intel.com, tommaso.merciai@amarulasolutions.com
Subject: Re: [PATCH v3 2/2] media: i2c: add support for OV4689
Date:   Thu, 20 Oct 2022 03:22:59 +0300
In-reply-to: <15ebc256-1855-7720-05e1-6673b1da7d93@wanadoo.fr>
Message-ID: <87fsfjz67r.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Christophe,

Thanks for the review! See my comments below.

On 2022-10-18 at 20:55 +02, Christophe JAILLET <christophe.jaillet@wanadoo.=
fr> wrote:

> Le 28/09/2022 =C3=A0 00:21, Mikhail Rudenko a =C3=A9crit=C2=A0:
>> Add a V4L2 sub-device driver for OmniVision OV4689 image sensor. This
>> is a 4 Mpx image sensor using the I2C bus for control and the CSI-2
>> bus for data.
>> This driver supports following features:
>> - manual exposure and analog gain control support
>> - test pattern support
>> - media controller support
>> - runtime PM support
>> - support following resolutions:
>>    + 2688x1520 at 30 fps
>> The driver provides all mandatory V4L2 controls for compatibility
>> with
>> libcamera. The sensor supports 1/2/4-lane CSI-2 modes, but the driver
>> implements 4 lane mode only at this moment.
>
> Hi,
>
> a few nitpick below.
>
> CJ
>
>> Signed-off-by: Mikhail Rudenko
>> <mike.rudenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>
> [...]
>
>> +static int ov4689_check_sensor_id(struct ov4689 *ov4689,
>> +				  struct i2c_client *client)
>> +{
>> +	struct device *dev =3D &ov4689->client->dev;
>> +	u32 id =3D 0;
>> +	int ret;
>> +
>> +	ret =3D ov4689_read_reg(client, OV4689_REG_CHIP_ID,
>> +			      OV4689_REG_VALUE_16BIT, &id);
>> +	if (id !=3D CHIP_ID) {
>> +		dev_err(dev, "Unexpected sensor id(%06x), ret(%d)\n", id, ret);
>> +		return -ENODEV;
>
> return ret?
> (otherwise what is the point of -EINVAL and -EIO in ov4689_read_reg()?)
>

Maybe we should reserve -ENODEV for the case when
ret=3D=3D0 && id !=3D CHIP_ID and return ret otherwise?
What do you think about it?

>> +	}
>> +
>> +	dev_info(dev, "Detected OV%06x sensor\n", CHIP_ID);
>> +
>> +	return 0;
>> +}
>
> [...]
>
>> +static int ov4689_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev =3D &client->dev;
>> +	struct v4l2_subdev *sd;
>> +	struct ov4689 *ov4689;
>> +	int ret;
>> +
>> +	ret =3D ov4689_check_hwcfg(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ov4689 =3D devm_kzalloc(dev, sizeof(*ov4689), GFP_KERNEL);
>> +	if (!ov4689)
>> +		return -ENOMEM;
>> +
>> +	ov4689->client =3D client;
>> +	ov4689->cur_mode =3D &supported_modes[OV4689_MODE_2688_1520];
>> +
>> +	ov4689->xvclk =3D devm_clk_get_optional(dev, NULL);
>> +	if (IS_ERR(ov4689->xvclk)) {
>> +		return dev_err_probe(dev, PTR_ERR(ov4689->xvclk),
>> +				     "Failed to get external clock\n");
>> +	}
>> +
>> +	if (!ov4689->xvclk) {
>> +		dev_dbg(dev,
>> +			"No clock provided, using clock-frequency property\n");
>> +		device_property_read_u32(dev, "clock-frequency", &ov4689->clock_rate);
>> +	} else {
>> +		ov4689->clock_rate =3D clk_get_rate(ov4689->xvclk);
>> +	}
>> +
>> +	if (ov4689->clock_rate !=3D OV4689_XVCLK_FREQ) {
>> +		dev_err(dev,
>> +			"External clock rate mismatch: got %d Hz, expected %d Hz\n",
>> +			ov4689->clock_rate, OV4689_XVCLK_FREQ);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ov4689->reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
>> +						     GPIOD_OUT_LOW);
>> +	if (IS_ERR(ov4689->reset_gpio)) {
>> +		dev_err(dev, "Failed to get reset-gpios\n");
>> +		return PTR_ERR(ov4689->reset_gpio);
>> +	}
>> +
>> +	ov4689->pwdn_gpio =3D devm_gpiod_get_optional(dev, "pwdn", GPIOD_OUT_L=
OW);
>> +	if (IS_ERR(ov4689->pwdn_gpio)) {
>> +		dev_err(dev, "Failed to get pwdn-gpios\n");
>> +		return PTR_ERR(ov4689->pwdn_gpio);
>> +	}
>> +
>> +	ret =3D ov4689_configure_regulators(ov4689);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to get power regulators\n");
>
> dev_err_probe()?
> I think that devm_regulator_bulk_get() can return -EPROBE_DEFER)
>

Nice catch, will fix in v4.

>> +		return ret;
>> +	}
>> +
>> +	mutex_init(&ov4689->mutex);
>> +
>> +	sd =3D &ov4689->subdev;
>> +	v4l2_i2c_subdev_init(sd, client, &ov4689_subdev_ops);
>> +	ret =3D ov4689_initialize_controls(ov4689);
>> +	if (ret)
>> +		goto err_destroy_mutex;
>> +
>> +	ret =3D ov4689_power_on(dev);
>> +	if (ret)
>> +		goto err_free_handler;
>> +
>> +	ret =3D ov4689_check_sensor_id(ov4689, client);
>> +	if (ret)
>> +		goto err_power_off;
>> +
>> +#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
>> +	sd->internal_ops =3D &ov4689_internal_ops;
>> +	sd->flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE;
>> +#endif
>> +#if defined(CONFIG_MEDIA_CONTROLLER)
>> +	ov4689->pad.flags =3D MEDIA_PAD_FL_SOURCE;
>> +	sd->entity.function =3D MEDIA_ENT_F_CAM_SENSOR;
>> +	ret =3D media_entity_pads_init(&sd->entity, 1, &ov4689->pad);
>> +	if (ret < 0)
>> +		goto err_power_off;
>> +#endif
>> +
>> +	ret =3D v4l2_async_register_subdev_sensor(sd);
>> +	if (ret) {
>> +		dev_err(dev, "v4l2 async register subdev failed\n");
>> +		goto err_clean_entity;
>> +	}
>> +
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +	pm_runtime_idle(dev);
>> +
>> +	return 0;
>> +
>> +err_clean_entity:
>> +	media_entity_cleanup(&sd->entity);
>> +err_power_off:
>> +	ov4689_power_off(dev);
>> +err_free_handler:
>> +	v4l2_ctrl_handler_free(&ov4689->ctrl_handler);
>> +err_destroy_mutex:
>> +	mutex_destroy(&ov4689->mutex);
>> +
>> +	return ret;
>> +}
>
> [...]


--
Best regards,
Mikhail Rudenko
