Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2BE5E8130
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiIWRzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiIWRz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:55:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D7110952F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:55:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so885422pjk.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kD2niSi8Q2s9C0iZoWvhDZfcfTDj+tYZVTvmx+Zc1Zw=;
        b=PM0D+7+7hgKH/DM4lleJ+v8ObShSmFRI8cpd628po+F9L0EcTYuFTl1JqOzFmgB/ay
         B4Faqi3WSoI4428phu+n7PP/zGNgp/k6XVDmE2p6RhyP5bqHiVCEwTIlsTtIFcPYuCac
         0RQTkNcFMe9Z0iIa1R7jNcIdoUI8Knk+mA8/B1DSgIguDljM70M2K3YcB4OpTCpbtLnR
         MThPr7sTSYFS2Go8g0plnnRT5a/1EVkPi8SHpjQ8PhhcoliHhI7eyKuHCbYcO9tudO6I
         WUAsTi5j9A5zn5jWdAgGHKSKVN7P8Kxvys0RfmnSd1XHxi4q1wssJoWEV1FKgZrEvWFW
         5zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kD2niSi8Q2s9C0iZoWvhDZfcfTDj+tYZVTvmx+Zc1Zw=;
        b=ELcqAKPSuwF0uA5DzwYWY4xMNsSMJ4w1XrVPa0unDf6IpNhO7wd4C3zRmkvU2+qpVq
         OmVDkAApYtTT0XjwqPoiAksJDqj1ZY7QfDpNuqu7aVo8HOj4MrrQcZDYSvB3IKQyK2cL
         rTWssZa/EeUMmbfZVoKeCkm4gJ9NAkKx5J6ZSDx6w9/BsY63cA3UB4tifuQJ9zgte7IZ
         Mtya8913+uQSqBv1SAZjshAp3vYa5rxMmZfNs4d9z20K1JHKGbvRUPXQEYmVCcVoiiFv
         AE4UAJwMyI+cXJHBVKLU8tZrFwrpMuuG0pY5eXB72c4cITIgBTLUxLyGK7norneRmQ39
         2lgA==
X-Gm-Message-State: ACrzQf2gTXJEAgfx4dj68ZOBTSM4nXkIW2JXKI2tSxVyKcq8ec7d/7B9
        aK+mJy5wjOalWjxJ4HBVsxm3ofQZU5iClY4RFKTXug==
X-Google-Smtp-Source: AMsMyM7z7XO7YKGCgb5rkwRjRFohT9KDK8Rupkb/zwBw/l+Fr/Xowg0TgfDTi0dOpn5k/x7a+Q8wlTPPlcQufjbCl4I=
X-Received: by 2002:a17:902:e74d:b0:178:796c:e1b7 with SMTP id
 p13-20020a170902e74d00b00178796ce1b7mr9394381plf.33.1663955726866; Fri, 23
 Sep 2022 10:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220923170218.1188423-1-ndesaulniers@google.com> <CAHk-=wiAwEA5KekL4+t+v6qAdKLSOQvBkGbumvk+Rxhaay8aFg@mail.gmail.com>
In-Reply-To: <CAHk-=wiAwEA5KekL4+t+v6qAdKLSOQvBkGbumvk+Rxhaay8aFg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 23 Sep 2022 10:55:15 -0700
Message-ID: <CAKwvOd=r+9X6JkikpuTvjdTn7DXusevoJBFjXtGQ1SZYCZ6f6g@mail.gmail.com>
Subject: Re: [PATCH] x86, mem: move memmove to out of line assembler
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Andy Lutomirski <luto@kernel.org>
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

Dropping Ma, emails bouncing.

On Fri, Sep 23, 2022 at 10:30 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Sep 23, 2022 at 10:02 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > memmove is quite large and probably shouldn't be inlined due to size
> > alone. A noinline function attribute would be the simplest fix, but
> > there's a few things that stand out with the current definition:
>
> I don't think your patch is wrong, and it's not that different from
> what the x86-64 code did long ago back in 2011 in commit 9599ec0471de
> ("x86-64, mem: Convert memmove() to assembly file and fix return value
> bug")
>
> But I wonder if we might be better off getting rid of that horrid
> memmove thing entirely.

We could remove __HAVE_ARCH_MEMMOVE from
arch/x86/include/asm/string_32.h for ARCH=i386 then rip this
arch-specific definition of memmove out.

Might performance regressions be a concern with that approach?

I'll write up a patch for that just to have on hand, and leave the
decision up to someone else.

> The original thing seems to be from 2010,
> where commit 3b4b682becdf ("x86, mem: Optimize memmove for small size
> and unaligned cases") did this thing for both 32-bit and 64-bit code.
>
> And it's really not likely used all that much - memcpy is the *much*
> more important function, and that's the one that has actually been
> updated for modern CPU's instead of looking like it's some copy from
> glibc or whatever.

I suspect that's probably where the duplicate 3 label comes from:
likely some macros were expanded from another codebase's
implementation, then copied into the kernel sources.

>
> To make things even stranger, on the x86-64 side, we actually have
> *two* copies of 'memmove()' - it looks like memcpy_orig() is already a
> memmove, in that it does that
>
>         cmp  %dil, %sil
>         jl .Lcopy_backward
>
> thing that seems to mean that it already handles the overlapping case.
>
> Anyway, that 32-bit memmove() implemented (badly) as inline asm does
> need to go. As you point out, it seems to get the clobbers wrong too,
> so it's actively buggy and just happens to work because there's
> nothing else in that function, and it clobbers %bx that is supposed to
> be callee-saved, but *presumably* the compile has to allocate %bx one
> of the other registers, so it will save and restore %bx anyway.
>
> So that current memmove() seems to be truly horrendously buggy, but in
> a "it happens to work" way. Your patch seems an improvement, but I get
> the feeling that it could be improved a lot more...
-- 
Thanks,
~Nick Desaulniers
