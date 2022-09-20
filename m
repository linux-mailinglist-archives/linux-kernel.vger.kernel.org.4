Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE985BEA85
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiITPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiITPuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:50:12 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70274BD26
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:50:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id z20so3543632ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jWZu+pNdv7Se5dUaLUT85efgm8rPYJPPiDerj+bezuw=;
        b=eQnttjwUDs1xlhpmFSnS0fXLYdoKaBAqVz9cvpffVXB3wVX/4u/FVhQc4KFq/Tw5nI
         TEdp9jVGG4bdCAovJCxQHTWzWDGrCmoT5eRMmZbgHoCvX8hIyZNRcvIfpPANhGRJQgpm
         UUHDLJtyhchir44V9SyhTdcl6xWqkGWcFT7hatukIo3o6zkXaGURkXdWVezVrNaiarTz
         ZKFNjOqvX5zQiQHDM848QtrGIhWyxpKrrvbZ9Hf67CUcjkTYOKUZbH/5KRNTs33p0xH3
         mt/P/JMWqsY4X/IF6iVroFyiZq90khDqQwganTL6O9ZLA7bomcwV4dZUhFHCWwJlgt2h
         cFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jWZu+pNdv7Se5dUaLUT85efgm8rPYJPPiDerj+bezuw=;
        b=sjcdJ1Ea66ixDAsArOWzO1/w1+fjm3ri+nnSnEqNo0AX6kMbotB+RgTwjqBjvGjnjR
         s0MfnB6RiKdmgkThvSp4ITpAG5HnAG8u2GLAoGnXL8ujUUQ7ze832AF8tJRgQGe9tCRF
         GoA1isdv8ZCfTFHxGoC9IAHI5j8I4mN/iF7iev+3wQqZgCItuvbVk6I0JctTrv91CVQH
         uaUIA4WjmpOlE6Yg2o65sjCbnUQ0F0r1T1WO8cLAFyeHPL55nsO2Rd4z4+JLLC1eponz
         tDYrl4Dnj/UvP+mTRhk4/XZXgvylVa8hzFncYfT5pmERTCEISOWbXaamWKQAROQiKAa3
         3a9g==
X-Gm-Message-State: ACrzQf3cLI2fRXLTaJ6LeTJsYNWRXI2GZ6H948VQAxaFt5KxjnfymVC4
        /SuBQt7Mj6tLNwZ067HhWutwEds49OJmvsD6f611SQ==
X-Google-Smtp-Source: AMsMyM6Oro+uhDCtZCLPdsSKYb/xxwrKfOSOWZKQJ3qce3JrhsL8jATjYXHG9vFwWMT4lHfjNAW3xm769rahr+GKweQ=
X-Received: by 2002:a2e:86cf:0:b0:26b:fe50:8c4c with SMTP id
 n15-20020a2e86cf000000b0026bfe508c4cmr6774771ljj.17.1663689008958; Tue, 20
 Sep 2022 08:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-6-vincent.guittot@linaro.org> <073938c4-ab23-2270-8e60-291f2901e230@arm.com>
 <CAKfTPtCWE5O4TeTBG8hgar8w56-WzvmX7aR9D7dXN_vJ5LCLyQ@mail.gmail.com> <b02452b2-900c-89da-c7b7-40a61268065e@arm.com>
In-Reply-To: <b02452b2-900c-89da-c7b7-40a61268065e@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 20 Sep 2022 17:49:57 +0200
Message-ID: <CAKfTPtDvWsq8YUEzK=xm+S22p=f1kR87a4hT38Ni_t4ZfZ0Zag@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] sched/fair: Take into account latency priority at wakeup
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sept 2022 at 15:18, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 19/09/2022 17:39, Vincent Guittot wrote:
> > On Mon, 19 Sept 2022 at 12:05, Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 16/09/2022 10:03, Vincent Guittot wrote:
> >>
> >> [...]
> >>
> >>> @@ -4512,7 +4519,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
> >>>       p->prio = current->normal_prio;
> >>>
> >>>       /* Propagate the parent's latency requirements to the child as well */
> >>> -     p->latency_nice = current->latency_nice;
> >>> +     p->latency_prio = current->latency_prio;
> >>
> >> Isn't here a `set_latency_offset(p)` missing here?
> >
> > Hmm, I think it's the opposite and the line above is a nop from the
> > beginning (i.e. patch 2).
>
> Yeah, you're right! It looked suspicious ...
>
> [...]
>
> >>> +      * the idle thread and don't set next buddy as a candidate for being
> >>> +      * picked in priority.
> >>> +      * In case of simultaneous wakeup from idle, the latency sensitive tasks
> >>> +      * lost opportunity to preempt non sensitive tasks which woke up
> >>> +      * simultaneously.
> >>> +      */
> >>
> >> The position of this comment block within this function is somehow
> >> misleading since it describes the reason for the function rather then a
> >> particular condition within this function. Wouldn't it be more readable
> >> when it would be a function header comment instead?
> >
> > I put it after the usual early return tests to put the comment close
> > to the useful part: the use of next buddy and __pick_first_entity()
>
> So you want to have the `wakeup_preempt_entity(se, pse) == 1` condition
> from check_preempt_wakeup() also for cfs_task woken up by others.

I wake the wakeup_preempt_entity(cfs_rq->next, left) < 1 in
pick_next_entity() to pick the task with highest latency constraint
when another class is running while waking up

>
> [...]
>
> >>> +      * requirement that needs to be evaluated versus other entity.
> >>> +      * Otherwise, use the latency weight to evaluate how much scheduling
> >>> +      * delay is acceptable by se.
> >>> +      */
> >>> +     if ((se->latency_offset < 0) || (curr->latency_offset < 0))
> >>> +             latency_offset -= curr->latency_offset;
> >>
> >> I still don't get the rationale behind why when either one (se or curr)
> >> of the latency_nice values is negative, we use the diff between them but
> >> if not, we only care about se's value. Why don't you always use the diff
> >> between se and curr? Since we have a range [-20 ... 19] why shouldn't we
> >> use the difference between let's say se = 19 and curr = 5?
> >> You discussed this with Tao Zhou on the v1 but I didn't understand it fully.
> >
> > Let say that current has a latency nice prio of 19 and a task A with a
> > latency nice of 10 wakes up. Both tasks don't care about scheduling
> > latency (current more than task A). If we use the diff, the output of
> > wakeup_latency_gran() would be negative (-10ms) which reflects the
> > fact that the waking task is sensitive to the latency and wants to
> > preempt current even if its vruntime is after. But obviously both
> > current and task A don't care to preempt at wakeup.
>
> OK, I understand but there is a certain level of unsteadiness here.
>
> If p has >0 it gets treated differently in case current has >=0 and case

"If p >=0"; 0 has same behavior than [1..19]

> current has <0.
>
> Do we expect that tasks set their value to [1..19] in this case, when
> the default 0 already indicates a 'don't care'?

I'm not sure that I understand your concern as [0..19] are treated in
the same way. Only tasks (curr or se) with offset <0 need a relative
comparison to the other. If curr and se has both a latency nice of
-19, se should not blindly preempt curr but only if curr already run
for its amount of time
