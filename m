Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74C69230B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjBJQOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjBJQNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:13:46 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C9A749B8;
        Fri, 10 Feb 2023 08:13:44 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id o8so4588459pls.11;
        Fri, 10 Feb 2023 08:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0CshUXcCs6affI6qquSsVCmroKwyEhvHhVKSrEyVPg=;
        b=ViHsFMlnSawkBFIZWJFQx80yiMCXj7HccAWN5L/S7NAJB8p38x1K09rE5i+b6o8Ekm
         B2NSbVTHw/tAIcaqjJm9SO/E3JohBKUwxv1j4g2t4aVWzMhh44RvdW+GBxNtw7T4Cv9J
         wp7SBzI1cZD2uinBfmCrex8lgvOiRQVwakMQ5XF4o+ML7u2FNhU9zvszunQePFuRy6kZ
         s9BtWrKAXkCdlIzP1HxlWpl9YDLAEeHYHwcTU4cn2BEWn2LkingChxWoPo66g9RG0d/j
         goBEiqKSMBCOHhL/2UipkbvTdNU4hNgo1ZiTS+Y9hxK8UMvEoNomfu6p8qo8+KlB/NIo
         q0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0CshUXcCs6affI6qquSsVCmroKwyEhvHhVKSrEyVPg=;
        b=i8fXy8aRLdQ+/tBCEl22JQEHjG5uvARCqe7R5bBtq8faCRvCocuBZ0s9xdZO8I87JX
         ev05tDudLyaRtngCdo+1v8cuv+k5J81BydCuaOexZV+tCHGQmXTPtUmebGJrH+SK9eA8
         aWp3BCHyFWpztRyP7pLR+8/PbsukMHIcZIfAUH2edbUUQG+bzjIOknPmWXmI/ULJ0qg8
         drTMLvBFDE9U7ohmp4UbCh6BRESgmRkyntcFyqXvA/duJpGqntbkqQhvx02TsqoyPJ9G
         XMsbQJ8+gSm2OCaY0+27RfO1Dcimh2NiV/Z5IqWIXi/SddSrw6G9kSzPR47NfXMVRRCp
         06yg==
X-Gm-Message-State: AO0yUKU35e7ZHB7+LcxJ7QBjH18ZmJxWMOSV43TRrNavA4oeLd8iaNZ8
        lddVV3WrGcE7YVvT5FtvCVQx7yJ8aXxa4Wb/fIU=
X-Google-Smtp-Source: AK7set//k492emoxe9ZyZKuKfHGgjiHYOHOnyfgXs3/778Ja38sSMuMqT5XDutbY0r7jdmpZF3wXjL82t9rl6fEDu1w=
X-Received: by 2002:a17:903:555:b0:196:14ea:d3c6 with SMTP id
 jo21-20020a170903055500b0019614ead3c6mr3612078plb.20.1676045624224; Fri, 10
 Feb 2023 08:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20230208184203.2260394-1-elver@google.com> <CA+fCnZeU=pRcyiBpj3nyri0ow+ZYp=ewU3dtSVm_6mh73y1NTA@mail.gmail.com>
 <CANpmjNP_Ka6RTqHNRD7xx93ebZhY+iz69GHBusT=A8X1KvViVA@mail.gmail.com>
In-Reply-To: <CANpmjNP_Ka6RTqHNRD7xx93ebZhY+iz69GHBusT=A8X1KvViVA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 10 Feb 2023 17:13:33 +0100
Message-ID: <CA+fCnZcNF5kNxNuphwj41P45tQEhQ9wX00ZA4g=KTX4sbUirQg@mail.gmail.com>
Subject: Re: [PATCH -tip] kasan: Emit different calls for instrumentable memintrinsics
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:35 AM Marco Elver <elver@google.com> wrote:
>
> On Thu, 9 Feb 2023 at 23:43, Andrey Konovalov <andreyknvl@gmail.com> wrote:
> >
> > On Wed, Feb 8, 2023 at 7:42 PM Marco Elver <elver@google.com> wrote:
> > >
> > > Clang 15 will provide an option to prefix calls to memcpy/memset/memmove
> > > with __asan_ in instrumented functions: https://reviews.llvm.org/D122724
> >
> > Hi Marco,
> >
> > Does this option affect all functions or only the ones that are marked
> > with no_sanitize?
>
> Only functions that are instrumented, i.e. wherever
> fsanitize=kernel-address inserts instrumentation.

Ack.

> > Based on the LLVM patch description, should we also change the normal
> > memcpy/memset/memmove to be noninstrumented?
>
> They are no longer instrumented as of 69d4c0d32186 (for
> CONFIG_GENERIC_ENTRY arches).

Ah, sorry, overlooked that.

> > These __asan_mem* functions are not defined in the kernel AFAICS.
> > Should we add them?
>
> Peter introduced them in 69d4c0d32186, and we effectively have no
> mem*() instrumentation on x86 w/o the compiler-enablement patch here.
>
> > Or maybe we should just use "__" as the prefix, as right now __mem*
> > functions are the ones that are not instrumented?
>
> __asan_mem* is for instrumented code, just like ASan userspace does
> (actually ASan userspace has been doing it like this forever, just the
> kernel was somehow special).
>
> [...]
> > > Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >
> > > The Fixes tag is just there to show the dependency, and that people
> > > shouldn't apply this patch without 69d4c0d32186.
>
> ^^^ Depends on this commit, which is only in -tip.

Got it. Missed that patch.

> > > +ifdef CONFIG_GENERIC_ENTRY
>
> It also only affects GENERIC_ENTRY arches.
>
> > > +# Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
> > > +# instead. With compilers that don't support this option, compiler-inserted
> > > +# memintrinsics won't be checked by KASAN.
> > > +CFLAGS_KASAN += $(call cc-param,asan-kernel-mem-intrinsic-prefix)
> > > +endif
>
> Probably the same should be done for SW_TAGS, because arm64 will be
> GENERIC_ENTRY at one point or another as well.

Yes, makes sense. I'll file a bug for this once I fully understand the
consequences of these changes.

> KASAN + GCC on x86 will have no mem*() instrumentation after
> 69d4c0d32186, which is sad, so somebody ought to teach it the same
> param as above.

Hm, with that patch we would have no KASAN checking within normal mem*
functions (not the ones embedded by the compiler) on GENERIC_ENTRY
arches even with Clang, right?
