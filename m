Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F446DB0B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjDGQfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDGQfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:35:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D52101
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 09:35:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j1-20020a05600c1c0100b003f04da00d07so4635710wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680885337; x=1683477337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LWQOIvTwhrFrh6vq2dg+9vFk4VF5GD4ZMBBHufppog=;
        b=zNnMPagkVYUM+vYSsaAGaAGpn3lxq3ikZLg+8TGa8DsROh18ELzy7kxabO3Ue+PEA5
         Tdu0/uUEWI24i5Nnn5WVnWIvjwAHdHDIjY+qzOk9Dhigu1bMwPpKdCmjSp7FVVFwP0ik
         foCEdw0qpwGoXXoW561M+s49jiz90VtISVEMddUj5wV4bQ2gXudfT6FDw5SgDWA2w2GI
         CbkMjMX92KdTD7TA7At/ayzA3Qifmva0sr2XZnEVWZ14KKLj5AkNGqU+321xzi8wxCY1
         rftfFtWNuXiShThLvENGHObBj+nVxzWRoZ2ZbWf/yW0jf5lMjC8NibhFLjuG4fwrTCBt
         Mb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680885337; x=1683477337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LWQOIvTwhrFrh6vq2dg+9vFk4VF5GD4ZMBBHufppog=;
        b=zp+z93RyHADf8TfGc0a1oW8Yif8z+VsIvTT6sEgbUB0u7e669ZgssVAiccIv875mi2
         1x7HhhquRZQra1ZyB2d8ZNPu589Yy2md9c0YBC9QFKyZmsCr4+fYhsXqSqAaG1UuqtF4
         cIA9vnoo4hawUrfCJkcRgdmF/88xm4Z97NzGvGeouYOM9OQO5CEnmjIbA3kjkhHVaqjU
         o6/7zOCY9L6KOadBEp4bbQpmFrW06yNxTTSgyCK+DoKDXjZbx8nhOT3X5wRo1CYMrY5v
         /+Z3Um5z7qOzt6FT8ho+FZHzRp6Pye2pAzz4xgWSp7j1G09pdgLQmOorsMu2V90VTeJ1
         qihA==
X-Gm-Message-State: AAQBX9fRaNHy8h6MrbbxbVsLq/FCQuvhg/ivuTRY2dN1xQFdUAutn97H
        bG4rEJSwJEIQpSNQWR8qi2Mu7g==
X-Google-Smtp-Source: AKy350YJOeUd8xhIUyjp5pWP9gzgVtHoK0TFSPacwdFAv0zDmOmrEt4wKCjMTEsadJdv+PlskprhIw==
X-Received: by 2002:a05:600c:215:b0:3ef:d386:1a3b with SMTP id 21-20020a05600c021500b003efd3861a3bmr2231719wmi.34.1680885337338;
        Fri, 07 Apr 2023 09:35:37 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7274:101a:ec05:6602? ([2a05:6e02:1041:c10:7274:101a:ec05:6602])
        by smtp.googlemail.com with ESMTPSA id t4-20020a5d6a44000000b002e558f1c45fsm4870418wrw.69.2023.04.07.09.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 09:35:36 -0700 (PDT)
Message-ID: <67315726-de8a-bc58-e4fd-d312899d6362@linaro.org>
Date:   Fri, 7 Apr 2023 18:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] thermal/drivers/bcm2835: Remove buggy call to
 thermal_of_zone_unregister
To:     rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Amit Kucheria <amitk@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230404075138.2914680-1-daniel.lezcano@linaro.org>
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230404075138.2914680-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

it seems like the remaining patches of the previous series does not 
raise feedbacks, I assume they are fine.

If nobody raises concern about it after this week-end, they will be 
applied to candidate for linux-next

Thanks
   -- Daniel


On 04/04/2023 09:51, Daniel Lezcano wrote:
> The driver is using the devm_thermal_of_zone_device_register().
> 
> In the error path of the function calling
> devm_thermal_of_zone_device_register(), the function
> devm_thermal_of_zone_unregister() should be called instead of
> thermal_of_zone_unregister(), otherwise this one will be called twice
> when the device is freed.
> 
> The same happens for the remove function where the devm_ guarantee the
> thermal_of_zone_unregister() will be called, so adding this call in
> the remove function will lead to a double free also.
> 
> Use devm_ variant in the error path of the probe function.
> 
> Remove thermal_of_zone_unregister() in the remove function.
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>     V2:
>       - Fixed wrong label call on the error path
> ---
>   drivers/thermal/broadcom/bcm2835_thermal.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
> index a217d832f24e..3acc9288b310 100644
> --- a/drivers/thermal/broadcom/bcm2835_thermal.c
> +++ b/drivers/thermal/broadcom/bcm2835_thermal.c
> @@ -275,7 +275,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
>   
>   	return 0;
>   err_tz:
> -	thermal_of_zone_unregister(tz);
> +	devm_thermal_of_zone_unregister(&pdev->dev, tz);
>   err_clk:
>   	clk_disable_unprepare(data->clk);
>   
> @@ -285,10 +285,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
>   static int bcm2835_thermal_remove(struct platform_device *pdev)
>   {
>   	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
> -	struct thermal_zone_device *tz = data->tz;
>   
>   	debugfs_remove_recursive(data->debugfsdir);
> -	thermal_of_zone_unregister(tz);
>   	clk_disable_unprepare(data->clk);
>   
>   	return 0;

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

