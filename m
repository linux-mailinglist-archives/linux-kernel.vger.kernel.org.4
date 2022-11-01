Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDA3615497
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKAWBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiKAWAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:00:41 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172E463CA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:00:11 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u11so22858544ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gL2t03t+uHvknGRuDP57y8VggTih0Gz+SNceIWbvmBw=;
        b=NPqqY39koC9Bv3K4wli6wHCs00eOMfUTOE2VUdrtR9lDmkwJSNG9lXx/gp2s22NFU9
         0q7SGdFOxk5h3ntucLCGpRaxvu95y8yhJZBstTAguGTR1O4KCH3pxO1FENMuddy5O76S
         khLitA+akMbINZvT2Kml1V6C7tyQIDnOd4Zk8ivyLLUNKEiGjO0M2q0GfQeNTCMAcsR9
         FwPo0Abi+lgvIq+YoUejgqfYN8KGN/nLJk1cOmkZ0mA+iYrF0zoJBsljuDhvVZLtxh6w
         KD8vWnsWs7RtH974Y1lyLDztP+GT5s0rstoR7WjyTd+mKrDcPnNF1GRbb64RtmXzkahb
         cp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gL2t03t+uHvknGRuDP57y8VggTih0Gz+SNceIWbvmBw=;
        b=2d52bJoxqKJn9eFxxx5nlaJPjfPRWOJw6jq0yg7JnCkEiPiLERgG3/MNSSmBrVH37H
         x++FYwrGJiuHwcrtahUR28n6QTsW7iznBknnPkF8/9j1C3nOwML5RAmA/L34LbYVgY60
         tSi+kpVfJ9b3XVJVH3WtlYVrohfL9cPAinlBfW/Tte4ea1oXyKyfMrGMXlVpSpAkuc1u
         Z/x/15FXRw8C7LaY1D/bPSx6WHRVjXzqRyJNhd0Qsz+cOT0cjD990nWXBPjLfQxXxkeE
         6+J/O1iNNMsQpBZwaUdZBJOchs/Wv256LOz8IsTJGad6mnTN1+bijNMZEzEfs9B2WAiP
         1Tpg==
X-Gm-Message-State: ACrzQf16mz9zVCj+MGrDTL7qWEJitMKYknu3LuB1JfS4saQraB3cEVPT
        PDjAp8zwkwrQr0He7aHIZu9o3jMY5x4Xtyqvu8w90w==
X-Google-Smtp-Source: AMsMyM7xGpuK7RXZJ6/2Mkeq/Lix1GPL/7RWkaRNSiRereJy8q1/SDEHC6lyopnFVjM1qOnhWtL/xo4x37zgxrQJO+I=
X-Received: by 2002:a05:651c:1073:b0:277:35ca:5eef with SMTP id
 y19-20020a05651c107300b0027735ca5eefmr7866493ljm.150.1667340009166; Tue, 01
 Nov 2022 15:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
 <CABk29Nu=XcjwRxnGBtKHfknxnDPpspghou06+W0fufnkGF6NkA@mail.gmail.com>
 <Y2BDFNpkSawKnE9S@slm.duckdns.org> <CABk29Nta-RJpTcybgOk9u4DH=1mwQFZsOxFuQ-UpCcTwzjzAuA@mail.gmail.com>
 <Y2Bf+CeQ8x2jKQ3S@slm.duckdns.org> <CABk29Nvqv-T1JuAq2cf9=AwRu=y1+YOR4xS2qnVo6+XpWd2UNQ@mail.gmail.com>
 <Y2B6V1PPuCcTXGp6@slm.duckdns.org> <CABk29Ns1VWEVRYENud4CW3JQPrcr79i_F2PBTANqt3t-LaYCfQ@mail.gmail.com>
 <Y2FwVX42LIKXSTz3@slm.duckdns.org> <CABk29Nua8ZsDfhY+x+VfYDkbkjfXLXTZ5JMVR9uiBygraxDM+g@mail.gmail.com>
 <Y2GUg8CiI68ZBznr@slm.duckdns.org>
In-Reply-To: <Y2GUg8CiI68ZBznr@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 1 Nov 2022 14:59:56 -0700
Message-ID: <CABk29Nvj8nRyD0HGo+gZ4CEr0kOJSsUbJnSNFs62D66EDTMGog@mail.gmail.com>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
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

On Tue, Nov 1, 2022 at 2:50 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Nov 01, 2022 at 01:56:29PM -0700, Josh Don wrote:
> > Maybe walking through an example would be helpful? I don't know if
> > there's anything super specific. For cgroup_mutex for example, the
> > same global mutex is being taken for things like cgroup mkdir and
> > cgroup proc attach, regardless of which part of the hierarchy is being
> > modified. So, we end up sharing that mutex between random job threads
> > (ie. that may be manipulating their own cgroup sub-hierarchy), and
> > control plane threads, which are attempting to manage root-level
> > cgroups. Bad things happen when the cgroup_mutex (or similar) is held
> > by a random thread which blocks and is of low scheduling priority,
> > since when it wakes back up it may take quite a while for it to run
> > again (whether that low priority be due to CFS bandwidth, sched_idle,
> > or even just O(hundreds) of threads on a cpu). Starving out the
> > control plane causes us significant issues, since that affects machine
> > health. cgroup manipulation is not a hot path operation, but the
> > control plane tends to hit it fairly often, and so those things
> > combine at our scale to produce this rare problem.
>
> I keep asking because I'm curious about the specific details of the
> contentions. Control plane locking up is obviously bad but they can usually
> tolerate some latencies - stalling out multiple seconds (or longer) can be
> catastrophic but tens or hundreds or millisecs occasionally usually isn't.
>
> The only times we've seen latency spikes from CPU side which is enough to
> cause system-level failures were when there were severe restrictions through
> bw control. Other cases sure are possible but unless you grab these mutexes
> while IDLE inside a heavily contended cgroup (which is a bit silly) you
> gotta push *really* hard.
>
> If most of the problems were with cpu bw control, fixing that should do for
> the time being. Otherwise, we'll have to think about finishing kernfs
> locking granularity improvements and doing something similar to cgroup
> locking too.

Oh we've easily hit stalls measured in multiple seconds. We
extensively use cpu.idle to group batch tasks. One of the memory
bandwidth mitigations implemented in userspace is cpu jailing, which
can end up pushing lots and lots of these batch threads onto a small
number of cpus. 5ms min gran * 200 threads is already one second :)
We're in the process of transitioning to using bw instead for this
instead in order to maintain parallelism. Fixing bw is definitely
going to be useful, but I'm afraid we'll still likely have some issues
from low throughput for non-bw reasons (some of which we can't
directly control, since arbitrary jobs can spin up and configure their
hierarchy/threads in antagonistic ways, in effect pushing out the
latency of some of their threads).

>
> Thanks.
>
> --
> tejun
