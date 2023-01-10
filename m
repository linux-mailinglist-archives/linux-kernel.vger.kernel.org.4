Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6A663604
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbjAJAFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbjAJAFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:05:23 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9111DDE7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:05:22 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f3so7062469pgc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 16:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ywk5kgimgzqnnPT+XZy47dxy0OlRvssJgYFxBD/Z4aE=;
        b=K4f/fsCYEekdsxkKz3b7M4aYBHvLignDAyYA6AqVyL50HxvhGB45l9SqOIKmd8BK2f
         IlrSNlIpag5PruA+qorMeir3g/F+EHk1PKs0fBSj+74ZdN2IeVOF+TkMYzI4AwiHoWci
         TMeFBaDMn1Oio3riXZu/BoqjYcLw0cPfBOo9OGYZ5VE+3AZVM/2pjsJKxaEbcdM/go/e
         XMkAYcTLCXXvWeZsngWu9lPJFmNb6DPZyF1bhj6OHbmY2JRlqaD7Z8Tq0lAL/cCf1wGT
         8Ttnt7CDs5ZmpN8TCM+v+ZpUSG6iwIrYVyoec7tjahfjSete7GQvRMl85kwK/EzjMSZx
         iYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ywk5kgimgzqnnPT+XZy47dxy0OlRvssJgYFxBD/Z4aE=;
        b=5jRl6MI2ICRXeFSjPRj0N0RYL9m5t9lBqIoQpb20BN1zd0DSt2x/6aHVYGhRBrfvf0
         1AOiKHzvdyuulEx3jPlkewrH5Wte/3NEOHye3BBp5N2vn5zCh8nwqW8A5jrQq0RFdYY4
         IA/BgpYgZ/rrKhtPCYjmKQBEUOknwPRj88hiJhiJ2ULa2I7GCiU7VyV9YkVU0ZIvUFaI
         nbmSBwHqhpP+hLWK2xHPgGeyF9x9EFp00Ne9lgU30IO+ieJLs5NWQsnpwPegqNunIzpn
         biEMPoz26hkowu+7lPxbj3fE2ywLSwIv3IxWWcTCfzi8PbKhfLrE6FSrUPRaKTAR65j8
         5xPA==
X-Gm-Message-State: AFqh2krWVQS6mqfrPlYKWON13hM54plhq3t+s2S8WfW4UDpyJbOO9JDw
        y+8RMYMR93Lo0TziK795I/IYY9fseKjjlxq+rBUDfA==
X-Google-Smtp-Source: AMrXdXtVwTLcBMamWsZkIKTNdshS3/u/EDgTWfUDOvfa4R33160dUHhm6rUdQJgg1hNJiNk3fCDNzcMdRKlWw9lh5+8=
X-Received: by 2002:a63:4943:0:b0:478:e6cf:c24c with SMTP id
 y3-20020a634943000000b00478e6cfc24cmr5160343pgk.365.1673309121880; Mon, 09
 Jan 2023 16:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-22-paulmck@kernel.org> <CAKwvOdmt7mnP_dfCMO_YUV792Zgtirk=NFqe8XH0z88-b0e23A@mail.gmail.com>
In-Reply-To: <CAKwvOdmt7mnP_dfCMO_YUV792Zgtirk=NFqe8XH0z88-b0e23A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Jan 2023 16:05:10 -0800
Message-ID: <CAKwvOdnQX1H9-8QnsUiXi+eK4udGdO34isHZ-PEzNDZwJbJ41w@mail.gmail.com>
Subject: Re: [PATCH rcu 22/27] init: Remove "select SRCU"
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, Tejun Heo <tj@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 4:02 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Jan 4, 2023 at 4:38 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
>
> Looks like that's the case as of
> commit 0cd7e350abc4 ("rcu: Make SRCU mandatory")
> in v6.2-rc1.
>
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Aaron Tomlin <atomlin@redhat.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>
> Patch LGTM
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Note that there's quite a few more of these though. Perhaps best to
> remove them all together? Or perhaps you already have individual
> patches out already for all of these?

Ah indeed, I missed that this was part of such a series:
https://lore.kernel.org/lkml/20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1/


>
> $ grep -rn 'select SRCU'
> mm/Kconfig:670: select SRCU
> kernel/power/Kconfig:121: select SRCU
> arch/mips/kvm/Kconfig:29: select SRCU
> arch/riscv/kvm/Kconfig:30: select SRCU
> arch/s390/kvm/Kconfig:34: select SRCU
> arch/powerpc/kvm/Kconfig:25: select SRCU
> arch/x86/kvm/Kconfig:49: select SRCU
> arch/x86/Kconfig:286: select SRCU
> arch/x86/Kconfig:1941: select SRCU
> arch/arm64/kvm/Kconfig:31: select SRCU
> init/Kconfig:1868: select SRCU
> security/tomoyo/Kconfig:9: select SRCU
> fs/btrfs/Kconfig:20: select SRCU
> fs/dlm/Kconfig:7: select SRCU
> fs/quota/Kconfig:9: select SRCU
> fs/notify/Kconfig:4: select SRCU
> drivers/md/Kconfig:9: select SRCU
> drivers/clk/Kconfig:26: select SRCU
> drivers/dax/Kconfig:4: select SRCU
> drivers/devfreq/Kconfig:4: select SRCU
> drivers/net/Kconfig:337: select SRCU
> drivers/hwtracing/stm/Kconfig:5: select SRCU
> drivers/cpufreq/Kconfig:6: select SRCU
> drivers/opp/Kconfig:4: select SRCU
>
> > ---
> >  init/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 7e5c3ddc341de..af511c726d695 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1865,7 +1865,6 @@ config PERF_EVENTS
> >         default y if PROFILING
> >         depends on HAVE_PERF_EVENTS
> >         select IRQ_WORK
> > -       select SRCU
> >         help
> >           Enable kernel support for various performance events provided
> >           by software and hardware.
> > --
> > 2.31.1.189.g2e36527f23
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
