Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB95F1DAC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiJAQgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJAQgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:36:13 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981243679E
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:36:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 2so955227pgl.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=92N2Ht1F2FaR7SxU08Quf0BC91IoqSTlAVu8rCjKoQg=;
        b=EQWUzNe3kEwtg2qwArLh6WzNabcgn1Yw+aMtQu3yxvaJTYtD17x3wr6P5msj9YKdMQ
         L7dTHkNaru2aXKbPoiuVCN5surMfFEZoWTqnLuooE3QSc/dKtDU8x40M0AdLjxFtSVCI
         jktGfq7w2Ga+992p84P0EkTrFBhmk2ujK6gG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=92N2Ht1F2FaR7SxU08Quf0BC91IoqSTlAVu8rCjKoQg=;
        b=8Gsz4C9Gc0L2zcJ4OXG9Ecoqqno+0F7gTGvZ9UBf3/art23uJgtRhdmf2iPSkNUE62
         pwsx2DWG3Nok+FMVcEKcFCIeNypfKlyw6mAIEqya0uXbVRJm6WMdGq5h50m424xeO0mV
         82/jLjEBRrAeuYoFw2BArKQj+5gj9Q7Ceje+Si7o2eYrkZjWoYWFnP7UpoxuSPTUvPby
         arQDV9Ob3MJUrgnfhNCk3tQZqZwWzOGu8RcqxGkRH/juxJmZVQ32bYMlY3YuRY1fwlI+
         qEBD6YmuaL5VPllF0Z5DZZlLlP0cqC+jU299cVHXqaqJQZF7JDG5HtBRhVUQ/wf0swZy
         IC5Q==
X-Gm-Message-State: ACrzQf3HyDDWW4ySGOHSryRf7X1u4Gt/BysDuIF+cMRd1fiukNspVsZx
        QcjXWLzt8KMGdIFBEH3S77I7VQ==
X-Google-Smtp-Source: AMsMyM4WZtYW4eGFpnedG2kLdNlVq4TUdI9HK4v+ssIXwSESDG6R1WecyRSMcfR2Dqpdq+wOucM2Dg==
X-Received: by 2002:a05:6a00:f04:b0:547:50b1:4f4e with SMTP id cr4-20020a056a000f0400b0054750b14f4emr14751547pfb.69.1664642168014;
        Sat, 01 Oct 2022 09:36:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 7-20020a620507000000b0055de3e207c9sm2594240pff.35.2022.10.01.09.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 09:36:07 -0700 (PDT)
Date:   Sat, 1 Oct 2022 09:36:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>
Subject: [GIT PULL] kcfi updates for v6.1-rc1
Message-ID: <202210010918.4918F847C4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these Control Flow Integrity updates for v6.1-rc1. As this
touches treewide things, arm64, and x86, I carried this tree instead of
it living in -tip, etc. This replaces the more fragile Clang CFI with
the new Clang KCFI that has been designed specifically for the Linux
kernel. GCC support is expected[1] in the future.

3 expected conflicts are minimal:

- arm64: https://lore.kernel.org/linux-next/20220927185911.512737-1-broonie@kernel.org/

- bpf-next: https://lore.kernel.org/linux-next/20220927190811.514527-1-broonie@kernel.org/
  Note that the above fix actually has a typo: the "))    ||" should be
  ")    ||", which was later fixed in linux-next.

- arm64-fixes: https://lore.kernel.org/linux-next/20220927190318.513999-1-broonie@kernel.org/
  The conflicting commit in arm64-fixes is needed for a bug in the older
  Clang CFI support. Merging arm64-fixes first may help resolve this
  one in a way that is easier for -stable to consume (i.e. arm64-fixes
  CFI fix lands, then the kcfi tree removes the block entirely), but
  the CFI fix could also just be sent directly to -stable directly if
  anything goes wrong.

Thanks!

-Kees

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kcfi-v6.1-rc1

for you to fetch changes up to 3c516f89e17e56b4738f05588e51267e295b5e63:

  x86: Add support for CONFIG_CFI_CLANG (2022-09-26 10:13:16 -0700)

----------------------------------------------------------------
kcfi updates for v6.1-rc1

This replaces the prior support for Clang's standard Control Flow
Integrity (CFI) instrumentation, which has required a lot of special
conditions (e.g. LTO) and work-arounds. The current implementation
("Kernel CFI") is specific to C, directly designed for the Linux kernel,
and takes advantage of architectural features like x86's IBT. This
series retains arm64 support and adds x86 support. Additional "generic"
architectural support is expected soon:
https://github.com/samitolvanen/llvm-project/commits/kcfi_generic

- treewide: Remove old CFI support details

- arm64: Replace Clang CFI support with Clang KCFI support

- x86: Introduce Clang KCFI support

----------------------------------------------------------------
Sami Tolvanen (22):
      treewide: Filter out CC_FLAGS_CFI
      scripts/kallsyms: Ignore __kcfi_typeid_
      cfi: Remove CONFIG_CFI_CLANG_SHADOW
      cfi: Drop __CFI_ADDRESSABLE
      cfi: Switch to -fsanitize=kcfi
      cfi: Add type helper macros
      lkdtm: Emit an indirect call for CFI tests
      psci: Fix the function type for psci_initcall_t
      arm64: Add types to indirect called assembly functions
      arm64: Add CFI error handling
      arm64: Drop unneeded __nocfi attributes
      init: Drop __nocfi from __init
      treewide: Drop function_nocfi
      treewide: Drop WARN_ON_FUNCTION_MISMATCH
      treewide: Drop __cficanonical
      objtool: Preserve special st_shndx indexes in elf_update_symbol
      objtool: Disable CFI warnings
      kallsyms: Drop CONFIG_CFI_CLANG workarounds
      x86/tools/relocs: Ignore __kcfi_typeid_ relocations
      x86: Add types to indirectly called assembly functions
      x86/purgatory: Disable CFI
      x86: Add support for CONFIG_CFI_CLANG

 Makefile                                  |  13 +-
 arch/Kconfig                              |  18 +-
 arch/arm64/crypto/ghash-ce-core.S         |   5 +-
 arch/arm64/crypto/sm3-ce-core.S           |   3 +-
 arch/arm64/include/asm/brk-imm.h          |   6 +
 arch/arm64/include/asm/ftrace.h           |   2 +-
 arch/arm64/include/asm/linkage.h          |   4 +
 arch/arm64/include/asm/mmu_context.h      |   4 +-
 arch/arm64/kernel/acpi_parking_protocol.c |   2 +-
 arch/arm64/kernel/alternative.c           |   2 +-
 arch/arm64/kernel/cpu-reset.S             |   5 +-
 arch/arm64/kernel/cpufeature.c            |   4 +-
 arch/arm64/kernel/ftrace.c                |   2 +-
 arch/arm64/kernel/machine_kexec.c         |   2 +-
 arch/arm64/kernel/psci.c                  |   2 +-
 arch/arm64/kernel/smp_spin_table.c        |   2 +-
 arch/arm64/kernel/traps.c                 |  47 +++-
 arch/arm64/kernel/vdso/Makefile           |   3 +-
 arch/arm64/mm/proc.S                      |   5 +-
 arch/x86/Kconfig                          |   2 +
 arch/x86/crypto/blowfish-x86_64-asm_64.S  |   5 +-
 arch/x86/entry/vdso/Makefile              |   3 +-
 arch/x86/include/asm/cfi.h                |  22 ++
 arch/x86/include/asm/linkage.h            |  12 +
 arch/x86/kernel/Makefile                  |   2 +
 arch/x86/kernel/cfi.c                     |  86 ++++++++
 arch/x86/kernel/traps.c                   |   4 +-
 arch/x86/lib/memcpy_64.S                  |   3 +-
 arch/x86/purgatory/Makefile               |   4 +
 arch/x86/tools/relocs.c                   |   1 +
 drivers/firmware/efi/libstub/Makefile     |   2 +
 drivers/firmware/psci/psci.c              |  12 +-
 drivers/misc/lkdtm/cfi.c                  |  15 +-
 drivers/misc/lkdtm/usercopy.c             |   2 +-
 include/asm-generic/bug.h                 |  16 --
 include/asm-generic/vmlinux.lds.h         |  37 ++--
 include/linux/cfi.h                       |  59 ++---
 include/linux/cfi_types.h                 |  45 ++++
 include/linux/compiler-clang.h            |  14 +-
 include/linux/compiler.h                  |  16 +-
 include/linux/compiler_types.h            |   4 -
 include/linux/init.h                      |   6 +-
 include/linux/module.h                    |  10 +-
 include/linux/pci.h                       |   4 +-
 kernel/cfi.c                              | 352 +++++-------------------------
 kernel/kallsyms.c                         |  17 --
 kernel/kthread.c                          |   3 +-
 kernel/module/main.c                      |  50 +----
 kernel/workqueue.c                        |   2 +-
 scripts/kallsyms.c                        |   1 +
 scripts/module.lds.S                      |  23 +-
 tools/objtool/check.c                     |   7 +-
 tools/objtool/elf.c                       |   7 +-
 53 files changed, 425 insertions(+), 554 deletions(-)
 create mode 100644 arch/x86/include/asm/cfi.h
 create mode 100644 arch/x86/kernel/cfi.c
 create mode 100644 include/linux/cfi_types.h

-- 
Kees Cook
