Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91786D75B8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbjDEHmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjDEHmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:42:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5685FB;
        Wed,  5 Apr 2023 00:42:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y20so45514098lfj.2;
        Wed, 05 Apr 2023 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680680552;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFkSNSmdjEj5WZ+cQz4ZN6eDKm1b45P05E0JY7M4/dc=;
        b=QkUPTcaVyRupX+vfB4ylbilqZ1x2MZrfm1rSuYmiNjwmZ5TchwRmgNfU23smy7ckTm
         OcvPFJiP7tDs73FhqUH4SxDwBRjEx39JoRFZYCwoH46BmG5++K7sRurIbiLKWvSeWVoL
         /Z2xxr1Erdd9HZQhk3huiCJHZvs/QGqCSlhBs7jbuDbU6Cn8blX4HbXG06uYcjB2o2Jm
         UYHSzy03CHH3cZsxp1NCCMcgZb5QmfO5jLo3aSA7sHzpxXQKDQunewPwgTHI/VXsGuoy
         2CLD1a4r32aUl/ximPGEhEOAiY8lSRBnqarKe3rWMqNirxfq2wg2ttcgvMQlySR/6JlM
         ptow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680680552;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFkSNSmdjEj5WZ+cQz4ZN6eDKm1b45P05E0JY7M4/dc=;
        b=o3nwaLMfZMSfcGd2FLVizXSFx+2mmyy1fQYx3vz+9TzVsG+mej5qbk1x/NH7G1oM97
         X7n1DtXRTjX8KRYjKMCbTX+9o4cOjeESRecT5qtBY6D4A3vtioNxXJWnCrFdcg4/5Jav
         IkP3VnlyutbJqOQL+UuQ3Zwm/KyMmwQM5kV9o2WOv3C9IIIRFALuUar7DX55xS8C1FD5
         gxhcR4fmjCIW58mmCzVmZ7CP171yui7UT8gVE65qao2zcqATXMPl0d5zNKOOJ1RRnwl7
         QWA0tyyQHtcfd/tULXiFTxLAoHB7Wg2bpwhpx1v3/bm7m+riM9dtU7BrdtKxHT9h8oiw
         bdHw==
X-Gm-Message-State: AAQBX9cGpaLypIM4/I6xS6lIzb4MOZNisSzDYIQeABtGcPepyJw6FpOG
        v2xP00PkwQrrkDXaop/VbC4=
X-Google-Smtp-Source: AKy350Z8YkOMLh2/lKtuf4t5rcifPj2ToVAyGXrjbyz9cUN25ldFh6TaS4YMYF89NHdnOrRxQ1Ox2w==
X-Received: by 2002:ac2:5221:0:b0:4eb:18d:91de with SMTP id i1-20020ac25221000000b004eb018d91demr1357646lfl.43.1680680551998;
        Wed, 05 Apr 2023 00:42:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id y10-20020ac2446a000000b004eb09081d77sm2739329lfl.91.2023.04.05.00.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 00:42:31 -0700 (PDT)
Message-ID: <2ee54bc0-65ee-1aa7-c045-72d92594683e@gmail.com>
Date:   Wed, 5 Apr 2023 10:42:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
 <20230403-da9063-disable-unused-v2-2-2f1bd2a2434a@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/3] regulator: da9063: implement basic XVP setter
In-Reply-To: <20230403-da9063-disable-unused-v2-2-2f1bd2a2434a@skidata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 08:29, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Allow to en- and disable voltage monitoring from the device tree.
> Consider that the da9063 only monitors UV *and* OV together, so both
> must be en- or disabled.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>   drivers/regulator/da9063-regulator.c | 100 +++++++++++++++++++++++++----------
>   1 file changed, 72 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
> index 1c720fc595b3..000fa0daef18 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -207,6 +207,24 @@ static const unsigned int da9063_bmem_bio_merged_limits[] = {
>   	4600000, 4800000, 5000000, 5200000, 5400000, 5600000, 5800000, 6000000
>   };
>   
> +static int da9063_set_xvp(struct regulator_dev *rdev, int lim_uV, int severity, bool enable)
> +{
> +	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
> +	struct device *dev = regl->hw->dev;
> +
> +	dev_dbg(dev, "%s: lim: %d, sev: %d, en: %d\n", regl->desc.name, lim_uV, severity, enable);
> +
> +	/*
> +	 * only support enable and disable.
> +	 * the da9063 offers a GPIO (GP_FB2) which is unasserted if an XV happens.
> +	 * therefore ignore severity here, as there might be handlers in hardware.
> +	 */
> +	if (lim_uV)
> +		return -EINVAL;
> +
> +	return regmap_field_write(regl->vmon, enable ? 1 : 0);
> +}
> +
>   static int da9063_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
>   {
>   	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
> @@ -545,37 +563,41 @@ static int da9063_buck_get_current_limit(struct regulator_dev *rdev)
>   }
>   
>   static const struct regulator_ops da9063_buck_ops = {
> -	.enable			= regulator_enable_regmap,
> -	.disable		= regulator_disable_regmap,
> -	.is_enabled		= regulator_is_enabled_regmap,
> -	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> -	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> -	.list_voltage		= regulator_list_voltage_linear,
> -	.set_current_limit	= da9063_buck_set_current_limit,
> -	.get_current_limit	= da9063_buck_get_current_limit,
> -	.set_mode		= da9063_buck_set_mode,
> -	.get_mode		= da9063_buck_get_mode,
> -	.get_status		= da9063_buck_get_status,
> -	.set_suspend_voltage	= da9063_set_suspend_voltage,
> -	.set_suspend_enable	= da9063_suspend_enable,
> -	.set_suspend_disable	= da9063_suspend_disable,
> -	.set_suspend_mode	= da9063_buck_set_suspend_mode,
> +	.enable				= regulator_enable_regmap,
> +	.disable			= regulator_disable_regmap,
> +	.is_enabled			= regulator_is_enabled_regmap,
> +	.get_voltage_sel		= regulator_get_voltage_sel_regmap,
> +	.set_voltage_sel		= regulator_set_voltage_sel_regmap,
> +	.list_voltage			= regulator_list_voltage_linear,
> +	.set_current_limit		= da9063_buck_set_current_limit,
> +	.get_current_limit		= da9063_buck_get_current_limit,
> +	.set_mode			= da9063_buck_set_mode,
> +	.get_mode			= da9063_buck_get_mode,
> +	.get_status			= da9063_buck_get_status,
> +	.set_suspend_voltage		= da9063_set_suspend_voltage,
> +	.set_suspend_enable		= da9063_suspend_enable,
> +	.set_suspend_disable		= da9063_suspend_disable,
> +	.set_suspend_mode		= da9063_buck_set_suspend_mode,
> +	.set_over_voltage_protection	= da9063_set_xvp,
> +	.set_under_voltage_protection	= da9063_set_xvp,
>   };
>   
>   static const struct regulator_ops da9063_ldo_ops = {
> -	.enable			= regulator_enable_regmap,
> -	.disable		= regulator_disable_regmap,
> -	.is_enabled		= regulator_is_enabled_regmap,
> -	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> -	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> -	.list_voltage		= regulator_list_voltage_linear,
> -	.set_mode		= da9063_ldo_set_mode,
> -	.get_mode		= da9063_ldo_get_mode,
> -	.get_status		= da9063_ldo_get_status,
> -	.set_suspend_voltage	= da9063_set_suspend_voltage,
> -	.set_suspend_enable	= da9063_suspend_enable,
> -	.set_suspend_disable	= da9063_suspend_disable,
> -	.set_suspend_mode	= da9063_ldo_set_suspend_mode,
> +	.enable				= regulator_enable_regmap,
> +	.disable			= regulator_disable_regmap,
> +	.is_enabled			= regulator_is_enabled_regmap,
> +	.get_voltage_sel		= regulator_get_voltage_sel_regmap,
> +	.set_voltage_sel		= regulator_set_voltage_sel_regmap,
> +	.list_voltage			= regulator_list_voltage_linear,
> +	.set_mode			= da9063_ldo_set_mode,
> +	.get_mode			= da9063_ldo_get_mode,
> +	.get_status			= da9063_ldo_get_status,
> +	.set_suspend_voltage		= da9063_set_suspend_voltage,
> +	.set_suspend_enable		= da9063_suspend_enable,
> +	.set_suspend_disable		= da9063_suspend_disable,
> +	.set_suspend_mode		= da9063_ldo_set_suspend_mode,
> +	.set_over_voltage_protection	= da9063_set_xvp,
> +	.set_under_voltage_protection	= da9063_set_xvp,
>   };

During my recent visit in the IIO territory I was told to by Jonathan to 
drop the 'pretty indenting' of structs like this. I think this shows 
well why - when longer members are added, it's hard to see from the diff 
what actually changed. So, if you re-spin and unless Mark has another 
opinion, maybe drop the tabs - in my eyes this does not do much for the 
readability.

Well, IMO this is definitely not something that would require a re-spin 
- and it may be others disagree with me on this. So, FWIW:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

