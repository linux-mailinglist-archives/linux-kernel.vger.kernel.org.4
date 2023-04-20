Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779BB6E92E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjDTLeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbjDTLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:34:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3295426BF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:33:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2a8a600bd05so4323301fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681990400; x=1684582400;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9k2DcL5LIOy5FVXrhau77Le/TavhwDcXiePdGdkn10E=;
        b=mIuHnew43aWAiUkGFrBdN4VBr7mU/3XoZwFGscfAMFMAmRIHUbQgOQTxHoge0j4eF8
         gK72n6Nt89/vCHu6N15QrIdNsQLny6OOwKaBxyKYzVtushjMbX6xk2C5EAofM1X6tXCv
         A7lOtHgkvX5X5d7vbEv769uGdezRrD/X5xvoVHDQUEd4TN4EK7/MVW9X7ZI/tvawMcQs
         2dbbVHiubLbisS4V7P/u5sJW8FHFwx/h283GIuQ1ExFTSKxRS32842LRQsIcvfm5yHV+
         e/OLn+dtOJNCt0AOyDV5MF0CqANw0PC5JYO30OsLdka/2YqkaCAFj2E7+JCdAvwTp+AZ
         x8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681990400; x=1684582400;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9k2DcL5LIOy5FVXrhau77Le/TavhwDcXiePdGdkn10E=;
        b=gOGKiXpDn/QkBU5OEne3sNUhXo81Lo71kQBWChz65TlLuRhv1qZkjZXjw0LmyQltN6
         QGRZ1qlLZtXNsuiuvd1rpOi9Ag6wl7IIuhKs/7SadYNS7JN5AoEKaKFcmocnr06Cahh7
         wDcYODXIkobQk02Q+xquY13oFZBhh38aK+sGH0D54RKQGJmhSU5bgJkDvtBvoxVd4QmO
         PH/YGuuVvNcRBw8iMnNMa0r9AYz/pk709BPudJJvCIzIvzrT8F4s3D5cFnN5S4ENNlZs
         UQZ0eGJ3AEhSaAz8mV+BcsMeUAL/QGmB2fom/1Q5cJTEqXg3xbn1E7S4Zcmydk2uJOAs
         iTNA==
X-Gm-Message-State: AAQBX9d5N+X/7q9jh5DAuqncEuf2/PB6dBiia9AHzi1PEI5Ca/Jfpegt
        IpJj42xgWMDwVl1E3tSa0uE=
X-Google-Smtp-Source: AKy350aECTZ+3OHFFsNyNWP3QBkTNs5ugQKyNdK2k6Xy/HX657YkD7LLWWDqZHk3bIvVO5WvfE3Rzw==
X-Received: by 2002:ac2:544c:0:b0:4ed:b09a:6447 with SMTP id d12-20020ac2544c000000b004edb09a6447mr349577lfn.60.1681990399664;
        Thu, 20 Apr 2023 04:33:19 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id o15-20020a056512050f00b004eb258f73a9sm188677lfb.163.2023.04.20.04.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 04:33:19 -0700 (PDT)
Message-ID: <ad59933d-714f-6444-b835-ecd9791934aa@gmail.com>
Date:   Thu, 20 Apr 2023 14:33:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, support.opensource@diasemi.com
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230419-dynamic-vmon-v1-0-f48b7438e891@skidata.com>
 <20230419-dynamic-vmon-v1-1-f48b7438e891@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH RFC 1/2] regulator: introduce regulator monitoring
 constraints
In-Reply-To: <20230419-dynamic-vmon-v1-1-f48b7438e891@skidata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 4/20/23 13:29, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Add constraints for regulator monitoring. These are useful when the
> state of the regulator might change during runtime, but the monitor
> state (in hardware) is not implicitly changed with the change of the
> regulator state or mode (in hardware).
> 
> When used, the core takes care of handling the monitor state. This could
> ensure that a monitor does not stay active when its regulator is
> disabled.

I think this could be useful feature. AFAIR for example the bd718x7 
regulator driver needs to disable the monitoring for the duration of a 
voltage change.

> +static int handle_monitors(struct regulator_dev *rdev, bool pre, bool enable, bool change,
> +			   unsigned int mode)
> +{
> +	const struct regulator_ops *ops = rdev->desc->ops;
> +	const struct regulation_constraints *reg_c = rdev->constraints;
> +
> +	/*
> +	 * ensure that voltage monitoring is explicitly enabled in the device tree and that the
> +	 * driver has monitoring constraints and protection ops.
> +	 */
> +	bool handle_ov = reg_c->over_voltage_detection && reg_c->ov_constraints &&
> +			 ops->set_over_voltage_protection;
> +	bool handle_uv = reg_c->under_voltage_detection && reg_c->uv_constraints &&
> +			 ops->set_under_voltage_protection;

Hm. Is there a reason why we need to perform these checks for each of 
the calls? Could we do checks when regulator is registered? Also, could 
we just directly have function pointers to monitoring disabling which 
would be populated by the driver. Core would then call these callbacks 
if they were populated (instead of these flags and unconditional call to 
handling). This might have other benefits as well (please see below).

> +	int ret = 0;
> +
> +	if (!handle_ov && !handle_uv)
> +		return 0;
> +
> +	dev_dbg(&rdev->dev, "%s: pre: %d, en: %d, ch: %d, mode: %u\n", __func__, pre, enable,
> +		change, mode);
> +	if ((enable + change + !!mode) > 1) {
> +		dev_err(&rdev->dev, "%s: invalid combination!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (handle_ov) {
> +		if (should_disable_monitor(reg_c->ov_constraints, pre, enable, change, mode))
> +			ret = handle_notify_limits(rdev, ops->set_over_voltage_protection,
> +						   &disable_limits);
> +		else if (should_enable_monitor(reg_c->ov_constraints, pre, enable, change, mode))
> +			ret = handle_notify_limits(rdev, ops->set_over_voltage_protection,
> +						   &reg_c->over_voltage_limits);
> +	}
> +	if (ret)
> +		return ret;
> +
> +	if (handle_uv) {
> +		if (should_disable_monitor(reg_c->uv_constraints, pre, enable, change, mode))
> +			ret = handle_notify_limits(rdev, ops->set_under_voltage_protection,
> +						   &disable_limits);
> +		else if (should_enable_monitor(reg_c->uv_constraints, pre, enable, change, mode))
> +			ret = handle_notify_limits(rdev, ops->set_under_voltage_protection,
> +						   &reg_c->under_voltage_limits);
> +	}
> +
> +	return ret;
> +}
> +
> +static inline int handle_monitors_disable(struct regulator_dev *rdev)
> +{
> +	return handle_monitors(rdev, true, false, false, REGULATOR_MODE_INVALID);
> +}
> +
> +static inline int handle_monitors_enable(struct regulator_dev *rdev)
> +{
> +	return handle_monitors(rdev, false, true, false, REGULATOR_MODE_INVALID);
> +}
> +
> +static inline int handle_monitors_set(struct regulator_dev *rdev, bool pre)
> +{
> +	return handle_monitors(rdev, pre, false, true, REGULATOR_MODE_INVALID);
> +}
> +
> +static inline int handle_monitors_mode(struct regulator_dev *rdev, bool pre, unsigned int mode)
> +{
> +	return handle_monitors(rdev, pre, false, false, mode);
> +}
> +
>   /**
>    * set_machine_constraints - sets regulator constraints
>    * @rdev: regulator source
> @@ -1512,7 +1612,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
>   			  "IC does not support requested over-current limits\n");
>   	}
>   
> -	if (rdev->constraints->over_voltage_detection)
> +	/* only if we have static monitoring. with dynamic, it will be set according to state. */
> +	if (rdev->constraints->over_voltage_detection && !rdev->constraints->ov_constraints)
>   		ret = handle_notify_limits(rdev,
>   					   ops->set_over_voltage_protection,
>   					   &rdev->constraints->over_voltage_limits);
> @@ -1526,7 +1627,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
>   			  "IC does not support requested over voltage limits\n");
>   	}
>   
> -	if (rdev->constraints->under_voltage_detection)
> +	/* only if we have static monitoring. with dynamic, it will be set according to state. */
> +	if (rdev->constraints->under_voltage_detection && !rdev->constraints->uv_constraints)
>   		ret = handle_notify_limits(rdev,
>   					   ops->set_under_voltage_protection,
>   					   &rdev->constraints->under_voltage_limits);
> @@ -2734,7 +2836,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
>   
>   	trace_regulator_enable_complete(rdev_get_name(rdev));
>   
> -	return 0;
> +	return handle_monitors_enable(rdev);

Eg, instead of unconditional call to handle_monitors_enable() could we 
here check if driver has given us a pointer to monitoring disabling 
function? Or, do you think it would be worth making this a tiny bit more 
generic by just doing some 'pre_enable' and 'post _disable' callbacks 
which driver can populate? Maybe we could also add 'ready-to-use' 
default helpers which drivers (who just want to propagate the call to 
ops->set_over_voltage_protection et al) could use.

I think that some PMICs I've seen had separate 'disable/enable all 
monitors' bit which needed to be used when monitoring was 
disabled/enabled due to an operation [voltage change/disable/enable].

If we allowed driver to populate the disabling callbacks, then this 
would support also those ICs which need to disable multiple monitors for 
the duration of an operation (or do some other strange stuff). It would 
also allow drivers to add delays to the function(s) re-enabling of 
monitors when needed - at least the bd718x7 had to wait for new voltage 
to stabilize prior re-enabling the monitors.


>   
> +/**
> + * struct monitoring_constraints - regulator monitoring constraints.
> + *
> + * This struct describes monitoring specific constraints.
> + *
> + * The constraints should be set by a driver if an enable/disable or regulator MODE switch does not
> + * change the state of the monitor implicitly. When used, the core handles the monitoring of a
> + * dynamic regulator implicitly on state/mode change, based on this configuration. This should
> + * avoid that the monitor reaches an invalid state.
> + *
> + * @mon_disable_during_reg_set: Monitor should be disabled before and enabled after the regulators'
> + *                              value is changed
> + * @mon_disable_during_reg_off: Monitor should be disabled before a regulator disable and enabled
> + *                              after a regulator enable
> + *
> + * @mon_disable_pre_reg_idle: Monitor should be disabled before a switch to MODE_IDLE
> + * @mon_disable_pre_reg_standby: Monitor should be disabled before a switch to MODE_STANDBY
> + * @mon_enable_post_reg_normal: Monitor should be enabled after a switch to MODE_NORMAL
> + * @mon_enable_post_reg_fast: Monitor should be enabled after a switch to MODE_FAST
> + */
> +struct monitoring_constraints {
> +	unsigned mon_disable_during_reg_set:1;
> +	unsigned mon_disable_during_reg_off:1;
> +
> +	unsigned mon_disable_pre_reg_idle:1;
> +	unsigned mon_disable_pre_reg_standby:1;
> +	unsigned mon_enable_post_reg_normal:1;
> +	unsigned mon_enable_post_reg_fast:1;
> +};

So, could we perhaps have function pointers for these in the ops instead 
of flags? Core could then call these if set? Do you think that would work?

> +
>   #define REGULATOR_NOTIF_LIMIT_DISABLE -1
>   #define REGULATOR_NOTIF_LIMIT_ENABLE -2
>   struct notification_limit {
> @@ -207,6 +237,10 @@ struct regulation_constraints {
>   
>   	unsigned int active_discharge;
>   
> +	/* monitoring constraints */
> +	const struct monitoring_constraints *ov_constraints;
> +	const struct monitoring_constraints *uv_constraints;
> +
>   	/* constraint flags */
>   	unsigned always_on:1;	/* regulator never off when system is on */
>   	unsigned boot_on:1;	/* bootloader/firmware enabled regulator */
> 

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

