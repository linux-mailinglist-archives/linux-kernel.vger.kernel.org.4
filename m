Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB446ECE54
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjDXNbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjDXNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:31:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E876B6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:30:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4eed6ddcae1so19128889e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682343036; x=1684935036;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84lZ63EJ/vtFwbNlLMlRnksP+nVV8Vp+w0mPgUs95gI=;
        b=srzrh6P1Be+6cLAUprzdLyCGD7cvIAveiGMYCdzo8/dE1FDw6UlnaRw+KvISoi7oos
         GbpvdTV8PNH9B7YQw91g2SlnDi0WWrVh0+KW6bnH3fonGupI3ClyYZx3Vy1Db0SfnOqY
         thpK/Y+wj68kxAQFNvMGQevxVPRFrxbxb/0prW++oJGiAwYDAPoFzvPVZN96tsozFlv1
         OeuIXp/3l+prwkyxz/4ET7q4qdP1USX/avyK3Vw3B2AcP/96fTSPopwj5vab9iRmgO2k
         8PM4MX/7YuRhGQBKYZNz6TCk3ACF62OPxssJwVSj7NN4Og/0Tf7jTZzQbV95PwwsyVjy
         ARfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682343036; x=1684935036;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84lZ63EJ/vtFwbNlLMlRnksP+nVV8Vp+w0mPgUs95gI=;
        b=Wmsdg/k25IJC82aZxettzjmz6bSa5PXdsRFLfWSe9ZpCZzZH641HljkbYJsXFToSxv
         jfUheUJy0uOv6dA9PebguZL8lFIMP+hZhv3Lxi5tbkjcQlkDhxUhcbxob2z+Uzvv5CGI
         TG9LRpdCExhXMtt8J9G/yPufbY8IS/cTFl/y6NDOC6845g3V/hxJ2CQSrFbWTsp9NvlN
         IYn6ZICC3G7q/2lNSkQSt7pt6VyE60Tj1vVNM8Bn5IgAZ9Kd2Y0b3LBj2Tm9ZBVwzAZr
         jdM2aym6HV0mMqtT/96tteoikKR4CWxkZMbGXMLBqyGJ98HXTB4fOxLk4hv/NmU0REns
         03GA==
X-Gm-Message-State: AAQBX9eZjUThOgaftleu8CXxxy0617cQVS+0CbmzvFKKo3DMoxZa7a7f
        7nuYdtlHvmm1e4WxAe1Ousr6q3LT59Y=
X-Google-Smtp-Source: AKy350aO18Ldpnqto1M66MhdMhIfeS2zhjjqyb24pZuj0Cylm6CXe1x4ozY3p4y4y5zPeLso0ycFBg==
X-Received: by 2002:a2e:800c:0:b0:2a8:e84e:4e5a with SMTP id j12-20020a2e800c000000b002a8e84e4e5amr2949401ljg.21.1682343036132;
        Mon, 24 Apr 2023 06:30:36 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id f24-20020a2e9198000000b002a8c32fd2f3sm1766286ljg.89.2023.04.24.06.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 06:30:35 -0700 (PDT)
Message-ID: <244225d6-5391-9f31-5065-c44318d7e235@gmail.com>
Date:   Mon, 24 Apr 2023 16:30:35 +0300
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
References: <20230419-dynamic-vmon-v2-0-c303bcc75ebc@skidata.com>
 <20230419-dynamic-vmon-v2-1-c303bcc75ebc@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH RFC v2 1/2] regulator: add properties to disable
 monitoring on actions
In-Reply-To: <20230419-dynamic-vmon-v2-1-c303bcc75ebc@skidata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/23 12:13, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> These are useful when the state of the regulator might change during
> runtime, but the monitors state (in hardware) are not implicitly changed
> with the change of the regulator state or mode (in hardware). Also, when
> the monitors should be disabled while ramping after a set_value().
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>   drivers/regulator/core.c         | 64 ++++++++++++++++++++++++++++++++++++----
>   include/linux/regulator/driver.h | 10 +++++++
>   2 files changed, 68 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 4fcd36055b02..5052e1da85a7 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -1360,7 +1360,7 @@ static int notif_set_limit(struct regulator_dev *rdev,
>   
>   static int handle_notify_limits(struct regulator_dev *rdev,
>   			int (*set)(struct regulator_dev *, int, int, bool),
> -			struct notification_limit *limits)
> +			const struct notification_limit *limits)
>   {
>   	int ret = 0;
>   
> @@ -1385,6 +1385,29 @@ static int handle_notify_limits(struct regulator_dev *rdev,
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
> +static int monitors_set_state(struct regulator_dev *rdev, bool enable)
> +{
> +	const struct regulation_constraints *reg_c = rdev->constraints;
> +	const struct regulator_ops *ops = rdev->desc->ops;
> +	int ret = 0;
> +
> +	/* only set the state if monitoring is activated in the device-tree. */
> +	if (reg_c->over_voltage_detection)
> +		ret = handle_notify_limits(rdev, ops->set_over_voltage_protection,
> +					   enable ? &reg_c->over_voltage_limits : &disable_limits);
> +	if (!ret && reg_c->under_voltage_detection)
> +		ret = handle_notify_limits(rdev, ops->set_under_voltage_protection,
> +					   enable ? &reg_c->under_voltage_limits : &disable_limits);

I still think forcing the use of the set_over_voltage_protection() / 
set_under_voltage_protection() (and omitting over-current protection) 
instead of allowing the driver to populate potentially more suitable 
callbacks is somewhat limiting.

For example, the only _in-tree_ regulator driver that I know is 
disabling monitors at voltage change is the bd718x7. There we have extra 
conditions for disabling - the power must be enabled (which could 
probably be a generic condition for disabling monitoring at voltage 
change), and also the new voltage must be greater than the old voltage. 
This logic is naturally implemented in set_under_voltage_protection - 
which should unconditionally disable the monitoring if it is requested 
via device-tree.

After that being said - I am leaving weighing pros and cons to You and 
Mark - I don't feel I am in a position where I should dictate the design 
here. I'll just say that if the new generic disabling unconditionally 
uses set_under_voltage_protection - then at least the bd718x7 can not 
benefit from it w/o relaxing the monitoring.

Finally, thanks Benjamin for improving things here!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

