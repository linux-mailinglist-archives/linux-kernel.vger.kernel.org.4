Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A884604DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJSQtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiJSQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:49:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89001C73C1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:49:04 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j130so1273732ybj.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9ZfzDpEuznz7JDO0MpUy4J66NH5NE0QVJuq6p+mpt0=;
        b=epFsZjbPDXKs/uJnbEHMuvJD+hZrSt9FzMgYqd/mH8LtXPiGaV8psQumxCoXK9sgfO
         L10JN3dev2bKHCRDrs3OjqjHjqP+DmJmalTXZ/su3aO/i+eyVaXECZfyIQagOIxt5D9b
         5SMvlmwAs0H2C1TBNV5QcfBY6uZ2M0NEkjIiSlRkS27+uMxADwcXQZixVJer/7fwovPQ
         ZfrzPQWM4yMQgVuEHHVrJyL9JPYOZXe11yu6u3AsOtQ30CyqlON+fSkmFmmN/wcOhnVO
         uujO7oXtYYA6V+oMiT56WCpR+V6Ust2lrtV8qJlCpv3uTmIoH2wx3iECkgQDsZokbFQC
         ZDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9ZfzDpEuznz7JDO0MpUy4J66NH5NE0QVJuq6p+mpt0=;
        b=zIdKTI8IBqYaHftcCwkBnqgcc1JVw/MDXzNIIztGW56v1NgeTdlqSR8EZR6ZW2mUOv
         zl+wVAH1ZIaBGQDYWmJX156+BLJ1L6QvbtrEtMWc6MCiJEuVh77AZKcugqxVYKI6/6k3
         A5L0cY4oJNHEOPljvyYxC/pyLK4+wjXpl7rwKsennFeWXWsciNXOvMAfrc6nO5TPTevp
         6QT5EzV6X1tIP+HJr5vcuNekq8SrAvoJxpb2GguDowE1MCre6zHtRADU64mEpLEKoffP
         wdwb07ZYULeuSwvo+/J54UaDmtkXU2DdQ1n28g861RjMph8Y4hoAoD6khT3BuWYrli3u
         iJqw==
X-Gm-Message-State: ACrzQf38GzTwGrMHCwk10Uo7WJum5uc/ttNPeA2GKt0qZLGl6NYJ4AUf
        qmPUIAjVcoSe17qnvkZ7VO6JuHLFToEwt3SkA8nh9A==
X-Google-Smtp-Source: AMsMyM5DkZinQHHC8pb/NksD2sLlylIK7q22Q/wf+HODW9dDpNq5xVtkobYW8TyJsJPErzcCHHgIw66b+HW2AA9mmCI=
X-Received: by 2002:a25:9d0a:0:b0:6bc:2641:19d4 with SMTP id
 i10-20020a259d0a000000b006bc264119d4mr7252756ybp.388.1666198143952; Wed, 19
 Oct 2022 09:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <Y1AZr01X1wvg5Klu@dev-arch.thelio-3990X>
In-Reply-To: <Y1AZr01X1wvg5Klu@dev-arch.thelio-3990X>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 19 Oct 2022 09:48:27 -0700
Message-ID: <CAG_fn=WYnfNHC3S1S=mCTKTnzL=UuH7Oz4W3HjsTXEQUtjrxtw@mail.gmail.com>
Subject: Re: -Wmacro-redefined in include/linux/fortify-string.h
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Oct 19, 2022 at 8:37 AM Nathan Chancellor <nathan@kernel.org> wrote=
:
>
> Hi all,
>
> I am seeing the following set of warnings when building an x86_64
> configuration that has CONFIG_FORTIFY_SOURCE=3Dy and CONFIG_KMSAN=3Dy:

I was also looking into this issue recently, because people start
running into it: https://github.com/google/kmsan/issues/89

I have a solution that redefines __underlying_memXXX to __msan_memXXX
under __SANITIZE_MEMORY__ in fortify-string.h and skips `#define
memXXX __msan_memXXX` in string_64.h, making KMSAN kinda work with
FORTIFY_SOURCE.
Dunno if that's necessary though: KMSAN is a debugging tool anyway,
and supporting it in fortify-string.h sounds excessive.

So I'm fine with disabling FORTIFY_STRING under KMSAN, unless someone objec=
ts.

>   In file included from scripts/mod/devicetable-offsets.c:3:
>   In file included from ./include/linux/mod_devicetable.h:13:
>   In file included from ./include/linux/uuid.h:12:
>   In file included from ./include/linux/string.h:253:
>   ./include/linux/fortify-string.h:496:9: error: 'memcpy' macro redefined=
 [-Werror,-Wmacro-redefined]
>   #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                 =
 \
>           ^
>   ./arch/x86/include/asm/string_64.h:17:9: note: previous definition is h=
ere
>   #define memcpy __msan_memcpy
>           ^
>   In file included from scripts/mod/devicetable-offsets.c:3:
>   In file included from ./include/linux/mod_devicetable.h:13:
>   In file included from ./include/linux/uuid.h:12:
>   In file included from ./include/linux/string.h:253:
>   ./include/linux/fortify-string.h:500:9: error: 'memmove' macro redefine=
d [-Werror,-Wmacro-redefined]
>   #define memmove(p, q, s)  __fortify_memcpy_chk(p, q, s,                =
 \
>           ^
>   ./arch/x86/include/asm/string_64.h:73:9: note: previous definition is h=
ere
>   #define memmove __msan_memmove
>           ^
>   2 errors generated.
>
> I can see that commit ff901d80fff6 ("x86: kmsan: use __msan_ string
> functions where possible.") appears to include a fix up for this warning
> with memset() but not memcpy() or memmove(). If I apply a similar fix up
> like so:
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-strin=
g.h
> index 4029fe368a4f..718ee17b31e3 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -493,6 +493,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_siz=
e_t size,
>   * __struct_size() vs __member_size() must be captured here to avoid
>   * evaluating argument side-effects further into the macro layers.
>   */
> +#ifndef CONFIG_KMSAN
>  #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                 \
>                 __struct_size(p), __struct_size(q),                     \
>                 __member_size(p), __member_size(q),                     \
> @@ -501,6 +502,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_siz=
e_t size,
>                 __struct_size(p), __struct_size(q),                     \
>                 __member_size(p), __member_size(q),                     \
>                 memmove)
> +#endif
>
>  extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memsc=
an);
>  __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size=
_t size)
>
> Then the instances of -Wmacro-redefined disappear but the fortify tests
> no longer pass for somewhat obvious reasons:
>
>   warning: unsafe memcpy() usage lacked '__read_overflow2' symbol in lib/=
test_fortify/read_overflow2-memcpy.c
>   warning: unsafe memmove() usage lacked '__read_overflow2' symbol in lib=
/test_fortify/read_overflow2-memmove.c
>   warning: unsafe memcpy() usage lacked '__read_overflow2_field' symbol i=
n lib/test_fortify/read_overflow2_field-memcpy.c
>   warning: unsafe memmove() usage lacked '__read_overflow2_field' symbol =
in lib/test_fortify/read_overflow2_field-memmove.c
>   warning: unsafe memcpy() usage lacked '__write_overflow' symbol in lib/=
test_fortify/write_overflow-memcpy.c
>   warning: unsafe memmove() usage lacked '__write_overflow' symbol in lib=
/test_fortify/write_overflow-memmove.c
>   warning: unsafe memset() usage lacked '__write_overflow' symbol in lib/=
test_fortify/write_overflow-memset.c
>   warning: unsafe memcpy() usage lacked '__write_overflow_field' symbol i=
n lib/test_fortify/write_overflow_field-memcpy.c
>   warning: unsafe memmove() usage lacked '__write_overflow_field' symbol =
in lib/test_fortify/write_overflow_field-memmove.c
>   warning: unsafe memset() usage lacked '__write_overflow_field' symbol i=
n lib/test_fortify/write_overflow_field-memset.c
>
> Should CONFIG_KMSAN depend on CONFIG_FORTIFY_SOURCE=3Dn like so? It seems
> like the two features are incompatible if I am reading ff901d80fff6
> correctly.
>
> diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> index b2489dd6503f..6a681621e3c5 100644
> --- a/lib/Kconfig.kmsan
> +++ b/lib/Kconfig.kmsan
> @@ -11,7 +11,7 @@ config HAVE_KMSAN_COMPILER
>  config KMSAN
>         bool "KMSAN: detector of uninitialized values use"
>         depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
> -       depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
> +       depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN && !FORTIFY_S=
OURCE
>         select STACKDEPOT
>         select STACKDEPOT_ALWAYS_INIT
>         help
>
> or is there a different obvious fix that I am missing?
>
> Cheers,
> Nathan



--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
