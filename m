Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1164174D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 15:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiLCOcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 09:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiLCOcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 09:32:21 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06920F69
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 06:32:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h10so2571829wrx.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 06:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8QjdvcBfpY62HjxgDg6d8xd9Ur3ryWmHVOJJHV4pl8o=;
        b=i+YT32mwJOa7srtTEon4jLCGGthL7khqDRCB8hLwQKxDeqrwVBVqNpIFtF2q9DQUT7
         d+dTN8UhbnJrjIAP4DD4mHBadMnss56aJM+4KpRbtUvOsTjtNp573o7Lmf91gp6NG4Yw
         Nwqu5+eAKl2EbUBs3BbURkpcX9895p5zPUhAQFQyQa7+UOLh7mGk7b0NZ1c+TynzTGr0
         Bpz+qNlkhJWABWkwYcmcYM7Dimau0tgVa08RLmDYe3AWrBFtWNoOYyoi+SQMk8a8X+Yc
         +JKh9NMjWiJRinJxfH8GMen1SHxdk8t2/BSboLJe5QCaFdQM/PUaL4kwHEIdFgNa92Tk
         eT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QjdvcBfpY62HjxgDg6d8xd9Ur3ryWmHVOJJHV4pl8o=;
        b=jCRnuoNVHFCuO+iXuRXN31LcDQWRJSKapBtNkrW2ip2JrINSRdFAPHEoWjp5RP+Oy+
         j8HqfGxmMagzQt6H9Kwj7WX+q8DEZTYdXVLuqFSOGcXzF1u8pCVRO+Xh7n3VCFM9ggAz
         Zih/31//E6mAP3ut+y8Pru3+dypgXI2usfG1jgSDABbxULV+Y3kJwWNbHOWlCiGq5YlG
         t2EU9yVgNXPCxPNGlpbgt6/LfajWImZTFXO9kwuoX4UG++Lk4jbr5BgqwbpsU3t1a2/2
         wMUmGeNyKVK3WNvTkzHWY9hOD7dWaTEt+bAJaKdz4O9810LC6g8ndaua4Xvdr5j0/76+
         ydTw==
X-Gm-Message-State: ANoB5plsxsuAjA70OyICiXpPAwK/ZG9LF3uHo6FxlBBisZ8XJy79Iuzb
        7qq7rz/3ht+BSUM3xvDfLZhi3w==
X-Google-Smtp-Source: AA0mqf5NQRPKlfSryMZww1AyP9jTO5a0yDUixPctCLCktjrEFR4gnc6+jwzHMn5lW8pX3In+gvw0ag==
X-Received: by 2002:adf:ba87:0:b0:241:c471:72b4 with SMTP id p7-20020adfba87000000b00241c47172b4mr37412701wrg.238.1670077938687;
        Sat, 03 Dec 2022 06:32:18 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id c14-20020a05600c0a4e00b003cffd3c3d6csm11668898wmq.12.2022.12.03.06.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 06:32:18 -0800 (PST)
Date:   Sat, 3 Dec 2022 14:32:16 +0000
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
Message-ID: <20221203143216.oezd2u6dpxodpuc3@airbuntu>
References: <20221127141742.1644023-1-qyousef@layalina.io>
 <20221127141742.1644023-4-qyousef@layalina.io>
 <CAJZ5v0iew=_pTq-v-2EdZN==8QY3donu9YUBtRYWdL18KBxs4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iew=_pTq-v-2EdZN==8QY3donu9YUBtRYWdL18KBxs4Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 19:27, Rafael J. Wysocki wrote:

> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7c0dd57e562a..4bbbca85134b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8856,23 +8856,20 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> >          *   * Thermal pressure will impact all cpus in this perf domain
> >          *     equally.
> >          */
> > -       if (sched_energy_enabled()) {
> > +       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> >                 unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> > -               struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> > +               struct cpufreq_policy *policy, __maybe_unused *policy_n;
> >
> >                 rq->cpu_capacity_inverted = 0;
> >
> > -               SCHED_WARN_ON(!rcu_read_lock_held());
> > -
> > -               for (; pd; pd = pd->next) {
> > -                       struct cpumask *pd_span = perf_domain_span(pd);
> > +               for_each_active_policy_safe(policy, policy_n) {
> 
> 1. Is the "safe" part sufficient for protection against concurrent
> deletion and freeing of list entries?  cpufreq driver removal can do
> that AFAICS.

The freeing part is not safe probably. I need to research this more. Do you
have issues against the exportation of this traversal in principle?

Switching them to be RCU protected could be the best safe option, anything
against that too? I might not end up needing that. I need to dig more.

> 2. For a casual reader of this code it may not be clear why cpufreq
> policies matter here.

I'm looking for a way to traverse the list of capacities of the system and
know their related CPUs.

AFAICT this information already exists in the performance domains and
cpufreq_policy. Performance domains are conditional to energy model and
schedutil. So trying to switch to cpufreq_policy.

Assuming this question wasn't a request to add a comment :-)


Thanks!

--
Qais Yousef
