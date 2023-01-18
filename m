Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8D46728D4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjART5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjART5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:57:45 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94A059541;
        Wed, 18 Jan 2023 11:57:42 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id s4so1814245qtx.6;
        Wed, 18 Jan 2023 11:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qWA5wiyfjH0Va+Vx5qAKgnXVeWFuFmu2RbQWpk+MCc=;
        b=MkYk6LD8I0u6FoU+zrOFzm9+HfOG9qh7vFwihyD9kbVeC2NuyQGGfGXS+0wT+o8lXg
         GMR4WogwcgeFmCtrqEcrZUfeA4ES6C4qt/cohsvIsMuW32D9W4awvLThONuCiqQTcKOh
         0/uZy0+QB87A8dTPxHhy6dCqMYjWNHOaUMz8TXrYKdkXkZzZVxZHgjDXj06NcqnOHoAK
         xr7l1PvgeFB4QNiPNoX7wCOcT3Bb8SIgOUMqamQK0vxzY7YCLokgRxxNfJjTe8RNBvDT
         I9Wqd3V0IrEYJFRyk7Pt7tsAh3IEpQ2eJxtws0iBn6aaMzZERw/W8cKdHSDmrfaf25Li
         nx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qWA5wiyfjH0Va+Vx5qAKgnXVeWFuFmu2RbQWpk+MCc=;
        b=OO8/juYlnbO84m9WXGGgYSqz5CjEh4qDRsqZ8ySlqwiMEMTNe7OSXIeeZJjO5dqs7k
         5/reHzdB/WgqZZKVvUYj7csAQqIj5TAhoSzh/hHFe+iz2+7DYm7q7zsmLWmIAonRoKfY
         MfsgCj7CQDZFk2KDUpr5XoLzZm6aqf++NtsiE8gcdx1K67gNfKiH1BWIuc148dddv0Hn
         WbwKPHcuspv0/+pK7xag9+0YhnDXwezhxarL5RE0oXb6GfXjnnYQkBKE5X2W5A8pgLxZ
         mrIMYhUg/1m0KIzhLFGuKDcvJhM7MVFPkBPN7ln1oe1k0KoITdceCuRJLrKRfLc6y21I
         z/Bg==
X-Gm-Message-State: AFqh2kpt2tsHaWaKD58g31DSg+WBP1xo74juH8cXWW3Kz+aQrr6CYXlf
        aaSEkACleyvAsV0Kk2dLI05c4Vw9Eq8=
X-Google-Smtp-Source: AMrXdXsd4MmZhfJts2pvzlCxOrOLnJ4Igu3WSwNBulzTItK+mfNTm2DuuFFzyd//LJYjrKnc6aSYzg==
X-Received: by 2002:a05:622a:1dc4:b0:3b6:3b60:e0 with SMTP id bn4-20020a05622a1dc400b003b63b6000e0mr10477164qtb.31.1674071861737;
        Wed, 18 Jan 2023 11:57:41 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:c0fe:24db:874d:3fd8? ([2600:1700:2442:6db0:c0fe:24db:874d:3fd8])
        by smtp.gmail.com with ESMTPSA id b24-20020ac86798000000b0039cc944ebdasm17888911qtp.54.2023.01.18.11.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:57:41 -0800 (PST)
Message-ID: <0c1b5696-060b-8545-994d-160217449951@gmail.com>
Date:   Wed, 18 Jan 2023 13:57:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V4 1/3] thermal: core: call put_device() only after
 device_register() fails
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
References: <cover.1674030722.git.viresh.kumar@linaro.org>
 <d6e5d4fcca5f66d290e907d10c45cb2e7bbb09e5.1674030722.git.viresh.kumar@linaro.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <d6e5d4fcca5f66d290e907d10c45cb2e7bbb09e5.1674030722.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 02:38, Viresh Kumar wrote:
> put_device() shouldn't be called before a prior call to
> device_register(). __thermal_cooling_device_register() doesn't follow
> that properly and needs fixing. Also
> thermal_cooling_device_destroy_sysfs() is getting called unnecessarily
> on few error paths.
> 
> Fix all this by placing the calls at the right place.
> 
> Based on initial work done by Caleb Connolly.
> 
> Fixes: 4748f9687caa ("thermal: core: fix some possible name leaks in error paths")
> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> For v6.2-rc.
> 
> V3->V4:
> - The first three versions were sent by Caleb.
> - The new version fixes the current bugs, without looking to optimize the
>   code any further, which is done separately in the next two patches.
> 
>  drivers/thermal/thermal_core.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index f17ab2316dbd..77bd47d976a2 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -909,15 +909,20 @@ __thermal_cooling_device_register(struct device_node *np,
>  	cdev->devdata = devdata;
>  
>  	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
> -	if (ret)
> -		goto out_kfree_type;
> +	if (ret) {
> +		kfree(cdev->type);
> +		goto out_ida_remove;
> +	}
>  
>  	thermal_cooling_device_setup_sysfs(cdev);
> +
>  	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>  	if (ret) {
> +		kfree(cdev->type);
>  		thermal_cooling_device_destroy_sysfs(cdev);
> -		goto out_kfree_type;
> +		goto out_ida_remove;
>  	}
> +
>  	ret = device_register(&cdev->device);
>  	if (ret)
>  		goto out_kfree_type;
> @@ -943,6 +948,8 @@ __thermal_cooling_device_register(struct device_node *np,
>  	thermal_cooling_device_destroy_sysfs(cdev);
>  	kfree(cdev->type);
>  	put_device(&cdev->device);
> +
> +	/* thermal_release() takes care of the rest */
>  	cdev = NULL;
>  out_ida_remove:
>  	ida_free(&thermal_cdev_ida, id);

My testing:

 Applied on top of v6.2-rc1
 The configuration is qcom_defconfig
 The system is a Qualcomm Dragon 8074

The two WARNING stack traces no longer occur after applying the patch.

Tested-by: Frank Rowand <frowand.list@gmail.com>

