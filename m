Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD32A622067
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiKHXl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKHXly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:41:54 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE9356558;
        Tue,  8 Nov 2022 15:41:53 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13b103a3e5dso18016530fac.2;
        Tue, 08 Nov 2022 15:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lL3wYywZqc8SuvAFtYvCg1Ig5Cr4m9aNe9NOfgkonxI=;
        b=MNU1xEk/jTlvgL9qgx9YOZGbQ1CP2VTMIAZkacmErgm2hxR81tp6el35ZJgtfl5eOf
         Rt4my9MG42zIdR112nUQ+jU1w5ImH9Snq974f/B5+VS8AGr6oNarYNJmwnN4Joj0ClHS
         5Mizw85n/Xr5WMKSGczySWa7Y8YP1gHOrUTnFJChzF+lQbMGwbPkXA50Atg1Sk4YwqY7
         BP5aqleLVPYNEn+swgNsZfYwXeEvEH5KKfxHyKJ6nDZp32/eoFdqu2XNztEYsYmexVZ6
         PqJrXyHicAtFNqhFF5oMDNLTH/ihTrqWA7Tm7lK4+SFr5kmTsf9X40ZXvzx6xJj4kRlM
         J1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lL3wYywZqc8SuvAFtYvCg1Ig5Cr4m9aNe9NOfgkonxI=;
        b=nZujN+BstE9sTtrmb768oOsds5TXN8O2UQ27GhrlWJ7BJiVJtqz88Ur5IHK9RKxMjQ
         UQIFw9KlqcR3ILLmQGzFHMwzE8crbv+VKpSafjgeA0mSQ5IcFynRlY2tis6jPAv+WVGH
         jvxfBV0VOlDMwTfkVBcIUpYsAtffZQwuHHU3MMqYJzcZCi+42rWWrF4w4SN0PyGPtHEj
         ISoWAMXeFbIK+peTHxkM3+zj3pcKlJE0nZAnnkBml+m6LQg+7VS37eotQSKU6TZt89oP
         9vQVWBduPURsJiVDJtdnl/O0WogazX7JZnySFIEGMQKrIuObVMmr+xBpKc7SIDEznXcs
         IbiA==
X-Gm-Message-State: ACrzQf1gdGzmjZkOVwtHCtyqd7DMewbqrio1Weq2ck62GmKtNbODE7/Q
        AebhY+wvghDIzAqeb6kVK/+wIgvjABvHpY770No=
X-Google-Smtp-Source: AMsMyM6eARPp7/8r/TGkAU4xaupeOVhCWitwJeKi9/j/e5UGR2iHsUNZBOmtzy3Op3Ed/1ODKVSwQGzxiGB7TAyssHk=
X-Received: by 2002:a05:6870:171d:b0:13d:173c:e71d with SMTP id
 h29-20020a056870171d00b0013d173ce71dmr28511421oae.252.1667950912446; Tue, 08
 Nov 2022 15:41:52 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNATrBDSLqBZFmWr5RA542pUVR=mieUSNVYXy8thkHS6w_A@mail.gmail.com>
 <20221107180137.3634978-1-ndesaulniers@google.com>
In-Reply-To: <20221107180137.3634978-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 9 Nov 2022 00:41:15 +0100
Message-ID: <CA+icZUW83H0H-oQkE5vyURWu6bD-OGYpTsNMwU1if5r=7+tpDA@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile.debug: support for -gz=zstd
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Sedat Dilek <sedat.dilek@dhl.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Terrell <terrelln@fb.com>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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

On Mon, Nov 7, 2022 at 7:08 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Make DEBUG_INFO_COMPRESSED a choice; DEBUG_INFO_UNCOMPRESSED is the
> default, DEBUG_INFO_COMPRESSED uses zlib, DEBUG_INFO_COMPRESSED_ZSTD
> uses zstd.
>
> Some quick N=1 measurements with du, /usr/bin/time -v, and bloaty:
>
> clang-16, x86_64 defconfig plus
> CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_UNCOMPRESSED=y:
> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:55.43
> 488M vmlinux
> 27.6%   136Mi   0.0%       0    .debug_info
>  6.1%  30.2Mi   0.0%       0    .debug_str_offsets
>  3.5%  17.2Mi   0.0%       0    .debug_line
>  3.3%  16.3Mi   0.0%       0    .debug_loclists
>  0.9%  4.62Mi   0.0%       0    .debug_str
>
> clang-16, x86_64 defconfig plus
> CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED=y (zlib):
> Elapsed (wall clock) time (h:mm:ss or m:ss): 1:00.35
> 385M vmlinux
> 21.8%  85.4Mi   0.0%       0    .debug_info
>  2.1%  8.26Mi   0.0%       0    .debug_str_offsets
>  2.1%  8.24Mi   0.0%       0    .debug_loclists
>  1.9%  7.48Mi   0.0%       0    .debug_line
>  0.5%  1.94Mi   0.0%       0    .debug_str
>
> clang-16, x86_64 defconfig plus
> CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED_ZSTD=y (zstd):
> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:59.69
> 373M vmlinux
> 21.4%  81.4Mi   0.0%       0    .debug_info
>  2.3%  8.85Mi   0.0%       0    .debug_loclists
>  1.5%  5.71Mi   0.0%       0    .debug_line
>  0.5%  1.95Mi   0.0%       0    .debug_str_offsets
>  0.4%  1.62Mi   0.0%       0    .debug_str
>
> That's only a 3.11% overall binary size savings over zlib, but at no
> performance regression.
>
> This renames the existing KConfig options:
> * DEBUG_INFO_UNCOMPRESSED -> DEBUG_INFO_COMPRESSED_NONE
> * DEBUG_INFO_COMPRESSED -> DEBUG_INFO_COMPRESSED_ZLIB
> So users upgrading may need to reset the new Kconfigs.
>
> Link: https://maskray.me/blog/2022-09-09-zstd-compressed-debug-sections
> Link: https://maskray.me/blog/2022-01-23-compressed-debug-sections
> Suggested-by: Sedat Dilek (DHL Supply Chain) <sedat.dilek@dhl.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes v1 -> v2:
> * Remove `depends on DEBUG_KERNEL` as per Nathan.
> * Rename Kconfigs as per Sedat and Masahiro.
> * Add note about renamed Kconfigs to commit message.
> * Add more help text to DEBUG_INFO_COMPRESSED_ZSTD.
>
>  lib/Kconfig.debug      | 29 +++++++++++++++++++++++++++--
>  scripts/Makefile.debug |  4 ++++
>  2 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 29280072dc0e..7c28a8fba02e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -312,8 +312,21 @@ config DEBUG_INFO_REDUCED
>           DEBUG_INFO build and compile times are reduced too.
>           Only works with newer gcc versions.
>
> -config DEBUG_INFO_COMPRESSED
> -       bool "Compressed debugging information"
> +choice
> +       prompt "Compressed Debug information"
> +       help
> +         Compress the resulting debug info. Results in smaller debug info sections,
> +         but requires that consumers are able to decompress the results.
> +
> +         If unsure, choose DEBUG_INFO_COMPRESSED_NONE.
> +
> +config DEBUG_INFO_COMPRESSED_NONE
> +       bool "Don't compress debug information"
> +       help
> +         Don't compress debug info sections.
> +
> +config DEBUG_INFO_COMPRESSED_ZLIB
> +       bool "Compress debugging information with zlib"
>         depends on $(cc-option,-gz=zlib)
>         depends on $(ld-option,--compress-debug-sections=zlib)
>         help
> @@ -327,6 +340,18 @@ config DEBUG_INFO_COMPRESSED
>           preferable to setting $KDEB_COMPRESS to "none" which would be even
>           larger.
>
> +config DEBUG_INFO_COMPRESSED_ZSTD
> +       bool "Compress debugging information with zstd"
> +       depends on $(cc-option,-gz=zstd)
> +       depends on $(ld-option,--compress-debug-sections=zstd)
> +       help
> +         Compress the debug information using zstd.  This may provide better
> +         compression than zlib, for about the same time costs, but requires newer
> +         toolchain support.  Requires GCC 13.0+ or Clang 16.0+, binutils 2.40+, and
> +         zstd.
> +
> +endchoice # "Compressed Debug information"
> +
>  config DEBUG_INFO_SPLIT
>         bool "Produce split debuginfo in .dwo files"
>         depends on $(cc-option,-gsplit-dwarf)
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 332c486f705f..8ac3379d2255 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -31,6 +31,10 @@ ifdef CONFIG_DEBUG_INFO_COMPRESSED

^^ ifdef CONFIG_DEBUG_INFO_COMPRESSED_ZLIB

...from a quick (re)view.

-Sedat-

>  DEBUG_CFLAGS   += -gz=zlib
>  KBUILD_AFLAGS  += -gz=zlib
>  KBUILD_LDFLAGS += --compress-debug-sections=zlib
> +else ifdef CONFIG_DEBUG_INFO_COMPRESSED_ZSTD
> +DEBUG_CFLAGS   += -gz=zstd
> +KBUILD_AFLAGS  += -gz=zstd
> +KBUILD_LDFLAGS += --compress-debug-sections=zstd
>  endif
>
>  KBUILD_CFLAGS  += $(DEBUG_CFLAGS)
>
> base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
> --
> 2.38.1.431.g37b22c650d-goog
>
