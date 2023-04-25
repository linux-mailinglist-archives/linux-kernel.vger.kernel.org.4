Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183176EE39D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjDYOGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjDYOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:06:48 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BD0210A;
        Tue, 25 Apr 2023 07:06:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a920d484bdso47548245ad.1;
        Tue, 25 Apr 2023 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682431606; x=1685023606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pgVL/zYIF4XcbODFmxnXkOmVcf6q9IMBOAtXThWZzgc=;
        b=InxUH49EiiW3ppy/iRWuLl0rW4LGgc8lOv5f/kIGO7ZHHTeYfQnBuYhS+CkV0l6hr9
         aKYi3mdJSD8nLqxyd5NkhIH0a0VJSZyugpgRSIbDnVqmo78/8JdibYimEBYMVp76EQvZ
         5M6x1N/8Xx3BHurcz9zaUYH0m9hhY2DSGXtSJChe//hL6o71/SuaBqDr0kP2VwuGyvK8
         5Y+pc/ft0jaRk/xc8/VjBTLZTxpYTd2BWWdLHOGVJcjqqiNuA7Y6Am20hja8p4n+nez4
         TuTuapn9z7M4tjaw5/wSOzchqkm4sPTXQBnbxYPd//hLw8jphLSDV7GGlMmN0AXZgfim
         NNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682431606; x=1685023606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgVL/zYIF4XcbODFmxnXkOmVcf6q9IMBOAtXThWZzgc=;
        b=WnIqAzBuE/s1OLDC/UETyAyKimvOdwkomoU022FJW0LMyb9Gl2qnbIRvJFsYbBwbKc
         F0NtUDtYL8mGhndw7eojK/kBTPByeDAmN5SaLGNCn390lrpHcyLNIPYmdoKJFq16dUNE
         LwffMa4ehBZk/ClTfgNtr+naOVVrN9Jjc1pVjNxcDBBeGqCqboQ2oBSfLLS8ySeCGXQT
         zYWf8csw29R8WLNLsCbGgrkR9PG6u7k1QYY0f5m3bMOB4sN40NhHsi9JHlVxuqqfPtZS
         oH+OVTMtFHO6F+dGTTAVyrVdy0bnNTwebnV1NHsR4jVjFxGrhUYxVHlVKos5wfiSY8+s
         Np4g==
X-Gm-Message-State: AAQBX9cnPMl+GsbM1FDB8xa+p/Q5mhv3kNLHy8LAAs5m/8SMjNnK4MSs
        9TRK13qdXNe+wi+Znldaawk1upsPhRY=
X-Google-Smtp-Source: AKy350bNRWXukim0EYjXvnfjtsCVq2HHeVAnc2lBBPPxJStsWuRE3QZF2cGIc1Lmrd53Lyr3dodPJw==
X-Received: by 2002:a17:903:2441:b0:1a6:ff6a:83ed with SMTP id l1-20020a170903244100b001a6ff6a83edmr20912153pls.65.1682431605894;
        Tue, 25 Apr 2023 07:06:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id az1-20020a170902a58100b0019cbe436b87sm8385610plb.81.2023.04.25.07.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 07:06:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2ea16959-4525-90fb-b928-d652a4613574@roeck-us.net>
Date:   Tue, 25 Apr 2023 07:06:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] watchdog: starfive: Fix the probe return error if PM
 and early_enable are both disabled
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20230425100456.32718-1-xingyu.wu@starfivetech.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230425100456.32718-1-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 03:04, Xingyu Wu wrote:
> When the starfive watchdog driver uses 'pm_runtime_put_sync()' as probe
> return value at last and 'early_enable' is disabled, it could return the
> error '-ENOSYS' if the CONFIG_PM is disabled, but the driver should works
> normally.
> 
> Add a check to make sure the PM is enabled and then use
> 'pm_runtime_put_sync()' as return value when 'early_enable' is disabled.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
> 
> Hi, Guenter and Wim,
> 
> This patch fixes the issue of StarFive watchdog driver and rebases on
> the master branch of linux-next.
> 
> Thanks.
>   
> ---
>   drivers/watchdog/starfive-wdt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> index 1995cceca51e..51e487e09960 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -492,7 +492,8 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>   		goto err_exit;
>   
>   	if (!early_enable)
> -		return pm_runtime_put_sync(&pdev->dev);
> +		if (pm_runtime_enabled(&pdev->dev))
> +			return pm_runtime_put_sync(&pdev->dev);
>   

Why not just

	if (!early_enable)
		pm_runtime_put_sync(&pdev->dev)

like almost every other caller of pm_runtime_put_sync() ?

Guenter

