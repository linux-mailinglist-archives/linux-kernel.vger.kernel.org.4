Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A74E62D64F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbiKQJS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbiKQJSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:18:46 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E8360377
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:18:40 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id o13so622794ilc.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rnNkhD49ZX86noJXnc45GrrX0asvHoDEzC6w1qgJFjQ=;
        b=oUEoVoNVq+/z4tPMfMzXi/xMduKKG6eGVwa1i1wRb0zwhqEYHn9gwftg/id7J+Sb0C
         eXrLLo0hDDhcJjV1zmrxU2nBbSGAetGD+9YXAwU2UCZmBTR7zLGN11BU+9qS3qgcqvJa
         AHOeR2Xn8/2R7K6+veESpZt+x7P7QUgGOSXY3gR2mRjJg2aRSUJxgcQchqgq6NT902iT
         xVynXl9BvfHq1MGIC83DrKNUl2ujhMxgEfnUe7Bzw23QtfGrJg0azCW1bPVvoXh+8HF4
         bgY6vG6jK8IfWvC39RmxWwpCk+AdSbGw09GLy47bAIlzgye50ZdTh+Cc6oPpLO2ZdQZ0
         WDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnNkhD49ZX86noJXnc45GrrX0asvHoDEzC6w1qgJFjQ=;
        b=Xjs8+sm37T+f9KXiNeONDMKn9AUzbQ3Dda8/WS1tcWyLY2du/vYIUz6vyLIVixbtsy
         UzoEWnSWCAl4K6g05f/7i+sSrXNJwNhgMyzDYa9gIroR0Makb+x6HVgGjx73dmsHud7F
         zfg5aG2KKU/Tk0n/ban6AMgoMPCc3GL5s537S/Pox2g+KyKwEpYPJLE8kC8hSNv3bZU3
         vBbT20/6HFTxPZUzGYGvgu9ayZREK1Jyfr83MCyUC3WoLohfg9afVFfw8A8rXx5jOD3f
         it4rvCQlM+1rbXinwBFmn+UbGm0dAhjJEBmUlbLLSwqM17XHrSdZZTof6o+DsUzJTmZh
         F5vA==
X-Gm-Message-State: ANoB5pla8Q6TVvyZ2x8+bszwQjbji01DVPGVisoU2HrbR+8AW3kBB7ee
        JZipdSMNuyejo0LppAXI4gYIDc5PWW7hfbCcsPvk4w==
X-Google-Smtp-Source: AA0mqf5xuAPtl0jH4aMVdgd2horFQvkUCaSlkdiVX3z0bAKWklPigkCb4DrPkxKRN3rfGkbmf1p4/h9Brt1UjfwsBdc=
X-Received: by 2002:a92:2611:0:b0:302:815d:50c1 with SMTP id
 n17-20020a922611000000b00302815d50c1mr889848ile.31.1668676719743; Thu, 17 Nov
 2022 01:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
 <20221110175009.18458-2-vincent.guittot@linaro.org> <Y3Gwr2p5BcofuZ8e@google.com>
 <CAKfTPtD2A3QaMON_jkhaobY0Wy+LpnAnfhtuaozK_OkmSvuf8Q@mail.gmail.com> <Y3SefaraLvX2hPYj@ziqianlu-desk2>
In-Reply-To: <Y3SefaraLvX2hPYj@ziqianlu-desk2>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 17 Nov 2022 10:18:28 +0100
Message-ID: <CAKfTPtBX_3rZ_7sNUrt7isqa9wvJ1KZpe=Prsycq59iO+UWvxg@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] sched/fair: fix unfairness at wakeup
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, riel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 at 09:26, Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Mon, Nov 14, 2022 at 12:05:18PM +0100, Vincent Guittot wrote:
> > On Mon, 14 Nov 2022 at 04:06, Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > Hi Vincent,
> > >
> > > On Thu, Nov 10, 2022 at 06:50:01PM +0100, Vincent Guittot wrote:
>
> ... ...
>
> > > > +static inline unsigned long  get_latency_max(void)
> > > > +{
> > > > +     unsigned long thresh = get_sched_latency(false);
> > > > +
> > > > +     thresh -= sysctl_sched_min_granularity;
> > >
> > > Could you clarify, why are you subtracting sched_min_granularity here? Could
> > > you add some comments here to make it clear?
> >
> > If the waking task failed to preempt current it could to wait up to
> > sysctl_sched_min_granularity before preempting it during next tick.
>
> check_preempt_tick() compares vdiff/delta between the leftmost se and
> curr against curr's ideal_runtime, it doesn't use thresh here or the
> adjusted wakeup_gran, so I don't see why reducing thresh here can help
> se to preempt curr during next tick if it failed to preempt curr in its
> wakeup path.

If waking task doesn't preempt curr, it will wait for the next
check_preempt_tick(), but check_preempt_tick() ensures a minimum
runtime of sysctl_sched_min_granularity before comparing the vruntime.
Thresh doesn't help in check_preempt_tick() but anticipate the fact
that if it fails to preempt now, current can get an additional
sysctl_sched_min_granularity runtime before being preempted.

>
> I can see reducing thresh here with whatever value can help the waking
> se to preempt curr in wakeup_preempt_entity() though, because most
> likely the waking se's vruntime is cfs_rq->min_vruntime -
> sysctl_sched_latency/2 and curr->vruntime is near cfs_rq->min_vruntime
> so vdiff is about sysctl_sched_latency/2, which is the same value as
> get_sched_latency(false) and when thresh is reduced some bit, then vdiff
> in wakeup_preempt_entity() will be larger than gran and make it possible
> to preempt.
>
> So I'm confused by your comment or I might misread the code.
