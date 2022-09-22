Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD545E5C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiIVHPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiIVHMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:12:46 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2492BC8886
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:12:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l12so9844835ljg.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4qwFmOB0PsZUxn1YuAMzNGjJlPsdphw8R7+YvCnubH0=;
        b=iGpJQHoFw4RkJ0uM0bYTb2MnQVcC7/PM9gf1/JiBbL2L5D7bcQ1uS2sQHS2Ey2LI0C
         eWLTEnJatcH+RErg6Z39iRbzhe/cFRg9IM5YuCJBg5COFpucMSXVDbkAUOZZKRuI5QPA
         irQV//+k0BTPSACljotoPGLCrHLzF6pXlGBxODHVCTvsPirYgx985RqxXJpwV7xjqCUe
         4PBcau3zMUeB+Gp5Mvgx3Ppmrud+GxocH+oFwVWrU0kKyzQwx+hLuYjOGtc4aTK24AMm
         Bw/vEXmbFaR6GCL7g3ww5HB43KEzohLWYSHIPpEOob/E59f3LhZPOONq0Zugy3Op8VHS
         VeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4qwFmOB0PsZUxn1YuAMzNGjJlPsdphw8R7+YvCnubH0=;
        b=UC7JPjrHjN4Vc8vhpf0MFq6d1fD6JcmshWnoN/k77zqll7dqctbfvRFFOi3cvcJl1D
         YmoHCbphtZ/AwW6cJcKUmLjpLG7gDlcAE0bakh4XNPbtFhw9iAlYCadws+Z/LDUnmNDj
         +3taZ9zXbZTmGL4Tr3JmZGY8x9OrxbxCYnzuwxJWh7gqBAaK3dho6k6VOUBSVAYHw1IM
         re9fMwS+YyBIbJKrvnDfxCZmi2hF5gkdqgSSdyyLNYInf4od3Lt1eqEUhyj60j/l0rYo
         jVl4TY+pacFDMwKKSjoUZfFYkIo3DeZHDN3MnqpTh9TSC5A4aNfd2o5EdyedUM606hQz
         ZAkQ==
X-Gm-Message-State: ACrzQf0yzQr0kv+8cXlG2BdqvOzpQXVwYBlf6EfyfLSt/GIyR8KXV0oG
        /JOYzEFwhXvnMtT0OuRPvg/+yHYQGT2jE2WwvYgZvg==
X-Google-Smtp-Source: AMsMyM4JYpd2n9iO3hmVepFOcLWqFkwfXgjMAL6JrMTRIg86WKiHwNCEUkx4CO5qX/hHUyDd66RCOcMoe07AHhsFXMY=
X-Received: by 2002:a2e:bf21:0:b0:266:2be3:61e8 with SMTP id
 c33-20020a2ebf21000000b002662be361e8mr561798ljr.383.1663830750949; Thu, 22
 Sep 2022 00:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-6-vincent.guittot@linaro.org> <073938c4-ab23-2270-8e60-291f2901e230@arm.com>
 <CAKfTPtCWE5O4TeTBG8hgar8w56-WzvmX7aR9D7dXN_vJ5LCLyQ@mail.gmail.com>
 <b02452b2-900c-89da-c7b7-40a61268065e@arm.com> <CAKfTPtDvWsq8YUEzK=xm+S22p=f1kR87a4hT38Ni_t4ZfZ0Zag@mail.gmail.com>
 <04c65f4f-5072-2a07-cbe0-63046a7bc58f@arm.com>
In-Reply-To: <04c65f4f-5072-2a07-cbe0-63046a7bc58f@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 22 Sep 2022 09:12:19 +0200
Message-ID: <CAKfTPtA1UFRGsDRVRNn_M2OEQ2G8A5MzWP_3GpmSsf1=B9+DdA@mail.gmail.com>
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

On Thu, 22 Sept 2022 at 00:41, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 20/09/2022 17:49, Vincent Guittot wrote:
> > On Tue, 20 Sept 2022 at 15:18, Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 19/09/2022 17:39, Vincent Guittot wrote:
> >>> On Mon, 19 Sept 2022 at 12:05, Dietmar Eggemann
> >>> <dietmar.eggemann@arm.com> wrote:
> >>>>
> >>>> On 16/09/2022 10:03, Vincent Guittot wrote:
>
> [...]
>
> >>>>> +      * the idle thread and don't set next buddy as a candidate for being
> >>>>> +      * picked in priority.
> >>>>> +      * In case of simultaneous wakeup from idle, the latency sensitive tasks
> >>>>> +      * lost opportunity to preempt non sensitive tasks which woke up
> >>>>> +      * simultaneously.
> >>>>> +      */
> >>>>
> >>>> The position of this comment block within this function is somehow
> >>>> misleading since it describes the reason for the function rather then a
> >>>> particular condition within this function. Wouldn't it be more readable
> >>>> when it would be a function header comment instead?
> >>>
> >>> I put it after the usual early return tests to put the comment close
> >>> to the useful part: the use of next buddy and __pick_first_entity()
> >>
> >> So you want to have the `wakeup_preempt_entity(se, pse) == 1` condition
> >> from check_preempt_wakeup() also for cfs_task woken up by others.
> >
> > I wake the wakeup_preempt_entity(cfs_rq->next, left) < 1 in
> > pick_next_entity() to pick the task with highest latency constraint
> > when another class is running while waking up
>
> That's correct. This is where you potentially pick this task since it is
> the next_buddy.
> All I wanted to say is that check_preempt_from_others() and its `next &&
> wakeup_preempt_entity(next, se) == 1` is the counterpart of the
> `wakeup_preempt_entity(se, pse) == 1` in check_preempt_wakeup() to be
> able to set next_buddy even curr is from an other class than CFS.
>
> [...]
>
> >>>> I still don't get the rationale behind why when either one (se or curr)
> >>>> of the latency_nice values is negative, we use the diff between them but
> >>>> if not, we only care about se's value. Why don't you always use the diff
> >>>> between se and curr? Since we have a range [-20 ... 19] why shouldn't we
> >>>> use the difference between let's say se = 19 and curr = 5?
> >>>> You discussed this with Tao Zhou on the v1 but I didn't understand it fully.
> >>>
> >>> Let say that current has a latency nice prio of 19 and a task A with a
> >>> latency nice of 10 wakes up. Both tasks don't care about scheduling
> >>> latency (current more than task A). If we use the diff, the output of
> >>> wakeup_latency_gran() would be negative (-10ms) which reflects the
> >>> fact that the waking task is sensitive to the latency and wants to
> >>> preempt current even if its vruntime is after. But obviously both
> >>> current and task A don't care to preempt at wakeup.
> >>
> >> OK, I understand but there is a certain level of unsteadiness here.
> >>
> >> If p has >0 it gets treated differently in case current has >=0 and case
> >
> > "If p >=0"; 0 has same behavior than [1..19]
> >
> >> current has <0.
>
> Not quite. It depends on curr. With sysctl_sched_latency = 24ms:

I thought you were speaking about priority 0 vs [1..19] as you made a
difference in your previous comment below

>
> (1) p = 10 curr =  19 -> wakeup_latency_gran() returns 12ms
>
> (2) p = 10 curr = -10 -> wakeup_latency_gran() returns 24ms
>
> In (1) only p's own latency counts whereas in (2) we take the diff,

Yes because  curr is latency sensitive in (2) whereas it's not in (1)

>
> In (A) we 'punish' p even though it competes against curr which has an
> even lower latency requirement than p,

What is (A) ?  Assuming you meant (1), having a positive nice latency
means that you don't have latency requirement but you are tolerant to
scheduling delay so we don't 'punish' p. P will preempt curr is we are
above the tolerance

>
> >> Do we expect that tasks set their value to [1..19] in this case, when
> >> the default 0 already indicates a 'don't care'?
> >
> > I'm not sure that I understand your concern as [0..19] are treated in
> > the same way. Only tasks (curr or se) with offset <0 need a relative
> > comparison to the other. If curr and se has both a latency nice of
> > -19, se should not blindly preempt curr but only if curr already run
> > for its amount of time
>
> With p = -19 and curr = -19 we would take the diff, so 0ms.
>
> With p = 19 and curr = 19, if we would use `latency_offset -=
> curr->latency_offset` wakeup_latency_gran() would return 973/1024*24ms -
> 973/1024*24ms = 0ms and nothing will shift.
>
> OTHA, in case (1) wakeup_latency_gran() would return 512/1024*24ms -
> 973/1024*24ms = - 10.80ms. So p would gain an advantage here instead of
> a penalty.

And that's all the point. A priority >= 0 means that you don't care
about scheduling delays so there is no reason to be more aggressive
with a task that is also latency tolerant. We only have to ensure that
the delay stays in the acceptable range

>
> Essentially using the full [-20 .. 19] nice scope for `se vs. curr`
> comparison.
