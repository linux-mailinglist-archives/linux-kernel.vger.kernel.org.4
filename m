Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417A46B8C41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCNHzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCNHzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:55:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F68A120
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:55:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso4064805pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678780541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/XnDS+u1BJ9PwrZFIhUvNtXbiqN3vXLdMvOTPWV7p4I=;
        b=EidKDvusPSe3+2lUI3Wg4glCUBM2Iwaxvx+yx6NNmyzowm+H17LL+vx1b+tMrk8Y5K
         E2eo1H86YAMLt3vm4jvrHHU+EseblmLJ0cXlDQH3V//fKZAoip5KSRjlmV89XRfzacD+
         7sA496WInLnJCAvxr+UUDI+Lt79SgtnMz0nz1zAB7qWQJMBWq/mi1Gv0fJYDUqKJ2NBE
         DMYLw8bgWmaO0eyvwUvC2d3DXKrD0k0dVTSju2iNvSgKi6iqbvv0ylbSMm2mcteBwSTn
         +azOGNotBpFbXX305mTSH8hX7H4ucKOO3kqHs0oZXU+lBcNpxyPAxlEU4yuhUwlzsE/1
         oEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678780541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XnDS+u1BJ9PwrZFIhUvNtXbiqN3vXLdMvOTPWV7p4I=;
        b=1dfN+rXclKE04Ck6pvX7I4prhjrWL4CJFvrreCgC2YhWWj78J9rlw9uz1uKN3EIfGf
         1QFkVUKp8FXiUv/bC/5d1g7JaVupNPgCAliLP+OO2JfhXvCF7XASerMQgHg6vBxTnNDy
         6GkngOrjx9QpHU7RzvTOEJZK4YkZdJ8DgEKzbvzq6vNJhVUz+eHpIebPmNOU31FKFVLJ
         T5U8T/q74PU8ik8Ka4Iv47KFA8yF7Y4/VNbkAQkTJ71xDl8OCawI3NZzP+pMlc9U8IYY
         N0k9gSOKaOpENv4+aUaLQI6pSKHM04Puf53cmSuSH/9wh1a7kzaF3wWZdGysm5QFvUpQ
         ALJg==
X-Gm-Message-State: AO0yUKXUFbmff5vnu2Tw7mFeoCp6BGatBBgbhesgI8aKrWR+X5S78P39
        AAaTfhpABz/IEQMcNbOXDDIZ0GsQUv6SY7u3YMxwTw==
X-Google-Smtp-Source: AK7set+ObK2Zlo59h51ApANMAh7Iy8RD9fCcfYhIobjWb0jP5jZ2x+0K7JCYE2sQjzy/Mx4SauNPr5DID/O9G49DRBA=
X-Received: by 2002:a17:90b:28f:b0:23d:3659:9710 with SMTP id
 az15-20020a17090b028f00b0023d36599710mr592959pjb.3.1678780540995; Tue, 14 Mar
 2023 00:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230223185153.1499710-1-sshegde@linux.vnet.ibm.com>
 <xm26356w3rnp.fsf@google.com> <13e69582-80e0-86c7-9d93-d710446ef25a@linux.vnet.ibm.com>
In-Reply-To: <13e69582-80e0-86c7-9d93-d710446ef25a@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 14 Mar 2023 08:55:29 +0100
Message-ID: <CAKfTPtC8hc10V8weQRz2wzwyqQ0_cp+qpdpzwNbUefDNKKSn4Q@mail.gmail.com>
Subject: Re: [PATCH V3] Interleave cfs bandwidth timers for improved single
 thread performance at low utilization
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     Benjamin Segall <bsegall@google.com>, mingo@redhat.com,
        peterz@infradead.org, dietmar.eggemann@arm.com, tglx@linutronix.de,
        srikar@linux.vnet.ibm.com, arjan@linux.intel.com,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 15:22, Shrikanth Hegde <sshegde@linux.vnet.ibm.com> wrote:
>
>
>
> >> CPU cfs bandwidth controller uses hrtimer. Currently there is no initial
> >> value set. Hence all period timers would align at expiry.
> >> This happens when there are multiple CPU cgroup's.
> >>
> >> There is a performance gain that can be achieved here if the timers are
> >> interleaved when the utilization of each CPU cgroup is low and total
> >> utilization of all the CPU cgroup's is less than 50%. If the timers are
> >> interleaved, then the unthrottled cgroup can run freely without many
> >> context switches and can also benefit from SMT Folding. This effect will
> >> be further amplified in SPLPAR environment.
> >>
> >> This commit adds a random offset after initializing each hrtimer. This
> >> would result in interleaving the timers at expiry, which helps in achieving
> >> the said performance gain.
> >>
> >> This was tested on powerpc platform with 8 core SMT=8. Socket power was
> >> measured when the workload. Benchmarked the stress-ng with power
> >> information. Throughput oriented benchmarks show significant gain up to
> >> 25% while power consumption increases up to 15%.
> >>
> >> Workload: stress-ng --cpu=32 --cpu-ops=50000.
> >> 1CG - 1 cgroup is running.
> >> 2CG - 2 cgroups are running together.
> >> Time taken to complete stress-ng in seconds and power is in watts.
> >> each cgroup is throttled at 25% with 100ms as the period value.
> >>            6.2-rc6                     |   with patch
> >> 8 core   1CG    power   2CG     power  |  1CG    power  2 CG    power
> >>         27.5    80.6    40      90     |  27.3    82    32.3    104
> >>         27.5    81      40.2    91     |  27.5    81    38.7     96
> >>         27.7    80      40.1    89     |  27.6    80    29.7    106
> >>         27.7    80.1    40.3    94     |  27.6    80    31.5    105
> >>
> >> Latency might be affected by this change. That could happen if the CPU was
> >> in a deep idle state which is possible if we interleave the timers. Used
> >> schbench for measuring the latency. Each cgroup is throttled at 25% with
> >> period value is set to 100ms. Numbers are when both the cgroups are
> >> running simultaneously. Latency values don't degrade much. Some
> >> improvement is seen in tail latencies.
> >>
> >>              6.2-rc6        with patch
> >> Groups: 16
> >> 50.0th:          39.5            42.5
> >> 75.0th:         924.0           922.0
> >> 90.0th:         972.0           968.0
> >> 95.0th:        1005.5           994.0
> >> 99.0th:        4166.0          2287.0
> >> 99.5th:        7314.0          7448.0
> >> 99.9th:       15024.0         13600.0
> >>
> >> Groups: 32
> >> 50.0th:         819.0           463.0
> >> 75.0th:        1596.0           918.0
> >> 90.0th:        5992.0          1281.5
> >> 95.0th:       13184.0          2765.0
> >> 99.0th:       21792.0         14240.0
> >> 99.5th:       25696.0         18920.0
> >> 99.9th:       33280.0         35776.0
> >>
> >> Groups: 64
> >> 50.0th:        4806.0          3440.0
> >> 75.0th:       31136.0         33664.0
> >> 90.0th:       54144.0         58752.0
> >> 95.0th:       66176.0         67200.0
> >> 99.0th:       84736.0         91520.0
> >> 99.5th:       97408.0        114048.0
> >> 99.9th:      136448.0        140032.0
> >>
> >> Signed-off-by: Shrikanth Hegde<sshegde@linux.vnet.ibm.com>
> >> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> >
> > Reviewed-by: Ben Segall <bsegall@google.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Ben, Thank you very much for the review.
>
> Peter, Ingo, Vincent,
> Could you please provide your inputs? Any other benchmarks should be run?
>
>
> Sorry about the subject line. I should have included sched/fair. I realized it after
> mail was sent. I sent another mail with only subject line changed.
> They are same except subject line.
> https://lore.kernel.org/lkml/20230223185918.1500132-1-sshegde@linux.vnet.ibm.com/
>
> Should I resend the patch with better change log and a cover letter detailing
> test results instead?
>
> >
> >>
> >> Initial RFC PATCH, discussions and details on the problem:
> >> Link1: https://lore.kernel.org/lkml/5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com/
> >> Link2: https://lore.kernel.org/lkml/9c57c92c-3e0c-b8c5-4be9-8f4df344a347@linux.vnet.ibm.com/
> >>
> >> ---
> >>  kernel/sched/fair.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index ff4dbbae3b10..2a4a0969e04f 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -5923,6 +5923,10 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> >>      INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
> >>      hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
> >>      cfs_b->period_timer.function = sched_cfs_period_timer;
> >> +
> >> +    /* Add a random offset so that timers interleave */
> >> +    hrtimer_set_expires(&cfs_b->period_timer,
> >> +                        get_random_u32_below(cfs_b->period));
> >>      hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> >>      cfs_b->slack_timer.function = sched_cfs_slack_timer;
> >>      cfs_b->slack_started = false;
> >> --
> >> 2.31.1
