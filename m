Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CD26AAF76
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 13:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCEMTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 07:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCEMTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 07:19:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD7EC56;
        Sun,  5 Mar 2023 04:19:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DCCB60AD9;
        Sun,  5 Mar 2023 12:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EEDC433D2;
        Sun,  5 Mar 2023 12:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678018770;
        bh=7tYpfigQjWcZkxDVsVR7lvwm9n0s0p51vUiui9RvZ+o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=koqW0mwSIckdxD4c6tOA/+0SCbpauY/IABoBHWJkMBbm82Y+xRWmcq5D2ZV/syr83
         vWnoVFrbJjAEF4jDrlbqTyydmGTuu6DBJUFnD1beX5r5XisemD3tLr/d0sMbfCQDua
         rYvUj42X0sCik8y3a//TvEZmqfBhMq25LZKaKAKcDqNs4pZEq2YLlcTkuDcDnZWYVM
         Z+PVhOaUiTUOHt44xIFQMrihfzpyfFcb7Do2uDYM+YTXcomwkOyImOsqAei7Q5ywp7
         6yxGUDQv/5/TLqLnBF75iK4N0sbB8JzpeUR5A48vrPZdJWNv6WA4IdlqW5PApUIxvQ
         p98Vp2A0djbdw==
Received: by mail-oo1-f43.google.com with SMTP id bd3-20020a4aee03000000b00517affa07c0so1144775oob.7;
        Sun, 05 Mar 2023 04:19:30 -0800 (PST)
X-Gm-Message-State: AO0yUKVaBfHxa/39gOgfenYlSerHRdd86q7+uzbwcXa4lAwuC7tpUB7f
        nGq5/Nt+O3i1OM9YcU4Qa/VifpnVXMcBBEq7Tvc=
X-Google-Smtp-Source: AK7set8pbcu/6GAI+YMsaQO7uEVJbOGh74eb3Qs7NWKKU6I1K/tcm+dCEtRcZE49UrhxUSUDMfGDDt0F5eWHfNsu7TU=
X-Received: by 2002:a4a:928d:0:b0:51a:ac8f:b6f9 with SMTP id
 i13-20020a4a928d000000b0051aac8fb6f9mr2695665ooh.1.1678018769931; Sun, 05 Mar
 2023 04:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20221016182349.49308-1-masahiroy@kernel.org>
In-Reply-To: <20221016182349.49308-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Mar 2023 21:18:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNASQfrL2JnL2QDE_fBLV6KmMuJATpvRk2vaB0db49OysEA@mail.gmail.com>
Message-ID: <CAK7LNASQfrL2JnL2QDE_fBLV6KmMuJATpvRk2vaB0db49OysEA@mail.gmail.com>
Subject: Re: [PATCH v3] Remove Intel compiler support
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Len Brown <lenb@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Tom Rix <trix@redhat.com>, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus


My expectation was this would be picked up by x86 maintainers,
or otherwise, directly by you.



Are you happy with picking this up?
https://lore.kernel.org/lkml/20221016182349.49308-1-masahiroy@kernel.org/

It is still applicable to the mainline.
(by passing -C<n> option to reduce the context)


Masahiro







On Mon, Oct 17, 2022 at 3:24=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> include/linux/compiler-intel.h had no update in the past 3 years.
>
> We often forget about the third C compiler to build the kernel.
>
> For example, commit a0a12c3ed057 ("asm goto: eradicate CC_HAS_ASM_GOTO")
> only mentioned GCC and Clang.
>
> init/Kconfig defines CC_IS_GCC and CC_IS_CLANG but not CC_IS_ICC,
> and nobody has reported any issue.
>
> I guess the Intel Compiler support is broken, and nobody is caring
> about it.
>
> Harald Arnesen pointed out ICC (classic Intel C/C++ compiler) is
> deprecated:
>
>     $ icc -v
>     icc: remark #10441: The Intel(R) C++ Compiler Classic (ICC) is
>     deprecated and will be removed from product release in the second hal=
f
>     of 2023. The Intel(R) oneAPI DPC++/C++ Compiler (ICX) is the recommen=
ded
>     compiler moving forward. Please transition to use this compiler. Use
>     '-diag-disable=3D10441' to disable this message.
>     icc version 2021.7.0 (gcc version 12.1.0 compatibility)
>
> Arnd Bergmann provided a link to the article, "Intel C/C++ compilers
> complete adoption of LLVM".
>
> lib/zstd/common/compiler.h and lib/zstd/compress/zstd_fast.c were kept
> untouched for better sync with https://github.com/facebook/zstd
>
> Link: https://www.intel.com/content/www/us/en/developer/articles/technica=
l/adoption-of-llvm-complete-icx.html
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>
> Changes in v3:
>   - Do not change lib/zstd/
>
> Changes in v2:
>   - Remove "not supported by icc." comments from compiler_attributes.h
>   - Clean up __assume_aligned() macro
>   - Add more info from Harald Arnesen and Arnd Bergmann
>
>  arch/ia64/include/uapi/asm/cmpxchg.h      |   6 +-
>  arch/ia64/include/uapi/asm/intel_intrin.h | 162 ----------------------
>  arch/ia64/include/uapi/asm/intrinsics.h   |   6 +-
>  include/acpi/platform/acenv.h             |   5 +-
>  include/acpi/platform/acenvex.h           |   2 +-
>  include/acpi/platform/acintel.h           |  55 --------
>  include/linux/compiler-intel.h            |  34 -----
>  include/linux/compiler_attributes.h       |  14 +-
>  include/linux/compiler_types.h            |   2 -
>  scripts/cc-version.sh                     |   2 -
>  scripts/min-tool-version.sh               |   4 -
>  11 files changed, 5 insertions(+), 287 deletions(-)
>  delete mode 100644 arch/ia64/include/uapi/asm/intel_intrin.h
>  delete mode 100644 include/acpi/platform/acintel.h
>  delete mode 100644 include/linux/compiler-intel.h
>
> diff --git a/arch/ia64/include/uapi/asm/cmpxchg.h b/arch/ia64/include/uap=
i/asm/cmpxchg.h
> index ca2e02685343..259ae57570bf 100644
> --- a/arch/ia64/include/uapi/asm/cmpxchg.h
> +++ b/arch/ia64/include/uapi/asm/cmpxchg.h
> @@ -15,11 +15,7 @@
>  #include <linux/types.h>
>  /* include compiler specific intrinsics */
>  #include <asm/ia64regs.h>
> -#ifdef __INTEL_COMPILER
> -# include <asm/intel_intrin.h>
> -#else
> -# include <asm/gcc_intrin.h>
> -#endif
> +#include <asm/gcc_intrin.h>
>
>  /*
>   * This function doesn't exist, so you'll get a linker error if
> diff --git a/arch/ia64/include/uapi/asm/intel_intrin.h b/arch/ia64/includ=
e/uapi/asm/intel_intrin.h
> deleted file mode 100644
> index dc1884dc54b5..000000000000
> --- a/arch/ia64/include/uapi/asm/intel_intrin.h
> +++ /dev/null
> @@ -1,162 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef _ASM_IA64_INTEL_INTRIN_H
> -#define _ASM_IA64_INTEL_INTRIN_H
> -/*
> - * Intel Compiler Intrinsics
> - *
> - * Copyright (C) 2002,2003 Jun Nakajima <jun.nakajima@intel.com>
> - * Copyright (C) 2002,2003 Suresh Siddha <suresh.b.siddha@intel.com>
> - * Copyright (C) 2005,2006 Hongjiu Lu <hongjiu.lu@intel.com>
> - *
> - */
> -#include <ia64intrin.h>
> -
> -#define ia64_barrier()         __memory_barrier()
> -
> -#define ia64_stop()    /* Nothing: As of now stop bit is generated for e=
ach
> -                        * intrinsic
> -                        */
> -
> -#define ia64_getreg            __getReg
> -#define ia64_setreg            __setReg
> -
> -#define ia64_hint              __hint
> -#define ia64_hint_pause                __hint_pause
> -
> -#define ia64_mux1_brcst                _m64_mux1_brcst
> -#define ia64_mux1_mix          _m64_mux1_mix
> -#define ia64_mux1_shuf         _m64_mux1_shuf
> -#define ia64_mux1_alt          _m64_mux1_alt
> -#define ia64_mux1_rev          _m64_mux1_rev
> -
> -#define ia64_mux1(x,v)         _m_to_int64(_m64_mux1(_m_from_int64(x), (=
v)))
> -#define ia64_popcnt            _m64_popcnt
> -#define ia64_getf_exp          __getf_exp
> -#define ia64_shrp              _m64_shrp
> -
> -#define ia64_tpa               __tpa
> -#define ia64_invala            __invala
> -#define ia64_invala_gr         __invala_gr
> -#define ia64_invala_fr         __invala_fr
> -#define ia64_nop               __nop
> -#define ia64_sum               __sum
> -#define ia64_ssm               __ssm
> -#define ia64_rum               __rum
> -#define ia64_rsm               __rsm
> -#define ia64_fc                        __fc
> -
> -#define ia64_ldfs              __ldfs
> -#define ia64_ldfd              __ldfd
> -#define ia64_ldfe              __ldfe
> -#define ia64_ldf8              __ldf8
> -#define ia64_ldf_fill          __ldf_fill
> -
> -#define ia64_stfs              __stfs
> -#define ia64_stfd              __stfd
> -#define ia64_stfe              __stfe
> -#define ia64_stf8              __stf8
> -#define ia64_stf_spill         __stf_spill
> -
> -#define ia64_mf                        __mf
> -#define ia64_mfa               __mfa
> -
> -#define ia64_fetchadd4_acq     __fetchadd4_acq
> -#define ia64_fetchadd4_rel     __fetchadd4_rel
> -#define ia64_fetchadd8_acq     __fetchadd8_acq
> -#define ia64_fetchadd8_rel     __fetchadd8_rel
> -
> -#define ia64_xchg1             _InterlockedExchange8
> -#define ia64_xchg2             _InterlockedExchange16
> -#define ia64_xchg4             _InterlockedExchange
> -#define ia64_xchg8             _InterlockedExchange64
> -
> -#define ia64_cmpxchg1_rel      _InterlockedCompareExchange8_rel
> -#define ia64_cmpxchg1_acq      _InterlockedCompareExchange8_acq
> -#define ia64_cmpxchg2_rel      _InterlockedCompareExchange16_rel
> -#define ia64_cmpxchg2_acq      _InterlockedCompareExchange16_acq
> -#define ia64_cmpxchg4_rel      _InterlockedCompareExchange_rel
> -#define ia64_cmpxchg4_acq      _InterlockedCompareExchange_acq
> -#define ia64_cmpxchg8_rel      _InterlockedCompareExchange64_rel
> -#define ia64_cmpxchg8_acq      _InterlockedCompareExchange64_acq
> -
> -#define __ia64_set_dbr(index, val)     \
> -               __setIndReg(_IA64_REG_INDR_DBR, index, val)
> -#define ia64_set_ibr(index, val)       \
> -               __setIndReg(_IA64_REG_INDR_IBR, index, val)
> -#define ia64_set_pkr(index, val)       \
> -               __setIndReg(_IA64_REG_INDR_PKR, index, val)
> -#define ia64_set_pmc(index, val)       \
> -               __setIndReg(_IA64_REG_INDR_PMC, index, val)
> -#define ia64_set_pmd(index, val)       \
> -               __setIndReg(_IA64_REG_INDR_PMD, index, val)
> -#define ia64_set_rr(index, val)                \
> -               __setIndReg(_IA64_REG_INDR_RR, index, val)
> -
> -#define ia64_get_cpuid(index)  \
> -               __getIndReg(_IA64_REG_INDR_CPUID, index)
> -#define __ia64_get_dbr(index)          __getIndReg(_IA64_REG_INDR_DBR, i=
ndex)
> -#define ia64_get_ibr(index)            __getIndReg(_IA64_REG_INDR_IBR, i=
ndex)
> -#define ia64_get_pkr(index)            __getIndReg(_IA64_REG_INDR_PKR, i=
ndex)
> -#define ia64_get_pmc(index)            __getIndReg(_IA64_REG_INDR_PMC, i=
ndex)
> -#define ia64_get_pmd(index)            __getIndReg(_IA64_REG_INDR_PMD, i=
ndex)
> -#define ia64_get_rr(index)             __getIndReg(_IA64_REG_INDR_RR, in=
dex)
> -
> -#define ia64_srlz_d            __dsrlz
> -#define ia64_srlz_i            __isrlz
> -
> -#define ia64_dv_serialize_data()
> -#define ia64_dv_serialize_instruction()
> -
> -#define ia64_st1_rel           __st1_rel
> -#define ia64_st2_rel           __st2_rel
> -#define ia64_st4_rel           __st4_rel
> -#define ia64_st8_rel           __st8_rel
> -
> -/* FIXME: need st4.rel.nta intrinsic */
> -#define ia64_st4_rel_nta       __st4_rel
> -
> -#define ia64_ld1_acq           __ld1_acq
> -#define ia64_ld2_acq           __ld2_acq
> -#define ia64_ld4_acq           __ld4_acq
> -#define ia64_ld8_acq           __ld8_acq
> -
> -#define ia64_sync_i            __synci
> -#define ia64_thash             __thash
> -#define ia64_ttag              __ttag
> -#define ia64_itcd              __itcd
> -#define ia64_itci              __itci
> -#define ia64_itrd              __itrd
> -#define ia64_itri              __itri
> -#define ia64_ptce              __ptce
> -#define ia64_ptcl              __ptcl
> -#define ia64_ptcg              __ptcg
> -#define ia64_ptcga             __ptcga
> -#define ia64_ptri              __ptri
> -#define ia64_ptrd              __ptrd
> -#define ia64_dep_mi            _m64_dep_mi
> -
> -/* Values for lfhint in __lfetch and __lfetch_fault */
> -
> -#define ia64_lfhint_none       __lfhint_none
> -#define ia64_lfhint_nt1                __lfhint_nt1
> -#define ia64_lfhint_nt2                __lfhint_nt2
> -#define ia64_lfhint_nta                __lfhint_nta
> -
> -#define ia64_lfetch            __lfetch
> -#define ia64_lfetch_excl       __lfetch_excl
> -#define ia64_lfetch_fault      __lfetch_fault
> -#define ia64_lfetch_fault_excl __lfetch_fault_excl
> -
> -#define ia64_intrin_local_irq_restore(x)               \
> -do {                                                   \
> -       if ((x) !=3D 0) {                                 \
> -               ia64_ssm(IA64_PSR_I);                   \
> -               ia64_srlz_d();                          \
> -       } else {                                        \
> -               ia64_rsm(IA64_PSR_I);                   \
> -       }                                               \
> -} while (0)
> -
> -#define __builtin_trap()       __break(0);
> -
> -#endif /* _ASM_IA64_INTEL_INTRIN_H */
> diff --git a/arch/ia64/include/uapi/asm/intrinsics.h b/arch/ia64/include/=
uapi/asm/intrinsics.h
> index a0e0a064f5b1..63f27c4ec739 100644
> --- a/arch/ia64/include/uapi/asm/intrinsics.h
> +++ b/arch/ia64/include/uapi/asm/intrinsics.h
> @@ -14,11 +14,7 @@
>  #include <linux/types.h>
>  /* include compiler specific intrinsics */
>  #include <asm/ia64regs.h>
> -#ifdef __INTEL_COMPILER
> -# include <asm/intel_intrin.h>
> -#else
> -# include <asm/gcc_intrin.h>
> -#endif
> +#include <asm/gcc_intrin.h>
>  #include <asm/cmpxchg.h>
>
>  #define ia64_set_rr0_to_rr4(val0, val1, val2, val3, val4)              \
> diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.=
h
> index 03eb3d977075..9e4f7564201a 100644
> --- a/include/acpi/platform/acenv.h
> +++ b/include/acpi/platform/acenv.h
> @@ -148,15 +148,12 @@
>   *
>   ***********************************************************************=
******/
>
> -#if defined(__GNUC__) && !defined(__INTEL_COMPILER)
> +#if defined(__GNUC__)
>  #include <acpi/platform/acgcc.h>
>
>  #elif defined(_MSC_VER)
>  #include "acmsvc.h"
>
> -#elif defined(__INTEL_COMPILER)
> -#include <acpi/platform/acintel.h>
> -
>  #endif
>
>  #if defined(_LINUX) || defined(__linux__)
> diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acen=
vex.h
> index 3a6b1db9a984..72cc7bab469e 100644
> --- a/include/acpi/platform/acenvex.h
> +++ b/include/acpi/platform/acenvex.h
> @@ -35,7 +35,7 @@
>
>  #endif
>
> -#if defined(__GNUC__) && !defined(__INTEL_COMPILER)
> +#if defined(__GNUC__)
>  #include "acgccex.h"
>
>  #elif defined(_MSC_VER)
> diff --git a/include/acpi/platform/acintel.h b/include/acpi/platform/acin=
tel.h
> deleted file mode 100644
> index 85b1ae86ee63..000000000000
> --- a/include/acpi/platform/acintel.h
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> -/***********************************************************************=
*******
> - *
> - * Name: acintel.h - VC specific defines, etc.
> - *
> - * Copyright (C) 2000 - 2022, Intel Corp.
> - *
> - ***********************************************************************=
******/
> -
> -#ifndef __ACINTEL_H__
> -#define __ACINTEL_H__
> -
> -/*
> - * Use compiler specific <stdarg.h> is a good practice for even when
> - * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
> - */
> -#ifndef va_arg
> -#include <stdarg.h>
> -#endif
> -
> -/* Configuration specific to Intel 64-bit C compiler */
> -
> -#define COMPILER_DEPENDENT_INT64    __int64
> -#define COMPILER_DEPENDENT_UINT64   unsigned __int64
> -#define ACPI_INLINE                 __inline
> -
> -/*
> - * Calling conventions:
> - *
> - * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, threads)
> - * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
> - * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
> - * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list interface=
s
> - */
> -#define ACPI_SYSTEM_XFACE
> -#define ACPI_EXTERNAL_XFACE
> -#define ACPI_INTERNAL_XFACE
> -#define ACPI_INTERNAL_VAR_XFACE
> -
> -/* remark 981 - operands evaluated in no particular order */
> -#pragma warning(disable:981)
> -
> -/* warn C4100: unreferenced formal parameter */
> -#pragma warning(disable:4100)
> -
> -/* warn C4127: conditional expression is constant */
> -#pragma warning(disable:4127)
> -
> -/* warn C4706: assignment within conditional expression */
> -#pragma warning(disable:4706)
> -
> -/* warn C4214: bit field types other than int */
> -#pragma warning(disable:4214)
> -
> -#endif                         /* __ACINTEL_H__ */
> diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-inte=
l.h
> deleted file mode 100644
> index b17f3cd18334..000000000000
> --- a/include/linux/compiler-intel.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __LINUX_COMPILER_TYPES_H
> -#error "Please don't include <linux/compiler-intel.h> directly, include =
<linux/compiler.h> instead."
> -#endif
> -
> -#ifdef __ECC
> -
> -/* Compiler specific definitions for Intel ECC compiler */
> -
> -#include <asm/intrinsics.h>
> -
> -/* Intel ECC compiler doesn't support gcc specific asm stmts.
> - * It uses intrinsics to do the equivalent things.
> - */
> -
> -#define barrier() __memory_barrier()
> -#define barrier_data(ptr) barrier()
> -
> -#define RELOC_HIDE(ptr, off)                                   \
> -  ({ unsigned long __ptr;                                      \
> -     __ptr =3D (unsigned long) (ptr);                            \
> -    (typeof(ptr)) (__ptr + (off)); })
> -
> -/* This should act as an optimization barrier on var.
> - * Given that this compiler does not have inline assembly, a compiler ba=
rrier
> - * is the best we can do.
> - */
> -#define OPTIMIZER_HIDE_VAR(var) barrier()
> -
> -#endif
> -
> -/* icc has this, but it's called _bswap16 */
> -#define __HAVE_BUILTIN_BSWAP16__
> -#define __builtin_bswap16 _bswap16
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler=
_attributes.h
> index 898b3458b24a..9221302f6ae8 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -64,16 +64,10 @@
>   * compiler should see some alignment anyway, when the return value is
>   * massaged by 'flags =3D ptr & 3; ptr &=3D ~3;').
>   *
> - * Optional: not supported by icc
> - *
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.=
html#index-assume_005faligned-function-attribute
>   * clang: https://clang.llvm.org/docs/AttributeReference.html#assume-ali=
gned
>   */
> -#if __has_attribute(__assume_aligned__)
> -# define __assume_aligned(a, ...)       __attribute__((__assume_aligned_=
_(a, ## __VA_ARGS__)))
> -#else
> -# define __assume_aligned(a, ...)
> -#endif
> +#define __assume_aligned(a, ...)        __attribute__((__assume_aligned_=
_(a, ## __VA_ARGS__)))
>
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.=
html#index-cold-function-attribute
> @@ -91,7 +85,6 @@
>  /*
>   * Optional: only supported since gcc >=3D 9
>   * Optional: not supported by clang
> - * Optional: not supported by icc
>   *
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.=
html#index-copy-function-attribute
>   */
> @@ -104,7 +97,6 @@
>  /*
>   * Optional: not supported by gcc
>   * Optional: only supported since clang >=3D 14.0
> - * Optional: not supported by icc
>   *
>   * clang: https://clang.llvm.org/docs/AttributeReference.html#diagnose_a=
s_builtin
>   */
> @@ -128,7 +120,6 @@
>
>  /*
>   * Optional: not supported by clang
> - * Optional: not supported by icc
>   *
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html=
#index-designated_005finit-type-attribute
>   */
> @@ -242,7 +233,6 @@
>  /*
>   * Optional: only supported since gcc >=3D 8
>   * Optional: not supported by clang
> - * Optional: not supported by icc
>   *
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.=
html#index-nonstring-variable-attribute
>   */
> @@ -273,7 +263,6 @@
>
>  /*
>   * Optional: not supported by gcc.
> - * Optional: not supported by icc.
>   *
>   * clang: https://clang.llvm.org/docs/AttributeReference.html#overloadab=
le
>   */
> @@ -293,7 +282,6 @@
>   * Note: the "type" argument should match any __builtin_object_size(p, t=
ype) usage.
>   *
>   * Optional: not supported by gcc.
> - * Optional: not supported by icc.
>   *
>   * clang: https://clang.llvm.org/docs/AttributeReference.html#pass-objec=
t-size-pass-dynamic-object-size
>   */
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
> index 74e04ecd4c89..0e06a1a79401 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -92,8 +92,6 @@ static inline void __chk_io_ptr(const volatile void __i=
omem *ptr) { }
>  /* Compiler specific macros. */
>  #ifdef __clang__
>  #include <linux/compiler-clang.h>
> -#elif defined(__INTEL_COMPILER)
> -#include <linux/compiler-intel.h>
>  #elif defined(__GNUC__)
>  /* The above compilers also define __GNUC__, so order is important here.=
 */
>  #include <linux/compiler-gcc.h>
> diff --git a/scripts/cc-version.sh b/scripts/cc-version.sh
> index 2401c86fcf53..0573c92e841d 100755
> --- a/scripts/cc-version.sh
> +++ b/scripts/cc-version.sh
> @@ -12,8 +12,6 @@ get_c_compiler_info()
>         cat <<- EOF | "$@" -E -P -x c - 2>/dev/null
>         #if defined(__clang__)
>         Clang   __clang_major__  __clang_minor__  __clang_patchlevel__
> -       #elif defined(__INTEL_COMPILER)
> -       ICC     __INTEL_COMPILER  __INTEL_COMPILER_UPDATE
>         #elif defined(__GNUC__)
>         GCC     __GNUC__  __GNUC_MINOR__  __GNUC_PATCHLEVEL__
>         #else
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index b6593eac5003..8766e248ffbb 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -19,10 +19,6 @@ binutils)
>  gcc)
>         echo 5.1.0
>         ;;
> -icc)
> -       # temporary
> -       echo 16.0.3
> -       ;;
>  llvm)
>         if [ "$SRCARCH" =3D s390 ]; then
>                 echo 14.0.0
> --
> 2.34.1
>


--=20
Best Regards
Masahiro Yamada
