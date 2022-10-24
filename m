Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C6960BD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiJXWJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiJXWIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:08:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714A8FAEC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:21:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y14so7624817ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dERpXoQaj0B3/niiPTXBcW7nIYbTTJdlrNL1pNOuhbA=;
        b=JaJC+7DKRq+4NBzdEOFNn1U5rl9hxBTI+AX453mXolF8xgj+HHN+E4tUb9m+9/ePwe
         41E9wefx3R6UqxIkbY8mVi/LzCOKt4OOC5uh52m2UDqr9qDVo832N4o4lBGaSNLAvlQc
         Ng4w3nCkvBsWIRutfPKjhIou4fZrTmHdfp2oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dERpXoQaj0B3/niiPTXBcW7nIYbTTJdlrNL1pNOuhbA=;
        b=PxnnwcT1a45h7+q6nNhQ/st+GFphWOPX1pDdCd2akiY2fXB33Z3M9bJsu15xUlOmq2
         cvn3rJrYaPiuGQUjDCiGap7CnkuCFBNStE+lv/S4YvZQMq4RLmLC1Sht+pVN9scQTtG+
         y21TT8jG58JdJAZsq/J+3CDkrD8rwf2feGy7/vebDtWsBKVSHw+x+EolMGpOi0UOV8zz
         OIG9SduunavjtTKlv1INDrNufN0RA5JYRN6TOHctKY3jvO/hU3SI8AE59SUtGULwTqW6
         7PxsD65eTV87SMyi3J7iQm57YSDrlygeSlQAkBq6AM+MufBb9JFKMwywCh5bwqRplRxg
         JzRQ==
X-Gm-Message-State: ACrzQf1SRDf7zf28gchhQGh5b+jetFnN1gO1Yk5KLk4PH+zuUXRRMK5E
        XCqg4B3tqcPHVu+UHzOav7SEJO7U9GSwJR5dqYJL2rHEURk=
X-Google-Smtp-Source: AMsMyM6zgHzftfXgAJWzJydsRQHFR+KbBSbeaLnXm3nQkFJ5jn6auE82G3JQsFVB8UJBKtamZ6WrxH/Hi428/VW/VFs=
X-Received: by 2002:a05:6402:3806:b0:450:bad8:8cd5 with SMTP id
 es6-20020a056402380600b00450bad88cd5mr33236599edb.305.1666642108991; Mon, 24
 Oct 2022 13:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1ZtyjxKCcV0Hfjn@pc636> <Y1aDy3maaO39ClSU@pc636> <Y1ahs83258Lok9+O@google.com>
 <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1> <Y1a8ei1h7SzyYZx9@pc636>
 <20221024164819.GA5600@paulmck-ThinkPad-P17-Gen-1> <Y1bDdP3iHoa4xqZL@pc636>
 <Y1bGcQ7RPleYp3ge@pc636> <CAEXW_YQqiD1GU7HGrv9UU6vL_MqbxVt14=rxZAKqUpK+pkPDPw@mail.gmail.com>
 <Y1bODlfqVMQivzJU@pc636>
In-Reply-To: <Y1bODlfqVMQivzJU@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 24 Oct 2022 16:08:17 -0400
Message-ID: <CAEXW_YSRkNDhJu591S3GGQyJnCxCDJy6u_+-1Q_8z5_cQHb1Qg@mail.gmail.com>
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use call_rcu_flush()
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 1:40 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Mon, Oct 24, 2022 at 01:20:26PM -0400, Joel Fernandes wrote:
> > On Mon, Oct 24, 2022 at 1:08 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > >
> > > On Mon, Oct 24, 2022 at 06:55:16PM +0200, Uladzislau Rezki wrote:
> > > > On Mon, Oct 24, 2022 at 09:48:19AM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Oct 24, 2022 at 06:25:30PM +0200, Uladzislau Rezki wrote:
> > > > > > >
> > > > > > > You guys might need to agree on the definition of "good" here.  Or maybe
> > > > > > > understand the differences in your respective platforms' definitions of
> > > > > > > "good".  ;-)
> > > > > > >
> > > > > > Indeed. Bad is when once per-millisecond infinitely :) At least in such use
> > > > > > workload a can detect a power delta and power gain. Anyway, below is a new
> > > > > > trace where i do not use "flush" variant for the kvfree_rcu():
> > > > > >
> > > > > > <snip>
> > > > > > 1. Home screen swipe:
> > > > > >          rcuop/0-15      [003] d..1  1792.767750: rcu_batch_start: rcu_preempt CBs=1003 bl=10
> > > > > >          rcuop/2-33      [002] d..1  1792.771717: rcu_batch_start: rcu_preempt CBs=934 bl=10
> > > > > >          rcuop/3-40      [001] d..1  1794.811816: rcu_batch_start: rcu_preempt CBs=1508 bl=11
> > > > > >          rcuop/1-26      [003] d..1  1797.116382: rcu_batch_start: rcu_preempt CBs=2127 bl=16
> > > > > >          rcuop/4-48      [001] d..1  1797.124422: rcu_batch_start: rcu_preempt CBs=95 bl=10
> > > > > >          rcuop/5-55      [002] d..1  1797.124731: rcu_batch_start: rcu_preempt CBs=143 bl=10
> > > > > >          rcuop/6-62      [005] d..1  1798.911719: rcu_batch_start: rcu_preempt CBs=132 bl=10
> > > > > >          rcuop/2-33      [002] d..1  1803.003966: rcu_batch_start: rcu_preempt CBs=3797 bl=29
> > > > > >          rcuop/0-15      [003] d..1  1803.004707: rcu_batch_start: rcu_preempt CBs=2969 bl=23
> >
> > > > > > 2. App launches:
> > > > > >          rcuop/4-48      [005] d..1  1831.087612: rcu_batch_start: rcu_preempt CBs=6141 bl=47
> > > > > >          rcuop/7-69      [007] d..1  1831.095578: rcu_batch_start: rcu_preempt CBs=5464 bl=42
> > > > > >          rcuop/5-55      [004] d..1  1832.703571: rcu_batch_start: rcu_preempt CBs=8461 bl=66
> > > > > >          rcuop/0-15      [004] d..1  1833.731603: rcu_batch_start: rcu_preempt CBs=2548 bl=19
> > > > > >          rcuop/1-26      [006] d..1  1833.743691: rcu_batch_start: rcu_preempt CBs=2567 bl=20
> > > > > >          rcuop/2-33      [006] d..1  1833.744005: rcu_batch_start: rcu_preempt CBs=2359 bl=18
> > > > > >          rcuop/3-40      [006] d..1  1833.744286: rcu_batch_start: rcu_preempt CBs=3681 bl=28
> > > > > >          rcuop/4-48      [002] d..1  1838.079777: rcu_batch_start: rcu_preempt CBs=10444 bl=81
> > > > > >          rcuop/7-69      [001] d..1  1838.080375: rcu_batch_start: rcu_preempt CBs=12572 bl=98
> > > > > >            <...>-62      [002] d..1  1838.080646: rcu_batch_start: rcu_preempt CBs=14135 bl=110
> > > > > >          rcuop/6-62      [000] d..1  1838.087722: rcu_batch_start: rcu_preempt CBs=10839 bl=84
> > > > > >            <...>-62      [003] d..1  1839.227022: rcu_batch_start: rcu_preempt CBs=1834 bl=14
> > > > > >            <...>-26      [001] d..1  1839.963315: rcu_batch_start: rcu_preempt CBs=5769 bl=45
> > > > > >          rcuop/2-33      [001] d..1  1839.966485: rcu_batch_start: rcu_preempt CBs=3789 bl=29
> > > > > >            <...>-40      [001] d..1  1839.966596: rcu_batch_start: rcu_preempt CBs=6425 bl=50
> > > > > >          rcuop/2-33      [005] d..1  1840.541272: rcu_batch_start: rcu_preempt CBs=825 bl=10
> > > > > >          rcuop/2-33      [005] d..1  1840.547724: rcu_batch_start: rcu_preempt CBs=44 bl=10
> > > > > >          rcuop/2-33      [005] d..1  1841.075759: rcu_batch_start: rcu_preempt CBs=516 bl=10
> > > > > >          rcuop/0-15      [002] d..1  1841.695716: rcu_batch_start: rcu_preempt CBs=6312 bl=49
> > > > > >          rcuop/0-15      [003] d..1  1841.709714: rcu_batch_start: rcu_preempt CBs=39 bl=10
> > > > > >          rcuop/5-55      [004] d..1  1843.112442: rcu_batch_start: rcu_preempt CBs=16007 bl=125
> > > > > >          rcuop/5-55      [004] d..1  1843.115444: rcu_batch_start: rcu_preempt CBs=7901 bl=61
> > > > > >          rcuop/6-62      [001] dn.1  1843.123983: rcu_batch_start: rcu_preempt CBs=8427 bl=65
> > > > > >          rcuop/6-62      [006] d..1  1843.412383: rcu_batch_start: rcu_preempt CBs=981 bl=10
> > > > > >          rcuop/0-15      [003] d..1  1844.659812: rcu_batch_start: rcu_preempt CBs=1851 bl=14
> > > > > >          rcuop/0-15      [003] d..1  1844.667790: rcu_batch_start: rcu_preempt CBs=135 bl=10
> >
> > Definitely better, but I'd still ask why not just rely on the lazy
> > batching that we now have, since it is a memory pressure related
> > usecase. Or another approach could be, for CONFIG_RCU_LAZY, don't
> > disturb the lazy-RCU batching by queuing these "free memory" CBs; and
> > instead keep your improved kvfree_rcu() batching only for
> > !CONFIG_RCU_LAZY.
> >
>
> 1. Double-batching?
>
> The kvfree_rcu() interface itself keeps track of when to reclaim:
>   a) when a page is full;
>   b) when i high storm of freeing over rcu;
>   c) when a low memory condition.
>
> such control stays inside the kvfree_rcu(). Converting it to lazy
> variant:
>   a) lose the control, what will become as a problem;
>   b) nothing is improved.

AFAICS, the only thing being changed is when you are giving memory
back to the system. So you will be holding on to memory a bit longer.
And there's shrinkers that are already flushing those. I don't think
the users of kvfree_rcu() want to free memory instantly. If there is
such usecase, please share it.

> 2. Converting the queue_rcu_work() to lazy variant breaks a humanity
> interpretation when a queued work is supposed to be run. People do not
> expect seconds when they queue the work.

Which people? ;)

> Same as in the kvfree_rcu()
> we do not expect it we even used a high_prio queue in the beginning.
> There are ~10 users who queue the work and they did not expect it to
> be run in 10 seconds when they wrote the code.

That's a bit of a misinterpretation of what I'm saying. A variant
queue_rcu_work_flush() can be added for those users (such as ones that
are not freeing memory).

Thanks.
