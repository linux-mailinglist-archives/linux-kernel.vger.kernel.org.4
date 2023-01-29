Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A84680035
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjA2QV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjA2QVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:21:25 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09FB1DB8A
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:21:23 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id dr8so4074227ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEyMPUPsFAcAovSa13JKk8c6bTrTEnnzp7CeLSTl89w=;
        b=LlqK5CBfNrcC5GFoDI+UL21Cacle1BfmcnUaPxtfcMBcfwNefxBtt/5caqpDXr/U7Q
         tFzp6x+SE4rqMLw4acBSbJXN0CtF1ufN49La3GIFvt/c1OFO+/q4mPxy3GkUfB+XICKA
         NSQ7PdEESuXW25+y7jKFmLfuFVF8uaHxH/b78eHrzg5Qnn5c89YIhneH8TVUimEFG1BZ
         9JtvuSGQZtuUgcU1DIYzkbo1dponbcQMQKEIoCDTQUJeGFusbhPhBQFUeqabfJkBS/6z
         LmGm/y1xHC73vwWHTKhQpPF3GQ084QyRuoqDADCFq1FLdUWQPqfvNWjsUWRgKS+0KUSs
         Z4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEyMPUPsFAcAovSa13JKk8c6bTrTEnnzp7CeLSTl89w=;
        b=TW14SGDymLPNUIzn3X3DHEuyq34CYVVF6o6fYrILJ6yIfhFrgocUif1JosxG7ii5Cm
         5M1yrG3Pi/+XN76P3UgY6a/RInC3gMS1D4K723FCsSus0S4xlbhrj1MZG/zysGQjZMLq
         3OKMSxaY5CYwts2mxm92BROVnD4z3AYI3uaTqvAdQ7aI3ZjSEs7IdofwrPo65QCeOpVs
         0KPSfRc9QfYZ/Tmr31EffElcVVp3AElDxvxNCy/G7cIRsXdlrk4do7HHXXDpihSwykE7
         X9Ak7SFfy4nd0p9aj9uoosL4AfenXPuTD1TRdh9b1hnpij5YzxIej0p18iyQXaefil2h
         vOXw==
X-Gm-Message-State: AFqh2kos93gSGQ2TwOccGd33eDzdxT2k2z7pUmfln7iYk1tcLf5HYzlN
        f78ItrBRgWSwe/DeUCuEG0J5aw==
X-Google-Smtp-Source: AMrXdXt2HKmSmZ7X+UqY7YUO0kFEnxK8y/G1AkmyiHaLoZNji7QR9Uer75Hv3hwhGqFHBdSppMXdag==
X-Received: by 2002:a17:907:d049:b0:840:604:1da1 with SMTP id vb9-20020a170907d04900b0084006041da1mr56637787ejc.61.1675009282525;
        Sun, 29 Jan 2023 08:21:22 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id gj2-20020a170906e10200b008806a3c22c5sm2983620ejb.25.2023.01.29.08.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 08:21:22 -0800 (PST)
Date:   Sun, 29 Jan 2023 16:21:20 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        peterz@infradead.org, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Subject: Re: [PATCH v4] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <20230129162120.ynzgsxsdjwluucmk@airbuntu>
References: <20230119174244.2059628-1-vincent.guittot@linaro.org>
 <d5012cdf-ad5b-adf8-11f6-8ac2c3a89f0b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5012cdf-ad5b-adf8-11f6-8ac2c3a89f0b@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26/23 12:42, Dietmar Eggemann wrote:
> On 19/01/2023 17:42, Vincent Guittot wrote:
> > By taking into account uclamp_min, the 1:1 relation between task misfit
> > and cpu overutilized is no more true as a task with a small util_avg may
> > not fit a high capacity cpu because of uclamp_min constraint.
> > 
> > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > a CPU except for the uclamp_min hint which is a performance requirement.
> > 
> > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > can use this new value to take additional action to select the best CPU
> > that doesn't match uclamp_min hint.
> > 
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> > 
> > Change since v3:
> > - Keep current condition for uclamp_max_fits in util_fits_cpu()
> > - Update some comments
> 
> We had already this discussion whether this patch can also remove
> Capacity Inversion (CapInv).
> 
> After studying the code again, I'm not so sure anymore.
> 
> This patch:
> 
> (1) adds a dedicated return value (-1) to util_fits_cpu() when:
> 
> `util fits 80% capacity_of() && util < uclamp_min && uclamp_min >
> capacity_orig_thermal (region c)`
> 
> (2) Enhancements to the CPU selection in sic() and feec() to cater for
> this new return value.

-1 means that the task fits, but only uclamp_min hint fails. ie: the task util
is small enough to run on this cpu, but it would like to run faster and this
cpu can't satisfy this request at the moment.

> 
> IMHO this doesn't make the intention of CapInv in util_fits_cpu()
> obsolete, which is using:
> 
> in CapInv:
> 
>   capacity_orig         = capacity_orig_of() - thermal_load_avg
>   capacity_orig_thermal = capacity_orig_of() - thermal_load_avg
> 
> not in CapInv:
> 
>   capacity_orig         = capacity_orig_of()
>   capacity_orig_thermal = capacity_orig_of() - th_pressure
> 
> Maybe I still miss a bit of the story?

Vincent approach is different to mine. I tried to hide all the complexity in
util_fits_cpu() so all users don't care.

But with Vincent changes, now the decision is delegated to the caller to decide
what to do if thermal pressure is causing trouble.

IOW, I expect this line only stay after Vincent patch

	capacity_orig_thermal = capacity_orig_of() - th_pressure

HTH


Cheers

--
Qais Yousef

> 
> v3 hints to removing the bits in the next version:
> 
> https://lkml.kernel.org/r/20230115001906.v7uq4ddodrbvye7d@airbuntu
> 
> >  kernel/sched/fair.c | 105 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 82 insertions(+), 23 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d4db72f8f84e..54e14da53274 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4561,8 +4561,8 @@ static inline int util_fits_cpu(unsigned long util,
> >  	 * handle the case uclamp_min > uclamp_max.
> >  	 */
> >  	uclamp_min = min(uclamp_min, uclamp_max);
> > -	if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> > -		fits = fits && (uclamp_min <= capacity_orig_thermal);
> > +	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> > +		return -1;
> 
> Or does the definition 'return -1 if util fits but uclamp doesn't' make
> the distinction between capacity_orig and capacity_orig_thermal obsolete
> and so CapInv?
> 
> [...]
> 
> >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > @@ -6138,6 +6142,7 @@ static inline bool cpu_overutilized(int cpu)
> >  	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> >  	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> >  
> > +	/* Return true only if the utilization doesn't fits CPU's capacity */
> 
> small typo: s/doesn't fits/doesn't fit
> 
> [...]
> 
> > @@ -6946,12 +6952,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >  
> >  		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> >  			continue;
> > -		if (util_fits_cpu(task_util, util_min, util_max, cpu))
> > +
> > +		fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> > +
> > +		/* This CPU fits with all requirements */
> > +		if (fits > 0)
> >  			return cpu;
> > +		/*
> > +		 * Only the min performance hint (i.e. uclamp_min) doesn't fit.
> > +		 * Look for the CPU with best capacity.
> > +		 */
> > +		else if (fits < 0)
> > +			cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
> 
> Still don't grasp why we use thermal_load_avg() here? Looks to me that
> this would only match the CapInv case in util_fits_cpu().
> 
> [...]
> 
