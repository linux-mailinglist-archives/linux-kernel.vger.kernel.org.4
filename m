Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85446CD719
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjC2J5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjC2J5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:57:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D186E1BC8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:57:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l12so15004763wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680083853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpDwgmB/u9vyHkL9sWwGB0UNeE/S7UThI/HZB1NgANU=;
        b=fz4NvHv1EzsirLqLhPN2yCBBo7zPz9i6igQXeykMIbVXnmacbZlaVloT9oExv6leb2
         //O9TTeUtlAcEi9YOGiUO3/IKFI6n/ImQdMBUy77kopI2pW4hA3DTqocZIZNRqG4mzAC
         IkSn2Qu8uUpa7/oGGpw7JCuTerPTVqHH9ZeZP+yutTSp1Od9ZCmfqm+d4OrFN4R3Pdcy
         ptogcAi11EP4LUGscAowEn5PZ7qGgFRyKRuuYo3zIaiGABts42vkFzwQkWgk/e5ta4y7
         WRv3D2hsICB3Ur4m0Ra7SchroZ+C5uiBoo1uHFaapTZGPcmhLQt+FjLThZRbvd1bamI2
         zw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680083853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpDwgmB/u9vyHkL9sWwGB0UNeE/S7UThI/HZB1NgANU=;
        b=yNx/UU7ykkGUuxcD64P6rdrmb95C1HiS6Usei+QT0KV/RVyy3PSm/nQldwCHWO18Hz
         sxtdky4lt2ZUHKqeIeia3z/mRFYMQ/7ws94b0VH6zS4F0USwRqD7jkksdRL5ZMXgnG/p
         gLMxgJ281NgWUJ+D6zhs8wkuGlK5pYWqCVSMaurEH4dlX2FM9K6nvPjkiFpoLE792yTy
         7uzSCyw421pEWNxFXrVJPWa/yKSlZRVnJFBpzeqMhzqyb8Wo8jOs5v63bjCqu7NhZsR0
         cnsCggbmla0SE0Y4DJvvfQdlbONk3WSo0UIOhWCU2RAjdxJwWn0jq4aEZutqN5yznl5K
         nOkA==
X-Gm-Message-State: AAQBX9fyBK354ErXxWQYX/Pey9tDOUTPfIlW28M4ehLQ59rIjQ42UEWu
        K/VbtadyFX7QuINhKWQlqZFBsg==
X-Google-Smtp-Source: AKy350Y8qL++D6j6z5nLdN20qyPBtNIjwnzZlz09QrPn7OlTDICNYhXSCdI9pFBsycaLCxXy+Xpc2w==
X-Received: by 2002:a5d:590c:0:b0:2c7:d7c:7d7 with SMTP id v12-20020a5d590c000000b002c70d7c07d7mr1164710wrd.22.1680083853278;
        Wed, 29 Mar 2023 02:57:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8f24:e6f1:ea42:cf21? ([2a05:6e02:1041:c10:8f24:e6f1:ea42:cf21])
        by smtp.googlemail.com with ESMTPSA id i1-20020a5d6301000000b002d9568395f8sm19705034wru.36.2023.03.29.02.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 02:57:32 -0700 (PDT)
Message-ID: <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
Date:   Wed, 29 Mar 2023 11:57:32 +0200
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
> ---
> Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
> dec07d399cc8 is a commit in the linux-next branch of linux-pm repo.
> I'm not sure if the Fix tag applies to such commit or not.

Actually it reverts the work done to encapsulate the thermal zone device 
structure.

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

As it 'Should never happen', I would replace that by:

	if (WARN_ON(!hwmon))
		/* Should never happen... */
		return;



>   		return;
>   	}
>   

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

