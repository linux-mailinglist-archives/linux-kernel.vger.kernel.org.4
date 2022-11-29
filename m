Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACC363B753
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiK2Bin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiK2Bil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:38:41 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDE938B6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:38:40 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j4so20272921lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PNQT9xPO+I12IexcdFG8nFDygurJqye8iajgFLm9aR4=;
        b=cMlVRj0u7139NYS8b4nTCySme60GaCZXu2o+disAzc5jg/Zfmmc3rXh6sJRo0BNwX0
         sQh9OOcoBrniUtwvnExcrAMomw7IJUxbvZ8mxR5PRLtHm9moajO1WL+f7aW9nPyW6NVO
         IjD1G3/rX9WdkTk5k+L+7P6Ckr1NqXYZ2CYNFQ0ibMwmOuqdqoZaPPGZwbNYOsZ6WYS0
         vs6ePgGDfJJCwPofOj9Aqs2bVSdB5MZEWj/m+5F9cCINDINCTSp7HueX66YX45NFmVnf
         vP70fx34K0HVdEJ78v5L7S1tf7jMems5v39lUDiUvfy55K8tx2iPji/9xtk10HKXxQKL
         1p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNQT9xPO+I12IexcdFG8nFDygurJqye8iajgFLm9aR4=;
        b=CgbCKeEUkelEt6KxcV7yGkyQGJtuZR0mK0DnGcOlh8FT5RPvSy7pnDv8sRC5FAwT9J
         QJv1boyJEGIkGzMbOdzmO31f2rYIzImK0TbAhRyHUPJWczMjBrSb+r+bjJw4KbuEXJua
         l+/gwVf2xHN7MuZ9nAJBh1gvsf5sLgQWoTdwE/lYR+aL6SHNzwfUId1jtM+YKahx7qBP
         8f2ZHkdjrfT8TQ8g/ZUWkG2ryptBqhyTvN6mTf+zkt5EDsie4n2Za9UPk7wF2lzTsYMH
         X7xSfRV/wwwFfR/d+NjWE93yAbJNdfOoItqbc8mkdkhfSDsjkTAEkTLAedHFP1HjaRJW
         gW7Q==
X-Gm-Message-State: ANoB5pmOnhS/QUQwGqfyBolp4fzZ74r827qEfBFEGdeDY9r4iRrlISvS
        yFFIrLs33CBOQZEU69Q4+IU0JqYIywuF3MgWejPumg==
X-Google-Smtp-Source: AA0mqf70r7e9tbFoHQrrwQu0ImAOZX6nUdoGwGEFMUWkkHTaq00+n99Z0wpzKmNcAk25TIQAOMpjpc+5Ant4xSYWSxI=
X-Received: by 2002:ac2:518c:0:b0:4a2:4560:61e7 with SMTP id
 u12-20020ac2518c000000b004a2456061e7mr17747020lfi.170.1669685918755; Mon, 28
 Nov 2022 17:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20221117005418.3499691-1-joshdon@google.com> <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
 <094299a3-f039-04c1-d749-2bea0bc14246@linux.dev> <Y3tn5wz6TjsqfGTA@hirez.programming.kicks-ass.net>
 <CABk29Nuyp=Ba=qiJAospx-SR2ZQM9GrKW0pDUeJ3sfgNB4uLFg@mail.gmail.com>
 <Y3ymBOfRikUci/PD@hirez.programming.kicks-ass.net> <Y4CDZXZJpPB0J1BV@hirez.programming.kicks-ass.net>
 <Y4CD615rYurnV6h7@hirez.programming.kicks-ass.net> <Y4CHEOEbBqAm70oQ@hirez.programming.kicks-ass.net>
In-Reply-To: <Y4CHEOEbBqAm70oQ@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 28 Nov 2022 17:38:26 -0800
Message-ID: <CABk29Ns3oMNN2w6NLpjLFmMjSwzJDzRotN61-6KEtmWfv-iRdw@mail.gmail.com>
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
        Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        anna-maria@linutronix.de
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

On Fri, Nov 25, 2022 at 1:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 25, 2022 at 09:59:23AM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 25, 2022 at 09:57:09AM +0100, Peter Zijlstra wrote:
> > > On Tue, Nov 22, 2022 at 11:35:48AM +0100, Peter Zijlstra wrote:
> > > > On Mon, Nov 21, 2022 at 11:37:14AM -0800, Josh Don wrote:
> > > > > Yep, this tradeoff feels "best", but there are some edge cases where
> > > > > this could potentially disrupt fairness. For example, if we have
> > > > > non-trivial W, a lot of cpus to iterate through for dispatching remote
> > > > > unthrottle, and quota is small. Doesn't help that the timer is pinned
> > > > > so that this will continually hit the same cpu.
> > > >
> > > > We could -- if we wanted to -- manually rotate the timer around the
> > > > relevant CPUs. Doing that sanely would require a bit of hrtimer surgery
> > > > though I'm afraid.
> > >
> > > Here; something like so should enable us to cycle the bandwidth timer.
> > > Just need to figure out a way to find another CPU or something.
> >
> > Some more preparation...
>
> And then I think something like so.. That migrates the timer to the CPU
> of the first throttled entry -- possibly not the best heuristic, but its
> the simplest.
>
> NOTE: none of this has seen a compiler up close.

Thanks Peter, this overall looks good to me. One question though: I
was expecting to see that when we migrate the timer, we adjust expiry
to account for clock shift between cpus. Was this just not part of the
initial draft here, or is this somehow already accounted for?
