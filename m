Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5C0615205
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiKATMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiKATMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:12:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1321EAF2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:11:44 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a15so22322881ljb.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FccYZAniuq6nRVGyYDJ7zjVHwOXNS5lQO6I/rpbHjOQ=;
        b=sB1mwoFI/m+l/Ew4opzYjj6BfHId2DtqAeAlqBUw7jewUAngWTexFhyfPmqYQIN36f
         TTFtH1PfyAI6XGSvz5cmJPTL688ft6ihT363mb9LXZQuPI5vaCnsCa+RFdF/YXvg2j0N
         9fhcrERxVqminZvzuyBuU3GJ7KNexwFJG8AGLUM9pLQcGBCdPVgMZk/fY4R88lmQEd4w
         nLeWOxAawTJUp2X/Bl7qn6g7gzKECgLcz0Y8QY8Imz2mzKLRis4W7fzHNDCJEjmZ2PIl
         dkJr+SVoGO745dueGhSksR4xsRCeIkyxiFEKwOPbjX840mFnb/ngZkAtyn7iEneTHcsV
         uGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FccYZAniuq6nRVGyYDJ7zjVHwOXNS5lQO6I/rpbHjOQ=;
        b=ZmFYZNeFxFEdRJiVzVdsmm22e7XPdX+2gkuIZ1TgjpwCHTUFbtQAFF/uIOrDAg3tHm
         eEnIqNvfz09KvIO4roTCf+NS03h9zOm08uv2Ud1Ic3fi0b52aJsndQhqaUbSvOEcI06J
         w+DHhqROnu3M+F/2UsPsjO5kRoBxCaqwkKz6OwO4nL3go7wUNFSag4mfCu6HFNPWBxVA
         sIaOnvYZ4nVA2IR19xW2T3U4fyQhXdDFLz0m1cArIO4e3GpxpQ+w+Qxu0yf0sDPsYWzT
         +d8/dMbZF605tH2kjzpBmhGqAFSEL+5K5Vme5kEFYGTdiS38BnYUbOSGzCE4/oZ8ZcaZ
         8pPw==
X-Gm-Message-State: ACrzQf0H2S9yePTKydc/afrLrv4/snGRj+tHfMFNxgqsw/I/SGYLJ8tD
        5mIBPItipBWEbaBb41i9QjNgtV6qoqD9LpeJE0RgAw==
X-Google-Smtp-Source: AMsMyM4dY91u6R1+w8bG8BJ4eTkOXK1cyuQY9caMdmbW6eXkMcY61d4N5vIOtuY5HdmkZ5V1eD2oFFL+LarVq53/AlA=
X-Received: by 2002:a2e:9a8f:0:b0:277:2427:53cd with SMTP id
 p15-20020a2e9a8f000000b00277242753cdmr7785406lji.52.1667329902870; Tue, 01
 Nov 2022 12:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221026224449.214839-1-joshdon@google.com> <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
 <CABk29Nu=XcjwRxnGBtKHfknxnDPpspghou06+W0fufnkGF6NkA@mail.gmail.com>
 <Y2BDFNpkSawKnE9S@slm.duckdns.org> <CABk29Nta-RJpTcybgOk9u4DH=1mwQFZsOxFuQ-UpCcTwzjzAuA@mail.gmail.com>
 <Y2Bf+CeQ8x2jKQ3S@slm.duckdns.org> <CABk29Nvqv-T1JuAq2cf9=AwRu=y1+YOR4xS2qnVo6+XpWd2UNQ@mail.gmail.com>
 <Y2B6V1PPuCcTXGp6@slm.duckdns.org>
In-Reply-To: <Y2B6V1PPuCcTXGp6@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 1 Nov 2022 12:11:30 -0700
Message-ID: <CABk29Ns1VWEVRYENud4CW3JQPrcr79i_F2PBTANqt3t-LaYCfQ@mail.gmail.com>
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

On Mon, Oct 31, 2022 at 6:46 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Oct 31, 2022 at 06:01:19PM -0700, Josh Don wrote:
> > > Yeah, especially with narrow cpuset (or task cpu affinity) configurations,
> > > it can get pretty bad. Outside that tho, at least I haven't seen a lot of
> > > problematic cases as long as the low priority one isn't tightly entangled
> > > with high priority tasks, mostly because 1. if the resource the low pri one
> > > is holding affects large part of the system, the problem is self-solving as
> > > the system quickly runs out of other things to do 2. if the resource isn't
> > > affecting large part of the system, their blast radius is usually reasonably
> > > confined to things tightly coupled with it. I'm sure there are exceptions
> > > and we definitely wanna improve the situation where it makes sense.
> >
> > cgroup_mutex and kernfs rwsem beg to differ :) These are shared with
> > control plane threads, so it is pretty easy to starve those out even
> > while the system has plenty of work to do.
>
> Hahaha yeah, good point. We definitely wanna improve them. There were some
> efforts to improve kernfs locking granularity earlier this year. It was
> promising but didn't get to the finish line. cgroup_mutex, w/ cgroup2 and
> especially with the optimizations around CLONE_INTO_CGROUP, we avoid that in
> most hot paths and hopefully that should help quite a bit. If it continues
> to be a problem, we definitely wanna further improve it.
>
> Just to better understand the situation, can you give some more details on
> the scenarios where cgroup_mutex was in the middle of a shitshow?

There have been a couple, I think one of the main ones has been writes
to cgroup.procs. cpuset modifications also show up since there's a
mutex there.

>
> Thanks.
>
> --
> tejun
