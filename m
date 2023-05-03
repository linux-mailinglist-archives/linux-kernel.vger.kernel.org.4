Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DE76F5916
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjECN3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjECN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:29:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D017D102
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:29:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f315712406so24642575e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1683120588; x=1685712588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=deSB4fIzPnCGZiJ3i9xLJtD0CU45qpjA+sWGoKWKUYk=;
        b=P6X3TRMHoG+rkJdvTekJ3DvRzhOlOd98RZFcaLQwc2yMSDrcW8khyUfkvZLzjeH5jT
         kikNDJRwJ3d0QFX9rSJPkDnPT2fLprt6K0YVTH4QC0Tjq3HMviVb5Qye1mdaNePJ7mFy
         y9Hfy6toqXloAMZk5M6VD4C+7P1zN5pT5BeIvaAEK4rWjCsX8/Sk/BlLOoux0FEtduHo
         ns76MMO9x9nlsoQFWbRyaUEz8sJZRez9me2R28r9wA3OAqVuWdCEI9Xt3mZ3xEiu2/89
         m7DAzTQHKnYFRHdGuyz8OpEniwopSged0tFexCur05n+NxDzDx1Y4iMUI7EbpPRnDbqK
         h1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683120588; x=1685712588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deSB4fIzPnCGZiJ3i9xLJtD0CU45qpjA+sWGoKWKUYk=;
        b=BtXYOtQaWWTB+oVpJywPfB/zn/mE3VUIPhxnAVdCQYuwlJCDOYxjuXAyZTWtPNW+Am
         BGnl6RhFA2cQBEmHZul56NLYnGVyhSfIq1oBctujszzW5ghL2A3vDQDN2KWzSJpNwcQY
         Npw0Cvx/UoY7o5mTH6oZ6PAL5602QMJIk8k6EYP9xjIp3X0SP1V4ey8mGQQb0qrbi+8R
         BwcgrKw5R8zi6V9zKLMc8RsGQyv3DN69MiXT1LfM13DywkbpkD/4Kx4Vn7xcvE+qM7Rr
         RzzNkRiXw7B/4amdBxD23lXTeggFj8hiKgj+LXwqrxs/bihWP41zAj5kVIAdHq7pMU1v
         aMwQ==
X-Gm-Message-State: AC+VfDyJQZTt2es/7E27OW/lL9QieZm1pAH+9BGdWDht4zDinD5b1xRo
        ZAEsSZEc9Nd6g8eB1Fg6dDE3bQ==
X-Google-Smtp-Source: ACHHUZ5JYxXSGYVXBWKXLWOgyMLBzj4sVENusZvcV6ir59PZM/QBkq26fkAqKyxQIe+hosR55uRuOQ==
X-Received: by 2002:adf:e649:0:b0:306:2aea:466a with SMTP id b9-20020adfe649000000b003062aea466amr37625wrn.28.1683120588314;
        Wed, 03 May 2023 06:29:48 -0700 (PDT)
Received: from airbuntu (host109-154-46-114.range109-154.btcentralplus.com. [109.154.46.114])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6183000000b002faaa9a1721sm33946616wru.58.2023.05.03.06.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:29:47 -0700 (PDT)
Date:   Wed, 3 May 2023 14:29:43 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Saravana Kannan <saravanak@google.com>
Cc:     David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce
 SCHED_FLAG_RESET_UCLAMP_ON_FORK flag
Message-ID: <20230503132943.sz22x4zlln4xagjj@airbuntu>
References: <20230416213406.2966521-1-davidai@google.com>
 <20230419175414.ycnlaperdkjxgypx@airbuntu>
 <20230428115755.7uklfd4fmpoee4dp@airbuntu>
 <CAGETcx9xjLzQ2b3FraPsmG=w6=4pYU-tzW-na0Fd5qyrU+C+Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx9xjLzQ2b3FraPsmG=w6=4pYU-tzW-na0Fd5qyrU+C+Yw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28/23 11:12, Saravana Kannan wrote:
> On Fri, Apr 28, 2023 at 4:57 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 04/19/23 18:54, Qais Yousef wrote:
> >
> > [...]
> >
> > > I was considering to have something a bit more generic that allows selecting
> > > which attributes to reset.
> > >
> > > For example a syscall with SCHED_FLAG_RESET_ON_FORK_SEL combined with
> > > SCHED_FLAG_UCLAMP_MIN/MAX will only reset those. This should make it extensible
> > > if we have other similar use cases in the future. The downside it *might*
> > > require to be done in a separate syscall to the one that sets these parameter.
> > > But it should be done once.
> > >
> > > Maybe there's a better interface, but I think it makes sense to do it in a way
> > > that we won't have to do this again. Would be good to hear from maintainers
> > > first before you take my word for it ;-)
> >
> > Actually I think we can do a better and simpler generic interface. We don't
> > need a new flag. We can just add a new parameter for what to reset on fork.
> > When this value is 0 (which it should be by default), it means reset
> > everything.
> 
> Isn't he default NOT to reset everything?

The default when the RESET_ON_FORK flag is set. This field will not be used
otherwise. Like what happens for the other params.

> 
> > // pseudo code
> >
> > #define RESET_ON_FORK_ALL       0
> > #define RESET_ON_FORK_POLICY    BIT(1) // implies resetting priority
> > #define RESET_ON_FORK_PRIORITY  BIT(2)
> > #define RESET_ON_FORK_UCLAMP    BIT(3)
> >
> > struct sched_attr {
> >         ...
> >         __u64 sched_reset_on_fork_flags;
> > };
> >
> 
> Also, honestly I think this is over designing for a hypothetical. We

latency_nice is coming next and most likely to require something similar. It's
not hypothetical nor over designing. I think it's worthwhile spending time to
plan for the future. More interfaces are confusing to the end users. And glibc
already complained about evolution of sched_setattr, that's why we don't have
a wrapper there yet (beside none of us pushed that hard to resolve the concerns
due to lack of bandwidth).

https://public-inbox.org/libc-alpha/87va826rsb.fsf@mid.deneb.enyo.de/

(this thread reminded me linux-api must be CCed)

And there has been various discussions of the need of higher level
wrappers/libraries that exposes simpler interface to app developers. So I'm
actually expecting this to repeat. I think that was at LPC by Len Brown. I can
find this thread on libc mailing list.

https://public-inbox.org/libc-alpha/CAMe9rOpUh1pjfEUqf_hNxce8ZX=4mg6W=n+BbdZSNFHLi7wtkw@mail.gmail.com/

These QoS hints might imply manipulating nice values and I can see ending up
with a similar situation where we need to reset nice on fork without resetting
other params.

Generally I don't think we should restrict users to self-managed model.
A delegated model does make sense, and the latter implies the need for finer
control on what to reset.

There's rtkit by the way which already an example of a delegating model to
enable creating RT tasks by non privileged users.

Should rtkit force resetting uclamp when on fork? I think it's a grey area and
I learn towards it shouldn't.

> have approximately 53 unused bits. By the time we run out of those,
> we'd have added at least 20-50 more fields. At that point, we can
> always add a flags2 field if we need it. I like David's patch as is --
> it's clear and simple. Add a flag for explicitly what we are trying to
> do and extend as needed.

Fair enough. As I said if the maintainers are okay with current proposal, no
objection from my side. Based on my experience I didn't expect them to be. And
I do think a generic solution is not really complicated and is the better
option. You can consider this as a backup plan ;-)


Cheers

--
Qais Yousef
