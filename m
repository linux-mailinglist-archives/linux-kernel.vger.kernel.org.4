Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213746F1C47
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbjD1QJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjD1QJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:09:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5315E4E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:09:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so198320b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682698162; x=1685290162;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcwITyl7B7aWtvTq9Hih72gCunbXi/igXG+go8uAIWM=;
        b=clUvxnnz45DJ5mgyZGkwZS5xwHT8p+S/sGv1oayYvXCftLvLijJV5iQFS+UgEvM3vZ
         YWjhSB6GjHorIFW0eXSUITEofCe3wbx2P0AnMtOOEQ5e5I/enD+0q4XUZK50YUCpAN5C
         iOOok9mC+VcsgEh6EVwFMFdC4COmIcsve1HeL1UUSbGxPki38k7NU6B6cRjS+GXdEMTQ
         Ppp75qP3R7vmiMNcxV1jpwBdWlAQZZdu2koCrU0OabTrqDNhM1aUHnaBkdL4FteMJgvL
         7Yz18w4B4/pfrnPxqSwC+dM0cHQh3jg8Kw8mgGXbFJoynQihWpKuYZc7m+eGtHTB+nKI
         Ps9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682698162; x=1685290162;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcwITyl7B7aWtvTq9Hih72gCunbXi/igXG+go8uAIWM=;
        b=RiHbxkjMzdWDxps5vNS20PeDyAnwsbkQZr/ixF0q10aJVTd0p+zVxixDqsBRUC3Vdl
         7QZ8OD98e50wM7dVGoUq7OUKTHgr588SkSG3m5/V360CEviBhYdHP/7zwQCH1VBUJzOM
         gDFUo0c709+ehx902jUhWIBjr7d6rB+wkQjai+Rup6WFpa1lPgZAZdAfT7A0tCBOlPG9
         dzPsGB2fB7uDL5QWj4frE62NejnKYxY2D4WP5XoN7TQCVrJidKduOh1rYkN/0UIxFvjC
         QvOOhWvLna/pYKYnLZyOKDZcZIVwHMvBmlSGqEQopWWmq8ZF1LSnyi9LgtEnWR83XoVf
         2IQw==
X-Gm-Message-State: AC+VfDwi8OfkNpbHd+LPe26qHfNTxHGA+LjGXEI4Dhv7ZONDXfL0uXTw
        hTFFtx1UsdaG4B0wFYPbxkbNcg==
X-Google-Smtp-Source: ACHHUZ6y+Wgr5nXQFsXkg8FHV7SvHI8noRtp4AISyA3kcAM85Yi+Qyc09GrqjzLm5YEvSJlgnvFAhQ==
X-Received: by 2002:a05:6a00:1a92:b0:635:6603:2534 with SMTP id e18-20020a056a001a9200b0063566032534mr7312869pfv.14.1682698162187;
        Fri, 28 Apr 2023 09:09:22 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id n41-20020a056a000d6900b005e0699464e3sm15343235pfv.206.2023.04.28.09.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 09:09:21 -0700 (PDT)
Date:   Fri, 28 Apr 2023 09:09:21 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Apr 2023 09:08:32 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.4 Merge Window, Part 1
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-57198db1-de34-4dca-be9f-989b1137503e@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1ee7fc3f4d0a93831a20d5566f203d5ad6d44de8:

  RISC-V: always select RISCV_ALTERNATIVE for non-xip kernels (2023-03-29 11:48:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-mw1

for you to fetch changes up to b09313dd2e726fe5e1fa574cd73f5e326c6030a4:

  RISC-V: hwprobe: Explicity check for -1 in vdso init (2023-04-26 08:58:34 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.4 Merge Window, Part 1

* Support for runtime detection of the Svnapot extension.
* Support for Zicboz when clearing pages.
* We've moved to GENERIC_ENTRY.
* Support for !MMU on rv32 systems.
* The linear region is now mapped via huge pages.
* Support for building relocatable kernels.
* Support for the hwprobe interface.
* Various fixes and cleanups throughout the tree.

----------------------------------------------------------------
I'm definately going to have a second PR for the merge window, there's already
some fixes on the lists and there's some stragglers that I'm hoping can get
cleaned up in time.

I have two minor build issues, but otherwise this is clean.  The fixes are on
the lists
<https://lore.kernel.org/all/20230428152156.22840-1-palmer@rivosinc.com/>, but
I don't think they're directly relevant to this (and they're only manifesting
post-merge).

----------------------------------------------------------------
Alexandre Ghiti (16):
      riscv: Get rid of riscv_pfn_base variable
      riscv: Move the linear mapping creation in its own function
      riscv: Use PUD/P4D/PGD pages for the linear mapping
      riscv: Split early and final KASAN population functions
      riscv: Rework kasan population functions
      riscv: Move DTB_EARLY_BASE_VA to the kernel address space
      riscv: Fix EFI stub usage of KASAN instrumented strcmp function
      riscv: Fix ptdump when KASAN is enabled
      riscv: Unconditionnally select KASAN_VMALLOC if KASAN
      riscv: Prepare EFI header for relocatable kernels
      riscv: Move .rela.dyn outside of init to avoid empty relocations
      riscv: Introduce CONFIG_RELOCATABLE
      powerpc: Move script to check relocations at compile time in scripts/
      riscv: Check relocations at compile time
      riscv: Use --emit-relocs in order to move .rela.dyn in init
      riscv: Allow to downgrade paging mode from the command line

Andrew Jones (16):
      riscv: Clarify RISCV_ALTERNATIVE help text
      riscv: Rename Kconfig.erratas to Kconfig.errata
      riscv: alternatives: Remove unnecessary define and unused struct
      riscv: alternatives: Rename errata_id to patch_id
      riscv: lib: Include hwcap.h directly
      riscv: cpufeature: Drop errata_list.h and other unused includes
      RISC-V: alternatives: Support patching multiple insns in assembly
      RISC-V: Factor out body of riscv_init_cbom_blocksize loop
      dt-bindings: riscv: Document cboz-block-size
      RISC-V: Add Zicboz detection and block size parsing
      RISC-V: cpufeatures: Put the upper 16 bits of patch ID to work
      RISC-V: Use Zicboz in clear_page when available
      RISC-V: KVM: Provide UAPI for Zicboz block size
      RISC-V: KVM: Expose Zicboz to the guest
      RISC-V: hwprobe: There can only be one first
      RISC-V: hwprobe: Explicity check for -1 in vdso init

Björn Töpel (1):
      riscv: entry: Save a0 prior syscall_enter_from_user_mode()

Conor Dooley (3):
      RISC-V: convert new selectors of RISCV_ALTERNATIVE to dependencies
      RISC-V: align ISA extension Kconfig help text with each other
      dt-bindings: riscv: add sv57 mmu-type

Evan Green (7):
      RISC-V: Move struct riscv_cpuinfo to new header
      RISC-V: Add a syscall for HW probing
      RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
      RISC-V: hwprobe: Support probing of misaligned access performance
      selftests: Test the new RISC-V hwprobe interface
      RISC-V: Add hwprobe vDSO function and data
      RISC-V: hwprobe: Remove __init on probe_vendor_features()

Guo Ren (3):
      riscv: ptrace: Remove duplicate operation
      riscv: entry: Add noinstr to prevent instrumentation inserted
      riscv: entry: Convert to generic entry

Jesse Taube (1):
      riscv: configs: Add nommu PHONY defconfig for RV32

Jisheng Zhang (3):
      riscv: entry: Remove extra level wrappers of trace_hardirqs_{on,off}
      riscv: entry: Consolidate ret_from_kernel_thread into ret_from_fork
      riscv: entry: Consolidate general regs saving/restoring

Palmer Dabbelt (10):
      Merge patch series "riscv, mm: detect svnapot cpu support at runtime"
      Merge patch series "riscv: alternative/cpufeature related cleanups"
      Merge patch series "RISC-V: Apply Zicboz to clear_page"
      Merge patch series "riscv: Add GENERIC_ENTRY support"
      Merge patch series "Add RISC-V 32 NOMMU support"
      Merge patch series "RISC-V: Fixes for riscv_has_extension[un]likely()'s alternative dependency"
      Merge patch series "RISC-V Hardware Probing User Interface"
      Merge patch series "riscv: Use PUD/P4D/PGD pages for the linear mapping"
      Merge patch series "RISC-V kasan rework"
      Merge patch series "Introduce 64b relocatable kernel"

Qinglin Pan (3):
      riscv: mm: modify pte format for Svnapot
      riscv: mm: support Svnapot in hugetlb page
      riscv: mm: support Svnapot in huge vmap

Song Shuai (3):
      Revert "riscv: Set more data to cacheinfo"
      riscv: export cpu/freq invariant to scheduler
      riscv: Kconfig: enable SCHED_MC kconfig

Yimin Gu (1):
      riscv: Kconfig: Allow RV32 to build with no MMU

 Documentation/admin-guide/kernel-parameters.txt    |   5 +-
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   6 +
 Documentation/riscv/hwprobe.rst                    |  86 ++++
 Documentation/riscv/index.rst                      |   1 +
 arch/powerpc/tools/relocs_check.sh                 |  18 +-
 arch/riscv/Kconfig                                 |  78 +++-
 arch/riscv/{Kconfig.erratas => Kconfig.errata}     |   0
 arch/riscv/Makefile                                |  12 +-
 arch/riscv/Makefile.postlink                       |  49 ++
 arch/riscv/boot/Makefile                           |   7 +
 arch/riscv/errata/sifive/errata.c                  |   8 +-
 arch/riscv/errata/thead/errata.c                   |  14 +-
 arch/riscv/include/asm/alternative-macros.h        |  72 +--
 arch/riscv/include/asm/alternative.h               |  20 +-
 arch/riscv/include/asm/asm-prototypes.h            |   2 +
 arch/riscv/include/asm/asm.h                       |  61 +++
 arch/riscv/include/asm/cacheflush.h                |   3 +-
 arch/riscv/include/asm/cpufeature.h                |  23 +
 arch/riscv/include/asm/csr.h                       |   1 -
 arch/riscv/include/asm/entry-common.h              |  11 +
 arch/riscv/include/asm/hugetlb.h                   |  34 +-
 arch/riscv/include/asm/hwcap.h                     |   2 +
 arch/riscv/include/asm/hwprobe.h                   |  13 +
 arch/riscv/include/asm/insn-def.h                  |   4 +
 arch/riscv/include/asm/page.h                      |  30 +-
 arch/riscv/include/asm/pgtable-64.h                |  34 ++
 arch/riscv/include/asm/pgtable.h                   |  39 +-
 arch/riscv/include/asm/ptrace.h                    |  10 +-
 arch/riscv/include/asm/set_memory.h                |   3 +
 arch/riscv/include/asm/stacktrace.h                |   5 +
 arch/riscv/include/asm/syscall.h                   |  25 +
 arch/riscv/include/asm/thread_info.h               |  13 +-
 arch/riscv/include/asm/topology.h                  |  21 +
 arch/riscv/include/asm/vdso/data.h                 |  17 +
 arch/riscv/include/asm/vdso/gettimeofday.h         |   8 +
 arch/riscv/include/asm/vmalloc.h                   |  61 ++-
 arch/riscv/include/uapi/asm/hwprobe.h              |  37 ++
 arch/riscv/include/uapi/asm/kvm.h                  |   2 +
 arch/riscv/include/uapi/asm/unistd.h               |   9 +
 arch/riscv/kernel/Makefile                         |   4 +-
 arch/riscv/kernel/alternative.c                    |  21 +-
 arch/riscv/kernel/cacheinfo.c                      |  66 +--
 arch/riscv/kernel/compat_vdso/Makefile             |   2 +-
 arch/riscv/kernel/cpu.c                            |  10 +-
 arch/riscv/kernel/cpufeature.c                     |  67 ++-
 arch/riscv/kernel/efi-header.S                     |  19 +-
 arch/riscv/kernel/entry.S                          | 321 ++-----------
 arch/riscv/kernel/head.h                           |   1 -
 arch/riscv/kernel/image-vars.h                     |   2 -
 arch/riscv/kernel/mcount-dyn.S                     |  57 +--
 arch/riscv/kernel/pi/Makefile                      |  39 ++
 arch/riscv/kernel/pi/cmdline_early.c               |  62 +++
 arch/riscv/kernel/process.c                        |   5 +-
 arch/riscv/kernel/ptrace.c                         |  44 --
 arch/riscv/kernel/setup.c                          |   2 +-
 arch/riscv/kernel/signal.c                         |  29 +-
 arch/riscv/kernel/smpboot.c                        |   1 +
 arch/riscv/kernel/sys_riscv.c                      | 230 ++++++++-
 arch/riscv/kernel/trace_irq.c                      |  27 --
 arch/riscv/kernel/trace_irq.h                      |  11 -
 arch/riscv/kernel/traps.c                          | 144 +++++-
 arch/riscv/kernel/vdso.c                           |   6 -
 arch/riscv/kernel/vdso/Makefile                    |   4 +
 arch/riscv/kernel/vdso/hwprobe.c                   |  52 +++
 arch/riscv/kernel/vdso/sys_hwprobe.S               |  15 +
 arch/riscv/kernel/vdso/vdso.lds.S                  |   3 +
 arch/riscv/kernel/vmlinux.lds.S                    |  35 +-
 arch/riscv/kvm/vcpu.c                              |  11 +
 arch/riscv/lib/Makefile                            |   1 +
 arch/riscv/lib/clear_page.S                        |  74 +++
 arch/riscv/lib/memcpy.S                            |   2 +
 arch/riscv/lib/memmove.S                           |   2 +
 arch/riscv/lib/strcmp.S                            |   3 +-
 arch/riscv/lib/strlen.S                            |   4 +-
 arch/riscv/lib/strncmp.S                           |   3 +-
 arch/riscv/mm/Makefile                             |   4 +
 arch/riscv/mm/cacheflush.c                         |  64 +--
 arch/riscv/mm/fault.c                              |   6 +-
 arch/riscv/mm/hugetlbpage.c                        | 301 ++++++++++++
 arch/riscv/mm/init.c                               | 194 ++++++--
 arch/riscv/mm/kasan_init.c                         | 516 ++++++++++++---------
 arch/riscv/mm/physaddr.c                           |  16 +
 arch/riscv/mm/ptdump.c                             |  24 +-
 arch/riscv/tools/relocs_check.sh                   |  26 ++
 drivers/of/fdt.c                                   |  11 +-
 scripts/relocs_check.sh                            |  20 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/riscv/Makefile             |  58 +++
 tools/testing/selftests/riscv/hwprobe/Makefile     |  10 +
 tools/testing/selftests/riscv/hwprobe/hwprobe.c    |  90 ++++
 .../testing/selftests/riscv/hwprobe/sys_hwprobe.S  |  12 +
 91 files changed, 2589 insertions(+), 987 deletions(-)
 create mode 100644 Documentation/riscv/hwprobe.rst
 rename arch/riscv/{Kconfig.erratas => Kconfig.errata} (100%)
 create mode 100644 arch/riscv/Makefile.postlink
 create mode 100644 arch/riscv/include/asm/cpufeature.h
 create mode 100644 arch/riscv/include/asm/entry-common.h
 create mode 100644 arch/riscv/include/asm/hwprobe.h
 create mode 100644 arch/riscv/include/asm/topology.h
 create mode 100644 arch/riscv/include/asm/vdso/data.h
 create mode 100644 arch/riscv/include/uapi/asm/hwprobe.h
 create mode 100644 arch/riscv/kernel/pi/Makefile
 create mode 100644 arch/riscv/kernel/pi/cmdline_early.c
 delete mode 100644 arch/riscv/kernel/trace_irq.c
 delete mode 100644 arch/riscv/kernel/trace_irq.h
 create mode 100644 arch/riscv/kernel/vdso/hwprobe.c
 create mode 100644 arch/riscv/kernel/vdso/sys_hwprobe.S
 create mode 100644 arch/riscv/lib/clear_page.S
 create mode 100755 arch/riscv/tools/relocs_check.sh
 create mode 100755 scripts/relocs_check.sh
 create mode 100644 tools/testing/selftests/riscv/Makefile
 create mode 100644 tools/testing/selftests/riscv/hwprobe/Makefile
 create mode 100644 tools/testing/selftests/riscv/hwprobe/hwprobe.c
 create mode 100644 tools/testing/selftests/riscv/hwprobe/sys_hwprobe.S
