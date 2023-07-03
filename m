Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C6F745ABC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjGCLCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCLCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:02:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0661BD2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 04:02:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so6588419e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 04:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688382157; x=1690974157;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9e80uPEC5DnMutI91FgAhq3DLdZpxzcVXtL8gtIqIM=;
        b=Jo0/GTR3kPWvXEuoldbwXqWl6TCsuN04PAtL58QBy6GS26nDHa8X4UO9PK1tY4HXkb
         g4wr8WU5tUY+mU6NmXDSkMBg4UAlwF/iWUnBaiVrJws/VgbAYCUEogPNWAh8yOQJI7Ha
         hmIY/yyzDnrCmTudL5l00HlkYsyM649JU/XbiEXC2GHV5S0CgDhe4pMW3yKEkGMlkyya
         +Nr8eivtrdvFQSmwKfKDi+VcrHC5VXAnCErnWuQHCqBZWFO//A7VPjFqt/Eeu5PJUoxM
         TkNnYOtS8q0CT9g7HIV8dz4bYs+cHdlMjrqRZjde7r5u4fX8GdKveIbVhQw2Nua7POoj
         C2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688382157; x=1690974157;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9e80uPEC5DnMutI91FgAhq3DLdZpxzcVXtL8gtIqIM=;
        b=eB/r4NIFqROwBzb3jeB5lhIKCNu7d0QQgFsPEslMiB76mzZZwfP/0cWUbwJOF4nEGF
         RfWonJd6N014TUKQVKSCm2mgyi3+uRX9RdQEfRCQ0Ax3DVH1RLM40hxw5Hee87GLnPXC
         t93SRnG+eHMPAl0zVX1hsjdQCFkLRO3GAaHixF929KzPr+mU/UEb9VihFfheFB/9T2x0
         qIYhSSDiyFuc8C7GPTt5sW2aqkf/V715uSPEgLxZ8zSgRGAk+cZKprsQSaY9JFi1VmTm
         Vkdrdnq/QrMhbO+tZ2sfkzr0IZXwjNZM1g6KzOpT4LGlSUQKAaxVXMHdR96XjnVb0xu8
         +uDg==
X-Gm-Message-State: ABy/qLY/NyMERIdMXNdqB+G3lG/yh/bM86kNr+thl2fMyuVhUbnqjcTp
        ViX63nfL1XsCFNOI8GFwR++HncyUIkg=
X-Google-Smtp-Source: APBJJlE3Cvs96qVe3FPLVG+N+2Mx21wtEF6SRt1DcE0Y3UUpdz4UEVgCB071/sfL/mt6XMBg/NaNEg==
X-Received: by 2002:ac2:4f0e:0:b0:4f8:67aa:4f03 with SMTP id k14-20020ac24f0e000000b004f867aa4f03mr7572594lfr.1.1688382157028;
        Mon, 03 Jul 2023 04:02:37 -0700 (PDT)
Received: from [172.16.196.206] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x13-20020ac2488d000000b004edc72be17csm2647696lfc.2.2023.07.03.04.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 04:02:36 -0700 (PDT)
Message-ID: <4467bc6d-d4e7-aaa2-daab-875eb0e4159b@gmail.com>
Date:   Mon, 3 Jul 2023 14:02:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
 <20230419-dynamic-vmon-v4-13-4d3734e62ada@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH RFC v4 13/13] regulator: bd718x7: let the core handle the
 monitors
In-Reply-To: <20230419-dynamic-vmon-v4-13-4d3734e62ada@skidata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 23:03, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> The monitors of the bd718x7 must be disabled while the respective
> regulator is switching to a higher voltage. Use the new property
> '.mon_disable_reg_set_higher' to activate the handling in the core.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>

This looks great to me. Eg,
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

Just a thing crossed my mind if you want to go an extra mile... (Yeah, 
we usually do like to do a bit more work, right?)

I guess that enabling / disabling a monitor is in many cases a matter of 
setting/clearing a single bit in a monitoring register - or maybe in 
some cases setting a limit value to zero.

Do you think it might be worth to add a 'monitor_reg_enable_uv, 
monitor_reg_enable_ov, monitor_reg_enable_oc, monitor_reg_enable_temp' 
and 'monitor_mask_enable_uv, monitor_mask_enable_ov, 
monitor_mask_enable_oc, monitor_mask_enable_temp' in the regulator_desc 
+ provide helpers for the drivers which do not need any more complex stuff?

Just a thought. Again, thanks for working on this!

> ---
>   drivers/regulator/bd718x7-regulator.c | 136 +++-------------------------------
>   1 file changed, 10 insertions(+), 126 deletions(-)
> 
> diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
> index fbf609d219fc..251d098d088c 100644
> --- a/drivers/regulator/bd718x7-regulator.c
> +++ b/drivers/regulator/bd718x7-regulator.c
> @@ -128,128 +128,6 @@ static int bd71837_get_buck34_enable_hwctrl(struct regulator_dev *rdev)
>   	return !!(BD718XX_BUCK_RUN_ON & val);
>   }
>   
> -static void voltage_change_done(struct regulator_dev *rdev, unsigned int sel,
> -				unsigned int *mask)
> -{
> -	int ret;
> -
> -	if (*mask) {
> -		/*
> -		 * Let's allow scheduling as we use I2C anyways. We just need to
> -		 * guarantee minimum of 1ms sleep - it shouldn't matter if we
> -		 * exceed it due to the scheduling.
> -		 */
> -		msleep(1);
> -
> -		ret = regmap_clear_bits(rdev->regmap, BD718XX_REG_MVRFLTMASK2,
> -					 *mask);
> -		if (ret)
> -			dev_err(&rdev->dev,
> -				"Failed to re-enable voltage monitoring (%d)\n",
> -				ret);
> -	}
> -}
> -
> -static int voltage_change_prepare(struct regulator_dev *rdev, unsigned int sel,
> -				  unsigned int *mask)
> -{
> -	int ret;
> -
> -	*mask = 0;
> -	if (rdev->desc->ops->is_enabled(rdev)) {
> -		int now, new;
> -
> -		now = rdev->desc->ops->get_voltage_sel(rdev);
> -		if (now < 0)
> -			return now;
> -
> -		now = rdev->desc->ops->list_voltage(rdev, now);
> -		if (now < 0)
> -			return now;
> -
> -		new = rdev->desc->ops->list_voltage(rdev, sel);
> -		if (new < 0)
> -			return new;
> -
> -		/*
> -		 * If we increase LDO voltage when LDO is enabled we need to
> -		 * disable the power-good detection until voltage has reached
> -		 * the new level. According to HW colleagues the maximum time
> -		 * it takes is 1000us. I assume that on systems with light load
> -		 * this might be less - and we could probably use DT to give
> -		 * system specific delay value if performance matters.
> -		 *
> -		 * Well, knowing we use I2C here and can add scheduling delays
> -		 * I don't think it is worth the hassle and I just add fixed
> -		 * 1ms sleep here (and allow scheduling). If this turns out to
> -		 * be a problem we can change it to delay and make the delay
> -		 * time configurable.
> -		 */
> -		if (new > now) {
> -			int tmp;
> -			int prot_bit;
> -			int ldo_offset = rdev->desc->id - BD718XX_LDO1;
> -
> -			prot_bit = BD718XX_LDO1_VRMON80 << ldo_offset;
> -			ret = regmap_read(rdev->regmap, BD718XX_REG_MVRFLTMASK2,
> -					  &tmp);
> -			if (ret) {
> -				dev_err(&rdev->dev,
> -					"Failed to read voltage monitoring state\n");
> -				return ret;
> -			}
> -
> -			if (!(tmp & prot_bit)) {
> -				/* We disable protection if it was enabled... */
> -				ret = regmap_set_bits(rdev->regmap,
> -						      BD718XX_REG_MVRFLTMASK2,
> -						      prot_bit);
> -				/* ...and we also want to re-enable it */
> -				*mask = prot_bit;
> -			}
> -			if (ret) {
> -				dev_err(&rdev->dev,
> -					"Failed to stop voltage monitoring\n");
> -				return ret;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static int bd718xx_set_voltage_sel_restricted(struct regulator_dev *rdev,
> -						    unsigned int sel)
> -{
> -	int ret;
> -	int mask;
> -
> -	ret = voltage_change_prepare(rdev, sel, &mask);
> -	if (ret)
> -		return ret;
> -
> -	ret = regulator_set_voltage_sel_regmap(rdev, sel);
> -	voltage_change_done(rdev, sel, &mask);
> -
> -	return ret;
> -}
> -
> -static int bd718xx_set_voltage_sel_pickable_restricted(
> -		struct regulator_dev *rdev, unsigned int sel)
> -{
> -	int ret;
> -	int mask;
> -
> -	ret = voltage_change_prepare(rdev, sel, &mask);
> -	if (ret)
> -		return ret;
> -
> -	ret = regulator_set_voltage_sel_pickable_regmap(rdev, sel);
> -	voltage_change_done(rdev, sel, &mask);
> -
> -	return ret;
> -}
> -
>   static int bd71837_set_voltage_sel_pickable_restricted(
>   		struct regulator_dev *rdev, unsigned int sel)
>   {
> @@ -610,7 +488,7 @@ static int bd718x7_set_buck_ovp(struct regulator_dev *rdev, int lim_uV,
>    */
>   BD718XX_OPS(bd718xx_pickable_range_ldo_ops,
>   	    regulator_list_voltage_pickable_linear_range, NULL,
> -	    bd718xx_set_voltage_sel_pickable_restricted,
> +	    regulator_set_voltage_sel_pickable_regmap,
>   	    regulator_get_voltage_sel_pickable_regmap, NULL, NULL,
>   	    bd718x7_set_ldo_uvp, NULL, bd717x7_get_ldo_prot);
>   
> @@ -618,7 +496,7 @@ BD718XX_OPS(bd718xx_pickable_range_ldo_ops,
>   static const struct regulator_ops bd718xx_ldo5_ops_hwstate = {
>   	.is_enabled = never_enabled_by_hwstate,
>   	.list_voltage = regulator_list_voltage_pickable_linear_range,
> -	.set_voltage_sel = bd718xx_set_voltage_sel_pickable_restricted,
> +	.set_voltage_sel = regulator_set_voltage_sel_pickable_regmap,
>   	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
>   	.set_under_voltage_protection = bd718x7_set_ldo_uvp,
>   };
> @@ -631,12 +509,12 @@ BD718XX_OPS(bd718xx_pickable_range_buck_ops,
>   	    bd718x7_set_buck_ovp, bd717x7_get_buck_prot);
>   
>   BD718XX_OPS(bd718xx_ldo_regulator_ops, regulator_list_voltage_linear_range,
> -	    NULL, bd718xx_set_voltage_sel_restricted,
> +	    NULL, regulator_set_voltage_sel_regmap,
>   	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
>   	    NULL, bd717x7_get_ldo_prot);
>   
>   BD718XX_OPS(bd718xx_ldo_regulator_nolinear_ops, regulator_list_voltage_table,
> -	    NULL, bd718xx_set_voltage_sel_restricted,
> +	    NULL, regulator_set_voltage_sel_regmap,
>   	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
>   	    NULL, bd717x7_get_ldo_prot);
>   
> @@ -1818,6 +1696,12 @@ static int bd718xx_probe(struct platform_device *pdev)
>   		else
>   			desc->ops = swops[i];
>   
> +		/*
> +		 * bd718x7 requires to disable a regulator's over voltage
> +		 * protection while it changes to a higher value.
> +		 */
> +		desc->mon_disable_reg_set_higher = REGULATOR_MONITOR_OVER_VOLTAGE;
> +
>   		rdev = devm_regulator_register(&pdev->dev, desc, &config);
>   		if (IS_ERR(rdev))
>   			return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

