Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98E367E654
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjA0NPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjA0NOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:14:55 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAED977DD0;
        Fri, 27 Jan 2023 05:14:17 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso2093872oti.10;
        Fri, 27 Jan 2023 05:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJxS5HZhwkBpszh7vWIw8lli9f4o81OwCgf69fEDo9o=;
        b=CMMkwAyUYBWTxxd5dJkVyPDqOa5h8W+HgmziPzS3Z9PEKz8ZArlRzKI3WWW0xf21Ia
         zBaArFlGbh+lA7F+OpmmNOXvxaGw44l+w0c/LyM0f/sSWyZ/N6FAytskWE5sa4odQ843
         3jQ4iHJiP9Vyae9GtetOTI9xuYIIFZK16lEbbBNlshorrW4b2OXEJOfwFL8B24fd724O
         XQRoGef6qdSsoQ9naUiyitCl0GRTiyS5iA+R16PUDBmwpOTTqxbh2AQud0aXOh2MwiBt
         +7CSnctnzHE/Lb30Nmd0PLm5E24M7YxS9VtEMV7wAnUlH5LApwYJJkNlDMIKdonKun8j
         U5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJxS5HZhwkBpszh7vWIw8lli9f4o81OwCgf69fEDo9o=;
        b=q6VpKxa62ULut+4o0KUiwJxQKvcrRTePvrEiY+TBdTL2nH6KwCb78x/MuY9yUDb2TF
         HRzbaQWZiKFeDyFOB0tRqKSbqSV5UJaMV0PfbjwYB85WKSpGz745pdohCcmTJ5+nyVuA
         mH/T/6zd+L4/8bPger5tVqR9XitLaHj+tAVohG3VYQiDeergi4ymeFpg8RqiUiYOApi7
         XCOEca22CCHIPcIWn1H0oLVdOMiXJ2mAMkwN+O0RqMgSC90r6la6IyhrsPHIeo3Il7nv
         TNnYKtJkHZqyJlprm/4C0PL+2RerzLcrldGoZ1VYT8ywZuYggph+bdyN/a9ugvXWuCP5
         iSXQ==
X-Gm-Message-State: AFqh2kpE8vuKiVzyr9gLdoAHzTk+7Qypg3mLOCSWlIeN9QxXXT7FjNdp
        +8Jchw8RQ3BVlYrThlzRNmCHPlvSXEI=
X-Google-Smtp-Source: AMrXdXus/i4eYuc+3ovyb/yHMjbP6BrOxfmcV92S5T6HSgSttWglzHwyLd84Mzkpo9mwC9mqm9gq9A==
X-Received: by 2002:a05:6830:6993:b0:670:4588:f8c4 with SMTP id cy19-20020a056830699300b006704588f8c4mr24361037otb.18.1674825233283;
        Fri, 27 Jan 2023 05:13:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p18-20020a9d76d2000000b0068655f477a6sm1720983otl.50.2023.01.27.05.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 05:13:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 27 Jan 2023 05:13:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Song Liu <song@kernel.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] module: replace module_layout with module_memory
Message-ID: <20230127131351.GB3911997@roeck-us.net>
References: <20230125185004.254742-1-song@kernel.org>
 <Y9IYTI3pWuKbJ3bC@bombadil.infradead.org>
 <CAPhsuW7ipGS=RhowYSp06DBYOY31sYoup7-Je+CEuKCxJsHavQ@mail.gmail.com>
 <Y9Lp+5mqxP0bgvrM@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Lp+5mqxP0bgvrM@bombadil.infradead.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 01:00:43PM -0800, Luis Chamberlain wrote:
> Guenter Roeck,
> 
> Any chance you can give this branch a good spin on your multi-arch setup
> to see what may below up?
> 
I assume I shoud test v3 ?

Guenter

> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-testing
> 
> On Thu, Jan 26, 2023 at 12:01:40PM -0800, Song Liu wrote:
> > Hi Luis,
> > 
> > Thanks for your kind review!
> > 
> > On Wed, Jan 25, 2023 at 10:06 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > [...]
> > > >
> > > >         MOD_MEM_TYPE_TEXT,
> > > >         MOD_MEM_TYPE_DATA,
> > > >         MOD_MEM_TYPE_RODATA,
> > > >         MOD_MEM_TYPE_RO_AFTER_INIT,
> > > >         MOD_MEM_TYPE_INIT_TEXT,
> > > >         MOD_MEM_TYPE_INIT_DATA,
> > > >         MOD_MEM_TYPE_INIT_RODATA,
> > > >
> > > > and allocating them separately.
> > >
> > > First thanks for doing this work!
> > >
> > > This seems to not acknolwedge the original goal of the first module_layout and
> > > the latched rb-tree use, and that was was for speeding up __module_address()
> > > since it *can* even be triggered on NMIs. I say this because the first question
> > > that comes to me is the impact to performance on __module_address() I can't
> > > see that changing much here, but mention it as it similar consideration
> > > should be made in case future changes modify this path.
> > 
> > To make sure I understand this correctly. Do you mean we need something like
> > the following in the commit log?
> > 
> > """
> > This adds slightly more entries to mod_tree (from up to 3 entries per module, to
> > up to 7 entries per module). However, this at most adds a small constant
> > overhead to __module_address(), which is expected to be fast.
> > """
> 
> Yes I think this is very useful information for the reviewier.
> 
> > > Microbenching something so trivial as __module_address() may not be as useful
> > > for an idle system, at the very least being able to compare before and after
> > > even on idle may be useful *if* you eventually do some more radical changes
> > > here. Modules-related kernel/kallsyms_selftest.c did that for kallsyms_lookup_name()
> > > and friend just recently for a minor performance enhancement.
> > 
> > kernel/kallsyms_selftest.c is new to me. I will give it a try.
> 
> It was just merged, be sure to have da35048f2600 ("kallsyms: Fix
> scheduling with interrupts disabled in self-test").
> 
> > > > Signed-off-by: Song Liu <song@kernel.org>
> > > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > >
> > > > ---
> > > >
> > > > This is the preparation work for the type aware module_alloc() discussed
> > > > in [1]. While this work is not covered much in the discussion, it is a
> > > > critical step of the effort.
> > > >
> > > > As this part grows pretty big (~1000 lines, + and -), I would like get
> > > > some feedback on it, so that I know it is on the right track.
> > > >
> > > > Please share your comments. Thanks!
> > > >
> > > > Test coverage: Tested on x86_64.
> > >
> > > I will likely merge this onto modules-next soon, not because I think it is
> > > ready, but just because I think it *is* mostly ready and the next thing
> > > we need is exposure and testing. rc5 is pretty late to consider this
> > > for v6.3 and so hopefully for this cycle we can at least settle on
> > > something which will sit in linux-next since the respective linux-next
> > > after v6.3-rc1 is released.
> > 
> > Yes, this definitely needs more tests. Given different archs use
> > module_layout in all sorts of ways. I will be very surprised if I updated
> > all them correctly (though I tried hard to).
> 
> OK so let's be patient with testing. Getting help from Guenter here
> can probably speed up finding issues.
> 
> > > > Build tested by kernel test bot in [2]. The only regression in [2] was a
> > > > typo in parisc, which is also fixed.
> > > >
> > > > [1] https://lore.kernel.org/linux-mm/20221107223921.3451913-1-song@kernel.org/T/#u
> > >
> > > You still never addressed my performance suggestions so don't be
> > > surprised if I insist later. Yes you can use existing performance
> > > benchmarks, specially now with modules as a hard requirement, to
> > > show gains. So I'd like to clarify that if I'm reviewing late it is
> > > because:
> > >
> > > a) my modules patch review queue has been high as of late
> > > b) you seem to not have taken these performance suggestions into consideration
> > >    before and so I tend to put it at my end of my queue for review.
> > 
> > I think it will be a lot easier to run performance tests with the
> > module support. Let's see what we can do when we get to the
> > performance test part.
> 
> Fantastic, clearly I'm interested in being able to reproduce so I will
> email you offline about some techniques I've used to reproduce some
> things easily for testing things with modules.
> 
>   Luis
