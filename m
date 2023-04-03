Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8326D4B3D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjDCO6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjDCO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:58:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08219729A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:58:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so32825700pjt.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680533925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqtCpVS1sZLg+B1j1ia3uHWu+7Wr1bmfif2WtQYY+9o=;
        b=TjE8oj61wHg3uZwKzHcwN1kDGoVncguHHSkST0DIdbnlko099m2QRmzDpnajRO52wy
         iLL4Z3DONA1qW8i0L7twZl1zz4ULLOOOGRfjSYSlNeiNtYovaKZf1FPc386y3tPBiyGq
         DKI6YlvkY0eIXfDrICLRYQUJBP/ONdl4n7jlv7Rr8Qa6OA0cdGV7dlUQE5vkQgH1R3Ty
         8MRpRS1CDRE5WDCk42KtB+P0GsKfe3zukh3nuOgibdYXfmkdv2xTjlph41gpj9+MmGJc
         ZG4Fg2pPuBtEZ1rBYjtx7N3rNAQxdiAVkNk1ki9ZxvR5NTyNjGnJjaQWRSnXhvo2jHMK
         fMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqtCpVS1sZLg+B1j1ia3uHWu+7Wr1bmfif2WtQYY+9o=;
        b=6Kx3OJUnkyo3Nq6q4BIHwaesvkS4x/NThayilTH8MK+57nhmdsYSPedUcclFuBBVGr
         L1FCYNbi1zTatUfK2ZnX4boytVDiNexGTSkizDtX9Gev9QE1GE0yPyKBvHc4jB/eL0Ep
         W++3NpWKj6JzWCzwKM2JnjvsguZF3vumO+gzhj5xm1ebTxQ23TAEtbtb/Ys5TnO2stvg
         w/ejEWe9zL1E1HEC547fah4qJFQu3orLsw3kKVpPlNLnisZI9NVZze0Jk6Qc2X+/p7JF
         0VKujcaf3ThSTLWAF30hytlwUULiccuLEVRq1W2DbmSpcD8WGSUJ8xylrjuMkdxhoATE
         2NAA==
X-Gm-Message-State: AAQBX9fg/Oy9q5cEN/KFnUueLpZhiySeXA1pOq5zv8adyeQycTwZJKqk
        AA2J5tyGL7U4zM+c0lXSgsGlKG3mx2UzeA==
X-Google-Smtp-Source: AKy350Z2ly7JdJElTw4D+PcBloI2mU6uEIrngBnsODjCnn8K2H6io/uOqxky0Id5zo/bJPV/34NOCg==
X-Received: by 2002:a17:902:da8a:b0:1a2:8c7e:f31f with SMTP id j10-20020a170902da8a00b001a28c7ef31fmr17239477plx.11.1680533925427;
        Mon, 03 Apr 2023 07:58:45 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id g4-20020a63dd44000000b0050bf1d1cdc8sm6178646pgj.21.2023.04.03.07.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:58:44 -0700 (PDT)
Message-ID: <546c0079-6b1c-9a67-a4c6-328eeb8c5ba7@gmail.com>
Date:   Mon, 3 Apr 2023 23:58:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 08/14] extcon: Switch to use kasprintf_strarray()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-9-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-9-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 22. 23:39, Andy Shevchenko wrote:
> Since we have a generic helper, switch the module to use it.
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 25 +++++++++++--------------
>  drivers/extcon/extcon.h |  1 +
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 0d261ec6c473..a63e7eef02fd 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -23,6 +23,7 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/slab.h>
> +#include <linux/string_helpers.h>
>  #include <linux/sysfs.h>
>  
>  #include "extcon.h"
> @@ -1104,19 +1105,17 @@ static int extcon_alloc_cables(struct extcon_dev *edev)
>  	if (!edev->cables)
>  		return -ENOMEM;
>  
> +	edev->cable_names = kasprintf_strarray(GFP_KERNEL, "cable", edev->max_supported);
> +	if (!edev->cable_names) {
> +		kfree(edev->cables);
> +		return -ENOMEM;
> +	}
> +
>  	for (index = 0; index < edev->max_supported; index++) {
>  		cable = &edev->cables[index];
>  
> -		str = kasprintf(GFP_KERNEL, "cable.%d", index);
> -		if (!str) {
> -			for (index--; index >= 0; index--) {
> -				cable = &edev->cables[index];
> -				kfree(cable->attr_g.name);
> -			}
> -
> -			kfree(edev->cables);
> -			return -ENOMEM;
> -		}
> +		str = edev->cable_names[index];
> +		strreplace(str, '-', '.');
>  
>  		cable->edev = edev;
>  		cable->cable_index = index;
> @@ -1341,8 +1340,7 @@ int extcon_dev_register(struct extcon_dev *edev)
>  		kfree(edev->attrs_muex);
>  	}
>  err_alloc_muex:
> -	for (index = 0; index < edev->max_supported; index++)
> -		kfree(edev->cables[index].attr_g.name);
> +	kfree_strarray(edev->cable_names, edev->max_supported);
>  	if (edev->max_supported)
>  		kfree(edev->cables);
>  err_alloc_cables:
> @@ -1387,8 +1385,7 @@ void extcon_dev_unregister(struct extcon_dev *edev)
>  		kfree(edev->attrs_muex);
>  	}
>  
> -	for (index = 0; index < edev->max_supported; index++)
> -		kfree(edev->cables[index].attr_g.name);
> +	kfree_strarray(edev->cable_names, edev->max_supported);
>  
>  	if (edev->max_supported) {
>  		kfree(edev->extcon_dev_type.groups);
> diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
> index 877c0860e300..5624f65ba17a 100644
> --- a/drivers/extcon/extcon.h
> +++ b/drivers/extcon/extcon.h
> @@ -58,6 +58,7 @@ struct extcon_dev {
>  	/* /sys/class/extcon/.../cable.n/... */
>  	struct device_type extcon_dev_type;
>  	struct extcon_cable *cables;
> +	char **cable_names;

The extcon cable information should be included in struct extcon_cable
in order to gather information into one point like encapsulation.

I don't prefer to add 'cable_names'.

>  
>  	/* /sys/class/extcon/.../mutually_exclusive/... */
>  	struct attribute_group attr_g_muex;

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

