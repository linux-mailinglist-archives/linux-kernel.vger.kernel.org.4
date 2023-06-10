Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EC172AAA2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 11:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjFJJYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 05:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFJJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 05:24:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31A72129
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 02:24:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977d7bdde43so548588266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686389071; x=1688981071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XojwCKgKhnjiO7z1EOBqqb2iPuWe/crlH+uXgXBXB7A=;
        b=D4dP8H2UTLxaQ6rpMaJJbgbnz794U2JDheN7mjLjVMohYf7LI27mHijVKeHZKvi1m3
         c8FZP05OEPe4/uqoeFGdA6WE4mOna/HT/qi9LMq/LfO1Y/v2QWGkM+4AvUggZdZ8yjlQ
         RgN8iphJ9IU/MZYT+z5meDUICzMrD3Y6/4HjuyJXQtjklemyl/4N1qCN2AoVc2E1Vb2m
         Uyyn78vUsMP9ozBOzaLw+Qc74+NmHzWY9Ugchu94eucmVwaobaojT1Iznwy253sKE0HJ
         Vk2bs6KS39V++1171UK1Sg3WDAJq//dVcn6/8sIio7dRLECWNtPZtftj/Z1hy5oAhOBj
         vQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686389071; x=1688981071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XojwCKgKhnjiO7z1EOBqqb2iPuWe/crlH+uXgXBXB7A=;
        b=it0dT/w03OSPQKWbG3MuvYomdwV0T9Mq8dELHKUKuWuTMGUUSqgUGa/724DvCIngkN
         wliz9rhtugFTcAZcFSz9/Oy8r44X4l6D1wiIA8GpbzWiYgGFRHqgYYb6S5GmtVeTvhb3
         I3TwjSGz5M0kSgTi5+xVPx2uRVH0yUdCmEtu1mMjfn4DWvJTFDtepbiZ753xXPtPk1DD
         NIgihB9NZpiJu0koo5XR6cx0NWodHSeCRpnkoC2CCYhwLRtLfR0Lirfjm/VPCcg0EU0j
         S387EeRGaDh4GtveaEEskQ0R3O0KUs8AQ4GyC/UPU5HDTcVc1tCNSd7Rz8Be5+XsAdx2
         dwBw==
X-Gm-Message-State: AC+VfDxl1AIEgxBbl73x4/G+JrIeSX6AfttnEhjUN5H93b6E++vjNKZz
        vML3ksoB2Zxwa6iWOIpYX2HoNw==
X-Google-Smtp-Source: ACHHUZ4pBisGDKji6uOa3f0FnU4ZFqCgOV6oMmZC83f3QnL93SbSqlXkXMHN3OZ82e1apqn4uyjMxQ==
X-Received: by 2002:a17:907:7f0b:b0:976:f2e:ad6a with SMTP id qf11-20020a1709077f0b00b009760f2ead6amr4462360ejc.28.1686389071126;
        Sat, 10 Jun 2023 02:24:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id fy25-20020a170906b7d900b0096b55be592asm2319503ejb.92.2023.06.10.02.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 02:24:30 -0700 (PDT)
Message-ID: <87d90ade-644c-a45d-ce50-bdeded755b04@linaro.org>
Date:   Sat, 10 Jun 2023 11:24:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 2/2] ASoC: max98388: add amplifier driver
Content-Language: en-US
To:     =?UTF-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.com, ryans.lee@analog.com,
        wangweidong.a@awinic.com, shumingf@realtek.com,
        herve.codina@bootlin.com, ckeepax@opensource.cirrus.com,
        doug@schmorgal.com, ajye_huang@compal.corp-partner.google.com,
        kiseok.jo@irondevice.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     venkataprasad.potturu@amd.com, kernel test robot <lkp@intel.com>
References: <20230609234417.1139839-1-ryan.lee.analog@gmail.com>
 <20230609234417.1139839-2-ryan.lee.analog@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609234417.1139839-2-ryan.lee.analog@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2023 01:44, “Ryan wrote:
> From: Ryan Lee <ryans.lee@analog.com>
> 
> Added Analog Devices MAX98388 amplifier driver.
> MAX98388 provides a PCM interface for audio data and a standard I2C
> interface for control data communication.
> 
> Signed-off-by: Ryan Lee <ryans.lee@analog.com>
> Reported-by: kernel test robot <lkp@intel.com>

There is nothing to report here.

> Closes: 
> https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/2023
> 06082054.jIU9oENf-lkp@intel.com/__;!!A3Ni8CS0y2Y!46sHiAsmIiXxZ_QXIobho
> mY8F1f7F2yMYd_65NNFwRlcgut33--RdFjVAbg6jKf7Vs8GaYZ7oA$

Nothing to close and also broken link. Fix your mailer.

> ---
> Changes from v1:
>   Fixed build warnings.
> 
>  sound/soc/codecs/Kconfig    |   10 +
>  sound/soc/codecs/Makefile   |    2 +
>  sound/soc/codecs/max98388.c | 1042 +++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/max98388.h |  234 ++++++++
>  4 files changed, 1288 insertions(+)
>  create mode 100644 sound/soc/codecs/max98388.c
>  create mode 100644 sound/soc/codecs/max98388.h

...

> +
> +static void max98388_read_deveice_property(struct device *dev,
> +					   struct max98388_priv *max98388)
> +{
> +	int value;
> +
> +	if (!device_property_read_u32(dev, "adi,vmon-slot-no", &value))
> +		max98388->v_slot = value & 0xF;
> +	else
> +		max98388->v_slot = 0;
> +
> +	if (!device_property_read_u32(dev, "adi,imon-slot-no", &value))
> +		max98388->i_slot = value & 0xF;
> +	else
> +		max98388->i_slot = 1;
> +
> +	if (device_property_read_bool(dev, "adi,interleave-mode"))
> +		max98388->interleave_mode = true;
> +	else
> +		max98388->interleave_mode = false;
> +
> +	if (dev->of_node) {
> +		max98388->reset_gpio = of_get_named_gpio(dev->of_node,
> +							 "reset-gpio", 0);

Nope, use devm

> +		if (!gpio_is_valid(max98388->reset_gpio)) {
> +			dev_err(dev, "Looking up %s property in node %s failed %d\n",
> +				"reset-gpio", dev->of_node->full_name,
> +				max98388->reset_gpio);
> +		} else {
> +			dev_dbg(dev, "reset-gpio=%d",
> +				max98388->reset_gpio);
> +		}
> +	} else {
> +		/* this makes reset_gpio as invalid */
> +		max98388->reset_gpio = -1;

Why? To request it again? It does not make sense.

> +	}
> +}
> +
> +static int max98388_i2c_probe(struct i2c_client *i2c)
> +{
> +	int ret = 0;
> +	int reg = 0;
> +
> +	struct max98388_priv *max98388 = NULL;
> +
> +	max98388 = devm_kzalloc(&i2c->dev, sizeof(*max98388), GFP_KERNEL);
> +

Drop blank line.

> +	if (!max98388) {
> +		ret = -ENOMEM;

return -ENOMEM;

> +		return ret;
> +	}
> +	i2c_set_clientdata(i2c, max98388);
> +
> +	/* regmap initialization */
> +	max98388->regmap = devm_regmap_init_i2c(i2c, &max98388_regmap);
> +	if (IS_ERR(max98388->regmap)) {
> +		ret = PTR_ERR(max98388->regmap);
> +		dev_err(&i2c->dev,
> +			"Failed to allocate regmap: %d\n", ret);
> +		return ret;

return dev_err_probe

> +	}
> +
> +	/* voltage/current slot & gpio configuration */
> +	max98388_read_deveice_property(&i2c->dev, max98388);
> +
> +	/* Power on device */
> +	if (gpio_is_valid(max98388->reset_gpio)) {

What's this? You request it twice? No.


> +		ret = devm_gpio_request(&i2c->dev, max98388->reset_gpio,
> +					"MAX98388_RESET");
> +		if (ret) {
> +			dev_err(&i2c->dev, "%s: Failed to request gpio %d\n",
> +				__func__, max98388->reset_gpio);

return dev_err_probe

> +			return -EINVAL;
> +		}
> +		gpio_direction_output(max98388->reset_gpio, 0);
> +		msleep(50);
> +		gpio_direction_output(max98388->reset_gpio, 1);

1 means keep in reset, so why do you keep deviec reset afterwards? Was
it tested? You probably messed up values used for GPIOs as you stated in
example that it is active low.

> +		msleep(20);
> +	}
> +
> +	/* Read Revision ID */
> +	ret = regmap_read(max98388->regmap,
> +			  MAX98388_R22FF_REV_ID, &reg);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev,
> +			"Failed to read: 0x%02X\n", MAX98388_R22FF_REV_ID);
> +		return ret;

return dev_err_probe

> +	}
> +	dev_info(&i2c->dev, "MAX98388 revisionID: 0x%02X\n", reg);
> +
> +	/* codec registration */
> +	ret = devm_snd_soc_register_component(&i2c->dev,
> +					      &soc_codec_dev_max98388,
> +					      max98388_dai,
> +					      ARRAY_SIZE(max98388_dai));
> +	if (ret < 0)
> +		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static const struct i2c_device_id max98388_i2c_id[] = {
> +	{ "max98388", 0},
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, max98388_i2c_id);
> +
> +#if defined(CONFIG_OF)

Drop

> +static const struct of_device_id max98388_of_match[] = {
> +	{ .compatible = "adi,max98388", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max98388_of_match);
> +#endif
> +
> +#ifdef CONFIG_ACPI

Drop

> +static const struct acpi_device_id max98388_acpi_match[] = {
> +	{ "ADS8388", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, max98388_acpi_match);
> +#endif
> +
> +static struct i2c_driver max98388_i2c_driver = {
> +	.driver = {
> +		.name = "max98388",
> +		.of_match_table = of_match_ptr(max98388_of_match),
> +		.acpi_match_table = ACPI_PTR(max98388_acpi_match),

Just drop all wrappers. They are useless and only limit your driver (OF
can be used on some ACPI platforms).


Best regards,
Krzysztof

