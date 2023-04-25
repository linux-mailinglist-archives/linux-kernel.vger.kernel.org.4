Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C706EE44A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjDYOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjDYOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:52:44 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE263A92
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:52:43 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3ef31924c64so121901cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682434363; x=1685026363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFkADC61Ruy0YiM9Q7ZuLeqnPlgtrzBobMvcjsyYsxk=;
        b=SH22TsHZsxrHWA4Mt9nlzmpr5qi2uSUwjRQ4uOISknbWrSlr8BFHkPe/aR7eJPHGum
         cppRaxIDzzT2xXBArK0N+bAh7auJyizCpA3imu/QTB5qBF+YeePce879aChDQ4WcQ1Ea
         X2YVhFfUjwjkRg8i1SWEdQcLEExtMAJyG1537RABtFoLWpkDhGufwHrxM5dEj4NXYcRk
         fuTWmk/oIyN5mXPNVYN39kI2ZNKoLyidNgI9h1saP78ZoJjt6J/oUJTdTwPFPc1wZqur
         kMXrqe+R7RncpyKIUOAyjn4Kdwy0YClL2QRuzgPcjcRVmYt0ZJSSqRdFnw8sAkmDNUiK
         hFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682434363; x=1685026363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFkADC61Ruy0YiM9Q7ZuLeqnPlgtrzBobMvcjsyYsxk=;
        b=NANvWj6MhYMjQJVOQU4T2XOAocM2eIlT4iBRs5TANlZ473uIvPK/DMn9wRo5e854mR
         u2zhHt+A0IaMvLQclyAYcWT/yp6p0axpRW8GKxKDxlLl1gAVUWrUxUsdbpV5aSj9siGO
         idlXQMCdlJ3d1hY1ZOrn0p23emqfaUh9OsV9//H4aLHBfqeJbUS7Atq4n9+GGipJ45rR
         sf1Ddn0SbIotq4F5Y/dUAKSQUBYc8mf27usCc0XAiKd9dkRo5JxlNd+I/d6XLbUH3yWp
         P4j4BvX4KL6Su18CwM8ea3CuB7HTI8jDdn6IbpipwvHyHxBHYkMrV3w5DPjdhTGTN0gJ
         OArA==
X-Gm-Message-State: AAQBX9ckB7Oi4tXzvQ7eIEU4sQBMPsL6ardiPnBAtLzAEjFsXefCZTWR
        Qp5z304Zeug8Bkx/O7Mh7hOtZyaVc25z2coLCt2M
X-Google-Smtp-Source: AKy350ZMSSAQJJnpOj6JCQZqJN1PLCG6jXd5jxZhoAA5QImlOhfg0YjgFPTbT+0TuINYiITWcT+PDNneu4M72RYUNpM=
X-Received: by 2002:ac8:5f4e:0:b0:3de:b0b0:557c with SMTP id
 y14-20020ac85f4e000000b003deb0b0557cmr358349qta.18.1682434362935; Tue, 25 Apr
 2023 07:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com> <20230411042511.1606592-10-jstultz@google.com>
 <20230422101427.GD1214746@hirez.programming.kicks-ass.net>
In-Reply-To: <20230422101427.GD1214746@hirez.programming.kicks-ass.net>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 25 Apr 2023 15:52:31 +0100
Message-ID: <CANDhNCr3acrEpBYd2LVkY3At=HCDZxGWqbMMwzVJ-Mn--dv3DA@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] sched: Split scheduler execution context
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 11:14=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Apr 11, 2023 at 04:25:06AM +0000, John Stultz wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Lets define the scheduling context as all the scheduler state in
> > task_struct and the execution context as all state required to run the
> > task.
> >
> > Currently both are intertwined in task_struct. We want to logically
> > split these such that we can run the execution context of one task
> > with the scheduling context of another.
> >
> > To this purpose introduce rq_selected() to point to the task_struct
> > used for scheduler state and preserve rq_curr() to denote the execution
> > context.
>
> I can't say I like the rq_selected() naming :/

So, I'm not married to any particular naming, but the earlier use of
"rq->proxy" in the earlier patches really made very little sense, at
least from my perspective of the word (especially as it had logical
knots  where it would set rq->proxy to what pick_next_task() returned,
and then go and set curr to the results of proxy()).  So it seemed
cleanest to separate it out and use a different term.

We could do "rq_picked()", or "rq_next", or ...  suggestions are welcome.

Thanks again for taking a look here and providing feedback! I really
appreciate it!
-john
