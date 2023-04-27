Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4FE6F0EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344386AbjD0XIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344320AbjD0XH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101C30D6;
        Thu, 27 Apr 2023 16:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2F9264046;
        Thu, 27 Apr 2023 23:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7804C433A1;
        Thu, 27 Apr 2023 23:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1682636876;
        bh=owpzMMbHrySy4xu0dvyqtf9A4KyvYfpS5ibkBq/rpQM=;
        h=Date:From:To:Cc:Subject:From;
        b=GUqDyxpCZ+VB+hBQQbWEV0lM2xIB4LtXcLkQRr5OENf3pmrUCj+zz4IsfXhlxHmmD
         NXG3nTsz5FJ8w5ejw1fV8mYcEg4sP7WsOzd5PpwcuvTKsxvFbSL/pIPukNwi64fowz
         aLzs0MEgWbs+LqRdsuMhITzNO+gvlZr1zwjAWbrM=
Date:   Thu, 27 Apr 2023 16:07:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] non-MM updates for 6.4-rc1
Message-Id: <20230427160755.c9b9049fa931902b453e94a8@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge the mm-nonmm-stable.git updates for this merge cycle.

Forthcoming merge issues:

modules tree, scripts/gdb/linux/constants.py.in
https://lkml.kernel.org/r/20230414131330.1053570-1-broonie@kernel.org

Thanks.


The following changes since commit aa318c48808c0aa73216bd94c54c4553d3663add:

  Merge tag 'gpio-fixes-for-v6.3-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux (2023-04-07 13:53:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2023-04-27-16-01

for you to fetch changes up to d88f2f72ca89ead8743ee15e547274ba248e7c59:

  mailmap: add entries for Paul Mackerras (2023-04-27 13:45:31 -0700)

----------------------------------------------------------------
Mainly singleton patches all over the place.  Series of note are:

- updates to scripts/gdb from Glenn Washburn

- kexec cleanups from Bjorn Helgaas

----------------------------------------------------------------
Alexey Dobriyan (2):
      mm: uninline kstrdup()
      ELF: fix all "Elf" typos

Amjad Ouled-Ameur (1):
      scripts/gdb: timerlist: convert int chunks to str

Andrew Morton (1):
      scripts/link-vmlinux.sh: fix error message presentation

Andrey Konovalov (1):
      kcov: improve documentation

Andy Shevchenko (2):
      kernel.h: split the hexadecimal related helpers to hex.h
      lib/test-string_helpers: replace UNESCAPE_ANY by UNESCAPE_ALL_MASK

Arnd Bergmann (1):
      ocfs2: reduce ioctl stack usage

Bjorn Helgaas (2):
      x86/kexec: remove unnecessary arch_kexec_kernel_image_load()
      kexec: remove unnecessary arch_kexec_kernel_image_load()

Cai Huoqing (1):
      rapidio/tsi721: remove redundant pci_clear_master

Chao Yu (1):
      proc: remove mark_inode_dirty() in .setattr()

Chunguang Wu (1):
      fs/proc: add Kthread flag to /proc/$pid/status

Dan Carpenter (1):
      dca: delete unnecessary variable

Davidlohr Bueso (1):
      epoll: rename global epmutex

Dmitry Rokosov (1):
      checkpatch: introduce proper bindings license check

Florian Fainelli (4):
      scripts/gdb: bail early if there are no clocks
      scripts/gdb: bail early if there are no generic PD
      scripts/gdb: raise error with reduced debugging information
      scripts/gdb: print interrupts

Geert Uytterhoeven (1):
      libgcc: add forward declarations for generic library routines

Gerhard Engleder (1):
      checkpatch: ignore ETHTOOL_LINK_MODE_ enum values

Glenn Washburn (4):
      scripts/gdb: correct indentation in get_current_task
      scripts/gdb: support getting current task struct in UML
      scripts/gdb: create linux/vfs.py for VFS related GDB helpers
      scripts/gdb: add GDB convenience functions $lx_dentry_name() and $lx_i_dentry()

Guilherme G. Piccoli (1):
      notifiers: add tracepoints to the notifiers infrastructure

Heiko Carstens (1):
      proc/stat: remove arch_idle_time()

Hugh Dickins (1):
      ia64: fix an addr to taddr in huge_pte_offset()

Kevin Brodsky (1):
      uapi/linux/const.h: prefer ISO-friendly __typeof__

Kieran Bingham (1):
      scripts/gdb: add a Radix Tree Parser

Lukas Bulwahn (1):
      MAINTAINERS: remove the obsolete section EMBEDDED LINUX

Matthieu Baerts (5):
      docs: process: allow Closes tags with links
      checkpatch: don't print the next line if not defined
      checkpatch: use a list of "link" tags
      checkpatch: allow Closes tags with links
      checkpatch: check for misuse of the link tags

Noah Goldstein (1):
      lib/rbtree: use '+' instead of '|' for setting color.

Oleksandr Natalenko (1):
      mailmap: add entry for Oleksandr

Paolo Abeni (1):
      epoll: use refcount to reduce ep_mutex contention

Paul Mackerras (1):
      mailmap: add entries for Paul Mackerras

Peng Liu (3):
      scripts/gdb: fix lx-timerlist for struct timequeue_head change
      scripts/gdb: fix lx-timerlist for Python3
      scripts/gdb: fix lx-timerlist for HRTIMER_MAX_CLOCK_BASES printing

Randy Dunlap (2):
      ia64: mm/contig: fix section mismatch warning/error
      ia64: salinfo: placate defined-but-not-used warning

Tom Rix (1):
      kernel/hung_task.c: set some hung_task.c variables storage-class-specifier to static

Uros Bizjak (1):
      nfs: remove empty if statement from nfs3_prepare_get_acl

Wang Yong (1):
      delayacct: improve the average delay precision of getdelay tool to microsecond

Yang Yang (1):
      delayacct: track delays from IRQ/SOFTIRQ

 .mailmap                                           |   3 +
 Documentation/accounting/delay-accounting.rst      |  19 +-
 Documentation/dev-tools/kcov.rst                   | 169 +++++++++------
 Documentation/filesystems/proc.rst                 |   2 +
 Documentation/process/5.Posting.rst                |  22 +-
 Documentation/process/submitting-patches.rst       |  26 ++-
 .../zh_CN/accounting/delay-accounting.rst          |  10 +-
 MAINTAINERS                                        |   6 -
 arch/ia64/kernel/salinfo.c                         |   2 +-
 arch/ia64/mm/contig.c                              |   2 +-
 arch/ia64/mm/hugetlbpage.c                         |   2 +-
 arch/mips/boot/tools/relocs.c                      |   2 +-
 arch/um/os-Linux/elf_aux.c                         |   2 +-
 arch/x86/include/asm/kexec.h                       |   3 -
 arch/x86/kernel/machine_kexec_64.c                 |  11 -
 arch/x86/tools/relocs.c                            |   2 +-
 drivers/dca/dca-core.c                             |   4 +-
 drivers/rapidio/devices/tsi721.c                   |   3 -
 drivers/remoteproc/remoteproc_coredump.c           |   4 +-
 drivers/remoteproc/remoteproc_elf_loader.c         |   4 +-
 fs/binfmt_elf.c                                    |   2 +-
 fs/binfmt_elf_fdpic.c                              |   2 +-
 fs/eventpoll.c                                     | 215 +++++++++++--------
 fs/nfs/nfs3acl.c                                   |   5 +-
 fs/ocfs2/ioctl.c                                   |  37 +++-
 fs/proc/array.c                                    |   2 +
 fs/proc/base.c                                     |   1 -
 fs/proc/generic.c                                  |   1 -
 fs/proc/proc_sysctl.c                              |   1 -
 fs/proc/stat.c                                     |  26 ---
 fs/proc/vmcore.c                                   |  22 +-
 include/linux/delayacct.h                          |  15 ++
 include/linux/hex.h                                |  35 ++++
 include/linux/kernel.h                             |  29 +--
 include/linux/kexec.h                              |   8 -
 include/linux/libgcc.h                             |   7 +
 include/linux/rbtree_augmented.h                   |   4 +-
 include/trace/events/notifier.h                    |  69 ++++++
 include/uapi/linux/const.h                         |   2 +-
 include/uapi/linux/taskstats.h                     |   6 +-
 kernel/delayacct.c                                 |  14 ++
 kernel/hung_task.c                                 |  10 +-
 kernel/kexec_file.c                                |   6 +-
 kernel/notifier.c                                  |   6 +
 kernel/sched/core.c                                |   1 +
 lib/buildid.c                                      |   2 +-
 lib/rbtree.c                                       |   2 +-
 lib/test-string_helpers.c                          |   2 +-
 mm/util.c                                          |   1 +
 scripts/checkpatch.pl                              |  52 ++++-
 scripts/gdb/linux/clk.py                           |   2 +
 scripts/gdb/linux/constants.py.in                  |  24 +++
 scripts/gdb/linux/cpus.py                          |  24 ++-
 scripts/gdb/linux/genpd.py                         |   4 +-
 scripts/gdb/linux/interrupts.py                    | 232 +++++++++++++++++++++
 scripts/gdb/linux/proc.py                          |  16 +-
 scripts/gdb/linux/radixtree.py                     |  90 ++++++++
 scripts/gdb/linux/timerlist.py                     |  12 +-
 scripts/gdb/linux/utils.py                         |  13 +-
 scripts/gdb/linux/vfs.py                           |  59 ++++++
 scripts/gdb/vmlinux-gdb.py                         |   8 +-
 scripts/link-vmlinux.sh                            |   2 +-
 sound/soc/codecs/rt5677.c                          |   2 +-
 tools/accounting/getdelays.c                       |  30 +--
 tools/bpf/resolve_btfids/main.c                    |   2 +-
 tools/lib/bpf/libbpf.c                             |   2 +-
 tools/lib/bpf/usdt.c                               |   2 +-
 tools/perf/util/symbol-elf.c                       |   2 +-
 68 files changed, 1032 insertions(+), 377 deletions(-)
 create mode 100644 include/linux/hex.h
 create mode 100644 include/trace/events/notifier.h
 create mode 100644 scripts/gdb/linux/interrupts.py
 create mode 100644 scripts/gdb/linux/radixtree.py
 create mode 100644 scripts/gdb/linux/vfs.py

