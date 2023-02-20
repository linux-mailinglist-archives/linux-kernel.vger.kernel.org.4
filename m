Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF9769CC1F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjBTNeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjBTNeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:34:16 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690351A659
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:34:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so882110wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:to:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MTcE1D6Wq+f2x/4bGVRNKlqQDDwTAwPuTBkZqVC40M=;
        b=RzLz7H+PRYdW8zKmbhU5lTHnS2bdRG5p+9hkdCoJAl3LUecYi5jw2fRx/lGL4yOtKQ
         RFRJK0ECoKdekHErYwdieWEv5VnlF5CxBR8Gum2vsPThyprhgDpout9ngt0l3pX5aemj
         X+ZIl4ScQCAzdbBINRhEp9+mGJud8UGYHXYaTiIWOtb9PdtMo+afLUHxAelX3HQjlnFb
         1OBfcYRafj5IabmHn8tq9z/XAjeooGsKopjFKTHVF8B3vKN158wJY3vOB5qcV29Evqtu
         64d4HHc2Ep3zm93PpHJ49LyI4e00EdXlDYbWghCBHm5PC4HEbzgV00olx5ZVJ6fjyGE6
         0qwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:to:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MTcE1D6Wq+f2x/4bGVRNKlqQDDwTAwPuTBkZqVC40M=;
        b=gS2K7EOX0xv1YYaW6oIeTvG2BQLGTrbicYxgC5m3VY6q/7VoeE6HiocI4kC17Jx+gw
         4UINOkQa3eXyNA+yfI4L9N3/jltjZQigSoHOa2YDtMXFBSVlOcPgu2JKyHQgMwDB+c9i
         uDdEzKGtgqPdvE7Q4rr5ST3DVmXu/Md8eM1XxPcWgjy/vGXnlH6yMOiWQBh5LXGr/1rC
         CIoGkGbqgxbtd+nkEQY+iPNGNI5KgdMhFx1Z2XlupwQKuG3NywrxOmiTKG+HLo+Osepd
         7Q8ypW2C6knPLSNGcKSXaKilGoY2EDQVhXwiRGYH45VCztORTNbiyr6j5IxtFwRx4z2+
         +T3w==
X-Gm-Message-State: AO0yUKX6KtxV5gRspSk6yeyrUoC93YJpqb8qEOp/xtKw8OXZFwmIobNK
        TeyTmqQjeKxBmALALWr0iSMArw==
X-Google-Smtp-Source: AK7set81/Q7A64hUMTxW9WOSXdz9VNxzNMtMlyoZCzc3TwuBvqQd5+65Z3Ox48WTaqWewhjp/zNiFw==
X-Received: by 2002:a05:600c:319a:b0:3db:5f1:53a5 with SMTP id s26-20020a05600c319a00b003db05f153a5mr448165wmp.20.1676900049817;
        Mon, 20 Feb 2023 05:34:09 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:8d87:e6b4:7d0f:3fdb? ([2a05:6e02:1041:c10:8d87:e6b4:7d0f:3fdb])
        by smtp.googlemail.com with ESMTPSA id k18-20020a05600c409200b003db06224953sm1562488wmh.41.2023.02.20.05.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 05:34:09 -0800 (PST)
Message-ID: <9ac3a59f-a3b7-4128-87d0-7b3310ce7828@linaro.org>
Date:   Mon, 20 Feb 2023 14:34:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 07/17] thermal/hwmon: Use the thermal API instead
 tampering the internals
Content-Language: en-US
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
 <20230219143657.241542-8-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230219143657.241542-8-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

my script should have Cc'ed you but it didn't, so just a heads up this 
patch ;)

On 19/02/2023 15:36, Daniel Lezcano wrote:
> In this function, there is a guarantee the thermal zone is registered.
> 
> The sysfs hwmon unregistering will be blocked until we exit the
> function. The thermal zone is unregistered after the sysfs hwmon is
> unregistered.
> 
> When we are in this function, the thermal zone is registered.
> 
> We can call the thermal_zone_get_crit_temp() function safely and let
> the function use the lock which is private the thermal core code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_hwmon.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index bc02095b314c..15158715b967 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -77,15 +77,7 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
>   	int temperature;
>   	int ret;
>   
> -	mutex_lock(&tz->lock);
> -
> -	if (device_is_registered(&tz->device))
> -		ret = tz->ops->get_crit_temp(tz, &temperature);
> -	else
> -		ret = -ENODEV;
> -
> -	mutex_unlock(&tz->lock);
> -
> +	ret = thermal_zone_get_crit_temp(tz, &temperature);
>   	if (ret)
>   		return ret;
>   

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

