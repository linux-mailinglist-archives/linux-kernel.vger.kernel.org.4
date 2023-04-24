Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B116ED4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjDXSrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjDXSrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:47:02 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1296183;
        Mon, 24 Apr 2023 11:46:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3BBC7735;
        Mon, 24 Apr 2023 18:46:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3BBC7735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1682362018; bh=/JVPOAIBeTwxJLXXP0dzK24lywmxIgI20AGUbsi1iCI=;
        h=From:To:Cc:Subject:Date:From;
        b=lRgWdNhZIwXGXEYULYZgFo7+eO3rYEmAF2Cl6Hgk8jEvO9oU+dfRljGAPrC1t9mkq
         gglIp9oZjsa6iGBACevv/GCBUYmeqz1nci3nWvOcXCJyeWv33WF+BooOHrbtuyeDOX
         5Ewizz7O2oMUL9Wnyon6RAOitcHJHHLtHStE8k9txekep3x4UT2+U/YxdykhyYbXw8
         KndAw7AIcdPYyqlsNetTX6q8gZmN/+8s+QrHnLwEbq22wX4QkBkrBJX22Lj/qTPojE
         7ixh9u2KmtJjSnD8lSYB0wba6BMUGMaWWbBS4pkCigE8KDahBzt/rDMAWZAH9NZzY0
         tTylBoC/XXRtw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.4
Date:   Mon, 24 Apr 2023 12:46:57 -0600
Message-ID: <87edo9m82m.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d7ba3657d5162bd551e5c653f67f941c94a7dc0a:

  docs: vfio: fix header path (2023-03-14 11:31:57 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.4

for you to fetch changes up to 7e8472c820f04517ae5d5a27c1aecfa2263a0aa5:

  media: Adjust column width for pdfdocs (2023-04-23 09:25:52 -0600)

----------------------------------------------------------------
Commit volume in documentation is relatively low this time, but there is
still a fair amount going on, including:

- Reorganizing the architecture-specific documentation under
  Documentation/arch.  This makes the structure match the source directory
  and helps to clean up the mess that is the top-level Documentation
  directory a bit.  This work creates the new directory and moves x86 and
  most of the less-active architectures there.  The current plan is to move
  the rest of the architectures in 6.5, with the patches going through the
  appropriate subsystem trees.

- Some more Spanish translations and maintenance of the Italian
  translation.

- A new "Kernel contribution maturity model" document from Ted.

- A new tutorial on quickly building a trimmed kernel from Thorsten.

Plus the usual set of updates and fixes.

----------------------------------------------------------------

There will be minor conflicts with the x86 and driver-core trees.  In the
x86 case, the only fallout from the directory move comes from the addition
of shstk.rst in the shadow-stack series.  In the merges I've done (and
linux-next too), all that was needed was to manually "git add" the new file
under Documentation/arch/

The driver-core tree moved security-bugs.rst to the process directory,
generating a trivial conflict on Documentation/admin-guide/index.rst.

Akira Yokosawa (2):
      docs/sp_SP: Remove ZERO WIDTH SPACE in memory-barriers.txt
      media: Adjust column width for pdfdocs

Alain Volmat (1):
      Documentation: arm: remove stih415/stih416 related entries

Alexander Mikhalitsyn (2):
      docs: filesystems: vfs: actualize struct file_system_type description
      docs: filesystems: vfs: actualize struct super_operations description

Alexey Dobriyan (1):
      ELF: document some de-facto PT_* ABI quirks

Bagas Sanjaya (2):
      Documentation: maintainer-tip: Rectify link to "Describe your changes" section of submitting-patches.rst
      Documentation: kernel-parameters: Remove meye entry

Brian Masney (1):
      docs: clk: add documentation to log which clocks have been disabled

Carlos Bilbao (2):
      docs/sp_SP: Add translation of process/deprecated
      docs: Add relevant kernel publications to list of books

Federico Vaga (2):
      doc:it_IT: translation alignment
      doc:it_IT: translation alignment

Feng Tang (1):
      Documentation: Add document for false sharing

Florian Fainelli (1):
      Documentation: firmware: Clarify firmware path usage

Jakub Wilk (1):
      coding-style: fix title of Greg K-H's talk

Jonathan Corbet (13):
      docs: create a top-level arch/ directory
      docs: move x86 documentation into Documentation/arch/
      docs: zh_CN: create the architecture-specific top-level directory
      docs: move xtensa documentation under Documentation/arch/
      docs: move sparc documentation under Documentation/arch/
      docs: move superh documentation under Documentation/arch/
      docs: move openrisc documentation under Documentation/arch/
      docs: move nios2 documentation under Documentation/arch/
      docs: Move arc architecture docs under Documentation/arch/
      docs: move ia64 architecture docs under Documentation/arch/
      docs: move parisc documentation under Documentation/arch/
      docs: move m68k architecture documentation under Documentation/arch/
      docs: turn off "smart quotes" in the HTML build

Kim Phillips (1):
      docs/mm: Physical Memory: Fix grammar

Krzysztof Kozlowski (1):
      Documentation/process: always CC responsible lists

Lin Yu Chen (1):
      docs: trace: Fix typo in ftrace.rst

Lukas Bulwahn (5):
      MAINTAINERS: remove historic section DEVICE NUMBER REGISTRY
      docs: admin: unicode: update information on state of lanana.org document
      qnx6: credit contributor and mark filesystem orphan
      qnx4: credit contributors in CREDITS
      docs: kmemleak: adjust to config renaming

Michael S. Tsirkin (1):
      dma-api-howto: typo fix

Mike Rapoport (IBM) (1):
      docs/mm: Physical Memory: add example of interleaving nodes

Randy Dunlap (3):
      Documentation: fs/proc: corrections and update
      Documentation: kernel-parameters: sort NFS parameters
      Documentation: kernel-parameters: sort all "no..." parameters

Theodore Ts'o (1):
      Documentation/process: Add Linux Kernel Contribution Maturity Model

Thorsten Leemhuis (1):
      docs: describe how to quickly build a trimmed kernel

Tomi Valkeinen (1):
      media: Fix building pdfdocs

Tony Luck (1):
      Documentation/x86: Update split lock documentation

Zang Leigang (1):
      docs/zh_CN: fix a wrong format

 CREDITS                                            |   16 +
 Documentation/admin-guide/hw-vuln/mds.rst          |    2 +-
 .../admin-guide/hw-vuln/tsx_async_abort.rst        |    2 +-
 Documentation/admin-guide/index.rst                |    1 +
 Documentation/admin-guide/kernel-parameters.rst    |    8 +-
 Documentation/admin-guide/kernel-parameters.txt    |  341 +++---
 .../admin-guide/quickly-build-trimmed-linux.rst    | 1092 ++++++++++++++++++++
 Documentation/admin-guide/ras.rst                  |    2 +-
 Documentation/admin-guide/sysctl/kernel.rst        |    4 +-
 Documentation/admin-guide/unicode.rst              |    9 +-
 Documentation/{ => arch}/arc/arc.rst               |    0
 Documentation/{ => arch}/arc/features.rst          |    0
 Documentation/{ => arch}/arc/index.rst             |    0
 Documentation/{ => arch}/ia64/aliasing.rst         |    0
 Documentation/{ => arch}/ia64/efirtc.rst           |    0
 Documentation/{ => arch}/ia64/err_inject.rst       |    0
 Documentation/{ => arch}/ia64/features.rst         |    0
 Documentation/{ => arch}/ia64/fsys.rst             |    0
 Documentation/{ => arch}/ia64/ia64.rst             |    0
 Documentation/{ => arch}/ia64/index.rst            |    0
 Documentation/{ => arch}/ia64/irq-redir.rst        |    0
 Documentation/{ => arch}/ia64/mca.rst              |    0
 Documentation/{ => arch}/ia64/serial.rst           |    0
 Documentation/{arch.rst => arch/index.rst}         |   14 +-
 Documentation/{ => arch}/m68k/buddha-driver.rst    |    0
 Documentation/{ => arch}/m68k/features.rst         |    0
 Documentation/{ => arch}/m68k/index.rst            |    0
 Documentation/{ => arch}/m68k/kernel-options.rst   |    0
 Documentation/{ => arch}/nios2/features.rst        |    0
 Documentation/{ => arch}/nios2/index.rst           |    0
 Documentation/{ => arch}/nios2/nios2.rst           |    0
 Documentation/{ => arch}/openrisc/features.rst     |    0
 Documentation/{ => arch}/openrisc/index.rst        |    0
 .../{ => arch}/openrisc/openrisc_port.rst          |    0
 Documentation/{ => arch}/openrisc/todo.rst         |    0
 Documentation/{ => arch}/parisc/debugging.rst      |    0
 Documentation/{ => arch}/parisc/features.rst       |    0
 Documentation/{ => arch}/parisc/index.rst          |    0
 Documentation/{ => arch}/parisc/registers.rst      |    0
 Documentation/{ => arch}/sh/booting.rst            |    0
 Documentation/{ => arch}/sh/features.rst           |    0
 Documentation/{ => arch}/sh/index.rst              |    0
 Documentation/{ => arch}/sh/new-machine.rst        |    0
 Documentation/{ => arch}/sh/register-banks.rst     |    0
 Documentation/{ => arch}/sparc/adi.rst             |    0
 Documentation/{ => arch}/sparc/console.rst         |    0
 Documentation/{ => arch}/sparc/features.rst        |    0
 Documentation/{ => arch}/sparc/index.rst           |    0
 .../{ => arch}/sparc/oradax/dax-hv-api.txt         |    0
 .../{ => arch}/sparc/oradax/oracle-dax.rst         |    0
 .../{ => arch}/x86/amd-memory-encryption.rst       |    0
 Documentation/{ => arch}/x86/amd_hsmp.rst          |    0
 Documentation/{ => arch}/x86/boot.rst              |    4 +-
 Documentation/{ => arch}/x86/booting-dt.rst        |    2 +-
 Documentation/{ => arch}/x86/buslock.rst           |   10 +-
 Documentation/{ => arch}/x86/cpuinfo.rst           |    0
 Documentation/{ => arch}/x86/earlyprintk.rst       |    0
 Documentation/{ => arch}/x86/elf_auxvec.rst        |    0
 Documentation/{ => arch}/x86/entry_64.rst          |    0
 Documentation/{ => arch}/x86/exception-tables.rst  |    0
 Documentation/{ => arch}/x86/features.rst          |    0
 Documentation/{ => arch}/x86/i386/IO-APIC.rst      |    0
 Documentation/{ => arch}/x86/i386/index.rst        |    0
 Documentation/{ => arch}/x86/ifs.rst               |    0
 Documentation/{ => arch}/x86/index.rst             |    0
 Documentation/{ => arch}/x86/intel-hfi.rst         |    0
 Documentation/{ => arch}/x86/intel_txt.rst         |    0
 Documentation/{ => arch}/x86/iommu.rst             |    0
 Documentation/{ => arch}/x86/kernel-stacks.rst     |    0
 Documentation/{ => arch}/x86/mds.rst               |    0
 Documentation/{ => arch}/x86/microcode.rst         |    0
 Documentation/{ => arch}/x86/mtrr.rst              |    2 +-
 Documentation/{ => arch}/x86/orc-unwinder.rst      |    0
 Documentation/{ => arch}/x86/pat.rst               |    0
 Documentation/{ => arch}/x86/pti.rst               |    0
 Documentation/{ => arch}/x86/resctrl.rst           |    0
 Documentation/{ => arch}/x86/sgx.rst               |    0
 Documentation/{ => arch}/x86/sva.rst               |    0
 Documentation/{ => arch}/x86/tdx.rst               |    0
 Documentation/{ => arch}/x86/tlb.rst               |    0
 Documentation/{ => arch}/x86/topology.rst          |    0
 Documentation/{ => arch}/x86/tsx_async_abort.rst   |    0
 .../{ => arch}/x86/usb-legacy-support.rst          |    0
 .../{ => arch}/x86/x86_64/5level-paging.rst        |    2 +-
 .../{ => arch}/x86/x86_64/boot-options.rst         |    4 +-
 .../{ => arch}/x86/x86_64/cpu-hotplug-spec.rst     |    0
 .../x86/x86_64/fake-numa-for-cpusets.rst           |    2 +-
 Documentation/{ => arch}/x86/x86_64/fsgs.rst       |    0
 Documentation/{ => arch}/x86/x86_64/index.rst      |    0
 .../{ => arch}/x86/x86_64/machinecheck.rst         |    0
 Documentation/{ => arch}/x86/x86_64/mm.rst         |    0
 Documentation/{ => arch}/x86/x86_64/uefi.rst       |    0
 Documentation/{ => arch}/x86/xstate.rst            |    0
 Documentation/{ => arch}/x86/zero-page.rst         |    0
 Documentation/{ => arch}/xtensa/atomctl.rst        |    0
 Documentation/{ => arch}/xtensa/booting.rst        |    0
 Documentation/{ => arch}/xtensa/features.rst       |    0
 Documentation/{ => arch}/xtensa/index.rst          |    0
 Documentation/{ => arch}/xtensa/mmu.rst            |    0
 Documentation/arm/index.rst                        |    2 -
 Documentation/arm/sti/overview.rst                 |   10 +-
 Documentation/arm/sti/stih415-overview.rst         |   14 -
 Documentation/arm/sti/stih416-overview.rst         |   13 -
 Documentation/conf.py                              |    7 +-
 Documentation/core-api/asm-annotations.rst         |    2 +-
 Documentation/core-api/dma-api-howto.rst           |    2 +-
 Documentation/dev-tools/kmemleak.rst               |    2 +-
 Documentation/driver-api/clk.rst                   |    5 +
 Documentation/driver-api/device-io.rst             |    2 +-
 .../driver-api/firmware/fw_search_path.rst         |    9 +-
 Documentation/filesystems/proc.rst                 |   44 +-
 Documentation/filesystems/vfs.rst                  |  105 +-
 Documentation/index.rst                            |    2 +-
 Documentation/kernel-hacking/false-sharing.rst     |  206 ++++
 Documentation/kernel-hacking/index.rst             |    1 +
 Documentation/mm/physical_memory.rst               |   21 +-
 Documentation/process/coding-style.rst             |    2 +-
 .../process/contribution-maturity-model.rst        |  109 ++
 Documentation/process/index.rst                    |    1 +
 Documentation/process/kernel-docs.rst              |   36 +-
 Documentation/process/maintainer-tip.rst           |    4 +-
 Documentation/process/submitting-patches.rst       |   19 +-
 Documentation/trace/ftrace.rst                     |    2 +-
 .../it_IT/core-api/symbol-namespaces.rst           |    3 +-
 .../translations/it_IT/doc-guide/parse-headers.rst |    5 +-
 Documentation/translations/it_IT/index.rst         |   47 +-
 .../translations/it_IT/kernel-hacking/locking.rst  |    5 +
 .../translations/it_IT/process/5.Posting.rst       |   13 +-
 .../translations/it_IT/process/changes.rst         |    4 +-
 .../translations/it_IT/process/clang-format.rst    |    2 +-
 .../translations/it_IT/process/coding-style.rst    |    6 +-
 .../translations/it_IT/process/deprecated.rst      |   29 +-
 .../translations/it_IT/process/email-clients.rst   |   25 +
 Documentation/translations/it_IT/process/index.rst |    1 +
 .../it_IT/process/maintainer-pgp-guide.rst         |  348 +++----
 .../it_IT/process/programming-language.rst         |   25 +-
 .../it_IT/process/stable-kernel-rules.rst          |    6 +
 .../it_IT/process/submitting-patches.rst           |    4 +-
 .../it_IT/process/volatile-considered-harmful.rst  |    4 +-
 .../translations/sp_SP/memory-barriers.txt         |    2 +-
 .../translations/sp_SP/process/deprecated.rst      |  381 +++++++
 Documentation/translations/sp_SP/process/index.rst |    1 +
 .../zh_CN/admin-guide/mm/damon/lru_sort.rst        |    2 +-
 .../zh_CN/{arch.rst => arch/index.rst}             |    8 +-
 .../zh_CN/{ => arch}/openrisc/index.rst            |    4 +-
 .../zh_CN/{ => arch}/openrisc/openrisc_port.rst    |    4 +-
 .../zh_CN/{ => arch}/openrisc/todo.rst             |    4 +-
 .../zh_CN/{ => arch}/parisc/debugging.rst          |    4 +-
 .../translations/zh_CN/{ => arch}/parisc/index.rst |    4 +-
 .../zh_CN/{ => arch}/parisc/registers.rst          |    4 +-
 Documentation/translations/zh_CN/index.rst         |    2 +-
 Documentation/userspace-api/ELF.rst                |   34 +
 Documentation/userspace-api/index.rst              |    1 +
 .../userspace-api/media/v4l/pixfmt-rgb.rst         |    5 +-
 Documentation/virt/kvm/api.rst                     |    2 +-
 MAINTAINERS                                        |   42 +-
 arch/arm/Kconfig                                   |    2 +-
 arch/ia64/kernel/efi.c                             |    2 +-
 arch/ia64/kernel/fsys.S                            |    2 +-
 arch/ia64/mm/ioremap.c                             |    2 +-
 arch/ia64/pci/pci.c                                |    2 +-
 arch/m68k/Kconfig.machine                          |    4 +-
 arch/sh/Kconfig.cpu                                |    2 +-
 arch/x86/Kconfig                                   |   10 +-
 arch/x86/Kconfig.debug                             |    2 +-
 arch/x86/boot/header.S                             |    2 +-
 arch/x86/entry/entry_64.S                          |    2 +-
 arch/x86/include/asm/bootparam_utils.h             |    2 +-
 arch/x86/include/asm/page_64_types.h               |    2 +-
 arch/x86/include/asm/pgtable_64_types.h            |    2 +-
 arch/x86/kernel/cpu/microcode/amd.c                |    2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c              |    2 +-
 arch/x86/kernel/cpu/sgx/sgx.h                      |    2 +-
 arch/x86/kernel/kexec-bzimage64.c                  |    2 +-
 arch/x86/kernel/pci-dma.c                          |    2 +-
 arch/x86/mm/pat/set_memory.c                       |    2 +-
 arch/x86/mm/tlb.c                                  |    2 +-
 arch/x86/platform/pvh/enlighten.c                  |    2 +-
 arch/xtensa/include/asm/initialize_mmu.h           |    2 +-
 drivers/sbus/char/oradax.c                         |    2 +-
 drivers/vhost/vhost.c                              |    2 +-
 fs/qnx4/README                                     |    9 -
 fs/qnx6/README                                     |    8 -
 security/Kconfig                                   |    2 +-
 tools/include/linux/err.h                          |    2 +-
 tools/objtool/Documentation/objtool.txt            |    2 +-
 186 files changed, 2622 insertions(+), 629 deletions(-)
 create mode 100644 Documentation/admin-guide/quickly-build-trimmed-linux.rst
 rename Documentation/{ => arch}/arc/arc.rst (100%)
 rename Documentation/{ => arch}/arc/features.rst (100%)
 rename Documentation/{ => arch}/arc/index.rst (100%)
 rename Documentation/{ => arch}/ia64/aliasing.rst (100%)
 rename Documentation/{ => arch}/ia64/efirtc.rst (100%)
 rename Documentation/{ => arch}/ia64/err_inject.rst (100%)
 rename Documentation/{ => arch}/ia64/features.rst (100%)
 rename Documentation/{ => arch}/ia64/fsys.rst (100%)
 rename Documentation/{ => arch}/ia64/ia64.rst (100%)
 rename Documentation/{ => arch}/ia64/index.rst (100%)
 rename Documentation/{ => arch}/ia64/irq-redir.rst (100%)
 rename Documentation/{ => arch}/ia64/mca.rst (100%)
 rename Documentation/{ => arch}/ia64/serial.rst (100%)
 rename Documentation/{arch.rst => arch/index.rst} (72%)
 rename Documentation/{ => arch}/m68k/buddha-driver.rst (100%)
 rename Documentation/{ => arch}/m68k/features.rst (100%)
 rename Documentation/{ => arch}/m68k/index.rst (100%)
 rename Documentation/{ => arch}/m68k/kernel-options.rst (100%)
 rename Documentation/{ => arch}/nios2/features.rst (100%)
 rename Documentation/{ => arch}/nios2/index.rst (100%)
 rename Documentation/{ => arch}/nios2/nios2.rst (100%)
 rename Documentation/{ => arch}/openrisc/features.rst (100%)
 rename Documentation/{ => arch}/openrisc/index.rst (100%)
 rename Documentation/{ => arch}/openrisc/openrisc_port.rst (100%)
 rename Documentation/{ => arch}/openrisc/todo.rst (100%)
 rename Documentation/{ => arch}/parisc/debugging.rst (100%)
 rename Documentation/{ => arch}/parisc/features.rst (100%)
 rename Documentation/{ => arch}/parisc/index.rst (100%)
 rename Documentation/{ => arch}/parisc/registers.rst (100%)
 rename Documentation/{ => arch}/sh/booting.rst (100%)
 rename Documentation/{ => arch}/sh/features.rst (100%)
 rename Documentation/{ => arch}/sh/index.rst (100%)
 rename Documentation/{ => arch}/sh/new-machine.rst (100%)
 rename Documentation/{ => arch}/sh/register-banks.rst (100%)
 rename Documentation/{ => arch}/sparc/adi.rst (100%)
 rename Documentation/{ => arch}/sparc/console.rst (100%)
 rename Documentation/{ => arch}/sparc/features.rst (100%)
 rename Documentation/{ => arch}/sparc/index.rst (100%)
 rename Documentation/{ => arch}/sparc/oradax/dax-hv-api.txt (100%)
 rename Documentation/{ => arch}/sparc/oradax/oracle-dax.rst (100%)
 rename Documentation/{ => arch}/x86/amd-memory-encryption.rst (100%)
 rename Documentation/{ => arch}/x86/amd_hsmp.rst (100%)
 rename Documentation/{ => arch}/x86/boot.rst (99%)
 rename Documentation/{ => arch}/x86/booting-dt.rst (96%)
 rename Documentation/{ => arch}/x86/buslock.rst (93%)
 rename Documentation/{ => arch}/x86/cpuinfo.rst (100%)
 rename Documentation/{ => arch}/x86/earlyprintk.rst (100%)
 rename Documentation/{ => arch}/x86/elf_auxvec.rst (100%)
 rename Documentation/{ => arch}/x86/entry_64.rst (100%)
 rename Documentation/{ => arch}/x86/exception-tables.rst (100%)
 rename Documentation/{ => arch}/x86/features.rst (100%)
 rename Documentation/{ => arch}/x86/i386/IO-APIC.rst (100%)
 rename Documentation/{ => arch}/x86/i386/index.rst (100%)
 rename Documentation/{ => arch}/x86/ifs.rst (100%)
 rename Documentation/{ => arch}/x86/index.rst (100%)
 rename Documentation/{ => arch}/x86/intel-hfi.rst (100%)
 rename Documentation/{ => arch}/x86/intel_txt.rst (100%)
 rename Documentation/{ => arch}/x86/iommu.rst (100%)
 rename Documentation/{ => arch}/x86/kernel-stacks.rst (100%)
 rename Documentation/{ => arch}/x86/mds.rst (100%)
 rename Documentation/{ => arch}/x86/microcode.rst (100%)
 rename Documentation/{ => arch}/x86/mtrr.rst (99%)
 rename Documentation/{ => arch}/x86/orc-unwinder.rst (100%)
 rename Documentation/{ => arch}/x86/pat.rst (100%)
 rename Documentation/{ => arch}/x86/pti.rst (100%)
 rename Documentation/{ => arch}/x86/resctrl.rst (100%)
 rename Documentation/{ => arch}/x86/sgx.rst (100%)
 rename Documentation/{ => arch}/x86/sva.rst (100%)
 rename Documentation/{ => arch}/x86/tdx.rst (100%)
 rename Documentation/{ => arch}/x86/tlb.rst (100%)
 rename Documentation/{ => arch}/x86/topology.rst (100%)
 rename Documentation/{ => arch}/x86/tsx_async_abort.rst (100%)
 rename Documentation/{ => arch}/x86/usb-legacy-support.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/5level-paging.rst (98%)
 rename Documentation/{ => arch}/x86/x86_64/boot-options.rst (98%)
 rename Documentation/{ => arch}/x86/x86_64/cpu-hotplug-spec.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/fake-numa-for-cpusets.rst (97%)
 rename Documentation/{ => arch}/x86/x86_64/fsgs.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/index.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/machinecheck.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/mm.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/uefi.rst (100%)
 rename Documentation/{ => arch}/x86/xstate.rst (100%)
 rename Documentation/{ => arch}/x86/zero-page.rst (100%)
 rename Documentation/{ => arch}/xtensa/atomctl.rst (100%)
 rename Documentation/{ => arch}/xtensa/booting.rst (100%)
 rename Documentation/{ => arch}/xtensa/features.rst (100%)
 rename Documentation/{ => arch}/xtensa/index.rst (100%)
 rename Documentation/{ => arch}/xtensa/mmu.rst (100%)
 delete mode 100644 Documentation/arm/sti/stih415-overview.rst
 delete mode 100644 Documentation/arm/sti/stih416-overview.rst
 create mode 100644 Documentation/kernel-hacking/false-sharing.rst
 create mode 100644 Documentation/process/contribution-maturity-model.rst
 create mode 100644 Documentation/translations/sp_SP/process/deprecated.rst
 rename Documentation/translations/zh_CN/{arch.rst => arch/index.rst} (82%)
 rename Documentation/translations/zh_CN/{ => arch}/openrisc/index.rst (79%)
 rename Documentation/translations/zh_CN/{ => arch}/openrisc/openrisc_port.rst (97%)
 rename Documentation/translations/zh_CN/{ => arch}/openrisc/todo.rst (88%)
 rename Documentation/translations/zh_CN/{ => arch}/parisc/debugging.rst (94%)
 rename Documentation/translations/zh_CN/{ => arch}/parisc/index.rst (79%)
 rename Documentation/translations/zh_CN/{ => arch}/parisc/registers.rst (98%)
 create mode 100644 Documentation/userspace-api/ELF.rst
 delete mode 100644 fs/qnx4/README
 delete mode 100644 fs/qnx6/README
