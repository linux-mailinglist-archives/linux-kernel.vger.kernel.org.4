Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7926FC7EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjEINbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjEINba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:31:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526922D7E
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:31:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6436e004954so6069124b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683639089; x=1686231089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh3wmGQSylgZ+lbfEaskp3lMwur0X/UJKmpCZYE7vBk=;
        b=AaPq1d4hdO4Bt5tNNsSP9xnSVfgBBnvQ+uY4pcUWKcaY96rKWhbd40YGpSxONTSqyB
         Igu6fIGId4v8akGbBgO0BqXYS0iathNp5dRTckCeHlYm2jtyWhj3UzMY69VEKLjX6Gcz
         yGMO1n17tzfx6eKK83d8BWqbA+eYC26ZhRWLksqEpoRDsSuZU8UyP5pHKrUm4lmkhnr+
         CKg6+SVnZOYUi+P5tA6bylG01Iz15oBy7E+GIb/y2RMPr55mIdPCD2CkGwgi7sThKTVA
         0A+SX6eXHeBGRW7fKHCzk95uoOfkjjYD78zCw10FWuOkoKshGMktzxrsEokUn6o2mNHl
         3JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683639089; x=1686231089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bh3wmGQSylgZ+lbfEaskp3lMwur0X/UJKmpCZYE7vBk=;
        b=T9kvI/d+1lmv+EXv/V3trRCbV12SDBRJAoua94GCKQRSlYbxReqOnBEo39tdDlB902
         P8MAs9l9kj/yFpiBQUk0kN+dasDzS7cZqWVBRvTsphgOIh6NJFoALhf6Nx7rBi8VsxB9
         ZQ8NXpHVLagO0T/SOSbkAl4WmlIFxLIm8XixSCJBksrPfMbrlA41cSAisLwHcs0mTawC
         1CCwvkRlSGZ2gvt0NAvtnQLm8wnjVggW/Q0kNaznyrgd3oTNn5wuOd8aDoLF3rOsc7q5
         N0CDlmo1B0N8nfoPvJbTIIxN4KHfkjS0EuGvSbAXrtdOjPZezHj+wNgttwXW9qsz87Sg
         pWjQ==
X-Gm-Message-State: AC+VfDxb7tvPKuWAG4H7ZbHjqbffgS2Ti/w5Cvex3e7gIh7uZfr+6bpM
        shRNAnCTADEZ3BecEZjhzXAno2zfgoZzw+Yi+K67NQ==
X-Google-Smtp-Source: ACHHUZ4wn+v9xMk/emcWaJW48FvHwGfYby9drzxTDLxsH0w9zNLL93gW63rlxCSVXk6PJd29sSAot4yKqisteVW9q/I=
X-Received: by 2002:a05:6a20:7492:b0:100:b137:3563 with SMTP id
 p18-20020a056a20749200b00100b1373563mr6127980pzd.32.1683639088509; Tue, 09
 May 2023 06:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683156492.git.tim.c.chen@linux.intel.com> <231cf298efb8627499bb42788588a6108c7b8f7c.1683156492.git.tim.c.chen@linux.intel.com>
In-Reply-To: <231cf298efb8627499bb42788588a6108c7b8f7c.1683156492.git.tim.c.chen@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 May 2023 15:31:16 +0200
Message-ID: <CAKfTPtD1W6vJQBsNKEt_4tn2EeAs=73CeH4LoCwENrh2JUDwnQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] sched/fair: Check whether active load balance is
 needed in busiest group
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
> In the busiest group, we need to consider whether active load balance
> to a local group is needed even when it is not overloaded.  For example,
> when the busiest group is a SMT group that's fully busy and the destination group
> is a cluster group with idle CPU.  Such condition is considered by
> asym_active_balance() in load balancing but not when looking for busiest
> group and load imbalance.  Add this consideration in find_busiest_group()
> and calculate_imbalance().
>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

Could you have a look at what we did with misfit ?

we already have a SD_ASYM_CPUCAPACITY when  busiest->group_type ==
group_misfit_task. Misfit_task is between overloaded and ahs_spare to
handle such situation. Please detect this during the update of
statistic and tag the group correctly. We will not re-start to add
exception everywhere.

> ---
>  kernel/sched/fair.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 87317634fab2..bde962aa160a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9433,6 +9433,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                                 sgs->group_capacity;
>  }
>
> +/* One group is SMT while the other group is not */
> +static inline bool asymmetric_groups(struct sched_group *sg1,
> +                                   struct sched_group *sg2)
> +{
> +       if (!sg1 || !sg2)
> +               return false;
> +
> +       return (sg1->flags & SD_SHARE_CPUCAPACITY) !=
> +               (sg2->flags & SD_SHARE_CPUCAPACITY);
> +}
> +
>  /**
>   * update_sd_pick_busiest - return 1 on busiest group
>   * @env: The load balancing environment.
> @@ -10079,6 +10090,31 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>         update_idle_cpu_scan(env, sum_util);
>  }
>
> +static inline bool asym_active_balance_busiest(struct lb_env *env, struct sd_lb_stats *sds)
> +{
> +       /*
> +        * Don't balance to a group without spare capacity.
> +        *
> +        * Skip non asymmetric sched group balancing. That check
> +        * is handled by code path handling imbalanced load between
> +        * similar groups.
> +        */
> +       if (env->idle == CPU_NOT_IDLE ||
> +           sds->local_stat.group_type != group_has_spare ||
> +           !asymmetric_groups(sds->local, sds->busiest))
> +               return false;
> +
> +       /*
> +        * For SMT source group, pull when there are two or more
> +        * tasks over-utilizing a core.
> +        */
> +       if (sds->busiest->flags & SD_SHARE_CPUCAPACITY &&
> +           sds->busiest_stat.sum_h_nr_running > 1)
> +               return true;
> +
> +       return false;
> +}
> +
>  /**
>   * calculate_imbalance - Calculate the amount of imbalance present within the
>   *                      groups of a given sched_domain during load balance.
> @@ -10164,6 +10200,12 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>                         return;
>                 }
>
> +               if (asym_active_balance_busiest(env, sds)) {
> +                       env->migration_type = migrate_task;
> +                       env->imbalance = 1;
> +                       return;
> +               }
> +
>                 if (busiest->group_weight == 1 || sds->prefer_sibling) {
>                         unsigned int nr_diff = busiest->sum_nr_running;
>                         /*
> @@ -10371,6 +10413,9 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>                          */
>                         goto out_balanced;
>
> +               if (asym_active_balance_busiest(env, &sds))
> +                       goto force_balance;
> +
>                 if (busiest->group_weight > 1 &&
>                     local->idle_cpus <= (busiest->idle_cpus + 1))
>                         /*
> --
> 2.32.0
>
