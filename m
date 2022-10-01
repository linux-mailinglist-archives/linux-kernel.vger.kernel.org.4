Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25745F1E7C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 19:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJARxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 13:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJARxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 13:53:31 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4126160
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 10:53:30 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w13so7806522oiw.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wbtzj9Oow153p/L7yXUuSIhH5aOvTiCvDOeythim3lw=;
        b=iLnJAdQLxCXSXCM5NZqE3pyfuylMk2K+unihQxi7XFWh9XBCpcncWwVLnxcs9YPwQY
         E3J5SZRr65DQa/1l13tsFs+xRcNS/N+PYLcYy08JMWt8yFUV5Eqwu9TE1GyOCjNriU76
         y405aM+nC2wUhscaOgcZNbdx/PTzI8D6jMH5YUlaCZ0FhZ2+t5JXpp051pvctvHPkjMN
         XpGZud+i6i/QL826VqnIQGm25dP9zUMBzSEEJA+r7QFCyZLlBCCUl7z9kigKEPhapUtr
         mhXEnzmMWD1iEM8BkME7MAZRL8CFLqwDqdzYMdaf9VgqaicW3jsBQ3OOGb7sGJ0uNzY5
         pJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wbtzj9Oow153p/L7yXUuSIhH5aOvTiCvDOeythim3lw=;
        b=B3DippiloD3LqSkF69CI7QXTJIjsiTtQygF5SO0cyhUXpY1xpCWefI0D6HjTpTaBcl
         gEVRMBE5wYtvxo7zTtg2NcPb+5R9SW7tPdkfNHaJdhYKA9xzEqK7I2Xg6r3v99PAPW4Y
         9A3HoDpVsS5669dVqtcoY4M//+WnKTHj0gh76h6v0zfcENLcgcySP9fKFJ8YxDuxmbWP
         zHBcKqstDGINMikbnXmFTXqyu3tTxlZy9hsz8rmI8wmRP57y/Q+Aj78Cz35IdmIZaD5P
         a9MwSFJ3Y02xncxYsn9qFqWuq+W9biDpyeEQ7KXh1NjdTzarhTCkn5wpbBpY+F76HXmc
         F5ow==
X-Gm-Message-State: ACrzQf2kkfep6dCoY9F2YI+UieDgYRnhpHmddIFI8c+C418zFiHpkJwR
        YPXmtLqvcwD/BJF2QwPqDLhrVKtgvJr24E5bTjs=
X-Google-Smtp-Source: AMsMyM4jQn2h9HlpZD4yKjQcSns+CyNSZSm9XuP47cAyuogZK5Fx4ELZL8fO7MmFzKQz3aNhwEWcr7/pqi7TqwZCzhQ=
X-Received: by 2002:a05:6808:e8e:b0:34d:7829:135 with SMTP id
 k14-20020a0568080e8e00b0034d78290135mr1455186oil.252.1664646809207; Sat, 01
 Oct 2022 10:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <202210010918.4918F847C4@keescook>
In-Reply-To: <202210010918.4918F847C4@keescook>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 1 Oct 2022 19:52:53 +0200
Message-ID: <CA+icZUXmsoj0cu8y3KLF5RUPUeZTiCky-hB=ot-Di0+-dat2HQ@mail.gmail.com>
Subject: Re: [GIT PULL] kcfi updates for v6.1-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Moreira, Joao" <joao.moreira@intel.com>
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

On Sat, Oct 1, 2022 at 6:36 PM Kees Cook <keescook@chromium.org> wrote:
>
> Hi Linus,
>
> Please pull these Control Flow Integrity updates for v6.1-rc1. As this
> touches treewide things, arm64, and x86, I carried this tree instead of
> it living in -tip, etc. This replaces the more fragile Clang CFI with
> the new Clang KCFI that has been designed specifically for the Linux
> kernel. GCC support is expected[1] in the future.
>
> 3 expected conflicts are minimal:
>
> - arm64: https://lore.kernel.org/linux-next/20220927185911.512737-1-broonie@kernel.org/
>
> - bpf-next: https://lore.kernel.org/linux-next/20220927190811.514527-1-broonie@kernel.org/
>   Note that the above fix actually has a typo: the "))    ||" should be
>   ")    ||", which was later fixed in linux-next.
>
> - arm64-fixes: https://lore.kernel.org/linux-next/20220927190318.513999-1-broonie@kernel.org/
>   The conflicting commit in arm64-fixes is needed for a bug in the older
>   Clang CFI support. Merging arm64-fixes first may help resolve this
>   one in a way that is easier for -stable to consume (i.e. arm64-fixes
>   CFI fix lands, then the kcfi tree removes the block entirely), but
>   the CFI fix could also just be sent directly to -stable directly if
>   anything goes wrong.
>

I checked my long list of logs, journals and selfmade Linux (Debian)
packages in my Clang-CFI / KCFI testing.

My first email to Sami was (in private):

[Clang-ThinLTO][Clang-CFI] "[PATCH] x86/asm: Replace __force_order
with memory clobber"
Aug 25, 2020, 7:30 PM

My first tryouts was with Linux v5.9-rc1 and LLVM-11;

# grep cfi packages_*.txt | egrep 'llvm|clang' | sort | head -10
packages_0612.txt:ii linux-image-5.9.0-rc1-12-amd64-llvm11-cfi
5.9.0~rc1-12~bullseye+dileks1
...
packages_0625.txt:ii linux-image-5.9.0-rc2-4-amd64-llvm11-cfi
5.9.0~rc2-4~bullseye+dileks1
...

# LC_ALL=C ll packages_0612.txt packages_0625.txt
-rw-r--r-- 1 root root 95K Aug 23  2020 packages_0612.txt
-rw-r--r-- 1 root root 96K Aug 26  2020 packages_0625.txt

My first HOORAY was with a selfmade
linux-image-5.9.0-rc2-4-amd64-llvm11-cfi on 26-Aug-2020 - on bare
metal, of course.
Two years ago.

Today, we have Linux v6.0 FINAL and LLVM-15.0.2 coming ([1] has a KCFI
Git for LLVM-15)...

Time goes bye, so quickly...

Thanks to Sami and the LLVM/Clang maintainers and community!

-Sedat-

[1] https://github.com/samitolvanen/llvm-project/commits/15.x/kcfi

> Thanks!
>
> -Kees
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
>
> The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:
>
>   Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kcfi-v6.1-rc1
>
> for you to fetch changes up to 3c516f89e17e56b4738f05588e51267e295b5e63:
>
>   x86: Add support for CONFIG_CFI_CLANG (2022-09-26 10:13:16 -0700)
>
> ----------------------------------------------------------------
> kcfi updates for v6.1-rc1
>
> This replaces the prior support for Clang's standard Control Flow
> Integrity (CFI) instrumentation, which has required a lot of special
> conditions (e.g. LTO) and work-arounds. The current implementation
> ("Kernel CFI") is specific to C, directly designed for the Linux kernel,
> and takes advantage of architectural features like x86's IBT. This
> series retains arm64 support and adds x86 support. Additional "generic"
> architectural support is expected soon:
> https://github.com/samitolvanen/llvm-project/commits/kcfi_generic
>
> - treewide: Remove old CFI support details
>
> - arm64: Replace Clang CFI support with Clang KCFI support
>
> - x86: Introduce Clang KCFI support
>
> ----------------------------------------------------------------
> Sami Tolvanen (22):
>       treewide: Filter out CC_FLAGS_CFI
>       scripts/kallsyms: Ignore __kcfi_typeid_
>       cfi: Remove CONFIG_CFI_CLANG_SHADOW
>       cfi: Drop __CFI_ADDRESSABLE
>       cfi: Switch to -fsanitize=kcfi
>       cfi: Add type helper macros
>       lkdtm: Emit an indirect call for CFI tests
>       psci: Fix the function type for psci_initcall_t
>       arm64: Add types to indirect called assembly functions
>       arm64: Add CFI error handling
>       arm64: Drop unneeded __nocfi attributes
>       init: Drop __nocfi from __init
>       treewide: Drop function_nocfi
>       treewide: Drop WARN_ON_FUNCTION_MISMATCH
>       treewide: Drop __cficanonical
>       objtool: Preserve special st_shndx indexes in elf_update_symbol
>       objtool: Disable CFI warnings
>       kallsyms: Drop CONFIG_CFI_CLANG workarounds
>       x86/tools/relocs: Ignore __kcfi_typeid_ relocations
>       x86: Add types to indirectly called assembly functions
>       x86/purgatory: Disable CFI
>       x86: Add support for CONFIG_CFI_CLANG
>
>  Makefile                                  |  13 +-
>  arch/Kconfig                              |  18 +-
>  arch/arm64/crypto/ghash-ce-core.S         |   5 +-
>  arch/arm64/crypto/sm3-ce-core.S           |   3 +-
>  arch/arm64/include/asm/brk-imm.h          |   6 +
>  arch/arm64/include/asm/ftrace.h           |   2 +-
>  arch/arm64/include/asm/linkage.h          |   4 +
>  arch/arm64/include/asm/mmu_context.h      |   4 +-
>  arch/arm64/kernel/acpi_parking_protocol.c |   2 +-
>  arch/arm64/kernel/alternative.c           |   2 +-
>  arch/arm64/kernel/cpu-reset.S             |   5 +-
>  arch/arm64/kernel/cpufeature.c            |   4 +-
>  arch/arm64/kernel/ftrace.c                |   2 +-
>  arch/arm64/kernel/machine_kexec.c         |   2 +-
>  arch/arm64/kernel/psci.c                  |   2 +-
>  arch/arm64/kernel/smp_spin_table.c        |   2 +-
>  arch/arm64/kernel/traps.c                 |  47 +++-
>  arch/arm64/kernel/vdso/Makefile           |   3 +-
>  arch/arm64/mm/proc.S                      |   5 +-
>  arch/x86/Kconfig                          |   2 +
>  arch/x86/crypto/blowfish-x86_64-asm_64.S  |   5 +-
>  arch/x86/entry/vdso/Makefile              |   3 +-
>  arch/x86/include/asm/cfi.h                |  22 ++
>  arch/x86/include/asm/linkage.h            |  12 +
>  arch/x86/kernel/Makefile                  |   2 +
>  arch/x86/kernel/cfi.c                     |  86 ++++++++
>  arch/x86/kernel/traps.c                   |   4 +-
>  arch/x86/lib/memcpy_64.S                  |   3 +-
>  arch/x86/purgatory/Makefile               |   4 +
>  arch/x86/tools/relocs.c                   |   1 +
>  drivers/firmware/efi/libstub/Makefile     |   2 +
>  drivers/firmware/psci/psci.c              |  12 +-
>  drivers/misc/lkdtm/cfi.c                  |  15 +-
>  drivers/misc/lkdtm/usercopy.c             |   2 +-
>  include/asm-generic/bug.h                 |  16 --
>  include/asm-generic/vmlinux.lds.h         |  37 ++--
>  include/linux/cfi.h                       |  59 ++---
>  include/linux/cfi_types.h                 |  45 ++++
>  include/linux/compiler-clang.h            |  14 +-
>  include/linux/compiler.h                  |  16 +-
>  include/linux/compiler_types.h            |   4 -
>  include/linux/init.h                      |   6 +-
>  include/linux/module.h                    |  10 +-
>  include/linux/pci.h                       |   4 +-
>  kernel/cfi.c                              | 352 +++++-------------------------
>  kernel/kallsyms.c                         |  17 --
>  kernel/kthread.c                          |   3 +-
>  kernel/module/main.c                      |  50 +----
>  kernel/workqueue.c                        |   2 +-
>  scripts/kallsyms.c                        |   1 +
>  scripts/module.lds.S                      |  23 +-
>  tools/objtool/check.c                     |   7 +-
>  tools/objtool/elf.c                       |   7 +-
>  53 files changed, 425 insertions(+), 554 deletions(-)
>  create mode 100644 arch/x86/include/asm/cfi.h
>  create mode 100644 arch/x86/kernel/cfi.c
>  create mode 100644 include/linux/cfi_types.h
>
> --
> Kees Cook
