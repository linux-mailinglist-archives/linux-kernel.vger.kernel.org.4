Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0144373E18B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjFZOFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjFZOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:05:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52971BB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:05:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b69ea3b29fso18851781fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687788299; x=1690380299;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=et+L+q6O3jHNtaG3/mzwJ+2mcPlY+UMw89qcTFxpEsY=;
        b=MxjIWFkmvm7Y3Hj7kgc4oh2TmNBY21N43aFU4dm8Qh50vgBu0UmyCI9FI16ripOTsX
         ZzSHiq9gZ+Hah+s486gqYwXqxSdSWjKMFVloK2j2qPutC6rjCYJuO3RHvo56B7ZuflXU
         TlZQGO5aSteDtnZbL3upIefOQ7L6Imi1Og7Y/RduSUPApiSPkzWCqO42RqY0STf2y5hf
         WH+QyxkWopapWwIEBqIFSJSeCVA3yezwYSsi+WQf5VSUbDr3rle/974mMKJWDlE2CbIu
         yA2ROsu1YwJTEBbuPb3PmOytATcf0wJFdygA4ChKopdZ0t6b8mpgzByNEbco5xTZaglf
         STNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687788299; x=1690380299;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=et+L+q6O3jHNtaG3/mzwJ+2mcPlY+UMw89qcTFxpEsY=;
        b=RfcQYfPMbZoPmrLQr+QxsxggcNE3L/tWOvJoY5ESMq+diAkdE46eSdvZyFMjP2fvaw
         DORgX+da00EEmYiUz8H+XRQx3MizSzgQxL63dj381Lm9vAz1SuLEJfOj3gNNCxS0AZnj
         Js1+k5XXOX/wfUZOwYHHvV5KVCwr2nO5xcy+5F12fDcfUOUtAEks8la8H9f2SwvVHFFC
         jddeiIXTx4hc/Nf1fcLfzsjESLATtfbdsqdENnzrSG+rKdsagwcNrakLavpKPInKeO9v
         mFdZ4pw0vTrghUv1GfaB/gJUre3GKpF0eQxxgvZdNyC+2uMng9o5mluPfkojZFzNDeXR
         GShA==
X-Gm-Message-State: AC+VfDxMoZ8MKwc00XVtDGciTvirG7jWKjXZDg29LiHirBhnvQ/1rRsn
        sTSOAm/06CBbfkCiMwxbbd8=
X-Google-Smtp-Source: ACHHUZ7V35e8IlAzQlhWkcU470MqE0jwehKjU/efHna60JW0NUT5v443QLGtaUG1v1pvYiBR15+7Qg==
X-Received: by 2002:a2e:8099:0:b0:2b5:85a9:7e9a with SMTP id i25-20020a2e8099000000b002b585a97e9amr9705677ljg.1.1687788299155;
        Mon, 26 Jun 2023 07:04:59 -0700 (PDT)
Received: from [10.100.102.18] ([83.136.201.74])
        by smtp.gmail.com with ESMTPSA id oz31-20020a170906cd1f00b0098d15d170a0sm3273699ejb.202.2023.06.26.07.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 07:04:58 -0700 (PDT)
Message-ID: <2938c236-1144-d49e-f02e-2c2e99ce17af@gmail.com>
Date:   Mon, 26 Jun 2023 17:04:58 +0300
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
 <20230419-dynamic-vmon-v4-8-4d3734e62ada@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH RFC v4 08/13] regulator: move monitor handling into own
 function
In-Reply-To: <20230419-dynamic-vmon-v4-8-4d3734e62ada@skidata.com>
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
> Extract the current monitor handling into an own function and create
> helper for initialization, disabling and re-enabling of monitors.
> For reenabling the monitors, the current state and mode is considered to
> avoid entering an invalid state on regulators with enabled workarounds.
> 
> Additionally, monitors of disabled regulators are not disabled before
> changing state. The mon_disable_reg_disabled property is still respected
> in this case, because turning off the monitor happens when the regulator
> is still enabled.
> 
> Differ between initialization and normal "workaround handling" when an
> EOPNOTSUPP is returned.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>   drivers/regulator/core.c | 234 +++++++++++++++++++++++++++++++++++------------
>   1 file changed, 178 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 9bddab17450e..873e53633698 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -1426,7 +1426,7 @@ static int notif_set_limit(struct regulator_dev *rdev,
>   
>   static int handle_notify_limits(struct regulator_dev *rdev,
>   			int (*set)(struct regulator_dev *, int, int, bool),
> -			struct notification_limit *limits)
> +			const struct notification_limit *limits)
>   {
>   	int ret = 0;
>   
> @@ -1451,6 +1451,180 @@ static int handle_notify_limits(struct regulator_dev *rdev,
>   
>   	return ret;
>   }
> +
> +static const struct notification_limit disable_limits = {
> +	.prot = REGULATOR_NOTIF_LIMIT_DISABLE,
> +	.err = REGULATOR_NOTIF_LIMIT_DISABLE,
> +	.warn = REGULATOR_NOTIF_LIMIT_DISABLE,
> +};
> +
> +static int monitors_set_state(struct regulator_dev *rdev,  bool enable,
> +			      unsigned int mons)
> +{
> +	const struct regulation_constraints *reg_c = rdev->constraints;
> +	const struct regulator_ops *ops = rdev->desc->ops;
> +	int tmp, ret = 0;
> +
> +	rdev_dbg(rdev, "%s: en: %d, mons: %x\n", __func__, enable, mons);
> +
> +	/* only set the state if monitoring is activated in the device-tree. */
> +	if ((mons & REGULATOR_MONITOR_OVER_VOLTAGE) && reg_c->over_voltage_detection) {
> +		tmp = handle_notify_limits(rdev, ops->set_over_voltage_protection,
> +					   enable ? &reg_c->over_voltage_limits
> +					   : &disable_limits);
> +		if (tmp) {
> +			if (tmp != -EOPNOTSUPP) {
> +				rdev_err(rdev, "failed to set over voltage limits %pe\n",
> +					 ERR_PTR(tmp));
> +				return tmp;
> +			}
> +			rdev_warn(rdev,
> +				  "IC does not support requested over voltage limits\n");
> +			ret = tmp;
> +		}
> +	}
> +	if ((mons & REGULATOR_MONITOR_UNDER_VOLTAGE) && reg_c->under_voltage_detection) {
> +		tmp = handle_notify_limits(rdev, ops->set_under_voltage_protection,
> +					   enable ? &reg_c->under_voltage_limits
> +					   : &disable_limits);
> +		if (tmp) {
> +			if (tmp != -EOPNOTSUPP) {
> +				rdev_err(rdev, "failed to set under voltage limits %pe\n",
> +					 ERR_PTR(tmp));
> +				return ret;
> +			}
> +			rdev_warn(rdev,
> +				  "IC does not support requested under voltage limits\n");
> +			ret = tmp;
> +		}
> +	}
> +	if ((mons & REGULATOR_MONITOR_OVER_CURRENT) && reg_c->over_current_detection) {
> +		tmp = handle_notify_limits(rdev, ops->set_over_current_protection,
> +					   enable ? &reg_c->over_curr_limits
> +					   : &disable_limits);
> +		if (ret) {
> +			if (tmp != -EOPNOTSUPP) {
> +				rdev_err(rdev, "failed to set over current limits: %pe\n",
> +					 ERR_PTR(tmp));
> +				return tmp;
> +			}
> +			rdev_warn(rdev,
> +				  "IC does not support requested over-current limits\n");
> +			ret = tmp;
> +		}
> +	}
> +	if ((mons & REGULATOR_MONITOR_OVER_TEMPERATURE) && reg_c->over_temp_detection) {
> +		tmp = handle_notify_limits(rdev, ops->set_thermal_protection,
> +					   enable ? &reg_c->temp_limits
> +					   : &disable_limits);
> +		if (tmp) {
> +			if (tmp != -EOPNOTSUPP) {
> +				rdev_err(rdev, "failed to set temperature limits %pe\n",
> +					 ERR_PTR(tmp));
> +				return tmp;
> +			}
> +			rdev_warn(rdev,
> +				  "IC does not support requested temperature limits\n");
> +			ret = tmp;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * monitors_disable - disables given monitors if the regulator is enabled
> + * @rdev: regulator source
> + * @mons: monitors to enable
> + */
> +static int monitors_disable(struct regulator_dev *rdev, unsigned int mons)
> +{
> +	int reg_enabled;
> +
> +	if (!mons)
> +		return 0;

Just a minor thing but can we do this check already at the caller side? 
I think that would show the logic more clearly already in the functions 
implementing the actual action requested by the user. 
(disable/enable/change voltage). Eg, the logic in those functions would 
be clear:

if (flag_to_do_magic_monitor_toggling)
	monitors_disable();

and similarly for the monitors_reenable()...

> +
> +	reg_enabled = _regulator_is_enabled(rdev);
> +	if (reg_enabled <= 0)
> +		return reg_enabled;
> +
> +	return monitors_set_state(rdev, false, mons);
> +}
> +
> +/**
> + * monitors_enable - enables given monitors
> + * @rdev: regulator source
> + * @mons: monitors to enable
> + *
> + * Enables monitors based on their workaround properties and the current state
> + * or mode.
> + */
> +static int monitors_enable(struct regulator_dev *rdev, unsigned int mons)
> +{
> +	const struct regulator_desc *desc = rdev->desc;
> +	const struct regulator_ops *ops = desc->ops;
> +
> +	/* don't enable monitors if regulator is in unsupported mode. */
> +	if (desc->mon_unsupported_reg_modes &&
> +	    (desc->mon_unsupported_reg_modes & ops->get_mode(rdev)))
> +		return 0;
> +
> +	/* don't enable monitor on disabled regulator with workaround active. */
> +	if (mons & desc->mon_disable_reg_disabled) {
> +		int reg_enabled = _regulator_is_enabled(rdev);
> +
> +		if (reg_enabled < 0)
> +			return reg_enabled;
> +		if (!reg_enabled)
> +			mons &= ~desc->mon_disable_reg_disabled;
> +	}
> +
> +	return monitors_set_state(rdev, true, mons);
> +}
> +
> +static int monitors_init(struct regulator_dev *rdev)
> +{
> +	unsigned int mons = REGULATOR_MONITOR_NONE;
> +	int reg_enabled = _regulator_is_enabled(rdev);
> +	int ret;
> +
> +	/*
> +	 * Ensure that monitors of disabled regulators with respective
> +	 * workaround active are disabled during initialization.
> +	 */
> +	if (reg_enabled < 0)
> +		return reg_enabled;
> +	if (!reg_enabled && rdev->desc->mon_disable_reg_disabled) {
> +		mons = rdev->desc->mon_disable_reg_disabled;
> +		ret = monitors_set_state(rdev, false, mons);
> +	}
> +
> +	/* Ignore EOPNOTSUPP at initialization, but not during workarounds. */
> +	ret = monitors_enable(rdev, ~mons);
> +	if (ret && ret != -EOPNOTSUPP)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int monitors_reenable(struct regulator_dev *rdev, unsigned int mons)
> +{
> +	int reg_enabled;
> +
> +	if (!mons)
> +		return 0;
> +

...here.

> +	/*
> +	 * Monitors of disabled regulators are not turned off, therefore skip
> +	 * turning on.
> +	 */
> +	reg_enabled = _regulator_is_enabled(rdev);
> +	if (reg_enabled <= 0)
> +		return reg_enabled;
> +
> +	return monitors_enable(rdev, mons);
> +}
> +

Sorry but my flight landed so I need to stop reviewing for now... This 
will be a busy week for me. It may be I can't go through rest of the 
patches until later :/

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

