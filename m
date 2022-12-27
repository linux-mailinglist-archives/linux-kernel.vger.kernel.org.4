Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720476566EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 03:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiL0CwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 21:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0CwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 21:52:15 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CD5B38
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:52:14 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a14so8127420pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0YjVWIlmCitavVVHffm/x0dEW/XaK8FourNyKarE0k=;
        b=YzESosf+nlKTT23zBm0t3f5ER72MzGJwb8rgU72vdWQ+KNUKNiVlnxFONiSFk9IB66
         b7MCTfNPtEHlrg9WTgugDQdjTtuSSi9Y/LKrMviQOYmQfqVDQ5RBTg1IFFsvEfX8XKqD
         usjzFoE6eZu9xL7ngAOPy+/Fb5zCN+DNPfF37ZP4B8HFp2hOj9wCeAFQpHbH5s0jTsyW
         FcJdubWUggu39K93nNr82hZSpbmhpuTOHw3Jh4TKxiV5UetK3bR2zrwKZ2/pztfYEB1t
         gy4bldf8NkfFcdKLjzhVfVVXOU/+ljXOXab5gdXKDVDx6y67pXMjcDRS6Mh+TDYo9IdV
         9hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0YjVWIlmCitavVVHffm/x0dEW/XaK8FourNyKarE0k=;
        b=tIpgjTUgkdyctbkMxOx1I2BdNpiaO0+J8Q8MB5mAmYnJwoiTIyLssdO+JwGIVUqKjH
         yW3+lQznJPocS9iEGSCej9/BUjmzBL3P/QjzcjgQewuIOk+MvvfmVDeCD6WPGJYUXc0r
         b0+hRiFmmM3Gvq7m/+EHvf16Jt4g/vb7yJL6kIn5J0Ao+XvnzhvoETAToHiPe64L/aad
         vs1Hn6W6pWTTO9jvFGN+nP93mT1lSvQyDME9h64OPahILM4wwt3XWVOI5WaSj3CxrGkw
         O44h/oYzeHO/Gp2elfjJtETyqvxBHc5ryMeupeiwn4qj8fUm9HfH28pA15GFHYjfjAi1
         cPNg==
X-Gm-Message-State: AFqh2krmR+BlyxpBuh77RjIntWGAAtp8KBEEipDfh0G57WctKR0NjtE7
        NPuaTTDa8liKzdmUutREd1Ycwb2HeNJVfIyB
X-Google-Smtp-Source: AMrXdXuXaxySOhmgosC390iLmKoofuQ5utwHIKl3HLf4ZpkgFZXo1ReEublXCZHePMnem6/QShViZA==
X-Received: by 2002:aa7:9f90:0:b0:578:795e:c8d3 with SMTP id z16-20020aa79f90000000b00578795ec8d3mr23332171pfr.29.1672109534164;
        Mon, 26 Dec 2022 18:52:14 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id y13-20020aa793cd000000b0056be4dbd4besm7493465pff.111.2022.12.26.18.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 18:52:13 -0800 (PST)
Date:   Tue, 27 Dec 2022 08:22:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <perry.yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
        ray.huang@amd.com, Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 08/13] cpufreq: amd-pstate: implement suspend and
 resume callbacks
Message-ID: <20221227025211.jjkmwtwg6whgavgd@vireshk-i7>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-9-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225163442.2205660-9-perry.yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-12-22, 00:34, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> add suspend and resume support for the AMD processors by amd_pstate_epp
> driver instance.
> 
> When the CPPC is suspended, EPP driver will set EPP profile to 'power'
> profile and set max/min perf to lowest perf value.
> When resume happens, it will restore the MSR registers with
> previous cached value.
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c671f4955766..e3676d1a85c7 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1041,6 +1041,44 @@ static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
>  	return 0;
>  }
>  
> +static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int ret;
> +
> +	/* avoid suspending when EPP is not enabled */
> +	if (cppc_state != AMD_PSTATE_ACTIVE)
> +		return 0;
> +
> +	/* set this flag to avoid setting core offline*/
> +	cpudata->suspended = true;
> +
> +	/* disable CPPC in lowlevel firmware */
> +	ret = amd_pstate_enable(false);
> +	if (ret)
> +		pr_err("failed to suspend, return %d\n", ret);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (cpudata->suspended) {

When will resume get called without being suspended first ?

> +		mutex_lock(&amd_pstate_limits_lock);
> +
> +		/* enable amd pstate from suspend state*/
> +		amd_pstate_epp_reenable(cpudata);
> +
> +		mutex_unlock(&amd_pstate_limits_lock);
> +
> +		cpudata->suspended = false;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -1062,6 +1100,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.exit		= amd_pstate_epp_cpu_exit,
>  	.offline	= amd_pstate_epp_cpu_offline,
>  	.online		= amd_pstate_epp_cpu_online,
> +	.suspend	= amd_pstate_epp_suspend,
> +	.resume		= amd_pstate_epp_resume,
>  	.name		= "amd_pstate_epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
> -- 
> 2.34.1

-- 
viresh
