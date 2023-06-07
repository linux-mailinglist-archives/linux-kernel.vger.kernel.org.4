Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B6725A37
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbjFGJYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbjFGJY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:24:26 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A458E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:24:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3094910b150so7182456f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686129863; x=1688721863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHiJavEgLpvPSoAWMa5+afasJi2XtguSQGZabSBoZy4=;
        b=yIDOuj7qUNG9ylsspk2Kypvp30Q/UrBU5ozHjp0V0cIlT1FfoESemKGtuMJFsMI9gP
         ZQH9lGtuSodflpCW7WqFbNbVI8xj9beDwYYM/mYHXesZ3W4IX8jzUj501t6Lem3XoiTt
         OgDSDveDLa7WsJZvb8EQFPZG7t2JS/eeHNITmntY896PbJS+2C9DBWcJ9C5SlXfK9RGY
         r9IknGQtYpn0TzDrNvRh9mUtZEFum8gPhlu4ltQhZ9lfW/634lyTYG290DNvK7bJKptE
         E+ZrSaUOmQZnfm0Vplh1OWz/0l4hmAy5AV12s8VOj25xqISkAy3uJ0NnWIe7Lk2HYdTK
         Fi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129863; x=1688721863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHiJavEgLpvPSoAWMa5+afasJi2XtguSQGZabSBoZy4=;
        b=IYl3+nd7sORihBx6HD43craLilb08hBFnRmwwxyyTeC2C981yuMFLbMfKzSM2LduWP
         v9/bNp1SeuqHYTXTpM0lyCJ2Mr+qzBXYDYcD3p0+y9a2I2bTb8Qb8edzMHMf9ONbKcBQ
         n/K8R05RPsKVAsMMEgS8KX85VStQ7Z7vTZ6+AjXcOiNwYwAjhOLblbtMqP0qu+sRxT51
         ISuPUebk7k7JA+wxLBwXf5CiY68CJSbQuRw7Oy07AEsq3E2PPiipQVqb2I3erla8Xaw0
         jbwuUJWlLP0UOZbDmuFAcIEGg+TCE78O36rore0FR1EV3rs1X7HiyyrQ0YKx/CoStohe
         PKww==
X-Gm-Message-State: AC+VfDzg6Xxk5hnUmSTZ5QTP4Gf6a1g5zZqRQyJra2GapytY3itXTQ0Z
        D2LIazY+RVl+luxTpkNoSR6eQA==
X-Google-Smtp-Source: ACHHUZ5O4Fpz4/8sz3Ma22BHJaCCEsF27TTTWpL4mIJyJoYmHDyN4aF1OIDyfDZ+7yNgQpnTvLdZzw==
X-Received: by 2002:a5d:5341:0:b0:30e:1fc4:d0c9 with SMTP id t1-20020a5d5341000000b0030e1fc4d0c9mr3726783wrv.9.1686129863290;
        Wed, 07 Jun 2023 02:24:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d8fb:84d9:d402:6b22? ([2a05:6e02:1041:c10:d8fb:84d9:d402:6b22])
        by smtp.googlemail.com with ESMTPSA id y13-20020adfd08d000000b003063db8f45bsm14852094wrh.23.2023.06.07.02.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 02:24:22 -0700 (PDT)
Message-ID: <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
Date:   Wed, 7 Jun 2023 11:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Content-Language: en-US
To:     Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230607003721.834038-1-evalenti@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


Hi Eduardo,

On 07/06/2023 02:37, Eduardo Valentin wrote:
> From: Eduardo Valentin <eduval@amazon.com>
> 
> As the thermal zone caches the current and last temperature
> value, the sysfs interface can use that instead of
> forcing an actual update or read from the device.

If the read fails, userspace can handle that by using the previous 
value. Do we really want to hide driver dysfunctions?

> This way, if multiple userspace requests are coming
> in, we avoid storming the device with multiple reads
> and potentially clogging the timing requirement
> for the governors.


Can you elaborate 'the timing requirement for the governors' ? I'm 
missing the point

> Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
> Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
> Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
> Cc: linux-pm@vger.kernel.org (open list:THERMAL)
> Cc: linux-kernel@vger.kernel.org (open list)
> 
> Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> ---
>   drivers/thermal/thermal_sysfs.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index b6daea2398da..a240c58d9e08 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -35,12 +35,23 @@ static ssize_t
>   temp_show(struct device *dev, struct device_attribute *attr, char *buf)
>   {
>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	int temperature, ret;
> -
> -	ret = thermal_zone_get_temp(tz, &temperature);
> +	int temperature;
>   
> -	if (ret)
> -		return ret;
> +	/*
> +	 * don't force new update from external reads
> +	 * This way we avoid messing up with time constraints.
> +	 */
> +	if (tz->mode == THERMAL_DEVICE_DISABLED) {
> +		int r;
> +
> +		r = thermal_zone_get_temp(tz, &temperature); /* holds tz->lock*/
> +		if (r)
> +			return r;
> +	} else {
> +		mutex_lock(&tz->lock);
> +		temperature = tz->temperature;
> +		mutex_unlock(&tz->lock);
> +	}

No please, we are pushing since several weeks a lot of changes to 
encapsulate the thermal zone device structure and prevent external core 
components to use the internals directly. Even if we can consider the 
thermal_sysfs as part of the core code, that changes is not sysfs related.

>   	return sprintf(buf, "%d\n", temperature);
>   }

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

