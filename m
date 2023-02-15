Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6975669817F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBORAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBORAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:00:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5130B227AC;
        Wed, 15 Feb 2023 09:00:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03821B82284;
        Wed, 15 Feb 2023 17:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE879C433A1;
        Wed, 15 Feb 2023 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676480441;
        bh=VoQwZs3PxI1i874YQCQlLkJEn6xUMQQcU23iQzMW+C0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l6yVD0n4pNTIryCzJ1++9C3o+yNyd6ANgzX4HE6VDoSpcqQxOGe71C0kMMmY6k+hP
         3HmW3jNjeYyPXVPLk34+masfFPU/mT1vRD26Ov+H7Z2FaKgXaIvV+LSJ2TKKkYPMYo
         s4NTf07w+PFI7/BDLYnhFY4/XXG/VrPO86j5M/9QRXdY5uEIHA8rai93E9Tz/hhlPl
         jWns3NhpL66SOkW6vyyGXG3oqcuGb5AhBtlJ78iuyNTtFpJzwr1agSOGaAlAICSVqh
         AG6t5a/Ra2SSqOWzWMPnoDRayIfThnfFcVrP5wPRAQdiG9UmSapYlWLgjECvO/lozW
         hAWo2Fqc0YpAA==
Received: by mail-lf1-f47.google.com with SMTP id x40so28343471lfu.12;
        Wed, 15 Feb 2023 09:00:41 -0800 (PST)
X-Gm-Message-State: AO0yUKUtbSqNsxIWfz/oW4fjyuMjYyey/Huco/ZaGTkmMFe1ebMredyW
        YPZwyzHF/GUv1DPlzYoXoz7P70FvqJFkJsJKtWs=
X-Google-Smtp-Source: AK7set/D8UdVGWPvKoXHXLDpezTyNBw+XWJJLmwG90ECV8Wopu6lQqarv5JHZvpRETKcWSTvzhwNlO65nGKHlVuXaeQ=
X-Received: by 2002:a05:6512:340f:b0:4db:37ff:f5d0 with SMTP id
 i15-20020a056512340f00b004db37fff5d0mr43536lfr.1.1676480439859; Wed, 15 Feb
 2023 09:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20230215100008.2565237-1-ardb@kernel.org> <mhng-37f3f56f-70a4-4800-8685-e9a4c5922ce5@palmer-ri-x1c9>
In-Reply-To: <mhng-37f3f56f-70a4-4800-8685-e9a4c5922ce5@palmer-ri-x1c9>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Feb 2023 18:00:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFmZYmrZB7QyLCu3rpkChat=PVqPHsOi+HuWRj-FZ2S-g@mail.gmail.com>
Message-ID: <CAMj1kXFmZYmrZB7QyLCu3rpkChat=PVqPHsOi+HuWRj-FZ2S-g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Retire IA64/Itanium support
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        Arnd Bergmann <arnd@arndb.de>, tony.luck@intel.com,
        jrtc27@jrtc27.com, glaubitz@physik.fu-berlin.de,
        willy@infradead.org, Marc Zyngier <maz@kernel.org>,
        linux@roeck-us.net, Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 17:50, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 15 Feb 2023 02:00:03 PST (-0800), ardb@kernel.org wrote:
> > The IA64 port of Linux has no maintainer, and according to a report from
> > its only remaining user [0], it has been broken for a month and nobody
> > cares.
> >
> > Given that keeping a complex but unused architecture alive uses up
> > valuable developer bandwidth, let's just get rid of it.
> >
> > This supersedes my patch proposing to mark it as 'dead', which received
> > no replies from anyone that wants to keep it alive. [1]
> >
> > [0] https://www.spinics.net/lists/linux-ia64/msg21926.html
> > [1] https://lore.kernel.org/all/20230128122904.1345120-1-ardb@kernel.org/
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Jessica Clarke <jrtc27@jrtc27.com>
> > Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: linux-ia64@vger.kernel.org
> >
> > Ard Biesheuvel (5):
> >   arch: Remove Itanium (IA-64) architecture
> >   kernel: Drop IA64 support from sig_fault handlers
> >   Documentation: Drop IA64 from feature descriptions
> >   lib/raid6: Drop IA64 support
> >   Documentation: Drop or replace remaining mentions of IA64
>
> Not sure if I'm missing it in the diff, but it looks like there's also a
> bunch of "#ifdef __ia64__" and "#ifdef __IA64__" type code spread
> throughout the kernel.  I didn't look at the actual diff, but it's in
> files that aren't showing up in the diffstat.
>

Thanks for taking a look. It seems I indeed missed a couple.

> Just "git grep -i __ia64__" lists a bunch.  I didn't look at all of
> them, but at least spot checking include/acpi/actypes.h looks like it's
> a real Itanium workaround.  If the arch goes, it's probbaly worth
> removing those too?
>

The ACPI code is synced with another project, so I didn't touch it.
Same goes for some other header files where IA-64 is referenced, e.g.,
in the PE/COFF header stuff.

> There's also some mentions of "Itanium" in Documentation outside that
> don't look like they got caught here.  Not sure if they'd be worth
> getting rid of, though as they could still be useful examples.  The
> blurb in Documentation/memory-barriers.txt looks pretty port-specific,
> though.
>

Yeah, I don't think it is necessary to rewrite history soviet-style,
so some remaining references are fine IMHO.
