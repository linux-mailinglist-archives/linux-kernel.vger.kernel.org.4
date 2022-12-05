Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B54642A1A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiLEOJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiLEOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:09:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652181A815
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:09:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d1so18724764wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 06:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpFyROjz1L+eqiyq1o9kVVnYvtLdIPNCiOE0RPzkwwo=;
        b=1gq3ReJzxgbkMV+vHUCQ8JDB9r+kHVxenV5tMKSLdUU82/B2bh5ytPlqrYG34Oz/Zk
         RzIkqYPwMX6vKH9Rg/OocZf0kxQXWV1ju4LEngMw87OOF7uCOUkj8/Ob5r9cmEHv24fX
         haxsHWWo/wCt6bsEMbB6hgu8ehURKjU7jNT69xZCqT8bbEfT3JJ9v1CtD0H3+jmrbSnY
         ykknROwYrms4f9smJH/ifqLyxriSpN9HG55JGA8PDyCA6ICKX//F1v6sY1plR/JLeZ27
         Nuiku0vNJRxBJ/f35k9dnCdtz/hGEr4iQWs8NT6SB3Fqo2B8S8o8v2VPzunCsGJAa0b4
         qhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpFyROjz1L+eqiyq1o9kVVnYvtLdIPNCiOE0RPzkwwo=;
        b=pneqlZtr/JSDlC+ilPlEdyEcfYKv2OQ/cJj57VI+Wf4ce/C+Mkdml0PNGTktOMpnJU
         5xQiMCVNe/vBv8EUFPm74TSXe0v1DklGvbXzOLGxmAXIBtigiP8gxjo2KhxJ4TU7+m9L
         DERKpcGznaQ+prp6Rbts3R0c/4fs+ZUsHv5IMuG7FX6oFC3lRorzBDpSZJtKstvhVmNZ
         7+062cfHP96LKoakvAeUTl3XuryVD59vnjEr9+P/4rXuXTGP+ghi04wvCNHZQXGxd3Ba
         aftYLHiMMwZjrN0I+lh3G61afE/IgD/K612xDfAcv0//L8HZA7S1KQJgLupiIS5ezEti
         a8lw==
X-Gm-Message-State: ANoB5plR/iufl5r9K6H8h7jZQn729v8kGfTq2fOgV8BF3bcgXzjP5T8g
        7Ax1r/vytAHNti684nXE3IvaUA==
X-Google-Smtp-Source: AA0mqf6FVMkKs68rdD+2cGg5Zl18rhVwCvPB9N3z4yAwOITdD/PsA2pTln0N6jUcoeFTej8oSMdO3Q==
X-Received: by 2002:adf:f549:0:b0:242:591c:89dd with SMTP id j9-20020adff549000000b00242591c89ddmr4979579wrp.696.1670249366861;
        Mon, 05 Dec 2022 06:09:26 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id f21-20020a1c6a15000000b003cf4d99fd2asm17254019wmc.6.2022.12.05.06.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 06:09:25 -0800 (PST)
Date:   Mon, 5 Dec 2022 14:09:24 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
Message-ID: <20221205140924.mzx62sijl3kujh53@airbuntu>
References: <20221127141742.1644023-1-qyousef@layalina.io>
 <20221127141742.1644023-4-qyousef@layalina.io>
 <CAJZ5v0iew=_pTq-v-2EdZN==8QY3donu9YUBtRYWdL18KBxs4Q@mail.gmail.com>
 <20221203143216.oezd2u6dpxodpuc3@airbuntu>
 <CAJZ5v0h_uoja87NUZb-tWmG_6Fb+1bATB03VRO0Foi5nFadiVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h_uoja87NUZb-tWmG_6Fb+1bATB03VRO0Foi5nFadiVQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/22 13:39, Rafael J. Wysocki wrote:
> On Sat, Dec 3, 2022 at 3:32 PM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 11/30/22 19:27, Rafael J. Wysocki wrote:
> >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 7c0dd57e562a..4bbbca85134b 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -8856,23 +8856,20 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> > > >          *   * Thermal pressure will impact all cpus in this perf domain
> > > >          *     equally.
> > > >          */
> > > > -       if (sched_energy_enabled()) {
> > > > +       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> > > >                 unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> > > > -               struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> > > > +               struct cpufreq_policy *policy, __maybe_unused *policy_n;
> > > >
> > > >                 rq->cpu_capacity_inverted = 0;
> > > >
> > > > -               SCHED_WARN_ON(!rcu_read_lock_held());
> > > > -
> > > > -               for (; pd; pd = pd->next) {
> > > > -                       struct cpumask *pd_span = perf_domain_span(pd);
> > > > +               for_each_active_policy_safe(policy, policy_n) {
> > >
> > > 1. Is the "safe" part sufficient for protection against concurrent
> > > deletion and freeing of list entries?  cpufreq driver removal can do
> > > that AFAICS.
> >
> > The freeing part is not safe probably.
> 
> Well, I don't even think that the traversal part is safe against
> concurrent removal of list entries (it is safe against removal of list
> entries in the loop itself).
> 
> list_for_each_entry_safe() assumes that n will always point to a valid
> list entry, but what if the entry pointed to by it is deleted by a
> concurrent thread?

Yeah I was being too hopeful here that safe does magic.

> 
> > I need to research this more. Do you
> > have issues against the exportation of this traversal in principle?
> >
> > Switching them to be RCU protected could be the best safe option, anything
> > against that too?
> 
> Not really, it just occurred to me that you may end up dealing with a
> corrupted list here.

Yes.

> 
> > I might not end up needing that. I need to dig more.
> >
> > > 2. For a casual reader of this code it may not be clear why cpufreq
> > > policies matter here.
> >
> > I'm looking for a way to traverse the list of capacities of the system and
> > know their related CPUs.
> 
> So why don't you mention this in a comment, for instance?

Sorry my bad. I realize my questions could have been clearer now.

> 
> > AFAICT this information already exists in the performance domains and
> > cpufreq_policy. Performance domains are conditional to energy model and
> > schedutil. So trying to switch to cpufreq_policy.
> >
> > Assuming this question wasn't a request to add a comment :-)
> 
> Yes, it was. :-)
> 
> That said though, this change makes the scheduler kind of depend on
> cpufreq which feels a bit like a corner cut TBH.

I share your sentiment; hence my request for feedback before I spend more time
on this. And apologies for not being clearer about my questions.

The deps is soft and it already exist in the form that performance domains,
schedutil, thermal pressure are all interacting with cpufreq subsystem already.

I can add a better comment for sure; if this ends up being the right thing to
do.

> I do realize that cpufreq happens to be maintaining a data structure
> that turns out to be useful here, but the reason why it is there has
> nothing to do with this code AFAICS.

The comments about needing to check for performance domains to detect capacity
inversion is not clear? Sorry I realize again now that all of this might look
out of the blue for you.

The issue I'm dealing with is that I want to know when thermal pressure has
gone too far that the capacity of the performance domain now is lower than
another domain in the system; aka capacity inversion.

The issue at hand is that when using uclamp_min; we need to consider thermal
pressure. But not unconditionally as we have corner cases like this one:

	p->util_avg = 10%
	p->uclamp_min = 90%

	capacity_orig_of(big) = 100%
	capacity_orig_of(med) = 60%

the task wants to run near the top perf level of the system; but if we take
thermal pressure blindly then we will fail to place the task on the big core
even though it's the most performant core. For example if

	capacity_orig_of(big) - thermal_pressure = 80%

then from uclamp_min hint perspective, the big core is fine and it's the best
placement we can get. The task is not getting what it gets, but 80% is better
than going down to 60% or lower.

On the other hand if

	p->util_avg = 10%
	p->uclamp_min = 60%

The task can be placed on a medium or big core. But if medium core is under
thermal pressure; then we do have the option to place it on big; and if we
ignore thermal pressure the task could miss a deadline because of this
unnecessary bad placement decision.

By knowing when we are in capacity inversion; we can ignore thermal pressure
for big cores until we hit the inversion point since then we know that we do
have another higher performance point in the system to consider.

We do update the capacity of the CPUs in this code. Hence why I added this
extra logic to detect the inversion here. And for that; the only way I found to
do it is by going via perf domain, but Dietmar made me realize it's dependent
on energy_model; so I'm trying to use cpufreq policies instead. If cpufreq is
not present, then there's no thermal pressure signals too; and this whole loop
should be optimized out by the compiler.

Hope this helps to clarify and not add more confusion! This logic is used in
the scheduler when deciding whether a task fits the CPU based on its util_avg
and uclamp values.

I wanted to check if it's alright to make these macros visible in cpufreq.h and
use them here. And check with the right locking rules. It seems converting the
list to be rcu protected is the right way forward.

Assuming Vincent (or you) don't tell me there's actually a better way to handle
all of that that I missed :-)


Thanks!

--
Qais Yousef
