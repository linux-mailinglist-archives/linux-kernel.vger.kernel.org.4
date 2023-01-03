Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DBC65C7A5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbjACTkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbjACTkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:40:09 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B3C13FBE;
        Tue,  3 Jan 2023 11:40:06 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f20so33071795lja.4;
        Tue, 03 Jan 2023 11:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=di6+B/a8IzWMU+YNat5Sofaq/W1nrTJmHjw8c69qvaI=;
        b=lRKzUBOE1GhqTB132HvL9VHc1Xlfw89at8dCADYWfEHGmoAKi+8emR5dXTKqY6qMqa
         sRJGy/r7SYkyh2G3tqwZtrJBHIE4swTCaFon9gPHfszva5deEpvuyuWjWZOBZjjsjc2/
         SsyoD+OXrdPRiNXHrYflsUhHmkWxZOMXHOnWUwEIuVM49FOiY+B578EEoQ1e0osIuqPC
         tFuXNUWFZKGTe+zz4MCNaL6T33KyHVMWl6cLbSjxo5k8r12lidWs+dPDyio2f5CUKhjz
         9JGbnq5ZRT5hVOsFfC4w7Pe4n+P7vP9/CGCRJTCS0ggMOcoxPNkXz4QYqAkgqloOk/iw
         +8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=di6+B/a8IzWMU+YNat5Sofaq/W1nrTJmHjw8c69qvaI=;
        b=7dCPLhkAx5fQyCo3OqeshNv+SjzqVhanlRPx2UXE69lRB7CFc0orkIcgARxzUSQyyc
         9+qftUdYPb0Wrf+6wc5LPQ90sUIlTTbrMGbzUrvCiAArr4l5UCL+itcByovjClXtm+Sb
         mCPYu6u8jnVsTjCu66frK8ZAU8T7u+A6wQLRrCEW994xnrdKP3PDplDvKN4iQlnE71ns
         n5uxKBDOZqBR3M0eyztlywO8sf/3KZfqLwXx2lfU8dt80IYMZEIfDC3a4IKLtn6xEHL4
         e6kU+MgktnrPrY0ZUKN3MFosPRrVtFY8Y1730vAWT6LDNibuNBHvcXMSKCVDerHCzq7Y
         r3pw==
X-Gm-Message-State: AFqh2kp6a0aZSt7gIMuO/2YWOfWEyrnQJy7DQVwyXYQigSSGuWlrTLch
        MofPYajxmo20qmzzejUnfi1SmGCImpB1trNZM1M=
X-Google-Smtp-Source: AMrXdXvq+p0XY2mL04hhyI79maNj4LkKf1liLSxbAXsUAs5wxywLnY8+XI3fDCLoj7mmpTWAN2zuEtCfTkPzNpP1YcQ=
X-Received: by 2002:a2e:9805:0:b0:27f:c51a:a069 with SMTP id
 a5-20020a2e9805000000b0027fc51aa069mr1773133ljj.487.1672774805212; Tue, 03
 Jan 2023 11:40:05 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUW83H0H-oQkE5vyURWu6bD-OGYpTsNMwU1if5r=7+tpDA@mail.gmail.com>
 <20221110195932.377841-1-ndesaulniers@google.com> <CAK7LNATtt9Ot5D2rJLC=gpvBFEE70Vct+gX4UKw13F7=UqO1XQ@mail.gmail.com>
In-Reply-To: <CAK7LNATtt9Ot5D2rJLC=gpvBFEE70Vct+gX4UKw13F7=UqO1XQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 3 Jan 2023 20:39:28 +0100
Message-ID: <CA+icZUXtw0PR07m6hG9DXZ9Xf82rY4wfSYYMc4WbVkLC6bz6qg@mail.gmail.com>
Subject: Re: [PATCH v3] Makefile.debug: support for -gz=zstd
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Sedat Dilek <sedat.dilek@dhl.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Terrell <terrelln@fb.com>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
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

On Sun, Nov 13, 2022 at 12:01 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Nov 11, 2022 at 5:00 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
...
>
> Applied to linux-kbuild.
> Thanks.
...
> > Changes v2 -> v3:
> > * Fix scripts/Makefile.debug as per Sedat.
> > * Update commit message as per Nicolas.
> >
> > Changes v1 -> v2:
> > * Remove `depends on DEBUG_KERNEL` as per Nathan.
> > * Rename Kconfigs as per Sedat and Masahiro.
> > * Add note about renamed Kconfigs to commit message.
> > * Add more help text to DEBUG_INFO_COMPRESSED_ZSTD.
...
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 29280072dc0e..7c28a8fba02e 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
...
> > +config DEBUG_INFO_COMPRESSED_ZSTD
> > +       bool "Compress debugging information with zstd"
> > +       depends on $(cc-option,-gz=zstd)
> > +       depends on $(ld-option,--compress-debug-sections=zstd)
> > +       help
> > +         Compress the debug information using zstd.  This may provide better
> > +         compression than zlib, for about the same time costs, but requires newer
> > +         toolchain support.  Requires GCC 13.0+ or Clang 16.0+, binutils 2.40+, and
> > +         zstd.
> > +
> > +endchoice # "Compressed Debug information"

Just saw:

GNU Binutils 2.40 Branched With Zstd Support, Zen 4, New Intel Instructions

Debian GNU/Linux ships version 2.39.90 in unstable release.

Maybe someone can point me to the release schedule of LLVM-16?

Thanks.

Best regards,
-Sedat-

[1] https://www.phoronix.com/news/GNU-Binutils-2.40
[2] https://metadata.ftp-master.debian.org/changelogs//main/b/binutils/binutils_2.39.90.20221231-1_changelog
