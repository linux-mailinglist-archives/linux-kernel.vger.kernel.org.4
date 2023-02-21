Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFEE69E870
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBUTjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBUTjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:39:09 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB301CF4C;
        Tue, 21 Feb 2023 11:39:07 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v3so5564452wrp.2;
        Tue, 21 Feb 2023 11:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEmwPFIQot2qDs+RW9A8Pn7ziBUNXIBkfPkKLs2AKrw=;
        b=RhuORwFULuibFKIvtWAFtiCYPBFD7lkDjRV999aQCFlmIM94QG8QVEieuK6HziL36m
         TQLQYBGcPa4Q4/S1njKGzn8tk6hKPUmVKiPGx1E0j2twTrFkl7gh7vq4VjTdCrX4otqu
         CJSbD2KFGEug9/L9wWqdnA3uatgVVhWOnylkm9XWiA2hpELeVTtdudz9IkYzvubuyWCm
         cG3rscLhzPTnRFKuznVCRMzq/3L5HEFellEl6EdwkuH3tdnKJ6TQvwMuXZEYpl3j1XBZ
         hTLxvFu+4lxQfT8d6jamtmg4ZIJY/jA9Kmgqqsca7UvvLsuWa31/iG+BeTd+AyJ3AQ1R
         mYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEmwPFIQot2qDs+RW9A8Pn7ziBUNXIBkfPkKLs2AKrw=;
        b=BYKEGLd4pTnfdw3tFjI6OFpa0YJ+E15zDJclKiVtJec8VRHiYqDu6WTQOoMYApxql8
         3Fy4yFPgCLR2ZJ5noDW6sVwm2p9nUSf39KqvyEC+XG99Y5JqMAHANsVat9pi8qCJFK7Q
         256GoRfhDA4+l+bApMvnHsbC+p9k7tjJut2naUyFhk1xR2qHl3QYpj2bNCpiO8bKA65l
         SUtoXDVdHbRqkP1wYbd+nlKUKaGvK82fD687PgcmEoYSGq9DIHN/K96kQ6h7xvgGOAby
         Zpu4XHuWW3PArLEY1eMR9ixr1FvYDYOcKJpw207U9icRMhFpCm+9oepnTi2a0Wz3ndVt
         8tRg==
X-Gm-Message-State: AO0yUKUEuMuJqMjZ35saJi0g9o3s2U4QoaL/F4SBt+I2QOjoT4tIyx/E
        AKW50BEUIk+SJ0zXEKlVqfcOtI8+L9E=
X-Google-Smtp-Source: AK7set8MZVhmD5Hw1W2pxlgQWVAPYLn8N3NynNc7gUQSaxrmYg20IYsUAtutcCUJe9O8ov6SlNJbUA==
X-Received: by 2002:a5d:4208:0:b0:2c3:db4f:f336 with SMTP id n8-20020a5d4208000000b002c3db4ff336mr5482843wrq.39.1677008345700;
        Tue, 21 Feb 2023 11:39:05 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d18-20020a5d6452000000b002c54f4d0f71sm6688939wrw.38.2023.02.21.11.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:39:05 -0800 (PST)
Date:   Tue, 21 Feb 2023 22:39:01 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 09/10] staging: dsp: add support for Fortemedia FM34NE
 DSP
Message-ID: <Y/Ud1bn+LExxLb/Q@kadam>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-10-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221183211.21964-10-clamor95@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:32:10PM +0200, Svyatoslav Ryhel wrote:
> +static int fm34ne_dsp_set_config(struct fm34ne_dsp_data *fm34, int state)
> +{
> +	struct device *dev = &fm34->client->dev;
> +
> +	const u8 *enable_ns_parameter = fm34->data->enable_noise_suppression;
> +	int enable_ns_length = fm34->data->enable_ns_length;
> +
> +	const u8 *disable_ns_parameter = fm34->data->disable_noise_suppression;
> +	int disable_ns_length = fm34->data->disable_ns_length;
> +
> +	int ret;
> +
> +	gpiod_set_value_cansleep(fm34->bypass_gpio, 1);
> +	msleep(20);
> +
> +	switch (state) {
> +	case FM34NE_NS_ENABLE:
> +		ret = fm34ne_dsp_write_config(fm34->client, enable_parameter,
> +					      sizeof(enable_parameter));
> +		if (ret < 0) {
> +			dev_err(dev, "failed to set DSP enable with %d\n", ret);
> +			goto exit;
> +		}
> +
> +		ret = fm34ne_dsp_write_config(fm34->client, enable_ns_parameter,
> +					      enable_ns_length);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable DSP noise suppression with %d\n", ret);
> +			goto exit;
> +		}
> +
> +		dev_info(dev, "noise suppression enable DSP parameter written\n");

Delete this type of debug code.

> +		break;
> +
> +	case FM34NE_NS_DISABLE:
> +		ret = fm34ne_dsp_write_config(fm34->client, enable_parameter,
> +					      sizeof(enable_parameter));
> +		if (ret < 0) {
> +			dev_err(dev, "failed to set DSP enable with %d\n", ret);
> +			goto exit;
> +		}
> +
> +		ret = fm34ne_dsp_write_config(fm34->client, disable_ns_parameter,
> +					      disable_ns_length);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to disable DSP noise suppression with %d\n", ret);
> +			goto exit;
> +		}
> +
> +		dev_info(dev, "noise suppression disable DSP parameter written\n");

Same etc.

> +		break;
> +
> +	case FM34NE_BYPASS:
> +	default:
> +		ret = fm34ne_dsp_write_config(fm34->client, bypass_parameter,
> +					      sizeof(bypass_parameter));
> +		if (ret < 0) {
> +			dev_err(dev, "failed to set DSP bypass with %d\n", ret);
> +			goto exit;
> +		}
> +
> +		dev_info(dev, "bypass DSP parameter written\n");
> +		break;
> +	}
> +
> +exit:
> +	gpiod_set_value_cansleep(fm34->bypass_gpio, 0);
> +
> +	return ret;
> +}
> +
> +static int fm34ne_dsp_set_hw(struct fm34ne_dsp_data *fm34)
> +{
> +	struct device *dev = &fm34->client->dev;
> +	int ret;
> +
> +	ret = clk_prepare_enable(fm34->dap_mclk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable the DSP MCLK: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(fm34->vdd_supply);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable vdd power supply\n");

clk_disable_unprepare(fm34->dap_mclk);

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void fm34ne_dsp_reset(struct fm34ne_dsp_data *fm34)
> +{
> +	gpiod_set_value_cansleep(fm34->reset_gpio, 1);
> +	msleep(20);
> +
> +	gpiod_set_value_cansleep(fm34->reset_gpio, 0);
> +	msleep(100);
> +}
> +
> +static int fm34ne_dsp_init_chip(struct fm34ne_dsp_data *fm34)
> +{
> +	const u8 *input_parameter = fm34->data->input_parameter;
> +	int input_parameter_length = fm34->data->input_parameter_length;
> +	int ret;
> +
> +	ret = fm34ne_dsp_set_hw(fm34);
> +	if (ret)
> +		return ret;
> +
> +	fm34ne_dsp_reset(fm34);
> +
> +	gpiod_set_value_cansleep(fm34->bypass_gpio, 1);
> +	msleep(20);
> +
> +	ret = i2c_smbus_write_byte(fm34->client, FM34NE_I2C_CHECK);
> +	if (ret < 0) {
> +		dev_info(&fm34->client->dev, "initial write failed\n");

dev_warn()?

> +		msleep(50);
> +
> +		fm34ne_dsp_reset(fm34);
> +		gpiod_set_value_cansleep(fm34->bypass_gpio, 0);
> +
> +		return ret;
> +	}
> +
> +	ret = fm34ne_dsp_write_config(fm34->client, input_parameter,
> +				      input_parameter_length);
> +	if (ret < 0)
> +		return -EINVAL;

Why not propagate the error code from fm34ne_dsp_write_config()?

> +
> +	msleep(100);
> +	gpiod_set_value_cansleep(fm34->bypass_gpio, 0);
> +
> +	dev_info(&fm34->client->dev, "%s detected\n", fm34->data->model);
> +
> +	/* Constantly set DSP to bypass mode for now */
> +	ret = fm34ne_dsp_set_config(fm34, FM34NE_BYPASS);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

regards,
dan carpenter
