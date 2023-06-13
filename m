Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D384A72DDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbjFMJoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjFMJoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:44:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E91BC7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:44:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8c9cb3144so2986195e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686649443; x=1689241443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GS4ZDwPdVKcB752SYSIB+ydV97yO49nogAsemi0GPWI=;
        b=nVGmNwy9Q14ecN48btygx3eRBRvrmo4+1pPDbypMH4BxMQNYdA5EkjKJ4s0lC2QDSw
         k/bXRsogPeCkrmnhBYZr+lnnEGoh75fOrgq3bexsZPPmY820jmPnh53VanLJqZx8u3If
         /NmAgA6kpQnJ5ERxrPWpYwm+f7vLjn1ib49YWx5HWoBON8uOxpgmZL6o2h5HXVshe58X
         fVaoIRnJ1Peb9NhKedgJv9t/M5uHPbryFV+NeXU6Rg+va9iPw1Ws7Ab7Ep94BPhWEdIH
         GQO1yd10DSdWYdsmJoL9YUM82DYjWzwhrdOBdej8JjUjiPCquTAqB3dcPh2D6h7jpBvI
         bkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686649443; x=1689241443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GS4ZDwPdVKcB752SYSIB+ydV97yO49nogAsemi0GPWI=;
        b=LtOynuZ32hjCdpDW2pEnmf3DLwz+sCJxFMVDQm0OHM4oKlRkDZeqz3AMc6swbLBTYJ
         OKheIkkpY9YciyI/BPxztdBi+ceG1Nkvwijj4mcmh3RzEurPrO+zU2CWZIkWvyEPNoKB
         9i5VbtHZwxwz3CfpweYSiIv16bAAV0z1sz/arJt3qj6dOwwCE7TwO7nUH8/yJP0c4Scr
         l7uhFYA8LfRZyFXQ4kX3F00nZkGV15syJ2tv4oU0py0W+nI6FgUfqILsrQ9p+6Cl4dqV
         3B4dqOc6uAmfZtEhr8HTLm/9WxJkZGOY1ZIRzPBQ+zYdFH5Fn/2RY8CCGLpo1jO10F4x
         ecqA==
X-Gm-Message-State: AC+VfDyUAguoTurMVqrhz9oQXXEik2mXtamrohvdiKNbMhGvKBCqTovc
        WD8aEYLjjGFyosNKnllrYel4eQ==
X-Google-Smtp-Source: ACHHUZ5aRKh3Ud2ou9GmjJW8cZ863CitZMIdu+JB0o8GhAQucSHx3tjIG0Oz9oZoA0/TYAOPtEEXeg==
X-Received: by 2002:a1c:7203:0:b0:3f7:f584:579b with SMTP id n3-20020a1c7203000000b003f7f584579bmr7364121wmc.9.1686649443481;
        Tue, 13 Jun 2023 02:44:03 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d6bf:b78b:2fff:653a? ([2a05:6e02:1041:c10:d6bf:b78b:2fff:653a])
        by smtp.googlemail.com with ESMTPSA id c18-20020a7bc852000000b003f42158288dsm13853752wml.20.2023.06.13.02.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 02:44:03 -0700 (PDT)
Message-ID: <3a840fbf-8250-9870-3caa-3e12c468aa24@linaro.org>
Date:   Tue, 13 Jun 2023 11:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal/drivers/generic-adc: Register thermal zones as
 hwmon sensors
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20230613093054.2067340-1-wenst@chromium.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230613093054.2067340-1-wenst@chromium.org>
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

On 13/06/2023 11:30, Chen-Yu Tsai wrote:
> Register thermal zones as hwmon sensors to let userspace read
> temperatures using standard hwmon interface.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/thermal/thermal-generic-adc.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
> index 017b0ce52122..e95dc354f192 100644
> --- a/drivers/thermal/thermal-generic-adc.c
> +++ b/drivers/thermal/thermal-generic-adc.c
> @@ -13,6 +13,8 @@
>   #include <linux/slab.h>
>   #include <linux/thermal.h>
>   
> +#include "thermal_hwmon.h"
> +
>   struct gadc_thermal_info {
>   	struct device *dev;
>   	struct thermal_zone_device *tz_dev;
> @@ -153,6 +155,12 @@ static int gadc_thermal_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
> +		return ret;
> +	}

Usually, if the hwmon registering fails this is not fatal.

> +
>   	return 0;
>   }
>   

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

