Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7BB5F97DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiJJFgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiJJFgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:24 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E654445F77
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 22:36:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g28so9872241pfk.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 22:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfQsfUWcWLp7hNK3mWIV/Z7JosDPzJlAzLay9IBS03w=;
        b=J8KfV2yNmkok12hzdB2FjY3ZgF+GPihES0oERJK0ZcgUeXtDu4loss1VPhphzgQKPw
         c6yUZGS34xey1Wo456Nv7HPnwmZ2W1Xee+y2cNqIDIOMcyevdW3QbJd6joJXgZnv09T0
         JugIJHbEDrIbT7dI+RSkFrslacUZ5+QAu1CjCPHSw77HBoBIAAxgHphMVdxmdSr2qivV
         7FFJfjBFxXG2XOboIQYoNf2C1RYPx6JHStXHrXHybwTAiJp0zb+Jea8687SyG+nfrbxW
         WtjkvPXJF1LRMVQe2dCB5VmFZYLWfDDv7BrBWZMauOJ7ruwGeoj8jrw4O9XVVaEu169I
         +0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfQsfUWcWLp7hNK3mWIV/Z7JosDPzJlAzLay9IBS03w=;
        b=AcFcCNVycXXsvK8bV4E1IM4YJSVAk7UqXb5qyk/lzHZPbcnwLxkXVcrjtrVzID8RFh
         26kNsh5WgJVNT0N5ChwhDLjD3ZKGjPSNesYSdBLSg6x9H/cD4FS8CNtQuWHEn8hKcq+i
         sr/n+p5xtNhT7GywexwD0O/7Rl6j/qwNn17pzDh7aANRgX6wuD+Kcq8olFlNxAdSzzQx
         8mv4UL/Ua85f/Fc4m7lIyEf5ACcRwjXBj51Y5mfTNfAivv0DTB0GJ3TuCriEWFMDL8Nc
         zCRioTs+q7QLdNBoKeezBVh9U6dklfOuRZJk5EmCmxFRYS52jkS7l+s47LNkuSXuhTpn
         4hTQ==
X-Gm-Message-State: ACrzQf2i28Xg/JFAwAzOvrC7I8X8Qp9nMDz4K6PC5U8jE3vYidQZOtSp
        yYK6CjW/DhulCsDnHa2x3rOC2P6UIwH8+A==
X-Google-Smtp-Source: AMsMyM6KJ805In/IA3pd8cm4y831vFgxF9U8Xk5cTWj3x/RulNnmGAAyR197pvognUiVYE3HKURStw==
X-Received: by 2002:a05:6a00:1ac8:b0:563:7d18:7a15 with SMTP id f8-20020a056a001ac800b005637d187a15mr998749pfv.59.1665380177243;
        Sun, 09 Oct 2022 22:36:17 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id b7-20020aa79507000000b005635477c42dsm1445741pfp.133.2022.10.09.22.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:16 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:06:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 1/2] cpufreq: Change macro for store scaling min/max
 frequency
Message-ID: <20221010053614.zu2f3btjlh7woxbj@vireshk-i7>
References: <20220930094821.31665-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930094821.31665-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-09-22, 10:48, Lukasz Luba wrote:
> In order to prepare extension to the store_scaling_max_freq() remove
> the macro and use two normal functions. The set value for max frequency
> is important for the task scheduler.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 47 ++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 69b3d61852ac..1f8b93f42c76 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -715,26 +715,33 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>  	return ret;
>  }
>  
> -/*
> - * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write access
> - */
> -#define store_one(file_name, object)			\
> -static ssize_t store_##file_name					\
> -(struct cpufreq_policy *policy, const char *buf, size_t count)		\
> -{									\
> -	unsigned long val;						\
> -	int ret;							\
> -									\
> -	ret = sscanf(buf, "%lu", &val);					\
> -	if (ret != 1)							\
> -		return -EINVAL;						\
> -									\
> -	ret = freq_qos_update_request(policy->object##_freq_req, val);\
> -	return ret >= 0 ? count : ret;					\
> -}
> -
> -store_one(scaling_min_freq, min);
> -store_one(scaling_max_freq, max);
> +static ssize_t store_scaling_max_freq
> +(struct cpufreq_policy *policy, const char *buf, size_t count)

I thought we can't break right after function's name according to
kernel's coding guidelines. Did you run checkpatch on this ?

> +{
> +	unsigned long val;
> +	int ret;
> +
> +	ret = sscanf(buf, "%lu", &val);
> +	if (ret != 1)
> +		return -EINVAL;
> +
> +	ret = freq_qos_update_request(policy->max_freq_req, val);
> +	return ret >= 0 ? count : ret;
> +}
> +
> +static ssize_t store_scaling_min_freq
> +(struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	int ret;
> +
> +	ret = sscanf(buf, "%lu", &val);
> +	if (ret != 1)
> +		return -EINVAL;
> +
> +	ret = freq_qos_update_request(policy->min_freq_req, val);
> +	return ret >= 0 ? count : ret;
> +}
>  
>  /*
>   * show_cpuinfo_cur_freq - current CPU frequency as detected by hardware
> -- 
> 2.17.1

-- 
viresh
