Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4834B5F3318
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJCQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJCQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:10:23 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE482716A;
        Mon,  3 Oct 2022 09:10:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 506552E0;
        Mon,  3 Oct 2022 16:10:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 506552E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664813419; bh=M09kvWUKKyXJT6BItOuZt0NVG4f6vBFUOXolhT1QKRI=;
        h=From:To:Cc:Subject:Date:From;
        b=L23NlEY9w6USpgSPhbH6XSEWdOAg96njN+s8zBko5oYsnep+AWzraDxaJy//R+C8l
         4Q02TL5Kslx+2D/K750RK0idJtC1SmykVL+Tu5ZVpj4H2g8YaHqqW+tn9B9VbIpHxj
         2Iz+iOEHbYu1sQe1FRZVRK2K1HA/hB7dW2zE3G/n/Gu/OXTutKy0tVxh36nTlMcMa1
         PV3HSF71xvXzCuXRAVkYCrzhC15LLXNaogdTPyYKp6LLYvGpOyt1w7fyeMAiN76ot+
         qq2rE9RRPgZPsWX/lmIjZRf/QWNyGzyq4l2+W1nmj4E6SvCRLlKKC//45Zf8hK2iqW
         EKSsnrL9DHa7A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation changes for 6.0
Date:   Mon, 03 Oct 2022 10:10:18 -0600
Message-ID: <87k05gga6t.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.1

for you to fetch changes up to 69d517e6e21099f81efbd39e47874649ae575804:

  checkpatch: warn on usage of VM_BUG_ON() and other BUG variants (2022-09-29 13:20:53 -0600)

----------------------------------------------------------------
There's not a huge amount of activity in the docs tree this time around,
but a few significant changes even so:

- A complete rewriting of the top-level index.rst file, which mostly
  reflects itself in a redone top page in the HTML-rendered docs.  The hope
  is that the new organization will be a friendlier starting point for
  both users and developers.

- Some math-rendering improvements.

- A coding-style.rst update on the use of BUG() and WARN()

- A big maintainer-PHP guide update.

- Some code-of-conduct updates

- More Chinese translation work

Plus the usual pile of typo fixes, corrections, and updates.

CONFLICTS: a Documentation/index.rst thrash could be expected to create a
lot of conflicts, but there seems to be just one: with the Rust tree.
Resolution is to take the docs version but add "rust/index" after
"livepatch/index".

There's also a small conflict with the RCU tree; just take the RCU side
there.

----------------------------------------------------------------
Akhil Raj (2):
      Remove duplicate words inside documentation
      Delete duplicate words from kernel docs

Akira Yokosawa (3):
      docs/conf.py: Treat mathjax as fallback math renderer
      docs/conf.py: Respect env variable SPHINX_IMGMATH
      docs/doc-guide: Add documentation on SPHINX_IMGMATH

Binbin Zhou (4):
      docs/zh_CN: core-api: Add idr Chinese translation
      docs/zh_CN: core-api: Add circular-buffers Chinese translation
      docs/zh_CN: core-api: Add generic-radix-tree Chinese translation
      docs/zh_CN: core-api: Add packing Chinese translation

David Hildenbrand (2):
      coding-style.rst: document BUG() and WARN() rules ("do not crash the kernel")
      checkpatch: warn on usage of VM_BUG_ON() and other BUG variants

Eric Lin (1):
      Documentation: irqdomain: Fix typo of "at least once"

Hoi Pok Wu (1):
      docs: hugetlbpage.rst: fix a typo of hugepage size

Jonathan Corbet (8):
      docs: promote the title of process/index.rst
      docs: Rewrite the front page
      docs: reconfigure the HTML left column
      docs: remove some index.rst cruft
      docs: move asm-annotations.rst into core-api
      docs: put atomic*.txt and memory-barriers.txt into the core-api book
      docs: add a man-pages link to the front page
      Merge branch 'fp' into docs-mw

JunChao Sun (1):
      Documentation: ext4: correct the document about superblock

Konstantin Ryabitsev (5):
      maintainer-pgp-guide: use key terminology consistent with upstream
      maintainer-pgp-guide: remove keyserver instructions
      maintainer-pgp-guide: update ECC support information
      maintainer-pgp-guide: add a section on PGP-signed patches
      maintainer-pgp-guide: minor wording tweaks

Kristen Carlson Accardi (1):
      Documentation/CoC: Reflect current CoC interpretation and practices

Lin Yujun (1):
      Documentation/hw-vuln: Update spectre doc

Lukas Bulwahn (2):
      docs: admin-guide: do not mention the 'run a.out user programs' feature
      docs: admin-guide: for kernel bugs refer to other kernel documentation

Lukasz Luba (1):
      docs: scheduler: Update new path for the sysctl knobs

Randy Dunlap (6):
      Documentation/ABI: correct possessive "its" typos
      Documentation: filesystems: correct possessive "its"
      Documentation: spufs: correct a duplicate word typo
      Documentation: fb: udlfb: clean up text and formatting
      Documentation: W1: minor typo corrections
      usb: chipidea: clarify Documentation/ABI text

Robert Elliott (1):
      docs/core-api: expand Fedora instructions for GCC plugins

Rong Tao (1):
      Documentation: process/submitting-patches: misspelling "mesages"

Salvatore Bonaccorso (1):
      Documentation: stable: Document alternative for referring upstream commit hash

Shuah Khan (1):
      docs: update mediator information in CoC docs

Thorsten Leemhuis (1):
      docs: process/5.Posting.rst: clarify use of Reported-by: tag

Tiezhu Yang (1):
      docs, kprobes: Fix the wrong location of Kprobes

Tuo Cao (1):
      docs: x86: replace do_IRQ int the entry_64.rst with common_interrupt()

Vernon Yang (1):
      Documentation/mm: modify page_referenced to folio_referenced

Wu XiangCheng (7):
      docs/zh_CN: Update zh_CN/process/email-clients.rst to 5.19
      docs/zh_CN: Update zh_CN/process/submitting-patches.rst to 5.19
      docs/zh_CN: Fix two missing labels in zh_CN/process
      docs/zh_CN: Update zh_CN/process/submit-checklist.rst to 6.0-rc2
      docs/zh_CN: Update zh_CN/process/coding-style.rst to 6.0-rc2
      docs/zh_CN: Update zh_CN/admin-guide/README.rst to 6.0-rc2
      docs/zh_CN: Add new translation of admin-guide/bootconfig.rst

Yang Yingliang (4):
      Documentation: devres: add missing PINCTRL helpers
      Documentation: devres: add missing SPI helper
      Documentation: devres: update IRQ helper
      Documentation: devres: add missing IO helper

Yanteng Si (9):
      docs/zh_CN: Update the translation of gpio to 6.0-rc1
      docs/zh_CN: Update the translation of io_ordering to 6.0-rc2
      docs/zh_CN: Remove IRQ and oops-tracing
      docs/zh_TW: Remove oops-tracing
      docs/zh_CN: add PCI acpi-info translation
      docs/zh_CN: add dt changesets translation
      docs/zh_CN: add dt dynamic-resolution-notes translation
      docs/zh_CN: add dt overlay-notes translation
      docs/zh_CN: add dt kernel-api translation

Zhao Mengmeng (1):
      Documentation: filesystems: xfs: update pseudocode and typo fixes

 Documentation/ABI/testing/sysfs-bus-bcma           |   2 +-
 Documentation/ABI/testing/sysfs-bus-fcoe           |   2 +-
 Documentation/ABI/testing/sysfs-bus-iio-proximity  |   2 +-
 Documentation/ABI/testing/sysfs-devices-system-cpu |   2 +-
 .../ABI/testing/sysfs-platform-chipidea-usb2       |   6 +-
 Documentation/ABI/testing/sysfs-power              |   2 +-
 Documentation/RCU/checklist.rst                    |   2 +-
 Documentation/RCU/lockdep.rst                      |   2 +-
 Documentation/admin-guide/README.rst               |  91 +--
 Documentation/admin-guide/hw-vuln/spectre.rst      |   1 +
 Documentation/admin-guide/kdump/vmcoreinfo.rst     |   2 +-
 Documentation/admin-guide/mm/hugetlbpage.rst       |   2 +-
 Documentation/bpf/instruction-set.rst              |   2 +-
 Documentation/bpf/map_cgroup_storage.rst           |   4 +-
 Documentation/conf.py                              |  42 +-
 Documentation/{ => core-api}/asm-annotations.rst   |   7 +-
 Documentation/core-api/cpu_hotplug.rst             |   2 +-
 Documentation/core-api/index.rst                   |   4 +
 Documentation/core-api/irq/irq-domain.rst          |   2 +-
 Documentation/core-api/wrappers/atomic_bitops.rst  |  18 +
 Documentation/core-api/wrappers/atomic_t.rst       |  19 +
 .../core-api/wrappers/memory-barriers.rst          |  18 +
 Documentation/doc-guide/sphinx.rst                 |  57 +-
 Documentation/driver-api/driver-model/devres.rst   |   7 +-
 Documentation/driver-api/isa.rst                   |   2 +-
 Documentation/fb/udlfb.rst                         |  23 +-
 Documentation/filesystems/caching/backend-api.rst  |   2 +-
 Documentation/filesystems/ext4/super.rst           |   6 +-
 Documentation/filesystems/f2fs.rst                 |   5 +-
 Documentation/filesystems/idmappings.rst           |   2 +-
 Documentation/filesystems/qnx6.rst                 |   2 +-
 Documentation/filesystems/spufs/spufs.rst          |   2 +-
 .../filesystems/xfs-delayed-logging-design.rst     |  18 +-
 Documentation/index.rst                            | 156 ++---
 Documentation/kbuild/gcc-plugins.rst               |  19 +-
 Documentation/locking/seqlock.rst                  |   2 +-
 Documentation/mm/unevictable-lru.rst               |   6 +-
 Documentation/process/5.Posting.rst                |   6 +-
 .../process/code-of-conduct-interpretation.rst     |  26 +-
 Documentation/process/coding-style.rst             |  62 ++
 Documentation/process/index.rst                    |   1 +
 Documentation/process/maintainer-pgp-guide.rst     | 286 ++++-----
 Documentation/process/stable-kernel-rules.rst      |   6 +
 Documentation/process/submitting-patches.rst       |   4 +-
 Documentation/scheduler/sched-design-CFS.rst       |   2 +-
 Documentation/staging/index.rst                    |  42 --
 Documentation/subsystem-apis.rst                   |  58 ++
 Documentation/trace/histogram.rst                  |   2 +-
 Documentation/trace/kprobes.rst                    |   4 +-
 Documentation/trace/timerlat-tracer.rst            |   2 +-
 Documentation/translations/zh_CN/IRQ.txt           |  39 --
 Documentation/translations/zh_CN/PCI/acpi-info.rst | 139 ++++
 Documentation/translations/zh_CN/PCI/index.rst     |  13 +-
 .../translations/zh_CN/admin-guide/README.rst      | 101 +--
 .../translations/zh_CN/admin-guide/bootconfig.rst  | 293 +++++++++
 .../translations/zh_CN/admin-guide/index.rst       |   2 +-
 .../zh_CN/core-api/circular-buffers.rst            | 210 ++++++
 .../zh_CN/core-api/generic-radix-tree.rst          |  23 +
 Documentation/translations/zh_CN/core-api/idr.rst  |  80 +++
 .../translations/zh_CN/core-api/index.rst          |   8 +-
 .../translations/zh_CN/core-api/packing.rst        | 160 +++++
 .../translations/zh_CN/devicetree/changesets.rst   |  37 ++
 .../zh_CN/devicetree/dynamic-resolution-notes.rst  |  31 +
 .../translations/zh_CN/devicetree/index.rst        |  13 +-
 .../translations/zh_CN/devicetree/kernel-api.rst   |  58 ++
 .../zh_CN/devicetree/overlay-notes.rst             | 140 ++++
 .../translations/zh_CN/driver-api/gpio/index.rst   |  69 ++
 .../zh_CN/{gpio.txt => driver-api/gpio/legacy.rst} | 184 ++++--
 .../translations/zh_CN/driver-api/index.rst        | 132 ++++
 .../translations/zh_CN/driver-api/io_ordering.rst  |  60 ++
 Documentation/translations/zh_CN/index.rst         |   4 +-
 Documentation/translations/zh_CN/io_ordering.txt   |  67 --
 Documentation/translations/zh_CN/oops-tracing.txt  | 212 ------
 .../translations/zh_CN/process/coding-style.rst    | 274 +++++---
 .../translations/zh_CN/process/email-clients.rst   | 265 +++++---
 .../zh_CN/process/submit-checklist.rst             |  84 +--
 .../zh_CN/process/submitting-patches.rst           | 714 ++++++++++-----------
 .../zh_CN/scheduler/sched-design-CFS.rst           |   2 +-
 Documentation/translations/zh_TW/oops-tracing.txt  | 212 ------
 Documentation/virt/kvm/x86/mmu.rst                 |   2 +-
 Documentation/w1/masters/ds2490.rst                |   2 +-
 Documentation/w1/w1-generic.rst                    |   2 +-
 Documentation/x86/entry_64.rst                     |   4 +-
 scripts/checkpatch.pl                              |   8 +-
 84 files changed, 2957 insertions(+), 1731 deletions(-)
 rename Documentation/{ => core-api}/asm-annotations.rst (97%)
 create mode 100644 Documentation/core-api/wrappers/atomic_bitops.rst
 create mode 100644 Documentation/core-api/wrappers/atomic_t.rst
 create mode 100644 Documentation/core-api/wrappers/memory-barriers.rst
 create mode 100644 Documentation/subsystem-apis.rst
 delete mode 100644 Documentation/translations/zh_CN/IRQ.txt
 create mode 100644 Documentation/translations/zh_CN/PCI/acpi-info.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/bootconfig.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/circular-buffers.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/generic-radix-tree.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/idr.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/packing.rst
 create mode 100644 Documentation/translations/zh_CN/devicetree/changesets.rst
 create mode 100644 Documentation/translations/zh_CN/devicetree/dynamic-resolution-notes.rst
 create mode 100644 Documentation/translations/zh_CN/devicetree/kernel-api.rst
 create mode 100644 Documentation/translations/zh_CN/devicetree/overlay-notes.rst
 create mode 100644 Documentation/translations/zh_CN/driver-api/gpio/index.rst
 rename Documentation/translations/zh_CN/{gpio.txt => driver-api/gpio/legacy.rst} (89%)
 create mode 100644 Documentation/translations/zh_CN/driver-api/index.rst
 create mode 100644 Documentation/translations/zh_CN/driver-api/io_ordering.rst
 delete mode 100644 Documentation/translations/zh_CN/io_ordering.txt
 delete mode 100644 Documentation/translations/zh_CN/oops-tracing.txt
 delete mode 100644 Documentation/translations/zh_TW/oops-tracing.txt
