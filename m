Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE8F6273E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiKNAo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKNAo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:44:57 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C510CE0E5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:44:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b21so8695628plc.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bAyzgj5CE9OWiOrrn+Nl/6JdPCxt0FavI2k3raPSuY=;
        b=xFkmgS2uxonwug4iVpSTPvOElejm9v2hX6Ek94GeiIxfKlxG5eNFVLItL8r6zT3/S1
         lo99J2Mxvc9+WefEqyZ6N/gZPPce+behH0UKlChvzI8dknlrWd1N9FbKB8Aj9az6ja9D
         /Klr2jIiMTEtTDLPQMpAVcdKcRPnDC+sjY2Lx1K5Xg8bezKkuZIk8Wpv/YSgLB4nl4nj
         QK7cQDOFZhCEAQHg63eRlHErcBBGlfpQAV1s3l11485Zd0Def8DHHMPkm74D0ZCJw0Bd
         q0YQJTT8H2ouGUMtDtQwOCBpMxXpN26DBvpr1T3GO8879mPHNXbUNZ8Be783g6ogb9SX
         qn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bAyzgj5CE9OWiOrrn+Nl/6JdPCxt0FavI2k3raPSuY=;
        b=ntOztcQxxm6Y+KOEQIHgybKJDTN17azsglV1MERHzDsGjJfR3a3nExtOFxf3v3vsqw
         GS57sNSDAxNcQn3Z0Z95pujT7w00vx2xJY0s4c37lQYTO+YTnUvXy2E4uIqiwpRQ0Cn+
         WieS8gKrfRpNfTu83xKepX7XxnzUpr6wvkc0vu4dsgi/KO6Dnwi3l6WUFLzwPEzzl3oy
         fTeFZfX4BZHGbvu769OtSS/7oydHSCsEO7rHYKcLWHPwBDH2OKsSCJ8Hq/2WbBBnTzn9
         PTOVCp1DabcrIKBGb/APGinsbtca1T4/Fdb5Usw6Tsux+tUegtiZugbDOPwJleRQw5qW
         32Ng==
X-Gm-Message-State: ANoB5pm3amdjiKOAFhEJi0S5tyaNQyrl9FsmJmqzeW6fNyhc/hvZQKjb
        RAzPLlpRMGkbRxW+6xfUcexhkg==
X-Google-Smtp-Source: AA0mqf6smN4U+y36efGs9D8IovwpZGXLCzjT0VTZyiqvCy6mB0yz2Jpya4A1KqFyHvDR97QH31O9Wg==
X-Received: by 2002:a17:902:e94e:b0:182:6c84:7ff4 with SMTP id b14-20020a170902e94e00b001826c847ff4mr10807228pll.25.1668386693131;
        Sun, 13 Nov 2022 16:44:53 -0800 (PST)
Received: from [192.168.10.153] (ppp121-45-204-168.cbr-trn-nor-bras38.tpg.internode.on.net. [121.45.204.168])
        by smtp.gmail.com with ESMTPSA id p129-20020a622987000000b0055f209690c0sm5302501pfp.50.2022.11.13.16.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 16:44:52 -0800 (PST)
Message-ID: <d18f3050-b7b6-3911-f60f-127422960169@ozlabs.ru>
Date:   Mon, 14 Nov 2022 11:44:46 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101
 Thunderbird/107.0
Subject: Re: [PATCH kernel v3] zstd: Fixing mixed module-builtin objects
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        kernel test robot <lkp@intel.com>
References: <20220929020823.1373722-1-aik@ozlabs.ru>
 <CAK7LNARv=yLgyxz6QNt+0NXNK7c0+LOPcmAa1+fHRaT7ajgGng@mail.gmail.com>
Content-Language: en-US
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <CAK7LNARv=yLgyxz6QNt+0NXNK7c0+LOPcmAa1+fHRaT7ajgGng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2022 07:58, Masahiro Yamada wrote:
> On Thu, Sep 29, 2022 at 11:08 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>
>> With CONFIG_ZSTD_COMPRESS=m and CONFIG_ZSTD_DECOMPRESS=y we end up in
>> a situation when files from lib/zstd/common/ are compiled once to be
>> linked later for ZSTD_DECOMPRESS (build-in) and ZSTD_COMPRESS (module)
>> even though CFLAGS are different for builtins and modules.
>> So far somehow this was not a problem but enabling LLVM LTO exposes
>> the problem as:
>>
>> ld.lld: error: linking module flags 'Code Model': IDs have conflicting values in 'lib/built-in.a(zstd_common.o at 5868)' and 'ld-temp.o'
>>
>> This particular conflict is caused by KBUILD_CFLAGS=-mcmodel=medium vs.
>> KBUILD_CFLAGS_MODULE=-mcmodel=large , modules use the large model on
>> POWERPC as explained at
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?h=v5.18-rc4#n127
>> but the current use of common files is wrong anyway.
> 
> 
> BTW, how to reproduce this error?
> 
> You referred to the arch/powerpc/Makefile,
> but ARCH=powerpc cannot enable Clang LTO.
> (powerpc does not select ARCH_SUPPORTS_LTO_CLANG).


I posted a patch for that a while back but it did not get much interest 
as there appears to be an alternative to LTO which does not require the 
compiler support, I forgot the name of that thing and changed the 
employer since then so lost track of this entirely :)

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220629083011.1763768-1-aik@ozlabs.ru/


> 
> 
> 
> 
> 
>> This works around the issue by introducing a zstd_common module with
>> shared code.
>>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> [robot found a problem in v2]
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>> Changes:
>> v3:
>> * added EXPORT_SYMBOL_GPL to compile with:
>> CONFIG_ZSTD_COMMON=m
>> CONFIG_ZSTD_COMPRESS=m
>> CONFIG_ZSTD_DECOMPRESS=m
>> Vast majority of cases have CONFIG_ZSTD_COMMON=y so this went unnoticed
>> ---
>>   lib/zstd/Makefile                | 18 ++++++++----------
>>   lib/zstd/common/entropy_common.c |  5 ++++-
>>   lib/zstd/common/zstd_common.c    | 10 ++++++++++
>>   lib/Kconfig                      |  8 ++++++--
>>   4 files changed, 28 insertions(+), 13 deletions(-)
>>
>> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
>> index fc45339fc3a3..440bd0007ae2 100644
>> --- a/lib/zstd/Makefile
>> +++ b/lib/zstd/Makefile
>> @@ -10,14 +10,10 @@
>>   # ################################################################
>>   obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
>>   obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
>> +obj-$(CONFIG_ZSTD_COMMON) += zstd_common.o
>>
>>   zstd_compress-y := \
>>                  zstd_compress_module.o \
>> -               common/debug.o \
>> -               common/entropy_common.o \
>> -               common/error_private.o \
>> -               common/fse_decompress.o \
>> -               common/zstd_common.o \
>>                  compress/fse_compress.o \
>>                  compress/hist.o \
>>                  compress/huf_compress.o \
>> @@ -33,12 +29,14 @@ zstd_compress-y := \
>>
>>   zstd_decompress-y := \
>>                  zstd_decompress_module.o \
>> -               common/debug.o \
>> -               common/entropy_common.o \
>> -               common/error_private.o \
>> -               common/fse_decompress.o \
>> -               common/zstd_common.o \
>>                  decompress/huf_decompress.o \
>>                  decompress/zstd_ddict.o \
>>                  decompress/zstd_decompress.o \
>>                  decompress/zstd_decompress_block.o \
>> +
>> +zstd_common-y := \
>> +               common/debug.o \
>> +               common/entropy_common.o \
>> +               common/error_private.o \
>> +               common/fse_decompress.o \
>> +               common/zstd_common.o \
>> diff --git a/lib/zstd/common/entropy_common.c b/lib/zstd/common/entropy_common.c
>> index 53b47a2b52ff..a311808c0d56 100644
>> --- a/lib/zstd/common/entropy_common.c
>> +++ b/lib/zstd/common/entropy_common.c
>> @@ -15,6 +15,7 @@
>>   /* *************************************
>>   *  Dependencies
>>   ***************************************/
>> +#include <linux/module.h>
>>   #include "mem.h"
>>   #include "error_private.h"       /* ERR_*, ERROR */
>>   #define FSE_STATIC_LINKING_ONLY  /* FSE_MIN_TABLELOG */
>> @@ -239,7 +240,7 @@ size_t FSE_readNCount(
>>   {
>>       return FSE_readNCount_bmi2(normalizedCounter, maxSVPtr, tableLogPtr, headerBuffer, hbSize, /* bmi2 */ 0);
>>   }
>> -
>> +EXPORT_SYMBOL_GPL(FSE_readNCount);
>>
>>   /*! HUF_readStats() :
>>       Read compact Huffman tree, saved by HUF_writeCTable().
>> @@ -255,6 +256,7 @@ size_t HUF_readStats(BYTE* huffWeight, size_t hwSize, U32* rankStats,
>>       U32 wksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
>>       return HUF_readStats_wksp(huffWeight, hwSize, rankStats, nbSymbolsPtr, tableLogPtr, src, srcSize, wksp, sizeof(wksp), /* bmi2 */ 0);
>>   }
>> +EXPORT_SYMBOL_GPL(HUF_readStats);
>>
>>   FORCE_INLINE_TEMPLATE size_t
>>   HUF_readStats_body(BYTE* huffWeight, size_t hwSize, U32* rankStats,
>> @@ -355,3 +357,4 @@ size_t HUF_readStats_wksp(BYTE* huffWeight, size_t hwSize, U32* rankStats,
>>       (void)bmi2;
>>       return HUF_readStats_body_default(huffWeight, hwSize, rankStats, nbSymbolsPtr, tableLogPtr, src, srcSize, workSpace, wkspSize);
>>   }
>> +EXPORT_SYMBOL_GPL(HUF_readStats_wksp);
>> diff --git a/lib/zstd/common/zstd_common.c b/lib/zstd/common/zstd_common.c
>> index 3d7e35b309b5..0f1f63be25d9 100644
>> --- a/lib/zstd/common/zstd_common.c
>> +++ b/lib/zstd/common/zstd_common.c
>> @@ -13,6 +13,7 @@
>>   /*-*************************************
>>   *  Dependencies
>>   ***************************************/
>> +#include <linux/module.h>
>>   #define ZSTD_DEPS_NEED_MALLOC
>>   #include "zstd_deps.h"   /* ZSTD_malloc, ZSTD_calloc, ZSTD_free, ZSTD_memset */
>>   #include "error_private.h"
>> @@ -35,14 +36,17 @@ const char* ZSTD_versionString(void) { return ZSTD_VERSION_STRING; }
>>    *  tells if a return value is an error code
>>    *  symbol is required for external callers */
>>   unsigned ZSTD_isError(size_t code) { return ERR_isError(code); }
>> +EXPORT_SYMBOL_GPL(ZSTD_isError);
>>
>>   /*! ZSTD_getErrorName() :
>>    *  provides error code string from function result (useful for debugging) */
>>   const char* ZSTD_getErrorName(size_t code) { return ERR_getErrorName(code); }
>> +EXPORT_SYMBOL_GPL(ZSTD_getErrorName);
>>
>>   /*! ZSTD_getError() :
>>    *  convert a `size_t` function result into a proper ZSTD_errorCode enum */
>>   ZSTD_ErrorCode ZSTD_getErrorCode(size_t code) { return ERR_getErrorCode(code); }
>> +EXPORT_SYMBOL_GPL(ZSTD_getErrorCode);
>>
>>   /*! ZSTD_getErrorString() :
>>    *  provides error code string from enum */
>> @@ -59,6 +63,7 @@ void* ZSTD_customMalloc(size_t size, ZSTD_customMem customMem)
>>           return customMem.customAlloc(customMem.opaque, size);
>>       return ZSTD_malloc(size);
>>   }
>> +EXPORT_SYMBOL_GPL(ZSTD_customMalloc);
>>
>>   void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
>>   {
>> @@ -71,6 +76,7 @@ void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
>>       }
>>       return ZSTD_calloc(1, size);
>>   }
>> +EXPORT_SYMBOL_GPL(ZSTD_customCalloc);
>>
>>   void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
>>   {
>> @@ -81,3 +87,7 @@ void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
>>               ZSTD_free(ptr);
>>       }
>>   }
>> +EXPORT_SYMBOL_GPL(ZSTD_customFree);
>> +
>> +MODULE_LICENSE("Dual BSD/GPL");
>> +MODULE_DESCRIPTION("Zstd Common");
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index dc1ab2ed1dc6..3ea8941ab18d 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -343,12 +343,16 @@ config LZ4HC_COMPRESS
>>   config LZ4_DECOMPRESS
>>          tristate
>>
>> +config ZSTD_COMMON
>> +       select XXHASH
>> +       tristate
>> +
>>   config ZSTD_COMPRESS
>> -       select XXHASH
>> +       select ZSTD_COMMON
>>          tristate
>>
>>   config ZSTD_DECOMPRESS
>> -       select XXHASH
>> +       select ZSTD_COMMON
>>          tristate
>>
>>   source "lib/xz/Kconfig"
>> --
>> 2.37.3
>>
> 
> 

-- 
Alexey
