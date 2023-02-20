Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3A769D722
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjBTXfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjBTXfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:35:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9201C329;
        Mon, 20 Feb 2023 15:35:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F141B80E15;
        Mon, 20 Feb 2023 23:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100A4C433D2;
        Mon, 20 Feb 2023 23:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676936102;
        bh=hMOsmlvR2t+k+bsssnNo6rhzqeTd4vbjn50URgVXM+E=;
        h=Date:From:To:Cc:Subject:From;
        b=IcRAMBUL+0f5miwQ7FdpZI0SwLOMwVMcgufiawYW52s0WyzvrPtIoEJnxkASRwMC8
         e6F6gUdXgyKJg96hfLHSigmqhGZ4xvmHjVVMTLZ4LGKqlZKaYsMUI34N2eKhp6fMTT
         +b+zKSuh6TwHxCOezc/QrHgjr3lOtnmM7oyAySZ4=
Date:   Mon, 20 Feb 2023 15:35:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] Non MM updates for 6.3-rc1
Message-Id: <20230220153501.19c3ba46c67612f1cf1d7d08@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this set of non-MM patches which I've accumulated
over the previous -rc cycle.  Thanks.


The following changes since commit 077010cef0aec280ac6eccc217395cbe8543d5a8:

  Sync with v6.2-rc4 (2023-01-18 16:52:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stabl=
e-2023-02-20-15-29

for you to fetch changes up to 817013880a6883f7ab08030d1f8cfef5f07ba467:

  Update CREDITS file entry for Jesper Juhl (2023-02-09 17:03:20 -0800)

----------------------------------------------------------------
There is no particular theme here - mainly quick hits all over the tree.

Most notable is a set of zlib changes from Mikhail Zaslonko which enhances
and fixes zlib's use of S390 hardware support: "lib/zlib: Set of s390
DFLTCC related patches for kernel zlib".

----------------------------------------------------------------
Alexander Pantyukhin (1):
      scripts/bloat-o-meter: use the reverse flag for sort

Alexander Potapenko (2):
      fs: hfs: initialize fsdata in hfs_file_truncate()
      fs: hfsplus: initialize fsdata in hfsplus_file_truncate()

Alexey Dobriyan (1):
      proc: mark /proc/cmdline as permanent

Andy Shevchenko (1):
      util_macros.h: add missing inclusion

Christophe JAILLET (1):
      initramfs: use kstrtobool() instead of strtobool()

Diederik de Haas (1):
      scripts/spelling.txt: add more spelling corrections

Dmitrii Bundin (1):
      scripts/gdb: add mm introspection utils

Geert Uytterhoeven (1):
      lib: add Dhrystone benchmark test

Hyeonggon Yoo (1):
      lib/Kconfig.debug: do not enable DEBUG_PREEMPT by default

Ira Weiny (1):
      checkpatch: mark kunmap() and kunmap_atomic() deprecated

Jan Kara (1):
      fs: gracefully handle ->get_block not mapping bh in __mpage_writepage

Jesper Juhl (1):
      Update CREDITS file entry for Jesper Juhl

Joe Perches (1):
      checkpatch: improve EMBEDDED_FILENAME test

Juerg Haefliger (1):
      arch/Kconfig: fix indentation

Kai Wasserb=E4ch (2):
      checkpatch: warn when unknown tags are used for links
      checkpatch: warn when Reported-by: is not followed by Link:

Kevin Hao (1):
      scripts/tags.sh: fix the Kconfig tags generation when using latest ct=
ags

Li zeming (2):
      arch/alpha/kernel/smp.c: remove unnecessary (void*) conversions
      arch/alpha/kernel/process.c: remove unnecessary (void*) conversions

Liu Shixin (1):
      hfs: fix missing hfs_bnode_get() in __hfs_bnode_create

Luca Ceresoli (1):
      scripts/spelling.txt: add "exsits" pattern and fix typo instances

Manfred Spraul (2):
      lib/percpu_counter: percpu_counter_add_batch() overflow/underflow
      include/linux/percpu_counter.h: race in uniprocessor percpu_counter_a=
dd()

Masami Hiramatsu (Google) (2):
      error-injection: remove EI_ETYPE_NONE
      docs: fault-injection: add requirements of error injectable functions

Mikhail Zaslonko (8):
      lib/zlib: adjust offset calculation for dfltcc_state
      lib/zlib: implement switching between DFLTCC and software
      lib/zlib: fix DFLTCC not flushing EOBS when creating raw streams
      lib/zlib: fix DFLTCC ignoring flush modes when avail_in =3D=3D 0
      lib/zlib: DFLTCC not writing header bits when avail_out =3D=3D 0
      lib/zlib: Split deflate and inflate states for DFLTCC
      lib/zlib: DFLTCC support inflate with small window
      lib/zlib: DFLTCC always switch to software inflate for Z_PACKET_FLUSH=
 option

Pali Roh=E1r (1):
      fat: fix return value of vfat_bad_char() and vfat_replace_char() func=
tions

Randy Dunlap (5):
      freevxfs: fix kernel-doc warnings
      ntfs: fix multiple kernel-doc warnings
      userns: fix a struct's kernel-doc notation
      cramfs: Kconfig: fix spelling & punctuation
      sparc: allow PM configs for sparc32 COMPILE_TEST

Ricardo Ribalda (4):
      scripts/spelling.txt: add `permitted'
      Documentation: sysctl: correct kexec_load_disabled
      kexec: factor out kexec_load_permitted
      kexec: introduce sysctl parameters kexec_load_limit_*

Ryusuke Konishi (2):
      nilfs2: replace WARN_ONs for invalid DAT metadata block requests
      nilfs2: prevent WARNING in nilfs_dat_commit_end()

SeongJae Park (1):
      scripts/spelling: add a few more typos

Thorsten Leemhuis (1):
      checkpatch: use proper way for show problematic line

Tom Rix (1):
      lib/zlib: remove redundation assignement of avail_in dfltcc_gdht()

Uros Bizjak (2):
      lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
      fs/ext4: use try_cmpxchg in ext4_update_bh_state

XU pengfei (1):
      hfsplus: remove unnecessary variable initialization

Zqiang (1):
      kthread_worker: check all delayed works when destroy kthread worker

fuyuanli (1):
      hung_task: print message when hung_task_warnings gets down to zero.

 CREDITS                                           |   6 +-
 Documentation/admin-guide/sysctl/kernel.rst       |  25 +-
 Documentation/fault-injection/fault-injection.rst |  65 ++++
 arch/Kconfig                                      | 128 ++++----
 arch/alpha/kernel/process.c                       |   2 +-
 arch/alpha/kernel/smp.c                           |   4 +-
 arch/sparc/Kconfig                                |   2 +-
 arch/x86/kvm/emulate.c                            |   8 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c          |   2 +-
 fs/cramfs/Kconfig                                 |   2 +-
 fs/ext4/inode.c                                   |   5 +-
 fs/fat/namei_vfat.c                               |   4 +-
 fs/freevxfs/vxfs_subr.c                           |   6 +-
 fs/freevxfs/vxfs_super.c                          |   2 +-
 fs/hfs/bnode.c                                    |   1 +
 fs/hfs/extent.c                                   |   2 +-
 fs/hfsplus/extents.c                              |   2 +-
 fs/hfsplus/xattr.c                                |  18 +-
 fs/mpage.c                                        |   2 +
 fs/nilfs2/dat.c                                   |  38 ++-
 fs/ntfs/aops.c                                    |  10 +-
 fs/ntfs/aops.h                                    |   2 +-
 fs/ntfs/compress.c                                |   6 +-
 fs/ntfs/dir.c                                     |   4 +-
 fs/ntfs/inode.c                                   |   6 +-
 fs/ntfs/mft.c                                     |   2 +-
 fs/ntfs/namei.c                                   |   4 +-
 fs/ntfs/runlist.c                                 |   2 +-
 fs/ntfs/super.c                                   |  12 +-
 fs/proc/cmdline.c                                 |   1 +
 include/asm-generic/error-injection.h             |   7 +-
 include/linux/error-injection.h                   |   3 +-
 include/linux/kexec.h                             |   3 +-
 include/linux/percpu_counter.h                    |   6 +-
 include/linux/util_macros.h                       |   2 +
 init/initramfs.c                                  |   4 +-
 kernel/hung_task.c                                |   2 +
 kernel/kexec.c                                    |   4 +-
 kernel/kexec_core.c                               |  94 +++++-
 kernel/kexec_file.c                               |  11 +-
 kernel/kthread.c                                  |   5 +
 kernel/user_namespace.c                           |   2 +-
 lib/Kconfig.debug                                 |  40 ++-
 lib/Makefile                                      |   2 +
 lib/dhry.h                                        | 358 ++++++++++++++++++=
++++
 lib/dhry_1.c                                      | 283 +++++++++++++++++
 lib/dhry_2.c                                      | 175 +++++++++++
 lib/dhry_run.c                                    |  85 +++++
 lib/error-inject.c                                |   2 +-
 lib/genalloc.c                                    |  18 +-
 lib/percpu_counter.c                              |  25 +-
 lib/zlib_deflate/deflate.c                        |  23 +-
 lib/zlib_dfltcc/dfltcc.c                          |  25 +-
 lib/zlib_dfltcc/dfltcc.h                          |  57 +---
 lib/zlib_dfltcc/dfltcc_deflate.c                  |  91 ++++--
 lib/zlib_dfltcc/dfltcc_deflate.h                  |  21 ++
 lib/zlib_dfltcc/dfltcc_inflate.c                  |  24 +-
 lib/zlib_dfltcc/dfltcc_inflate.h                  |  37 +++
 lib/zlib_inflate/inflate.c                        |   2 +-
 net/openvswitch/flow_table.c                      |   2 +-
 scripts/bloat-o-meter                             |   3 +-
 scripts/checkpatch.pl                             |  38 ++-
 scripts/gdb/linux/mm.py                           | 222 ++++++++++++++
 scripts/gdb/vmlinux-gdb.py                        |   1 +
 scripts/spelling.txt                              |  17 +
 scripts/tags.sh                                   |  10 +-
 sound/soc/fsl/fsl-asoc-card.c                     |   2 +-
 67 files changed, 1781 insertions(+), 298 deletions(-)
 create mode 100644 lib/dhry.h
 create mode 100644 lib/dhry_1.c
 create mode 100644 lib/dhry_2.c
 create mode 100644 lib/dhry_run.c
 create mode 100644 lib/zlib_dfltcc/dfltcc_deflate.h
 create mode 100644 lib/zlib_dfltcc/dfltcc_inflate.h
 create mode 100644 scripts/gdb/linux/mm.py

