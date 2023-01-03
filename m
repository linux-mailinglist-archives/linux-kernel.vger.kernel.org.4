Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5282865C635
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbjACS1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238941AbjACS1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:27:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F23B2AF4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:26:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2641614C8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B6AC433D2;
        Tue,  3 Jan 2023 18:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672770400;
        bh=jZTBCfU3n9+ttpwW+YG7BYpeGomZJDY3La4AaIwYJZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XY68PC0ClLhYnpu6uMbY58u+2NN7AZPJp2WsvFAnkCYYO+dZ0sCm2+DgmfqjQ6noi
         +VhQymqK+l6vuqq365F4xnRYMhRSzXvsCOcjhr6TXk5DhVAke7jTmQWnaYeaXwse0M
         FCmBPc4VB43YCQq6FetXytUCSa8s0zmlRYNkXd6HsRd4fB0AgNoQXRogEr/uadOmJ3
         +cYsleleG1wYSPGkWbw42a0dQkkROzqjgyQkrqUNshrmB4JNwoUNkazQjCuDRwa2mH
         J5/Bj+Tx8I6xq+W9ACFGVIzGoWDMEqZvxX9WDrEO75LjDLkzNp2gbikuoiWY6wtgSC
         sXQ0Lwc84337g==
Date:   Tue, 3 Jan 2023 11:26:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: Linux 6.2-rc2
Message-ID: <Y7RzXSKYmAFAXMnr@dev-arch.thelio-3990X>
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
 <20230102225656.GA3532398@roeck-us.net>
 <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
 <20230103014535.GA313835@roeck-us.net>
 <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
 <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:58:48AM +0100, Ard Biesheuvel wrote:
> On Tue, 3 Jan 2023 at 03:13, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > ... and reverting commit 99cb0d917ff indeed fixes the problem.
> >
> > Hmm. My gut feel is that this just exposes some bug in binutils.
> >
> > That said, maybe that commit should not have added its own /DISCARDS/
> > thing, and instead just added that "*(.note.GNU-stack)" to the general
> > /DISCARDS/ thing that is defined by the
> >
> >   #define DISCARDS  ..
> >
> > a little bit later, so that we only end up with one single DISCARD
> > list. Something like this (broken patch on purpose):
> >
> >   --- a/include/asm-generic/vmlinux.lds.h
> >   +++ b/include/asm-generic/vmlinux.lds.h
> >   @@ -897,5 +897,4 @@
> >     */
> >    #define NOTES                                        \
> >   -     /DISCARD/ : { *(.note.GNU-stack) }              \
> >         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {       \
> >                 BOUNDED_SECTION_BY(.note.*, _notes)     \
> >   @@ -1016,4 +1015,5 @@
> >    #define DISCARDS                                     \
> >         /DISCARD/ : {                                   \
> >   +     *(.note.GNU-stack)                              \
> >         EXIT_DISCARDS                                   \
> >         EXIT_CALL                                       \
> >
> > But maybe that DISCARDS macrop ends up being used too late?
> >
> 
> Masahiro's v1 did something like this, and it caused an issue on
> RISC-V, which is why we ended up with this approach instead.
> 
> > It really shouldn't matter, but here we are, with a build problem with
> > some random old binutils on an odd platform..
> >
> 
> AIUI, the way ld.bfd used to combine output sections may also affect
> the /DISCARD/ pseudo-section, and so introducing it much earlier
> results in these discards to be interpreted in a different order.
> 
> The purpose of this change is to prevent .note.GNU-stack from deciding
> the section type of the .notes output section, and so keeping it in
> its own section should be sufficient. E.g.,

This appears to work for me. It fixes the build failures that
ClangBuiltLinux's CI reported and I still see a build ID for arm64's
vmlinux:

Tested-by: Nathan Chancellor <nathan@kernel.org>

I will throw this into the ClangBuiltLinux CI to make sure there are no
additional surprises but I do not expect to find anything.

> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -896,7 +896,7 @@
>   * Otherwise, the type of .notes section would become PROGBITS
> instead of NOTES.
>   */
>  #define NOTES                                                          \
> -       /DISCARD/ : { *(.note.GNU-stack) }                              \
> +       .note.GNU-stack : { *(.note.GNU-stack) }                        \
>         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {                       \
>                 BOUNDED_SECTION_BY(.note.*, _notes)                     \
>         } NOTES_HEADERS                                                 \
> 
> The .note.GNU-stack has zero size, so the result should be the same.
