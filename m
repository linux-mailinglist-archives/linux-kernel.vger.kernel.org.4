Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC79E673CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjASPCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:02:46 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45D8125
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:02:43 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n7so2152874wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3QK5WQn5QfBW/lzr1XE6GsXDkO2SXCDtOuGMfSg9l3M=;
        b=XG0Cz0s5psxor5yKGeQDddzYU6ImiInRjAEgxOUjHu7J9N0wbLsX0Y2+JjQKKzMX83
         PPtZ6pvhQzGzaTclzZXpZRH0i/g483oSTD5GzXEq/tWIdmXcHm1LaU9J791DqMN+XkmE
         Dj3Zc9QsQErsh4LnQshRbmT0tYtWAZF5ygTZfqDUMRUJNAhPasspLPaGcKTQcwjWGzJj
         qoa+hFVXJnyR9v94itjdrLWVdfiv3fF5a8WJlNboKnpKt7aW6kcCZdwssCbi9d64Dcdd
         jb8qUhu5mU9pSOQPcfBTXD9LM4KSZ9lAGX8CfjREVZHeuFI5gvHj/o0XhoETP+fWoXPL
         9hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QK5WQn5QfBW/lzr1XE6GsXDkO2SXCDtOuGMfSg9l3M=;
        b=chtRYRFx21s22vePP9VxJDCxQhKp4I/3lLiSg3JkrKwrdM1zs6nw0Nw7PIIweXtdEd
         FsGf/50YUyqhrcy5KOzTlDH6Bk5HSI/oTPFhxqotTP1UZjRtFx++8hQbYvAPD43fskkj
         N6P6ftggnBgj8UFvMyHDBCtpsgz2EVebeIvTO/Tn66GwVLg+7i4YmIRvIkaRXaK3ezLc
         m5QAptI7jdyIwn+3wjnoAWOfMAjJDARKdVDfMEM1D3BP9nUV68i+A2NTY/yj87RbXPeZ
         YQ0oTEZETuxa9AkFvm3OgRAhvAgfTrS9txljGUNUdVvAa0Y1ClneaAmY1kR8EK6n2tFT
         MMQQ==
X-Gm-Message-State: AFqh2kpnDr34BR0YizRsAnIXPUQAY4iowCiGLdMU340eGdH+D6vlYvdz
        JkO+Whek4f4EL7G3TvpygjKM/w==
X-Google-Smtp-Source: AMrXdXvN5OAXpi0lBHlrQWgXpVOOeMyLnW7Euf2BH25QlVqgl405zMxCn+7Fv4tUeo3hxiHoaph1og==
X-Received: by 2002:a5d:50c9:0:b0:2bd:db42:36cd with SMTP id f9-20020a5d50c9000000b002bddb4236cdmr9087284wrt.0.1674140562038;
        Thu, 19 Jan 2023 07:02:42 -0800 (PST)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id w8-20020adf8bc8000000b002bdc39849d1sm22061235wra.44.2023.01.19.07.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 07:02:41 -0800 (PST)
Message-ID: <c53fd127-2fc0-57a1-1ae1-c1ae3480eedc@linaro.org>
Date:   Thu, 19 Jan 2023 15:02:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
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
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
References: <cover.1674030722.git.viresh.kumar@linaro.org>
 <d6e5d4fcca5f66d290e907d10c45cb2e7bbb09e5.1674030722.git.viresh.kumar@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <d6e5d4fcca5f66d290e907d10c45cb2e7bbb09e5.1674030722.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 08:38, Viresh Kumar wrote:
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

Tested-by: Caleb Connolly <caleb.connolly@linaro.org>

Thanks for sending this, with this I no longer hit the splats when
get_max_state() fails.
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

-- 
Kind Regards,
Caleb (they/them)
