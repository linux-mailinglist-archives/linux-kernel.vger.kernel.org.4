Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F706D3C2B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 05:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDCDfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 23:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDCDfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 23:35:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC5972BC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 20:35:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s72so850885pgs.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 20:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680492932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/D4pTl4jFzV4jgHwDP3sW1Lt1J55i00u3GAQnSTJoQQ=;
        b=mDPqR5a6pMJJzyPRzXU8LTfrkGs2hUub739GYGKZRnBQ3D3+Ev6tXSvvmYnmW9n3Kb
         W2cX8vNKSBSi9J0xnBiyb+hP5dayw9BPQD2Ydg+TZJEoWR1vux7je3WmHI4SlbWJ72Oo
         WuMjgWDoECvTFfbeVmUL/yYP1xNm8EQvhBORJeYfAB4c0VWZ3LhrdyBn6yDivKSe7NJC
         N0czeT3FUw/4IYpfTApoYqjk0nYpTfT25LQPu4svY2oEYhRSqqufDzzrDxteGJ2boTYy
         xYYnlTV1LkQAhro3RadcySCGSI1+sB5a4TI+Ksp8ZQcWCSRDl+XI1LYO2AxhPhpwZRoE
         PKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680492932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/D4pTl4jFzV4jgHwDP3sW1Lt1J55i00u3GAQnSTJoQQ=;
        b=GKiyttrRPLxxsgWf7mPbzLBw6ndaehi632j5pQr/TBI3VNyuLYAE98jPSKMG5aIq5H
         aF+iVuo0t1+QDZISxJJfeLvJc4vwXQrFf6QrPS+kLhjbtdWxOsZY3IG8+XJ1Mf68+bvh
         v2Frax1O+URpWKRjzNOX/GJ0j9FJe05wKyHumBTg6+esJl7ZanNlZMWZQ/JF+e1uwa80
         JYUEtSXDDM7sT0b7mhuu5kMYGk0v5ZAMyIm9iQkubW7BVCCF+bJidzmMqOjdFopltOBd
         tHwDDspAiTUUaR9FlEcQ+/IGNikQt8KjXJR3KlVOlxuXlHWfCRtOpvdYmHdFjkyzDds7
         Pt7Q==
X-Gm-Message-State: AAQBX9dS29QFW7yTHTmots3u+zlf0K45yBxlwiuoX5kPmoLhW3gM3RmP
        P15LY/fNzk38e868w6EdexGKWA==
X-Google-Smtp-Source: AKy350ZcXokqcVbSfXh0/U/C+8KTXx9rbwWKFpC4NaX5XoDdZvPnEORMc6ZhHnuCbOGGp7xwcmH40g==
X-Received: by 2002:a62:1c45:0:b0:626:1523:b10d with SMTP id c66-20020a621c45000000b006261523b10dmr35575121pfc.4.1680492931885;
        Sun, 02 Apr 2023 20:35:31 -0700 (PDT)
Received: from localhost ([122.172.85.168])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79149000000b0062dd28aaca6sm5614107pfi.212.2023.04.02.20.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 20:35:31 -0700 (PDT)
Date:   Mon, 3 Apr 2023 09:05:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH resent] cpufreq: sparc: Fix exception handling in two
 functions
Message-ID: <20230403033529.x6n3ihhkypwizq3b@vireshk-i7>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
 <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-23, 15:02, Markus Elfring wrote:
> Date: Sat, 18 Mar 2023 11:40:11 +0100
> 
> The label “err_out” was used to jump to another pointer check despite of
> the detail in the implementation of the functions “us2e_freq_init”
> and “us3_freq_init” that it was determined already that the corresponding
> variable contained a null pointer (because of a failed memory allocation).
> 
> 1. Use additional labels.
> 
> 2. Reorder jump targets at the end.
> 
> 3. Delete an extra pointer check which became unnecessary
>    with this refactoring.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac ("Linux-2.6.12-rc2")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/cpufreq/sparc-us2e-cpufreq.c | 12 ++++++------
>  drivers/cpufreq/sparc-us3-cpufreq.c  | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
> index 92acbb25abb3..8534d8b1af56 100644
> --- a/drivers/cpufreq/sparc-us2e-cpufreq.c
> +++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
> @@ -324,12 +324,12 @@ static int __init us2e_freq_init(void)
>  		ret = -ENOMEM;
>  		driver = kzalloc(sizeof(*driver), GFP_KERNEL);
>  		if (!driver)
> -			goto err_out;
> +			goto reset_freq_table;

I would just return error from here.

> 
>  		us2e_freq_table = kzalloc((NR_CPUS * sizeof(*us2e_freq_table)),
>  			GFP_KERNEL);
>  		if (!us2e_freq_table)
> -			goto err_out;
> +			goto free_driver;
> 
>  		driver->init = us2e_freq_cpu_init;
>  		driver->verify = cpufreq_generic_frequency_table_verify;
> @@ -346,11 +346,11 @@ static int __init us2e_freq_init(void)
>  		return 0;
> 
>  err_out:
> -		if (driver) {
> -			kfree(driver);
> -			cpufreq_us2e_driver = NULL;
> -		}
>  		kfree(us2e_freq_table);
> +free_driver:
> +		kfree(driver);
> +		cpufreq_us2e_driver = NULL;
> +reset_freq_table:
>  		us2e_freq_table = NULL;

This wasn't set at this point, no point clearing it here. Also this
clearing of global variables isn't required at all, as after this
point no other function shall get called.

similar comments for the other file.

>  		return ret;
>  	}
> diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
> index e41b35b16afd..325f61bb2e40 100644
> --- a/drivers/cpufreq/sparc-us3-cpufreq.c
> +++ b/drivers/cpufreq/sparc-us3-cpufreq.c
> @@ -172,12 +172,12 @@ static int __init us3_freq_init(void)
>  		ret = -ENOMEM;
>  		driver = kzalloc(sizeof(*driver), GFP_KERNEL);
>  		if (!driver)
> -			goto err_out;
> +			goto reset_freq_table;
> 
>  		us3_freq_table = kzalloc((NR_CPUS * sizeof(*us3_freq_table)),
>  			GFP_KERNEL);
>  		if (!us3_freq_table)
> -			goto err_out;
> +			goto free_driver;
> 
>  		driver->init = us3_freq_cpu_init;
>  		driver->verify = cpufreq_generic_frequency_table_verify;
> @@ -194,11 +194,11 @@ static int __init us3_freq_init(void)
>  		return 0;
> 
>  err_out:
> -		if (driver) {
> -			kfree(driver);
> -			cpufreq_us3_driver = NULL;
> -		}
>  		kfree(us3_freq_table);
> +free_driver:
> +		kfree(driver);
> +		cpufreq_us3_driver = NULL;
> +reset_freq_table:
>  		us3_freq_table = NULL;
>  		return ret;
>  	}
> --
> 2.40.0

-- 
viresh
