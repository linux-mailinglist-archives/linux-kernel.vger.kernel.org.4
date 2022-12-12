Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF1B649B18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiLLJZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiLLJZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:25:14 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D826353;
        Mon, 12 Dec 2022 01:25:12 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3CBDA5BF;
        Mon, 12 Dec 2022 09:25:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3CBDA5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1670837112; bh=aMbHfMFhftas6iWhYBEfDllOeoQFT5eEg3+UmWp/IZM=;
        h=From:To:Cc:Subject:Date:From;
        b=oLRPb7qOKRR5np21ijVy7QKgVP9EYxAhqrp0WAg24ctIaO+Xt8o2zIcQhpsY8zj2M
         MWZLtFVkNkEiFKcvxHFVARWXsLQsS8gIUFG/zH6qhso/wiCmzPfugAFKK3hQKi33Np
         UL9egTxzRWXEvBozkde76gAcz4xf08YO3ghn2uPFKd2WWqk8qZkuoslKJCqUqSBA9f
         ydVdGR242inR9HJtBNHTenX1ZyRol0Uqvp4Exsm4AoebDFxV62M4WbC/Pi1rYK6TZO
         kI72tm23BjLbpB8TeBCcvCcahvdeiNeCLxsj9MXe1ltmRw4dLCnFAg5ikDbk253MnM
         RQbPaOGH+BK/Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.2
Date:   Mon, 12 Dec 2022 02:25:07 -0700
Message-ID: <87359lj7nw.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2f3f53d62307262f0086804ea7cea99b0e085450:

  docs/process/howto: Replace C89 with C11 (2022-10-24 11:27:51 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.2

for you to fetch changes up to cc8c418b4fc09ed58ddd27b8e90ec797e9ca1e67:

  Documentation/features: Use loongarch instead of loong (2022-12-05 02:50:=
12 -0700)

----------------------------------------------------------------
This was a not-too-busy cycle for documentation; highlights include:

- The beginnings of a set of translations into Spanish, headed up by Carlos
  Bilbao.

- More Chinese translations.

- A change to the Sphinx "alabaster" theme by default for HTML generation.
  Unlike the previous default (Read the Docs), alabaster is shipped with
  Sphinx by default, reducing the number of other dependencies that need to
  be installed.  It also (IMO) produces a cleaner and more readable result.

- The ability to render the documentation into the texinfo format
  (something Sphinx could always do, we just never wired it up until now).

Plus the usual collection of typo fixes, build-warning fixes, and minor
updates.

MEA CULPA: there is a messy set of merges into docs-next that really
should not be there.  I tried a different Git workflow this time around
and clearly didn't get it quite right.  Those merges were not meant to be
in the history at all, but I misbased the alabaster work and, worse,
didn't notice until now.  I've opted to show my messiness to the world
rather than engage in last-second rebasing, but I can easily clean that
up if you would prefer.  Won't happen again either way.

----------------------------------------------------------------
Akira Yokosawa (2):
      docs/ja_JP/howto: Update for v6.1
      docs/zh_CN: Fix '.. only::' directive's expression

Albert Zhou (1):
      Documentation: eisa: Fix typo

Alexander Potapenko (1):
      docs: kmsan: fix formatting of "Example report"

Binbin Zhou (3):
      docs/zh_CN: core-api: Add this_cpu_ops Chinese translation
      docs/zh_CN: core-api: Add timekeeping Chinese translation
      docs/zh_CN: core-api: Add errseq Chinese translation

Bj=C3=B6rn T=C3=B6pel (1):
      Documentation: riscv: Document the sv57 VM layout

Carlos Bilbao (10):
      Documentation: Start translations to Spanish
      Documentation: Add HOWTO Spanish translation into rst based build sys=
tem
      docs/sp_SP: Add process submitting-patches translation
      docs: Update maintainer of kernel-docs.rst
      docs: Retire old resources from kernel-docs.rst
      docs: Add book to process/kernel-docs.rst
      docs: Create translations/sp_SP/process/, move submitting-patches.rst
      docs/sp_SP: Add kernel-docs.rst Spanish translation
      docs/sp_SP: Add process coding-style translation
      docs/sp_SP: Add memory-barriers.txt Spanish translation

Chen Linxuan (1):
      Documentation: update the description of TracerPid in procfs.rst

Daniel Vetter (1):
      docs/sphinx: More depth in the rtd sidebar toc

David Heidelberg (1):
      Docs/admin-guide/mm/zswap: remove a paragraph about zswap being a new=
 feature

Jonathan Corbet (15):
      Merge branch 'docs-mw' into docs-next
      Merge branch 'docs-mw' into docs-next
      Merge branch 'docs-mw' into docs-next
      Merge branch 'docs-mw' into docs-next
      Merge branch 'docs-mw' into docs-next
      docs: Switch the default HTML theme to alabaster
      docs: tweak some Alabaster style parameters
      docs: update sphinx.rst to reflect the default theme change
      docs: sphinx-pre-install: don't require the RTD theme
      docs: improve the HTML formatting of kerneldoc comments
      docs: decruft Documentation/conf.py
      Merge branch 'alabaster-rb' into docs-mw
      Revert "docs/zh_CN: core-api: Add timekeeping Chinese translation"
      docs: Don't wire font sizes for HTML output
      Merge branch 'docs-fixes' into docs-mw

Jonathan Neusch=C3=A4fer (2):
      docs: admin-guide: hw_random: Make document title more generic and co=
ncise
      docs: ia64: Fix a typo ("identify mappings")

Kushagra Verma (1):
      Documentation: Fixed a typo in bootconfig.rst

Liam Beguin (3):
      math64: favor kernel-doc from header files
      math64: add kernel-doc for DIV64_U64_ROUND_UP
      math64: fix kernel-doc return value warnings

Maxim Cournoyer (1):
      doc: add texinfodocs and infodocs targets

Pali Roh=C3=A1r (1):
      Documentation: arm: marvell: Add Orion codenames and archive homepage

Randy Dunlap (3):
      sysfs: update Documentation
      debugfs: small Documentation cleaning
      Documentation: USB: correct possessive "its" usage

Rui Li (9):
      docs/zh_CN: Add userspace-api/index Chinese translation
      docs/zh_CN: Add userspace-api/ebpf Chinese translation
      docs/zh_CN: Add staging/index Chinese translation
      docs/zh_CN: Add staging/xz Chinese translation
      docs/zh_CN: Add userspace-api/no_new_privs Chinese translation
      docs/zh_CN: Add userspace-api/sysfs-platform_profile Chinese translat=
ion
      docs/zh_CN: Add userspace-api/seccomp_filter Chinese translation
      docs/zh_CN: Add userspace-api/futex2 Chinese translation
      docs/zh_CN: Add userspace-api/accelerators/ocxl Chinese translation

Stephen Kitt (5):
      docs: sysctl/fs: remove references to inode-max
      docs: sysctl/fs: remove references to dquot-max/-nr
      docs: sysctl/fs: merge the aio sections
      docs: sysctl/fs: remove references to super-max/-nr
      docs: sysctl/fs: re-order, prettify

Tiezhu Yang (4):
      docs/LoongArch: Update links of LoongArch ISA Vol1 and ELF psABI
      docs/zh_CN/LoongArch: Update links of LoongArch ISA Vol1 and ELF psABI
      Documentation/features-refresh.sh: Only sed the beginning "arch" of A=
RCH_DIR
      Documentation/features: Use loongarch instead of loong

Wei Li (1):
      Documentation/features: Update feature lists for 6.1

Yang Yingliang (3):
      Documentation: devres: add missing IIO helpers
      Documentation: devres: add missing LED helpers
      Documentation: devres: add missing PWM helper

Yanteng Si (5):
      docs/zh_CN: Add rust index Chinese translation
      docs/zh_CN: Add rust quick-start Chinese translation
      docs/zh_CN: Add rust general-information Chinese translation
      docs/zh_CN: Add rust coding-guidelines Chinese translation
      docs/zh_CN: Add rust arch-support Chinese translation

 Documentation/Makefile                             |   11 +
 Documentation/admin-guide/bootconfig.rst           |    2 +-
 Documentation/admin-guide/hw_random.rst            |    6 +-
 Documentation/admin-guide/mm/zswap.rst             |    8 +-
 Documentation/admin-guide/sysctl/fs.rst            |  240 +-
 Documentation/admin-guide/sysctl/kernel.rst        |    2 +
 Documentation/arm/marvell.rst                      |   12 +-
 Documentation/conf.py                              |  211 +-
 Documentation/core-api/kernel-api.rst              |    3 -
 Documentation/dev-tools/kmsan.rst                  |    1 +
 Documentation/doc-guide/sphinx.rst                 |   16 +-
 Documentation/driver-api/driver-model/devres.rst   |    8 +
 Documentation/driver-api/eisa.rst                  |    2 +-
 .../features/core/cBPF-JIT/arch-support.txt        |    2 +-
 .../features/core/eBPF-JIT/arch-support.txt        |    2 +-
 .../core/generic-idle-thread/arch-support.txt      |    2 +-
 .../features/core/jump-labels/arch-support.txt     |    4 +-
 .../core/thread-info-in-task/arch-support.txt      |    2 +-
 .../features/core/tracehook/arch-support.txt       |    2 +-
 .../features/debug/KASAN/arch-support.txt          |    4 +-
 .../debug/debug-vm-pgtable/arch-support.txt        |    2 +-
 .../debug/gcov-profile-all/arch-support.txt        |    2 +-
 Documentation/features/debug/kcov/arch-support.txt |    2 +-
 Documentation/features/debug/kgdb/arch-support.txt |    2 +-
 .../features/debug/kmemleak/arch-support.txt       |    2 +-
 .../debug/kprobes-on-ftrace/arch-support.txt       |    2 +-
 .../features/debug/kprobes/arch-support.txt        |    2 +-
 .../features/debug/kretprobes/arch-support.txt     |    2 +-
 .../features/debug/optprobes/arch-support.txt      |    2 +-
 .../features/debug/stackprotector/arch-support.txt |    2 +-
 .../features/debug/uprobes/arch-support.txt        |    2 +-
 .../debug/user-ret-profiler/arch-support.txt       |    2 +-
 .../features/io/dma-contiguous/arch-support.txt    |    2 +-
 .../locking/cmpxchg-local/arch-support.txt         |    2 +-
 .../features/locking/lockdep/arch-support.txt      |    2 +-
 .../locking/queued-rwlocks/arch-support.txt        |    2 +-
 .../locking/queued-spinlocks/arch-support.txt      |    4 +-
 .../features/perf/kprobes-event/arch-support.txt   |    2 +-
 .../features/perf/perf-regs/arch-support.txt       |    2 +-
 .../features/perf/perf-stackdump/arch-support.txt  |    2 +-
 .../sched/membarrier-sync-core/arch-support.txt    |    2 +-
 .../features/sched/numa-balancing/arch-support.txt |    2 +-
 Documentation/features/scripts/features-refresh.sh |    2 +-
 .../seccomp/seccomp-filter/arch-support.txt        |    2 +-
 .../time/arch-tick-broadcast/arch-support.txt      |    2 +-
 .../features/time/clockevents/arch-support.txt     |    2 +-
 .../time/context-tracking/arch-support.txt         |    2 +-
 .../features/time/irq-time-acct/arch-support.txt   |    2 +-
 .../features/time/virt-cpuacct/arch-support.txt    |    2 +-
 .../features/vm/ELF-ASLR/arch-support.txt          |    2 +-
 .../features/vm/PG_uncached/arch-support.txt       |    2 +-
 Documentation/features/vm/THP/arch-support.txt     |    2 +-
 Documentation/features/vm/TLB/arch-support.txt     |    2 +-
 .../features/vm/huge-vmap/arch-support.txt         |    2 +-
 .../features/vm/ioremap_prot/arch-support.txt      |    2 +-
 .../features/vm/pte_special/arch-support.txt       |    2 +-
 Documentation/filesystems/debugfs.rst              |    8 +-
 Documentation/filesystems/proc.rst                 |    3 +-
 Documentation/filesystems/sysfs.rst                |   41 +-
 Documentation/ia64/aliasing.rst                    |    2 +-
 Documentation/loongarch/introduction.rst           |    8 +-
 Documentation/process/kernel-docs.rst              |  477 +--
 Documentation/riscv/vm-layout.rst                  |   36 +
 Documentation/sphinx-static/custom.css             |   29 +
 Documentation/sphinx/requirements.txt              |    1 -
 Documentation/translations/index.rst               |    1 +
 Documentation/translations/ja_JP/howto.rst         |   66 +-
 Documentation/translations/sp_SP/disclaimer-sp.rst |    6 +
 Documentation/translations/sp_SP/howto.rst         |  617 ++++
 Documentation/translations/sp_SP/index.rst         |   81 +
 .../translations/sp_SP/memory-barriers.txt         | 3134 ++++++++++++++++=
++++
 .../translations/sp_SP/process/coding-style.rst    | 1315 ++++++++
 Documentation/translations/sp_SP/process/index.rst |   15 +
 .../translations/sp_SP/process/kernel-docs.rst     |  187 ++
 .../sp_SP/process/submitting-patches.rst           |  894 ++++++
 .../sp_SP/wrappers/memory-barriers.rst             |   19 +
 .../translations/zh_CN/core-api/errseq.rst         |  145 +
 .../translations/zh_CN/core-api/index.rst          |    6 +-
 .../translations/zh_CN/core-api/this_cpu_ops.rst   |  285 ++
 .../translations/zh_CN/doc-guide/index.rst         |    2 +-
 Documentation/translations/zh_CN/index.rst         |   11 +-
 .../translations/zh_CN/loongarch/introduction.rst  |    8 +-
 .../translations/zh_CN/rust/arch-support.rst       |   23 +
 .../translations/zh_CN/rust/coding-guidelines.rst  |  192 ++
 .../zh_CN/rust/general-information.rst             |   75 +
 Documentation/translations/zh_CN/rust/index.rst    |   28 +
 .../translations/zh_CN/rust/quick-start.rst        |  211 ++
 Documentation/translations/zh_CN/staging/index.rst |   26 +
 Documentation/translations/zh_CN/staging/xz.rst    |  100 +
 .../zh_CN/userspace-api/accelerators/ocxl.rst      |  168 ++
 .../zh_CN/userspace-api/ebpf/index.rst             |   22 +
 .../zh_CN/userspace-api/ebpf/syscall.rst           |   29 +
 .../translations/zh_CN/userspace-api/futex2.rst    |   80 +
 .../translations/zh_CN/userspace-api/index.rst     |   50 +
 .../zh_CN/userspace-api/no_new_privs.rst           |   57 +
 .../zh_CN/userspace-api/seccomp_filter.rst         |  293 ++
 .../zh_CN/userspace-api/sysfs-platform_profile.rst |   40 +
 Documentation/usb/CREDITS                          |    6 +-
 Documentation/usb/functionfs.rst                   |    2 +-
 Documentation/usb/gadget_multi.rst                 |    2 +-
 Documentation/userspace-api/media/Makefile         |    3 +-
 MAINTAINERS                                        |   10 +
 Makefile                                           |    2 +-
 include/linux/math64.h                             |   26 +-
 lib/math/div64.c                                   |   15 +-
 scripts/kernel-doc                                 |   54 +-
 scripts/sphinx-pre-install                         |    8 -
 107 files changed, 8540 insertions(+), 993 deletions(-)
 create mode 100644 Documentation/sphinx-static/custom.css
 create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
 create mode 100644 Documentation/translations/sp_SP/howto.rst
 create mode 100644 Documentation/translations/sp_SP/index.rst
 create mode 100644 Documentation/translations/sp_SP/memory-barriers.txt
 create mode 100644 Documentation/translations/sp_SP/process/coding-style.r=
st
 create mode 100644 Documentation/translations/sp_SP/process/index.rst
 create mode 100644 Documentation/translations/sp_SP/process/kernel-docs.rst
 create mode 100644 Documentation/translations/sp_SP/process/submitting-pat=
ches.rst
 create mode 100644 Documentation/translations/sp_SP/wrappers/memory-barrie=
rs.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/errseq.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/this_cpu_ops.=
rst
 create mode 100644 Documentation/translations/zh_CN/rust/arch-support.rst
 create mode 100644 Documentation/translations/zh_CN/rust/coding-guidelines=
.rst
 create mode 100644 Documentation/translations/zh_CN/rust/general-informati=
on.rst
 create mode 100644 Documentation/translations/zh_CN/rust/index.rst
 create mode 100644 Documentation/translations/zh_CN/rust/quick-start.rst
 create mode 100644 Documentation/translations/zh_CN/staging/index.rst
 create mode 100644 Documentation/translations/zh_CN/staging/xz.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/accelera=
tors/ocxl.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/ind=
ex.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/sys=
call.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/futex2.r=
st
 create mode 100644 Documentation/translations/zh_CN/userspace-api/index.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/no_new_p=
rivs.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/seccomp_=
filter.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/sysfs-pl=
atform_profile.rst
