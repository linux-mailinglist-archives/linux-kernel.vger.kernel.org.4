Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9898D60947F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJWPqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiJWPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:46:09 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E460E84;
        Sun, 23 Oct 2022 08:46:08 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so4671127otu.1;
        Sun, 23 Oct 2022 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zYoFy4PRUP0UQkgDblhvZS3W/3eVlXZam11FB2Q1TXA=;
        b=pdEf9ixy/2RDe3hm9ZC+O+yDJE2GQsMEdU/uN6jm5+d1dRoZySDgeYkMR79K5m99uY
         2ePLqutgCXgub9mKA4YZf4ASzolxU6mxmiYZiXKf8zba6+0ZFlNKRqLZLnJS2YiJ0KG0
         sjuslCZI+p8h0qQiIDqzd+2WmRGbdV/1I56xz+zdkpg1gYpRbknZgE+xCI7uWnzlTi1c
         bwALf6VlQSrP2CWyFZbs534xye6jkasYVXLQZ2vE7cXcRtxuXsWyOi+s2DyLjPup/gX2
         dYeYiWZIqZXk5nLPGoNUQOOCau4RDfZNA3JA01JWIoQzXWPoKsBjWdHSyUIfvbHAdia1
         HgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYoFy4PRUP0UQkgDblhvZS3W/3eVlXZam11FB2Q1TXA=;
        b=MG8ifDl+WLQpc2IiNwQwxEODIXZaAcADffUBZGvWFK7ov6421r2q3+bAtaTnnIE/G1
         FQf3ImsCNYH0LWTQLaPLzKfszMIMeBkgV7KcZyK8BM9V3e/JCSj0bcNdoLV1jxFfMwVN
         Td8HDv+hwRDKJuOejc3o/m3m6JEuNPeYkx0c2TWWiysw4ll4wC0WWoU0d3yukcWq6Q+Z
         7To12iAYlqIcEIYHMamRhSJpWS6JpoPDf+Ao1YsgB6eJVcIYrzNS8DuDWUoI0k93SuYD
         odfXN1/wlPRu3OK8rvcM2YJgksia/1evfqnHhQlE16cTXSERVfnz3hMDwgLBtOaYc1Uz
         vanQ==
X-Gm-Message-State: ACrzQf0EFB6JaCwIuLMucSZKd4x7HBNPzCDR8JZPqk0by855EPvrZA71
        d9Gch731oW6U7Q5280aaWMea6nKuoX1IS7zE0C0=
X-Google-Smtp-Source: AMsMyM7yE/d0nKKxlZj2DysD+C3yJ0L4Og3Ph5u2BF8bRuzYL6U1d+Q188l++GPU60G68+oF2DN8Iwsj1cX6y0l4dxI=
X-Received: by 2002:a05:6830:6084:b0:65c:3942:e3bf with SMTP id
 by4-20020a056830608400b0065c3942e3bfmr15062458otb.49.1666539967394; Sun, 23
 Oct 2022 08:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221020175655.1660864-1-ndesaulniers@google.com> <Y1GV9sHyODVmBbFW@dev-arch.thelio-3990X>
In-Reply-To: <Y1GV9sHyODVmBbFW@dev-arch.thelio-3990X>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 23 Oct 2022 17:45:30 +0200
Message-ID: <CA+icZUW2tFR=xjJEXJDNARW1yd_vjOOA1etF6aMN3Cx5ReFgmg@mail.gmail.com>
Subject: Re: [PATCH] Makefile.debug: support for -gz=zstd
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Sedat Dilek <sedat.dilek@dhl.com>,
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

On Thu, Oct 20, 2022 at 8:43 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Oct 20, 2022 at 10:56:49AM -0700, Nick Desaulniers wrote:
> > Make DEBUG_INFO_COMPRESSED a choice; DEBUG_INFO_UNCOMPRESSED is the
> > default, DEBUG_INFO_COMPRESSED uses zlib, DEBUG_INFO_COMPRESSED_ZSTD
> > uses zstd.
> >
> > Some quick N=1 measurements with du, /usr/bin/time -v, and bloaty:
> >
> > clang-16, x86_64 defconfig plus
> > CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_UNCOMPRESSED=y:
> > Elapsed (wall clock) time (h:mm:ss or m:ss): 0:55.43
> > 488M vmlinux
> > 27.6%   136Mi   0.0%       0    .debug_info
> >  6.1%  30.2Mi   0.0%       0    .debug_str_offsets
> >  3.5%  17.2Mi   0.0%       0    .debug_line
> >  3.3%  16.3Mi   0.0%       0    .debug_loclists
> >  0.9%  4.62Mi   0.0%       0    .debug_str
> >
> > clang-16, x86_64 defconfig plus
> > CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED=y (zlib):
> > Elapsed (wall clock) time (h:mm:ss or m:ss): 1:00.35
> > 385M vmlinux
> > 21.8%  85.4Mi   0.0%       0    .debug_info
> >  2.1%  8.26Mi   0.0%       0    .debug_str_offsets
> >  2.1%  8.24Mi   0.0%       0    .debug_loclists
> >  1.9%  7.48Mi   0.0%       0    .debug_line
> >  0.5%  1.94Mi   0.0%       0    .debug_str
> >
> > clang-16, x86_64 defconfig plus
> > CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED_ZSTD=y (zstd):
> > Elapsed (wall clock) time (h:mm:ss or m:ss): 0:59.69
> > 373M vmlinux
> > 21.4%  81.4Mi   0.0%       0    .debug_info
> >  2.3%  8.85Mi   0.0%       0    .debug_loclists
> >  1.5%  5.71Mi   0.0%       0    .debug_line
> >  0.5%  1.95Mi   0.0%       0    .debug_str_offsets
> >  0.4%  1.62Mi   0.0%       0    .debug_str
> >
> > That's only a 3.11% overall binary size savings over zlib, but at no
> > performance regression.
> >
> > Link: https://maskray.me/blog/2022-09-09-zstd-compressed-debug-sections
> > Link: https://maskray.me/blog/2022-01-23-compressed-debug-sections
> > Suggested-by: Sedat Dilek (DHL Supply Chain) <sedat.dilek@dhl.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> One small comment below.
>
> > ---
> >  lib/Kconfig.debug      | 26 +++++++++++++++++++++++++-
> >  scripts/Makefile.debug |  4 ++++
> >  2 files changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 3fc7abffc7aa..4085ac77dc12 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -312,8 +312,22 @@ config DEBUG_INFO_REDUCED
> >         DEBUG_INFO build and compile times are reduced too.
> >         Only works with newer gcc versions.
> >
> > +choice
> > +     prompt "Compressed Debug information"
> > +     depends on DEBUG_KERNEL
>
> I think you can drop this depends. The entire block is in an
> 'if DEBUG_INFO', which can only be true if CONFIG_DEBUG_KERNEL is set
> because of the dependencies of the "Debug information" prompt above this
> file, which is how CONFIG_DEBUG_INFO is selected.
>

Yes, dropping this is good.

> > +     help
> > +       Compress the resulting debug info. Results in smaller debug info sections,
> > +       but requires that consumers are able to decompress the results.
> > +
> > +       If unsure, choose DEBUG_INFO_UNCOMPRESSED.
> > +
> > +config DEBUG_INFO_UNCOMPRESSED
> > +     bool "Don't compress debug information"
> > +     help
> > +       Don't compress debug info sections.
> > +
> >  config DEBUG_INFO_COMPRESSED

Also, I prefer...

DEBUG_INFO_COMPRESSED_NONE
DEBUG_INFO_COMPRESSED_ZLIB
DEBUG_INFO_COMPRESSED_ZSTD

Following...

$ ld.lld-16 -v
Debian LLD 16.0.0 (compatible with GNU linkers)

$ ld.lld-16 --help | grep compress-debug-sections
 --compress-debug-sections=[none,zlib,zstd]

> > -     bool "Compressed debugging information"
> > +     bool "Compress debugging information with zlib"
> >       depends on $(cc-option,-gz=zlib)
> >       depends on $(ld-option,--compress-debug-sections=zlib)
> >       help
> > @@ -327,6 +341,16 @@ config DEBUG_INFO_COMPRESSED
> >         preferable to setting $KDEB_COMPRESS to "none" which would be even
> >         larger.
> >

Anyone, checked $KDEB_COMPRESS - does this need changes?

-Sedat-

> > +config DEBUG_INFO_COMPRESSED_ZSTD
> > +     bool "Compress debugging information with zstd"
> > +     depends on $(cc-option,-gz=zstd)
> > +     depends on $(ld-option,--compress-debug-sections=zstd)
> > +     help
> > +       Compress the debug information using zstd.  Requires GCC 13.0+ or Clang
> > +       16.0+, binutils 2.40+, and zstd.
> > +
> > +endchoice # "Compressed Debug information"
> > +
> >  config DEBUG_INFO_SPLIT
> >       bool "Produce split debuginfo in .dwo files"
> >       depends on $(cc-option,-gsplit-dwarf)
> > diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> > index 332c486f705f..8ac3379d2255 100644
> > --- a/scripts/Makefile.debug
> > +++ b/scripts/Makefile.debug
> > @@ -31,6 +31,10 @@ ifdef CONFIG_DEBUG_INFO_COMPRESSED
> >  DEBUG_CFLAGS += -gz=zlib
> >  KBUILD_AFLAGS        += -gz=zlib
> >  KBUILD_LDFLAGS       += --compress-debug-sections=zlib
> > +else ifdef CONFIG_DEBUG_INFO_COMPRESSED_ZSTD
> > +DEBUG_CFLAGS += -gz=zstd
> > +KBUILD_AFLAGS        += -gz=zstd
> > +KBUILD_LDFLAGS       += --compress-debug-sections=zstd
> >  endif
> >
> >  KBUILD_CFLAGS        += $(DEBUG_CFLAGS)
> > --
> > 2.38.0.135.g90850a2211-goog
> >
