Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB496CEE81
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjC2QCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjC2QB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:01:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AF35BB8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:00:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q19so13210960wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680105630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArwpNVIf9POAixbklkhIv67If2EwgIZ+QA4ChZDwYgE=;
        b=Idh5bizNTidzmJWpFEgi4q88BF2+/lO675pVeMaNsr8ygV36SvVkmWzi+QBNiYJKu6
         tF5oIdEWoj9xksHV/Xh4B2dTuZbzjgbBCTkwp67pEUOiif8JVbwKT2DIsUJd9GVb3CRo
         47Rj6TldHbceb66V68BIp976mKiukc2vkMUla6L7tV9MGqQ4sf2ibQf0WoYH9bCeSFGq
         NIOlXf1sFNwfiWODEiK8SIJcHA+NJ8UbpqrP+yLm2t/qnphTwYpc6Chxnlotla+7lUiZ
         lkvuRshIJgjHnsBbpXYjPnD6tIKAeDfnYY1juoZlKdm7rN1zNc6YRdEEtKEaEyhdGSwf
         yO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArwpNVIf9POAixbklkhIv67If2EwgIZ+QA4ChZDwYgE=;
        b=hW0MOYW7fIGrcuJoxkEWRU19UyXeKuru7vYv8+hPbaFO8Qu+bBtx7B13pb2HmzyQBT
         IYRPmdmaZoL5SSuvBKo/rKiJl7k1BgwKWI2BXlPwjPUUtBpXOZ1QXBeJo1DVrbsGatNn
         f4ZMQ6GF9BUTa13EtL+5ZSrymJ2Y5o/4NARPn5CH2QmCq0wrLIqcu+oMv9J2iJZ3l+pd
         I+TvaPRzNd/4Ky3jIluNjn3U0LIpZKLZyjcCxJJbd37YGBujv9SSCOgoMc7d6oaauDFX
         VMShEvvT1Qt8CLxorgI8ujqBFjTKX5Iq73ro0412pVzFe1+GTNBnmdHI03n21RPnNp9v
         68sg==
X-Gm-Message-State: AAQBX9dw3WF/rkL+cMYMxocRPGcSQNceNWuZJFbAOTSjvtll/Ar4YJnD
        lv/+bG4BhYf6bdCx6+x68VHKhA==
X-Google-Smtp-Source: AKy350bmfLsfH9MB3jVTmKwHrCdVGLJBaNHbyMMHil+19zF7gmCcgdeO3qEC0rHmFr/2uB1iBH/aJA==
X-Received: by 2002:a5d:4588:0:b0:2cf:ed87:37c9 with SMTP id p8-20020a5d4588000000b002cfed8737c9mr2251984wrq.11.1680105629985;
        Wed, 29 Mar 2023 09:00:29 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7c0e:2838:74e9:d05? ([2a05:6e02:1041:c10:7c0e:2838:74e9:d05])
        by smtp.googlemail.com with ESMTPSA id b9-20020adfde09000000b002daeb108304sm17446206wrm.33.2023.03.29.09.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 09:00:29 -0700 (PDT)
Message-ID: <77da9d68-3cb2-f765-21d2-e427776dca44@linaro.org>
Date:   Wed, 29 Mar 2023 18:00:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230329090055.7537-1-rui.zhang@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230329090055.7537-1-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 11:00, Zhang Rui wrote:
> When the hwmon device node of a thermal zone device is not found,
> using hwmon->device causes a kernel NULL pointer dereference.
> 
> Reported-by: Preble Adam C <adam.c.preble@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
> dec07d399cc8 is a commit in the linux-next branch of linux-pm repo.
> I'm not sure if the Fix tag applies to such commit or not.
> ---
>   drivers/thermal/thermal_hwmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index c59db17dddd6..261743f461be 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -229,7 +229,7 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>   	hwmon = thermal_hwmon_lookup_by_type(tz);
>   	if (unlikely(!hwmon)) {
>   		/* Should never happen... */
> -		dev_dbg(hwmon->device, "hwmon device lookup failed!\n");
> +		dev_dbg(&tz->device, "hwmon device lookup failed!\n");
>   		return;
>   	}
>   

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

