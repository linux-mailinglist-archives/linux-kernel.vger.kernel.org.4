Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E3632D11
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiKUThd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiKUTha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:37:30 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74622F54
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:37:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s8so20343379lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dvxWSbOGt/q3oX51qgBEOTTPkYmCFByVIpKRWftXbOw=;
        b=LjdkeOhNI7f/79ZCQ+XmzzpIVs+AXL5PcSXhsF5Gh1Wr9uE/nbTm2VUrUhmgr59Gqt
         l8Bhn4nXWuU2aly5bYpO1/bgwR6O9jGm72xqhYhV9/H5MQjvcqHpFb35wsyAMTBJhv8S
         O2eE9RgNhVXzeFALIVP/axHlANmE8zU1NyqYqkBzFhFIk5oQOfkP49w1Lv0WcUeGKT7Y
         tyoglseeJg/2js7XTxd7ZFZWlSmhZU15fdWAtn1TkIgrwhPRMruw7qXdD/cD88l3nCAU
         /2GJs3tt8X31uNgvkXR4GVn/2Khi01eh1NpY4yyB4yk48Ytk5oiVguPT6CFNsir2GZak
         YNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvxWSbOGt/q3oX51qgBEOTTPkYmCFByVIpKRWftXbOw=;
        b=4tFeTcoDlOgXDNIn4wDeLw5TQeZ8Q5GxDnrgW7yCaijqstGqdQiPyLStWsnRDbuwni
         nM2q5Jy4nQoqT0MFcNAwjZVL2MeNXp3bML++mC56xmy+H4i+QG28daHk97r7xkGZuGod
         ooEA+hh73Mdo739D9lJ0+2CTpw20qekQJj+yEMSiscyrIswMue0/HN5wtkv0DZV1CHmm
         VQ0khkBC+tA1Asn4LJLTOpxTUMiuPCBmHS+Vv8PMRwbU9xkDFdlOlUqch+mBGXtVxTGb
         3MjlSyC+1cNc8p36bhihEC7ebzIgSqB9g5WtMUZtQDrxIXJt6BXjVC2XYqrdYcmA1+OJ
         p+qA==
X-Gm-Message-State: ANoB5pmiTyXyQIVq2+gpclSXB1YLk0hCoCsmIOqx80+Hk761Tmh4gaGg
        Y5OtT8y28OVNf2LnzorQYCNWsSGo5/O/VN15oiAjPQ==
X-Google-Smtp-Source: AA0mqf6hOVEX40fcDo9d0/LnZvkf+/knmetLHjYOe1UdNkj+unLUWOrGuXY/LOLMtsxWHhfXqAVFknzFTR6zEiFKl48=
X-Received: by 2002:a19:6b13:0:b0:4b1:82c6:2959 with SMTP id
 d19-20020a196b13000000b004b182c62959mr6190678lfa.68.1669059446544; Mon, 21
 Nov 2022 11:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20221117005418.3499691-1-joshdon@google.com> <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
 <094299a3-f039-04c1-d749-2bea0bc14246@linux.dev> <Y3tn5wz6TjsqfGTA@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3tn5wz6TjsqfGTA@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 21 Nov 2022 11:37:14 -0800
Message-ID: <CABk29Nuyp=Ba=qiJAospx-SR2ZQM9GrKW0pDUeJ3sfgNB4uLFg@mail.gmail.com>
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 3:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Nov 20, 2022 at 10:22:40AM +0800, Chengming Zhou wrote:
> > > +               if (cfs_rq->runtime_remaining > 0) {
> > > +                       if (cpu_of(rq) != this_cpu ||
> > > +                           SCHED_WARN_ON(local_unthrottle)) {
> > > +                               unthrottle_cfs_rq_async(cfs_rq);
> > > +                       } else {
> > > +                               local_unthrottle = cfs_rq;
> > > +                       }
> > > +               } else {
> > > +                       throttled = true;
> > > +               }
> >
> > Hello,
> >
> > I don't get the point why local unthrottle is put after all the remote cpus,
> > since this list is FIFO? (earliest throttled cfs_rq is at the head)
>
> Let the local completion time for a CPU be W. Then if we queue a remote
> work after the local synchronous work, the lower bound for total
> completion is at least 2W.
>
> OTOH, if we first queue all remote work and then process the local
> synchronous work, the lower bound for total completion is W.
>
> The practical difference is that all relevant CPUs get unthrottled
> rougly at the same point in time, unlike with the original case, where
> some CPUs have the opportunity to consume W runtime while another is
> still throttled.

Yep, this tradeoff feels "best", but there are some edge cases where
this could potentially disrupt fairness. For example, if we have
non-trivial W, a lot of cpus to iterate through for dispatching remote
unthrottle, and quota is small. Doesn't help that the timer is pinned
so that this will continually hit the same cpu. But as I alluded to, I
think the net benefit here is greater with the local unthrottling
ordered last.
