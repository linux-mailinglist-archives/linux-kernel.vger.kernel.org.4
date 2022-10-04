Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFC05F487E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJDRaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJDRaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:30:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BFC62925
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:30:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so22385419wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ii4EWTzWzMKDISP9sP+5PqajfnmjPx6K0dPKG/qlzGk=;
        b=oOpdZX9uOyyBE9XAA4mmSH5QSRW5Z7soUTUD+gNtxXJGUpSsv/0VJ+Lrtnxgr2QBA/
         F36GDf9QbipvrogfYZvYqdI6+K1LltMqUGNSolGk4bxLVvuqQG7y+REeLrmQeihPbnzL
         juOnh+P0YALNC8mbtLzbLdh3qvRAWZ657IETvr5i40AMTLxYdmBlehVSOvgw40dRtC7+
         Ea/fG89U8DuoFNG4Qg1aH5y1bguW4VOd2kPFqOyd5tCvPScvs1N1JYfY/C0xr1v+kzlG
         dLDUXCOOfXgqim+7GM2YL3etzdLCFU8yP6oa7Nrq0d95OoJ6/XB92+GYDrPyCZo5kj0D
         kn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ii4EWTzWzMKDISP9sP+5PqajfnmjPx6K0dPKG/qlzGk=;
        b=WGt2pfxlnlwUAgefBqc8tRZo3C2dLnmW8QDgIFEsIViz7QP3AZaqHthNsI3OJnJU8g
         87kPE6s/PeQLReh6jCK5AVYSETFvpR77tF0Kh2cvIGqMG0Enw7KiSomgSn8ECsPIMnu4
         pdyAYnApeaiZ901x/K+KlJSEkwNfz3ClnfmIyqI8MdzUO4JeBgfV+UX/urTog5G1pXfo
         6+JkAoADu+bmLzNqcP75dFZ/WTMDT1nN26Ru87qEcB9tXbLd4KeVrAP8+FcfCIULnCBn
         ncJhW2risXH/9/49PR6zB4VPnYsmveE0AjHSSQ6m/rbAD1wx9UHtrUJNav2CUpiLHTjv
         ntLQ==
X-Gm-Message-State: ACrzQf3U+FtMyT+j/6Jt2kZvF5NRXeaFhO4DU8mFOSS3GdRfE4w5OFX9
        uIDdzh87Mwo0rC13QUEm07JL3Q==
X-Google-Smtp-Source: AMsMyM5lLxEAEm0+uIHax0B/5VyQsw0VHuDhMtthOq4XSNM/vaH9NwFtAk3EUi8cCsaGKrLRpGNfTg==
X-Received: by 2002:a5d:6da2:0:b0:22e:4244:953a with SMTP id u2-20020a5d6da2000000b0022e4244953amr5573628wrs.225.1664904612188;
        Tue, 04 Oct 2022 10:30:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c456:8337:99aa:2667? ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.googlemail.com with ESMTPSA id az30-20020adfe19e000000b002286670bafasm2613521wrb.48.2022.10.04.10.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 10:30:11 -0700 (PDT)
Message-ID: <0297ff96-0c68-6fa1-07e8-11ca316c817c@linaro.org>
Date:   Tue, 4 Oct 2022 19:30:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal/core: Fix parameter check when setting trip point
 temperatures
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
References: <20221004171843.2737200-1-linux@roeck-us.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221004171843.2737200-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Guenter,

this has been already fixed and the PR has been sent to Rafael:

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tag/?h=thermal-v6.1-rc1-2

Thanks for sending the fix anyway

   -- Daniel

On 04/10/2022 19:18, Guenter Roeck wrote:
> Commit 9326167058e8a ("thermal/core: Move set_trip_temp ops to the sysfs
> code") changed the parameter check in trip_point_temp_store() from
> 
> 	if (!tz->ops->set_trip_temp)
> 
> to
> 	if (!tz->ops->set_trip_temp && !tz->trips)
> 
> That means the condition will pass if either tz->ops->set_trip_temp
> or tz->trips is not NULL. Subsequently, access to tz->trips is
> checked again, but tz->ops->set_trip_temp is called unconditionally.
> This will result in a crash if the set_trip_temp callback is not set.
> Add check if tz->ops->set_trip_temp is NULL before trying to call it.
> 
> Fixes: 9326167058e8a ("thermal/core: Move set_trip_temp ops to the sysfs code")
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/thermal/thermal_sysfs.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 78c5841bdfae..ec495c7dff03 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -128,9 +128,11 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>   	if (kstrtoint(buf, 10, &temperature))
>   		return -EINVAL;
>   
> -	ret = tz->ops->set_trip_temp(tz, trip, temperature);
> -	if (ret)
> -		return ret;
> +	if (tz->ops->set_trip_temp) {
> +		ret = tz->ops->set_trip_temp(tz, trip, temperature);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	if (tz->trips)
>   		tz->trips[trip].temperature = temperature;


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
