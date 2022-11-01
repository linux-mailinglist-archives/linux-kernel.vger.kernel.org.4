Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A6D6153A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKAU4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKAU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:56:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7301B1DA6E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 13:56:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p8so25046243lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 13:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rZSmzcoQMbqfgLkLNVYbX8iJgnJ1KEQSiQFTCGQ48wg=;
        b=KmkPZmbozD3oR6GrZQ3BIpm2vAgz67d2WX/lJR9uf4Gfe6keslKHgzM1Syp35yWJm0
         wKsZIOpwBUS6C4ccy8zHoZ3SkolWplY8s8uzAWKurxQsFc8B6S5ao6d0dIp/6GEF5ySW
         E+W5zs5uKtYVq9gU0YKxOB9itkJI7LA4cC8YzOPGQ3Jb86kzzzKyaa465gWP0ZaJheKh
         pwnBq7OMfyzG0JvyaN53nqSzfMPdLPQF3gAKKIxqEEfgxRNElk/ZIuxwNYQsyIkzuwjU
         s6AHeg2Zf9g16J1Qu8H21dQr2i7OFs4nLer4nT1mSIG0+CDxXEA6L1EZTfvE1NwpbY8T
         pzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZSmzcoQMbqfgLkLNVYbX8iJgnJ1KEQSiQFTCGQ48wg=;
        b=eLXvU1ww3t0wNCJzQUWE+Ogp2rSgEAyQKPH1Xz61uAtHgQAgt1FK6y8aYqfJZbNNEF
         4ImIpgcUi/QEy0lDsNkWV4I0J486zY0vKXa+QsLVnC8rqaa+aGVqps2cthVXXvDp47dw
         3A90HpBqglbg4BQ/c8eV3poYep9OVJ/1+vzortbLLG41gIFjuHsqE68VeBReAJlGe/Qs
         PkRdl4IkBeAHer2IKfDoLOILZr9LNIqJ6Xu0enizrK+T9RdEsc9gZQZvO/3Z0GsQMaNN
         /iT6AsDw1I7ovddOA3VrS3Cfx4FTYg3XA+Nmoiw3CV9qgB4g9kjSNJ6uKtQP876UyoVM
         ZDBw==
X-Gm-Message-State: ACrzQf3RttOwshpu5VqVdKEnBWijAmQzhGAp6+scBbn+4zdG70/x6kdr
        vZS9L0+kYamIDDqk7lR+MviOO9DvlH31WWNRXFhT4g==
X-Google-Smtp-Source: AMsMyM6BKvhIDUokznaYWhDkCCF52xeoQ1+D9ODq4yJvPOBqZMKm90RfY1vCmWYat1C1KRsECuNlsN8d5RQCwZar/1M=
X-Received: by 2002:a05:6512:3a89:b0:4a2:fbe:5573 with SMTP id
 q9-20020a0565123a8900b004a20fbe5573mr7612599lfu.546.1667336201577; Tue, 01
 Nov 2022 13:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221026224449.214839-1-joshdon@google.com> <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
 <CABk29Nu=XcjwRxnGBtKHfknxnDPpspghou06+W0fufnkGF6NkA@mail.gmail.com>
 <Y2BDFNpkSawKnE9S@slm.duckdns.org> <CABk29Nta-RJpTcybgOk9u4DH=1mwQFZsOxFuQ-UpCcTwzjzAuA@mail.gmail.com>
 <Y2Bf+CeQ8x2jKQ3S@slm.duckdns.org> <CABk29Nvqv-T1JuAq2cf9=AwRu=y1+YOR4xS2qnVo6+XpWd2UNQ@mail.gmail.com>
 <Y2B6V1PPuCcTXGp6@slm.duckdns.org> <CABk29Ns1VWEVRYENud4CW3JQPrcr79i_F2PBTANqt3t-LaYCfQ@mail.gmail.com>
 <Y2FwVX42LIKXSTz3@slm.duckdns.org>
In-Reply-To: <Y2FwVX42LIKXSTz3@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 1 Nov 2022 13:56:29 -0700
Message-ID: <CABk29Nua8ZsDfhY+x+VfYDkbkjfXLXTZ5JMVR9uiBygraxDM+g@mail.gmail.com>
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

On Tue, Nov 1, 2022 at 12:15 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Nov 01, 2022 at 12:11:30PM -0700, Josh Don wrote:
> > > Just to better understand the situation, can you give some more details on
> > > the scenarios where cgroup_mutex was in the middle of a shitshow?
> >
> > There have been a couple, I think one of the main ones has been writes
> > to cgroup.procs. cpuset modifications also show up since there's a
> > mutex there.
>
> If you can, I'd really like to learn more about the details. We've had some
> issues with the threadgroup_rwsem because it's such a big hammer but not
> necessarily with cgroup_mutex because they are only used in maintenance
> operations and never from any hot paths.
>
> Regarding threadgroup_rwsem, w/ CLONE_INTO_CGROUP (userspace support is
> still missing unfortunately), the usual worfklow of creating a cgroup,
> seeding it with a process and then later shutting it down doesn't involve
> threadgroup_rwsem at all, so most of the problems should go away in the
> hopefully near future.

Maybe walking through an example would be helpful? I don't know if
there's anything super specific. For cgroup_mutex for example, the
same global mutex is being taken for things like cgroup mkdir and
cgroup proc attach, regardless of which part of the hierarchy is being
modified. So, we end up sharing that mutex between random job threads
(ie. that may be manipulating their own cgroup sub-hierarchy), and
control plane threads, which are attempting to manage root-level
cgroups. Bad things happen when the cgroup_mutex (or similar) is held
by a random thread which blocks and is of low scheduling priority,
since when it wakes back up it may take quite a while for it to run
again (whether that low priority be due to CFS bandwidth, sched_idle,
or even just O(hundreds) of threads on a cpu). Starving out the
control plane causes us significant issues, since that affects machine
health. cgroup manipulation is not a hot path operation, but the
control plane tends to hit it fairly often, and so those things
combine at our scale to produce this rare problem.

>
> Thanks.
>
> --
> tejun
