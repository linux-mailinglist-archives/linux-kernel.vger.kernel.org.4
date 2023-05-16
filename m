Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AE27042AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbjEPBKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbjEPBKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:10:06 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4951455BD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:10:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6439bbc93b6so9524196b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684199405; x=1686791405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ua1H7BSlxOVgCXi1cqjAb+iXMvrfwZl+3k3+nHoxTf0=;
        b=QBbDKsdxw/tBLj5Hk9EFNid5818/CeBXuZiv6gmeMwGg7aR4G2fPUjtrWG66Pkzr6R
         BFPLNNAMEVZ4w94vJWFyJBVOFAW1ywnmCeTIuyAQBGAZnZu8BDy7j2GAMJXkQIpydR0r
         BkvXHTYhFxDU69IPtD28tbT3bMe40Mi3HVaYl8qmTwbma+N1twu1ku4EKFeiBmzRNC6l
         mITDtao5b2/HJnIiivZQhxf0oBa9CNI5TrCn6nFxcrJVawy6Nmb6eLCwTT2G8TtzB7we
         jJcLvcnt//872bs9mpC44wRU2do8MJWeyCXfj2+3O91v3KGmeomPZBP7Fo7F8KdqIv/b
         ce2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684199405; x=1686791405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ua1H7BSlxOVgCXi1cqjAb+iXMvrfwZl+3k3+nHoxTf0=;
        b=TuDujVI+QAjLKxwKFOEh4MhoJcmB7V9Xhv1AZZqRVKSBZyPnXU47awkCSbaaDAyKo4
         o06ogrdcz7diX0QAFxO6K978G9+gydyotPXdE7w+rqxNhXdsolmbkO8cgsRN/TJXC22l
         TXoZq3GY12H8qCfsmQH3o0Z0nJg1gL1CTy9IUj8iD/b8jJ5bVO61l15ng7pAgbMC4Kde
         NfU+91zIRIwROY8OCzsTE/TFP+AvMGS8iMSucj8HyhTHQwigwMyAdFfTFXf8Rtdk9Smh
         YScnq8ewlbyLUkFURro8GpkzebBbx0JXiuYvVIhOUYgi5VCWdSYJh7sWUbuEf/vLGlY/
         3hEQ==
X-Gm-Message-State: AC+VfDwDxY8Hrx5nySAwyCEDFCiw1tgQ81rqvXnaER++PN+Rbz57Opgs
        wdWH9bQXluMxaz/kpER3Dv3uww==
X-Google-Smtp-Source: ACHHUZ7bmnz/oM81P5fMTL4EIWX38tn30Lm1HgbsQmd+RG9c5cSbbGFSEZW+0mRrfx247MwPqNc1aQ==
X-Received: by 2002:a05:6a20:8e24:b0:100:214c:d76e with SMTP id y36-20020a056a208e2400b00100214cd76emr37821002pzj.53.1684199404643;
        Mon, 15 May 2023 18:10:04 -0700 (PDT)
Received: from localhost ([122.172.82.60])
        by smtp.gmail.com with ESMTPSA id k4-20020a632404000000b00502e7115cbdsm12313129pgk.51.2023.05.15.18.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 18:10:03 -0700 (PDT)
Date:   Tue, 16 May 2023 06:40:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     ray.huang@amd.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com
Subject: Re: [PATCH v3 2/2] cpufreq: Warn if fast_switch is not set
Message-ID: <20230516011001.epa4xlvbiimu6ai3@vireshk-i7>
References: <20230515113404.4259-1-wyes.karny@amd.com>
 <20230515113404.4259-3-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515113404.4259-3-wyes.karny@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-05-23, 11:34, Wyes Karny wrote:
> If fast_switch_possible flag is set by the scaling driver, the governor
> is free to select fast_switch function even if adjust_perf is set. When
> the frequency invariance is disabled due to some reason governor
> fallbacks to fast_switch if fast_switch_possible is set. This could
> crash the kernel if the driver didn't set the fast_switch function
> pointer.
> 
> This issue becomes apparent when aperf/mperf overflow occurs with
> amd_pstate (passive) + schedutil.  When this happens, kernel disables
> frequency invariance calculation which causes schedutil to fallback to
> sugov_update_single_freq which currently relies on the fast_switch
> callback.
> 
> Normal flow:
>   sugov_update_single_perf
>     cpufreq_driver_adjust_perf
>       cpufreq_driver->adjust_perf
> 
> Error case flow:
>   sugov_update_single_perf
>     sugov_update_single_freq  <-- This is chosen because the freq invariant is disabled due to aperf/mperf overflow
>       cpufreq_driver_fast_switch
>          cpufreq_driver->fast_switch <-- Here NULL pointer dereference is happening, because fast_switch is not set

Not sure if all these details are required for this patch or not. It
is logically incorrect to set fast_switch_possible, while fast_switch
isn't set. That's a reason enough.

> Put up a warning message if the driver sets fast_switch_possible flag
> but not fast_switch.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  drivers/cpufreq/cpufreq.c | 18 ++++++++++++++++++
>  include/linux/cpufreq.h   |  5 ++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6b52ebe5a890..180be9235b08 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -501,6 +501,13 @@ void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
>  	if (!policy->fast_switch_possible)
>  		return;
>  
> +	/**

Doc style comments aren't required here I guess.

> +	 * It's not expected driver's fast_switch callback is not set
> +	 * even fast_switch_possible is true.
> +	 */
> +	if (!cpufreq_driver_has_fast_switch())
> +		pr_alert_once("fast_switch callback is not set\n");
> +
>  	mutex_lock(&cpufreq_fast_switch_lock);
>  	if (cpufreq_fast_switch_count >= 0) {
>  		cpufreq_fast_switch_count++;
> @@ -2143,6 +2150,17 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>  
> +/**
> + * cpufreq_driver_has_fast_switch - Check "fast switch" callback.
> + *
> + * Return 'true' if the ->fast_switch callback is present for the
> + * current driver or 'false' otherwise.
> + */
> +bool cpufreq_driver_has_fast_switch(void)

Why create a routine for this, when no one else is going to use it ?

> +{
> +	return !!cpufreq_driver->fast_switch;
> +}

I think you should add the required check in cpufreq_online(), after
cpufreq_driver->init() is called, and return failure if fast_switch
isn't set and fast_switch_possible is.

-- 
viresh
