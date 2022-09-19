Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C8E5BCC38
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiISMya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiISMy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:54:26 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168FF2AC51
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:54:24 -0700 (PDT)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 28JCs4A5027786
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 21:54:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 28JCs4A5027786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663592044;
        bh=VROyJy6r+HI1MVx6q7A+dVODLIUjvUP1B3i9Tlp+Klk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mHXaLSApVnFHYqLEHjcQ4Xt3FNIS8M25dWkpmuXFIYPLtWr8xqXUBW9RcrsddgQgU
         CzjV1pteE+VHMXqez8wjEWknGjnpdwzYOG8iR4O/TcD7rAiizZD0UulQD6MulNhY/d
         jyc2viyE9D8MmgC2JHp9r5ozAIllvTcM9ipTli+EfPOLJPD70ZnG4tKMbJebSWGrqY
         q5h2AJ3guYgtt+jndOBuiS5m2z22fO4WuaPFUDuDZhFgwEYpfRNX3o1uanxeca/TA2
         6sGN7gGHpqvfFKNX8D653EgOMX6uZobOuym/oUkZPOwUkiyNoCAwkXMNsOO2YYg3fV
         GeTBsHlDc6PfA==
X-Nifty-SrcIP: [209.85.161.42]
Received: by mail-oo1-f42.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so137416oop.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:54:04 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ZOI7scuGfVwrum8Rc9hfIqT96R93ivZ4ONF1rjdXcaBLIei0K
        YVi5XLe+zfVKZ9THUQcedCbPAJ0sGMO19VU5oS4=
X-Google-Smtp-Source: AMsMyM5C2hFn8ab1ZsHwl1juvH+iKVx+1TKLOHpF9MlGlWgiLYBxDr/P/C+KFCJrz/aCrnl4406Pv0/FWM5nBtXwYG4=
X-Received: by 2002:a4a:9c92:0:b0:473:f49d:d855 with SMTP id
 z18-20020a4a9c92000000b00473f49dd855mr6674253ooj.93.1663592043293; Mon, 19
 Sep 2022 05:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220429053329.2278740-1-aik@ozlabs.ru> <YoLjpivvU7dRVTuL@dev-arch.thelio-3990X>
 <7d30583e-7e58-5184-be2d-773882dd9092@ozlabs.ru> <ba973bf8-fee6-ba17-244e-32c00d6a06e4@ozlabs.ru>
In-Reply-To: <ba973bf8-fee6-ba17-244e-32c00d6a06e4@ozlabs.ru>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 19 Sep 2022 21:53:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNMhTn-+GcOHZrVj=viQxTMUS_7syat4icaPXUGtYkVw@mail.gmail.com>
Message-ID: <CAK7LNARNMhTn-+GcOHZrVj=viQxTMUS_7syat4icaPXUGtYkVw@mail.gmail.com>
Subject: Re: [PATCH kernel v2] zstd: Fixing mixed module-builtin objects
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 3:56 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> Ping? It's about 2 months now :)
>
>
> On 6/6/22 15:12, Alexey Kardashevskiy wrote:
> > Ping?
> >
> >




Applied to linux-kbuild.
Thanks.









> > On 5/17/22 09:52, Nathan Chancellor wrote:
> >> Hi Nick,
> >>
> >> Did you have any thoughts on this patch? It is necessary for enabling
> >> LTO with PowerPC:
> >>
> >> https://lore.kernel.org/20220429064547.2334280-1-aik@ozlabs.ru/
> >>
> >> If you don't have anything to send to Linus for the next cycle, perhaps
> >> this patch could be carried by the PowerPC folks with your ack?
> >>
> >> Cheers,
> >> Nathan
> >>
> >> On Fri, Apr 29, 2022 at 03:33:29PM +1000, Alexey Kardashevskiy wrote:
> >>> With CONFIG_ZSTD_COMPRESS=m and CONFIG_ZSTD_DECOMPRESS=y we end up in
> >>> a situation when files from lib/zstd/common/ are compiled once to be
> >>> linked later for ZSTD_DECOMPRESS (build-in) and ZSTD_COMPRESS (module)
> >>> even though CFLAGS are different for builtins and modules.
> >>> So far somehow this was not a problem but enabling LLVM LTO exposes
> >>> the problem as:
> >>>
> >>> ld.lld: error: linking module flags 'Code Model': IDs have
> >>> conflicting values in 'lib/built-in.a(zstd_common.o at 5868)' and
> >>> 'ld-temp.o'
> >>>
> >>> This particular conflict is caused by KBUILD_CFLAGS=-mcmodel=medium vs.
> >>> KBUILD_CFLAGS_MODULE=-mcmodel=large , modules use the large model on
> >>> POWERPC as explained at
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?h=v5.18-rc4#n127
> >>> but the current use of common files is wrong anyway.
> >>>
> >>> This works around the issue by introducing a zstd_common module with
> >>> shared code.
> >>>
> >>> Cc: Masahiro Yamada <masahiroy@kernel.org>
> >>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>> ---
> >>> Changes:
> >>> v2:
> >>> * add a new module instead of inlining common bits
> >>>
> >>> ---
> >>>   lib/zstd/Makefile                | 18 ++++++++----------
> >>>   lib/zstd/common/entropy_common.c |  4 +++-
> >>>   lib/zstd/common/zstd_common.c    |  7 +++++++
> >>>   lib/Kconfig                      |  8 ++++++--
> >>>   4 files changed, 24 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
> >>> index fc45339fc3a3..440bd0007ae2 100644
> >>> --- a/lib/zstd/Makefile
> >>> +++ b/lib/zstd/Makefile
> >>> @@ -10,14 +10,10 @@
> >>>   # ################################################################
> >>>   obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
> >>>   obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
> >>> +obj-$(CONFIG_ZSTD_COMMON) += zstd_common.o
> >>>   zstd_compress-y := \
> >>>           zstd_compress_module.o \
> >>> -        common/debug.o \
> >>> -        common/entropy_common.o \
> >>> -        common/error_private.o \
> >>> -        common/fse_decompress.o \
> >>> -        common/zstd_common.o \
> >>>           compress/fse_compress.o \
> >>>           compress/hist.o \
> >>>           compress/huf_compress.o \
> >>> @@ -33,12 +29,14 @@ zstd_compress-y := \
> >>>   zstd_decompress-y := \
> >>>           zstd_decompress_module.o \
> >>> -        common/debug.o \
> >>> -        common/entropy_common.o \
> >>> -        common/error_private.o \
> >>> -        common/fse_decompress.o \
> >>> -        common/zstd_common.o \
> >>>           decompress/huf_decompress.o \
> >>>           decompress/zstd_ddict.o \
> >>>           decompress/zstd_decompress.o \
> >>>           decompress/zstd_decompress_block.o \
> >>> +
> >>> +zstd_common-y := \
> >>> +        common/debug.o \
> >>> +        common/entropy_common.o \
> >>> +        common/error_private.o \
> >>> +        common/fse_decompress.o \
> >>> +        common/zstd_common.o \
> >>> diff --git a/lib/zstd/common/entropy_common.c
> >>> b/lib/zstd/common/entropy_common.c
> >>> index 53b47a2b52ff..f84612627471 100644
> >>> --- a/lib/zstd/common/entropy_common.c
> >>> +++ b/lib/zstd/common/entropy_common.c
> >>> @@ -15,6 +15,7 @@
> >>>   /* *************************************
> >>>   *  Dependencies
> >>>   ***************************************/
> >>> +#include <linux/module.h>
> >>>   #include "mem.h"
> >>>   #include "error_private.h"       /* ERR_*, ERROR */
> >>>   #define FSE_STATIC_LINKING_ONLY  /* FSE_MIN_TABLELOG */
> >>> @@ -239,7 +240,7 @@ size_t FSE_readNCount(
> >>>   {
> >>>       return FSE_readNCount_bmi2(normalizedCounter, maxSVPtr,
> >>> tableLogPtr, headerBuffer, hbSize, /* bmi2 */ 0);
> >>>   }
> >>> -
> >>> +EXPORT_SYMBOL_GPL(FSE_readNCount);
> >>>   /*! HUF_readStats() :
> >>>       Read compact Huffman tree, saved by HUF_writeCTable().
> >>> @@ -255,6 +256,7 @@ size_t HUF_readStats(BYTE* huffWeight, size_t
> >>> hwSize, U32* rankStats,
> >>>       U32 wksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
> >>>       return HUF_readStats_wksp(huffWeight, hwSize, rankStats,
> >>> nbSymbolsPtr, tableLogPtr, src, srcSize, wksp, sizeof(wksp), /* bmi2
> >>> */ 0);
> >>>   }
> >>> +EXPORT_SYMBOL_GPL(HUF_readStats);
> >>>   FORCE_INLINE_TEMPLATE size_t
> >>>   HUF_readStats_body(BYTE* huffWeight, size_t hwSize, U32* rankStats,
> >>> diff --git a/lib/zstd/common/zstd_common.c
> >>> b/lib/zstd/common/zstd_common.c
> >>> index 3d7e35b309b5..06f62b2026d5 100644
> >>> --- a/lib/zstd/common/zstd_common.c
> >>> +++ b/lib/zstd/common/zstd_common.c
> >>> @@ -13,6 +13,7 @@
> >>>   /*-*************************************
> >>>   *  Dependencies
> >>>   ***************************************/
> >>> +#include <linux/module.h>
> >>>   #define ZSTD_DEPS_NEED_MALLOC
> >>>   #include "zstd_deps.h"   /* ZSTD_malloc, ZSTD_calloc, ZSTD_free,
> >>> ZSTD_memset */
> >>>   #include "error_private.h"
> >>> @@ -59,6 +60,7 @@ void* ZSTD_customMalloc(size_t size, ZSTD_customMem
> >>> customMem)
> >>>           return customMem.customAlloc(customMem.opaque, size);
> >>>       return ZSTD_malloc(size);
> >>>   }
> >>> +EXPORT_SYMBOL_GPL(ZSTD_customMalloc);
> >>>   void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
> >>>   {
> >>> @@ -71,6 +73,7 @@ void* ZSTD_customCalloc(size_t size, ZSTD_customMem
> >>> customMem)
> >>>       }
> >>>       return ZSTD_calloc(1, size);
> >>>   }
> >>> +EXPORT_SYMBOL_GPL(ZSTD_customCalloc);
> >>>   void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
> >>>   {
> >>> @@ -81,3 +84,7 @@ void ZSTD_customFree(void* ptr, ZSTD_customMem
> >>> customMem)
> >>>               ZSTD_free(ptr);
> >>>       }
> >>>   }
> >>> +EXPORT_SYMBOL_GPL(ZSTD_customFree);
> >>> +
> >>> +MODULE_LICENSE("Dual BSD/GPL");
> >>> +MODULE_DESCRIPTION("Zstd Common");
> >>> diff --git a/lib/Kconfig b/lib/Kconfig
> >>> index 087e06b4cdfd..33f3a7054cdd 100644
> >>> --- a/lib/Kconfig
> >>> +++ b/lib/Kconfig
> >>> @@ -333,12 +333,16 @@ config LZ4HC_COMPRESS
> >>>   config LZ4_DECOMPRESS
> >>>       tristate
> >>> +config ZSTD_COMMON
> >>> +    select XXHASH
> >>> +    tristate
> >>> +
> >>>   config ZSTD_COMPRESS
> >>> -    select XXHASH
> >>> +    select ZSTD_COMMON
> >>>       tristate
> >>>   config ZSTD_DECOMPRESS
> >>> -    select XXHASH
> >>> +    select ZSTD_COMMON
> >>>       tristate
> >>>   source "lib/xz/Kconfig"
> >>> --
> >>> 2.30.2
> >>>
> >>>
> >
>
> --
> Alexey



-- 
Best Regards
Masahiro Yamada
