Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102786031BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJRRmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJRRmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:42:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D76BEEAB7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BBA8B8208B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17039C433C1;
        Tue, 18 Oct 2022 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666114935;
        bh=Y1SmAIBJbXB7lofHkE0yT9ZGmSVcPna44OsF5h7gypg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UPvVi/sspSqTaVQRhcpCXpz5gwPm4StgaAqpJRgzMj6rJo7BE/i4gwpzARBrde0uL
         emmK274aYnzf9EX8WsoGg1Y1nVtP21UD2LVRMbl1cP10AzdMergpBZXBIUKBTH4pl3
         eKgzLEVljwgdRolK/Oye72J5IVFW5b2aZ/rdsDVSD7kO57fDdEDn7sTPsssCSnKKjc
         iof72v9fsbYIOVf8KrHnRgnbQhpq/3IQj4/vvm+TjaCr2fiL3/U5J0t/O26oPD86Jd
         nT2Gw6JgKnM+SXwS11tkZKzdCu6gZUeFjMs94lTploX1UtYaLO4wlVFIE7lmqbx/tc
         +zxslyAGlUp/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B24285C0528; Tue, 18 Oct 2022 10:42:14 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:42:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Ryosuke Yasuoka <ryasuoka@redhat.com>, dvyukov@google.com,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] kcsan: Fix trivial typo in Kconfig help comments
Message-ID: <20221018174214.GS5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221018102254.2424506-1-ryasuoka@redhat.com>
 <CANpmjNMoZ6X-bPHg3pfWrnBfP-khpwXNvHxxrwXf2R27_PuSZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMoZ6X-bPHg3pfWrnBfP-khpwXNvHxxrwXf2R27_PuSZA@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 08:15:26AM -0700, Marco Elver wrote:
> On Tue, 18 Oct 2022 at 03:23, Ryosuke Yasuoka <ryasuoka@redhat.com> wrote:
> >
> > Fix trivial typo in Kconfig help comments in KCSAN_SKIP_WATCH and
> > KCSAN_SKIP_WATCH_RANDOMIZE
> >
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> 
> Reviewed-by: Marco Elver <elver@google.com>

Applied, thank you both!

							Thanx, Paul

> Thanks.
> 
> > ---
> >  lib/Kconfig.kcsan | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> > index 47a693c45864..375575a5a0e3 100644
> > --- a/lib/Kconfig.kcsan
> > +++ b/lib/Kconfig.kcsan
> > @@ -125,7 +125,7 @@ config KCSAN_SKIP_WATCH
> >         default 4000
> >         help
> >           The number of per-CPU memory operations to skip, before another
> > -         watchpoint is set up, i.e. one in KCSAN_WATCH_SKIP per-CPU
> > +         watchpoint is set up, i.e. one in KCSAN_SKIP_WATCH per-CPU
> >           memory operations are used to set up a watchpoint. A smaller value
> >           results in more aggressive race detection, whereas a larger value
> >           improves system performance at the cost of missing some races.
> > @@ -135,8 +135,8 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
> >         default y
> >         help
> >           If instruction skip count should be randomized, where the maximum is
> > -         KCSAN_WATCH_SKIP. If false, the chosen value is always
> > -         KCSAN_WATCH_SKIP.
> > +         KCSAN_SKIP_WATCH. If false, the chosen value is always
> > +         KCSAN_SKIP_WATCH.
> >
> >  config KCSAN_INTERRUPT_WATCHER
> >         bool "Interruptible watchers" if !KCSAN_STRICT
> > --
> > 2.37.3
> >
