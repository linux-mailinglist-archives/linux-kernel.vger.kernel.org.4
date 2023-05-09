Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0006B6FC811
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjEINhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbjEINhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:37:05 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F42121
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:36:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-52079a12451so4157471a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 06:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683639406; x=1686231406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLn8RjSszDsDIPWFfjQXVecpn5ymy34nhg3pULe9gJs=;
        b=kwBO9d7ZRy1DZnhorU1sn3keK02CS+EMGprm41+K56xzJOPe0CgXgpq9v4SiyhdDep
         Jp15dd1aasaULgR0zV0dRb/MqYOnFWQWF5r4Gl+RQBmDLLEgSgNbxb0FpnwofpzDy9WJ
         JOolmhezvKaCvPsZWi0dhWrqPrnhrs844LaHL/u42II5Y3h9J/lKHBFDB7KuFBdzT3y5
         1gJuRq9utqnG/fgjaPhq0U7ikCiG4n2pMz3IfNK8cBG56j0RZzczsDxPfRlAUlvz00bk
         pfsmdFPWiCSaMApqxM4Lfzd1vH0q/01Nu9TAG6HVsjHMwjkDBAiBlHngv4ppA+mxtmKJ
         z2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683639406; x=1686231406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLn8RjSszDsDIPWFfjQXVecpn5ymy34nhg3pULe9gJs=;
        b=fsJ+BLsrPf9XFSKTG5ZhWbQYzt9jIEJsKma1JQj1l2erDtzvbAWLfszG0SWnpSdUPq
         rfpk9yB+/Gvg7e1UdlgEwiMITmMNV1d+zQEf0dRrVeGV1YSyULSUx7cTTCZFh6dZgtiR
         LbgG5b8k/sNdYaZTVCOQ5k0w9efEU+SROu+Xw27gV1zeYUbtepHkD5szbcRzOC+VHk4/
         OEXUvlWzlNW3AYVvOIjeoRyw5813t1Td+NXmjpqskkwVkr/ORP6cRW0xgAY6hUkdzV1l
         iFShMOJxWPbh+lk7UpVDkiSOhpdtDFgpdEYmtYH2kJPA1zzfPDLJfNAdH2JZGWvzzvOz
         dOnw==
X-Gm-Message-State: AC+VfDxLZjYNHbZVH2RfICTHg+v5Q3Q09HlEsHAmnT2Q7py0pq0fdxJs
        oy85lLGoRSPGCKlHxOPc4ZmXmE0Hk0njgocZZQy7OA==
X-Google-Smtp-Source: ACHHUZ5FIoDgeNXzxKh97JDuLMJwG8z93n9wE47ysEJbSr0uaNFv99BYXa2Mk5akhTtxgYW9VsiVtugPi95uxgja/mY=
X-Received: by 2002:a17:90a:a613:b0:24e:2966:f62 with SMTP id
 c19-20020a17090aa61300b0024e29660f62mr15089277pjq.42.1683639406173; Tue, 09
 May 2023 06:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683156492.git.tim.c.chen@linux.intel.com> <b20517e3986bfdde8a605afa19d144ec411c7a42.1683156492.git.tim.c.chen@linux.intel.com>
In-Reply-To: <b20517e3986bfdde8a605afa19d144ec411c7a42.1683156492.git.tim.c.chen@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 May 2023 15:36:35 +0200
Message-ID: <CAKfTPtBU1Jehye1bY5Ve0hC9_oGKL=SoVRar3Kbs5rhGcEEnAw@mail.gmail.com>
Subject: Re: [PATCH 4/6] sched/fair: Skip prefer sibling move between SMT
 group and non-SMT group
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023 at 18:11, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> From: Tim C Chen <tim.c.chen@linux.intel.com>
>
> Do not try to move tasks between non SMT sched group and SMT sched
> group for "prefer sibling" load balance.
> Let asym_active_balance_busiest() handle that case properly.
> Otherwise we could get task bouncing back and forth between
> the SMT sched group and non SMT sched group.
>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a325db34b02..58ef7d529731 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10411,8 +10411,12 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>         /*
>          * Try to move all excess tasks to a sibling domain of the busiest
>          * group's child domain.
> +        *
> +        * Do not try to move between non smt sched group and smt sched
> +        * group. Let asym active balance properly handle that case.
>          */
>         if (sds.prefer_sibling && local->group_type == group_has_spare &&
> +           !asymmetric_groups(sds.busiest, sds.local) &&

Can't you delete SD_PREFER_SIBLING flags when building topology like
SD_ASYM_CPUCAPACITY does ?

Generally speaking  SD_ASYM_CPUCAPACITY and SD_ASYM_PACKING are doing
quite similar thing, it would be good to get one common solution
instead 2 parallel paths

>             busiest->sum_nr_running > local->sum_nr_running + 1)
>                 goto force_balance;
>
> --
> 2.32.0
>
