Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A413743D92
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjF3Ody (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjF3Ods (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:33:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5596D10CE;
        Fri, 30 Jun 2023 07:33:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D08131F8C2;
        Fri, 30 Jun 2023 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688135624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbd/fExIFs9vd/uVwFvEulgbuneSaKj7dgqktqkVNeQ=;
        b=P9PJQLmNcmBXYAUh1VS4Pd4Ra85i2iPGeQXJC7OHUflQHAFHHNpQL9jLT+eUxDhwOmTRft
        khvBg1sYc0TzaZIAfYfLLzcGt60BQ2hIG/YAXTX1+fOpULyZ7zWD3wVFidg/7BJuxzOMvg
        7vFOZKOHtzGg72KURffC88j/Mom2VEc=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AA8122C141;
        Fri, 30 Jun 2023 14:33:43 +0000 (UTC)
Date:   Fri, 30 Jun 2023 16:33:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for Jun 28
 (arch/powerpc/platforms/pseries/mobility.c)
Message-ID: <ZJ7nwwX3oLDLTjjB@alley>
References: <20230628142751.0527c993@canb.auug.org.au>
 <af19b76d-aa4b-6c88-9cac-eae4b2072497@infradead.org>
 <ZJ1Dborac_Kj4Qbw@alley>
 <CAD=FV=WCHp=T+6SVdzDgRDRoJ-82uWYB0hv_jWMB19jw3hXbsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WCHp=T+6SVdzDgRDRoJ-82uWYB0hv_jWMB19jw3hXbsg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-06-29 12:51:54, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 29, 2023 at 1:40 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Wed 2023-06-28 22:07:17, Randy Dunlap wrote:
> > >
> > >
> > > On 6/27/23 21:27, Stephen Rothwell wrote:
> > > > Hi all,
> > > >
> > > > Please do *not* add any v5.6 related stuff to your linux-next included
> > > > branches until after v5.5-rc1 has been released.
> > > >
> > > > Changes since 20230627:
> > > >
> > >
> > > on powerpc64, when
> > > # CONFIG_HARDLOCKUP_DETECTOR is not set:
> > >
> > > ../arch/powerpc/platforms/pseries/mobility.c: In function 'pseries_migrate_partition':
> > > ../arch/powerpc/platforms/pseries/mobility.c:753:17: error: implicit declaration of function 'watchdog_hardlockup_set_timeout_pct'; did you mean 'watchdog_hardlockup_stop'? [-Werror=implicit-function-declaration]
> > >   753 |                 watchdog_hardlockup_set_timeout_pct(factor);
> > >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >       |                 watchdog_hardlockup_stop
> > > cc1: all warnings being treated as errors
> > >
> > >
> > > Full randconfig file is attached.
> > >
> > >
> > > If I blatantly modify include/linux/nmi.h with these comments, it builds OK:
> > >
> > > //#if defined(CONFIG_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
> > > #include <asm/nmi.h>
> > > //#endif
> >
> > This is well describes the probem.
> >
> > The decision whether to include asm/nmi.h should not depend only on
> > CONFIG_HARDLOCKUP_DETECTOR_* when it is needed also for other stuff.
> >
> > I see two reasonable solutions:
> >
> > 1. We either create an empty "include/asm-generic/nmi.h" and
> >    always include asm/nmi.h in linux/nmi.h.
> >
> >    It looks is a bit weird but it might be the easiest solution
> >    unless it creates another problems elsewhere.
> >
> >
> > 2. Explicitely include asm/nmi.h where needed, in
> >    arch/powerpc/platforms/pseries/mobility.c and maybe somewhere as
> >    well.
> >
> >    It is already done in many cases:
> >
> >
> > I would personally prefer the 2nd variant.
> 
> Yes, this seems right to me. I'm always inclined to get build failures
> fixed ASAP, so I've posted a patch for it:
> 
> https://lore.kernel.org/r/20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid

Thanks a lot for the patch.

> > I am going to check other locations where it might be needed.
> 
> If you find anything else, we can either do a v2 or another patch.

I have found one more suspicious usage in arch/powerpc/kernel/exceptions-64s.S.
It calls soft_nmi_interrupt() which is defined in
powerpc/include/asm/nmi.h as well.

But it seems that it compiles even when asm/nmi.h is not included.
In fact, it has never been included. I have double checked this
with cross compilation.

So, this hopefully was the last build problem /o\

Best Regards,
Petr
