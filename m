Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ABB660A8D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjAGAGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGAGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:06:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6050108A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:06:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FF6861FA3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 00:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825BFC433D2;
        Sat,  7 Jan 2023 00:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673049962;
        bh=fXkgoZi2DYRR99T5Hvs3gdzsHh2II0unDZsZf0maiBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiHJDn/Y+2P5QPY8oHhwqG2K3MqR3Fz0Da3zV/lwx9I0msux09jLln6C2FBqM/Vf6
         dKwuhtWLWi+UNRRRxIFWNR6toeTPVKn9iijDRlK4usljOu+u37gHvYqmwPCVZyUjzS
         L2VvT1MjgJrcW+xrY8qOolamAEfTsfY7+lPMR/t4suKFV25q87p1/xwzTGy1wOOmyk
         8q3Xs34h0u6xHE26c5+UHbcV3Wl05w/XZhr7upE3IBI3AXWvL4HARiFGs+oD6pHp3q
         dJ1HI4WZbvNIYWKE6mXSKwz7eiB0WUlp2w5W8vzcQcvJ7toV/fPI1BU1xjKXDmUQue
         PogYI+AxQ413Q==
Date:   Fri, 6 Jan 2023 16:06:00 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kees Cook <kees@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chao Yu <chao@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Linux 6.2-rc1
Message-ID: <Y7i3aKj9pfHc1s+l@google.com>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221226195206.GA2626419@roeck-us.net>
 <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com>
 <DA632860-284E-4923-8863-9D2745DD289E@kernel.org>
 <20221227002941.GA2691687@roeck-us.net>
 <D8BDBF66-E44C-45D4-9758-BAAA4F0C1998@kernel.org>
 <20221227055212.GA2711289@roeck-us.net>
 <DE30CDA1-CFF4-49FE-B653-F4CA831EAA12@kernel.org>
 <20221228144408.GA873415@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228144408.GA873415@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28, Guenter Roeck wrote:
> On Tue, Dec 27, 2022 at 07:40:30PM -0800, Kees Cook wrote:
> > On December 26, 2022 9:52:12 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
> > >On Mon, Dec 26, 2022 at 05:32:28PM -0800, Kees Cook wrote:
> > >> On December 26, 2022 4:29:41 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
> > >> >On Mon, Dec 26, 2022 at 01:03:59PM -0800, Kees Cook wrote:
> > >> >> On December 26, 2022 12:56:29 PM PST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >> >> >On Mon, Dec 26, 2022 at 11:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >> >> >>
> > >> >> >> fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
> > >> >> >> include/linux/fortify-string.h:59:33: error: '__builtin_memset' pointer overflow between offset [28, 898293814] and size [-898293787, -1] [-Werror=array-bounds]
> > >> >> >> fs/f2fs/inline.c:430:9: note: in expansion of macro 'memset'
> > >> >> >>   430 |         memset(dst.bitmap + src.nr_bitmap, 0, dst.nr_bitmap - src.nr_bitmap);
> > >> >> >>       |         ^~~~~~
> > >> >> >
> > >> >> >Well, that's unfortunate.
> > >> >> 
> > >> >> I'll look into this.
> > >> >> 
> > >> >
> > >> >I did some more testing. The problem is seen with gcc 11.3.0, but not with
> > >> >gcc 12.2.0 nor with gcc 10.3.0.
> > >> 
> > >> That's what I'd expect: 10 didn't have variable range tracking wired up to -Warray-bounds, 11 does, and we disable -Warray-bounds on 12 because of 3 separate 12-only GCC bugs.
> > >> 
> > >> > gcc bug ? Should I switch to gcc 12.2.0 for
> > >> >powerpc when build testing the latest kernel ?
> > >> 
> > >> Sure? But that'll just hide it. I suspect GCC has found a way for dst.nr_bitmap to be compile-time 27, so the size is always negative.
> > >> 
> > >dst.nr_bitmap is initialized with SIZE_OF_DENTRY_BITMAP,
> > >which is defined as:
> > >
> > >#define NR_DENTRY_IN_BLOCK      214     /* the number of dentry in a block */
> > >#define SIZE_OF_DIR_ENTRY       11      /* by byte */
> > >#define SIZE_OF_DENTRY_BITMAP   ((NR_DENTRY_IN_BLOCK + BITS_PER_BYTE - 1) / \
> > >                                        BITS_PER_BYTE)
> > >
> > >((214 + 8 - 1) / 8 = 27, so dst.nr_bitmap is indeed compile-time 27.
> > >
> > >Not sure how would know that src.nr_bitmap can be > 27, though.
> > >Am I missing something ?
> > 
> > I think it's saying it can't rule out it being larger? I.e. there is no obvious bounds checking for it. Perhaps:
> > 
> > if (src.nr_bitmap > dst.nr_bitmap) {
> >     err = -EFSCORRUPTED;
> > 		goto out;
> > }
> > 
> 
> After going through all calculations, using maximum values (or minimum
> values where appropriate) everywhere, I calculated that src.nr_bitmap
> is always <= 24. The actual inode is sanity checked in
> fs/f2fs/inode.c:sanity_check_inode().

I also cannot find any case where src.nr_bitmap > 24. May this be a GCC issue?

> 
> Also, why is this only seen when I try to build powerpc test images ?
> 
> Thanks,
> Guenter
