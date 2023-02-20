Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D500369D0C0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjBTPim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjBTPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:38:40 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEE1CDD8;
        Mon, 20 Feb 2023 07:38:37 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A6D4B735;
        Mon, 20 Feb 2023 15:38:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A6D4B735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1676907516; bh=FN77Eocj/uWlqO6hQ9t5LTrOGHkBhoFvYZuNN+6e0Ls=;
        h=From:To:Cc:Subject:Date:From;
        b=Mr0zAcUZ0CnCCNHpIA/yf/SwtXyjY1RkPIvgeY/ZSdfAGXJEC3VLrthu0uywJ5nOD
         K5CbwLDd5qRca6tzlX34X5JdhobwTe/PzIFEFL6XV+3MKpbgeNLuM4D5qBlW7pS7Bh
         gj6ASXtWE5E3/lICCy0KC9gYwh4WkMIA81dmxDsHmalnEYUlK1FSVDCJBFNJTdoAcb
         7fwnAlD7RE6qZA8IPHmUrD/G2E3pIwv+rNaQ+AekL95fbv3SXCOkpo84Yh3qqZnOZz
         fAENPD0wLUPPw+v5na6W9ewewfagXq08X9xZqqpLSN2rTTGi8wBaGJD98/A+gvJy2S
         CtCEd0j2F6EXw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.3
Date:   Mon, 20 Feb 2023 08:38:35 -0700
Message-ID: <87o7poe490.fsf@meer.lwn.net>
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

The following changes since commit a33ae832bf3f2ac33e2e44b99f76130d3be848c5:

  docs/conf.py: Use about.html only in sidebar of alabaster theme (2023-01-=
11 15:06:50 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.3

for you to fetch changes up to cc29eadef921fe52aa58f32536a93d9ea0ca3eb7:

  Documentation/watchdog/hpwdt: Fix Format (2023-02-16 17:31:29 -0700)

----------------------------------------------------------------
It has been a moderately calm cycle for documentation; the significant
changes include:

- Some significant additions to the memory-management documentation

- Some improvements to navigation in the HTML-rendered docs

- A new document on workload tracing

- More Spanish and Chinese translations

...and the usual set of typo fixes and such.

On the down-side, there is a certain amount of cross-tree fixup work
that has created rather more than the usual number of merge conflicts,
specifically with the ftrace, mm, mm-stable, net-next, and hwmon trees.
They are all annoying but trivial to resolve.  If you'd rather I create
a resolution branch after those other trees are merged, just say the
word.

----------------------------------------------------------------
Bjorn Helgaas (1):
      printk: Document that CONFIG_BOOT_PRINTK_DELAY required for boot_dela=
y=3D

Carlos Bilbao (4):
      docs/sp_SP: Add process code-of-conduct.rst translation
      docs/sp_SP: Add process kernel-enforcement-statement.rst translation
      docs/sp_SP: Add process email-clients translation
      docs/sp_SP: Add process magic-number translation

Chen Xiao (1):
      docs: mm/page_owner: fix spelling mistakes

Conor Dooley (1):
      Documentation: process: Document suitability of Proton Mail for kerne=
l development

Donglin Peng (1):
      docs: ftrace: fix a issue with duplicated subtitle number

Fabio Fantoni (1):
      doc:it_IT: fix of 2 typos

Federico Vaga (4):
      doc: fix typo in botching up ioctls
      doc:it_IT: fix typo in email-client
      doc:it_IT: align Italian documentation
      doc:it_IT: add translation for botching-up-ioctl.rst

Hui Su (1):
      Doc/damon: fix the data path error

Jakob Koschel (1):
      docs/scripts/gdb: add necessary make scripts_gdb step

Jeffrey Hugo (1):
      docs: accel: Fix debugfs path

Jerry Hoemann (2):
      Documentation/watchdog/hpwdt: Fix Reference
      Documentation/watchdog/hpwdt: Fix Format

Jonathan Corbet (3):
      Merge branch 'docs-fixes' into docs-mw
      docs: Add more information to the HTML sidebar
      docs: Use HTML comments for the kernel-toc SPDX line

Jonathan Neusch=C3=A4fer (3):
      Documentation: coccinelle: Escape --options to fix Sphinx output
      scripts: kernel-doc: Remove workaround for @param... syntax
      dma-buf: Add "dma-buf" to title of documentation

Jules Maselbas (1):
      Documentation/mm: Fix typo emluation -> emulation

Kees Cook (1):
      docs: deprecated.rst: Add note about DECLARE_FLEX_ARRAY() usage

Konstantin Ryabitsev (1):
      docs: maintainer-pgp-guide: update for latest gnupg defaults

Lukas Bulwahn (1):
      docs/mm: Physical Memory: correct spelling in reference to CONFIG_PAG=
E_EXTENSION

Mike Rapoport (IBM) (4):
      docs/mm: Physical Memory: add structure, introduction and nodes descr=
iption
      docs/mm: Physical Memory: remove useless markup
      docs/mm: remove useless markup
      docs/admin-guide/mm: remove useless markup

Peter Foley (1):
      Documentation: Avoid duplicate Kconfig inclusion

Randy Dunlap (6):
      Documentation: admin: move OOO entries in kernel-parameters.txt
      Documentation: admin-guide: correct spelling
      Documentation: driver-api: correct spelling
      Documentation: sparc: correct spelling
      Documentation: userspace-api: correct spelling
      Documentation: core-api: padata: correct spelling

Ross Zwisler (1):
      docs: ftrace: always use canonical ftrace path

SeongJae Park (3):
      Docs/subsystem-apis: Remove '[The ]Linux' prefixes from titles of lis=
ted documents
      Docs/driver-api/index: Add missing SPDX License Identifier
      Docs/sound/index: Add missing SPDX License Identifier

Shuah Khan (2):
      docs: leds: fix the following docu build warning
      docs: add workload-tracing document to admin-guide

Sohil Mehta (1):
      x86/vsyscall: Fix documentation to reflect the default mode

Wang Yong (3):
      docs/zh_CN: fix a typo in howto
      Documentation: x86: fix typo in x86_64/mm.rst
      Documentation: KVM: fix typos in running-nested-guests.rst

Wyes Karny (1):
      Documentation: KVM: Update AMD memory encryption link

Yang Yang (1):
      docs: proc.rst: add softnet_stat to /proc/net table

Yanteng Si (14):
      docs/zh_CN: Update the translation of delay-accounting to 6.1-rc8
      docs/zh_CN: Update the translation of kernel-api to 6.1-rc8
      docs/zh_CN: Update the translation of mm-api to 6.1-rc8
      docs/zh_CN: Update the translation of highmem to 6.1-rc8
      docs/zh_CN: Update the translation of page_owner to 6.1-rc8
      docs/zh_CN: Update the translation of kasan to 6.1-rc8
      docs/zh_CN: Update the translation of testing-overview to 6.1-rc8
      docs/zh_CN: Update the translation of reclaim to 6.1-rc8
      docs/zh_CN: Update the translation of start to 6.1-rc8
      docs/zh_CN: Update the translation of usage to 6.1-rc8
      docs/zh_CN: Update the translation of ksm to 6.1-rc8
      docs/zh_CN: Update the translation of msi-howto to 6.1-rc8
      docs/zh_CN: Update the translation of energy-model to 6.1-rc8
      docs/zh_CN: Add a glossary of Chinese translation terms

Yoann Congal (3):
      Documentation: kprobetrace: Fix some typos
      Documentation: kprobetrace: Fix code block markup
      Documentation: kprobetrace: Split paragraphs

Zang Leigang (1):
      docs/zh_CN: add damon lru_sort translation

 Documentation/Kconfig                              |  10 +-
 Documentation/PCI/index.rst                        |   6 +-
 Documentation/accel/introduction.rst               |   2 +-
 Documentation/admin-guide/bcache.rst               |   2 +-
 .../admin-guide/cgroup-v1/blkio-controller.rst     |   2 +-
 Documentation/admin-guide/cgroup-v2.rst            |  10 +-
 Documentation/admin-guide/cifs/usage.rst           |   4 +-
 .../admin-guide/device-mapper/cache-policies.rst   |   2 +-
 Documentation/admin-guide/device-mapper/dm-ebs.rst |   2 +-
 .../admin-guide/device-mapper/dm-zoned.rst         |   2 +-
 .../admin-guide/device-mapper/unstriped.rst        |  10 +-
 Documentation/admin-guide/dynamic-debug-howto.rst  |   2 +-
 Documentation/admin-guide/gpio/gpio-sim.rst        |   2 +-
 Documentation/admin-guide/hw-vuln/mds.rst          |   4 +-
 Documentation/admin-guide/index.rst                |  11 +
 Documentation/admin-guide/kernel-parameters.txt    | 148 ++---
 .../admin-guide/kernel-per-CPU-kthreads.rst        |   2 +-
 .../admin-guide/laptops/thinkpad-acpi.rst          |   2 +-
 Documentation/admin-guide/md.rst                   |   2 +-
 Documentation/admin-guide/media/bttv.rst           |   2 +-
 Documentation/admin-guide/media/building.rst       |   2 +-
 Documentation/admin-guide/media/si476x.rst         |   2 +-
 Documentation/admin-guide/media/vivid.rst          |   2 +-
 Documentation/admin-guide/mm/concepts.rst          |  13 +-
 Documentation/admin-guide/mm/damon/lru_sort.rst    |   4 +-
 Documentation/admin-guide/mm/damon/reclaim.rst     |   4 +-
 Documentation/admin-guide/mm/hugetlbpage.rst       |   6 +-
 .../admin-guide/mm/idle_page_tracking.rst          |   7 +-
 Documentation/admin-guide/mm/index.rst             |   3 +-
 Documentation/admin-guide/mm/ksm.rst               |   2 -
 Documentation/admin-guide/mm/memory-hotplug.rst    |   2 -
 .../admin-guide/mm/numa_memory_policy.rst          |   6 +-
 Documentation/admin-guide/mm/numaperf.rst          |   2 -
 Documentation/admin-guide/mm/pagemap.rst           |  11 +-
 Documentation/admin-guide/mm/shrinker_debugfs.rst  |   2 -
 Documentation/admin-guide/mm/soft-dirty.rst        |   2 -
 Documentation/admin-guide/mm/swap_numa.rst         |   2 -
 Documentation/admin-guide/mm/transhuge.rst         |   2 -
 Documentation/admin-guide/mm/userfaultfd.rst       |   2 -
 Documentation/admin-guide/mm/zswap.rst             |   2 -
 Documentation/admin-guide/perf/hns3-pmu.rst        |   2 +-
 Documentation/admin-guide/pm/amd-pstate.rst        |   2 +-
 Documentation/admin-guide/pm/intel_pstate.rst      |   4 +-
 Documentation/admin-guide/spkguide.txt             |   4 +-
 Documentation/admin-guide/sysctl/vm.rst            |   4 +-
 Documentation/admin-guide/sysrq.rst                |   2 +-
 Documentation/admin-guide/workload-tracing.rst     | 606 +++++++++++++++++=
++++
 Documentation/conf.py                              |   5 +-
 Documentation/core-api/padata.rst                  |   2 +-
 Documentation/core-api/workqueue.rst               |   4 +-
 Documentation/cpu-freq/index.rst                   |   6 +-
 Documentation/crypto/index.rst                     |   6 +-
 Documentation/dev-tools/coccinelle.rst             |   8 +-
 Documentation/dev-tools/gdb-kernel-debugging.rst   |   4 +
 Documentation/driver-api/dma-buf.rst               |   6 +-
 Documentation/driver-api/dmaengine/client.rst      |   2 +-
 Documentation/driver-api/dmaengine/dmatest.rst     |   2 +-
 Documentation/driver-api/hsi.rst                   |   4 +-
 Documentation/driver-api/index.rst                 |   8 +-
 Documentation/driver-api/io-mapping.rst            |   4 +-
 Documentation/driver-api/md/md-cluster.rst         |   2 +-
 Documentation/driver-api/md/raid5-cache.rst        |   2 +-
 Documentation/driver-api/media/drivers/vidtv.rst   |   2 +-
 Documentation/driver-api/media/dtv-demux.rst       |   2 +-
 Documentation/driver-api/media/v4l2-subdev.rst     |   4 +-
 Documentation/driver-api/mei/nfc.rst               |   2 +-
 Documentation/driver-api/nfc/nfc-hci.rst           |   2 +-
 Documentation/driver-api/nvdimm/nvdimm.rst         |   2 +-
 Documentation/driver-api/nvdimm/security.rst       |   2 +-
 Documentation/driver-api/pin-control.rst           |   2 +-
 Documentation/driver-api/pldmfw/index.rst          |   2 +-
 Documentation/driver-api/serial/driver.rst         |   2 +-
 .../driver-api/surface_aggregator/ssh.rst          |   2 +-
 .../driver-api/thermal/intel_powerclamp.rst        |   2 +-
 Documentation/driver-api/usb/dwc3.rst              |   2 +-
 Documentation/driver-api/usb/usb3-debug-port.rst   |   2 +-
 Documentation/filesystems/proc.rst                 |   1 +
 Documentation/gpu/index.rst                        |   6 +-
 Documentation/hid/intel-ish-hid.rst                |   4 +-
 Documentation/hwmon/index.rst                      |   6 +-
 Documentation/input/index.rst                      |   6 +-
 Documentation/leds/index.rst                       |   1 +
 Documentation/mm/active_mm.rst                     |   2 -
 Documentation/mm/arch_pgtable_helpers.rst          |   2 -
 Documentation/mm/balance.rst                       |   2 -
 Documentation/mm/free_page_reporting.rst           |   2 -
 Documentation/mm/frontswap.rst                     |   2 -
 Documentation/mm/highmem.rst                       |   2 -
 Documentation/mm/hmm.rst                           |   4 +-
 Documentation/mm/hugetlbfs_reserv.rst              |   4 +-
 Documentation/mm/hwpoison.rst                      |   2 -
 Documentation/mm/index.rst                         |   6 +-
 Documentation/mm/ksm.rst                           |   4 +-
 Documentation/mm/memory-model.rst                  |   2 -
 Documentation/mm/mmu_notifier.rst                  |   2 -
 Documentation/mm/numa.rst                          |   6 +-
 Documentation/mm/page_frags.rst                    |   2 -
 Documentation/mm/page_migration.rst                |   6 +-
 Documentation/mm/page_owner.rst                    |   6 +-
 Documentation/mm/page_table_check.rst              |   2 -
 Documentation/mm/physical_memory.rst               | 347 ++++++++++++
 Documentation/mm/remap_file_pages.rst              |   2 -
 Documentation/mm/slub.rst                          |   2 -
 Documentation/mm/split_page_table_lock.rst         |   2 -
 Documentation/mm/transhuge.rst                     |   2 -
 Documentation/mm/unevictable-lru.rst               |   2 -
 Documentation/mm/z3fold.rst                        |   2 -
 Documentation/mm/zsmalloc.rst                      |   2 -
 .../device_drivers/ethernet/mellanox/mlx5.rst      |  92 ++--
 Documentation/peci/index.rst                       |   6 +-
 Documentation/process/botching-up-ioctls.rst       |   2 +-
 Documentation/process/deprecated.rst               |  26 +
 Documentation/process/email-clients.rst            |  20 +
 Documentation/process/maintainer-pgp-guide.rst     | 102 +---
 Documentation/scheduler/index.rst                  |   6 +-
 Documentation/scsi/index.rst                       |   6 +-
 Documentation/sound/hd-audio/notes.rst             |   6 +-
 Documentation/sound/index.rst                      |   8 +-
 Documentation/sparc/adi.rst                        |   4 +-
 Documentation/sparc/oradax/dax-hv-api.txt          |  44 +-
 Documentation/sphinx-static/custom.css             |  48 +-
 Documentation/sphinx/templates/kernel-toc.html     |  16 +
 Documentation/trace/events-msr.rst                 |   4 +-
 Documentation/trace/events-nmi.rst                 |   6 +-
 Documentation/trace/events.rst                     |  78 +--
 Documentation/trace/ftrace.rst                     |   6 +-
 Documentation/trace/histogram-design.rst           |  12 +-
 Documentation/trace/histogram.rst                  | 190 +++----
 Documentation/trace/kprobetrace.rst                |  49 +-
 Documentation/trace/mmiotrace.rst                  |  20 +-
 .../postprocess/trace-pagealloc-postprocess.pl     |   4 +-
 .../trace/postprocess/trace-vmscan-postprocess.pl  |   4 +-
 Documentation/trace/tracepoint-analysis.rst        |   8 +-
 Documentation/trace/uprobetracer.rst               |  22 +-
 Documentation/trace/user_events.rst                |  18 +-
 .../translations/it_IT/admin-guide/README.rst      |   2 +-
 .../translations/it_IT/doc-guide/kernel-doc.rst    |   2 +
 .../translations/it_IT/doc-guide/sphinx.rst        |  14 +-
 Documentation/translations/it_IT/index.rst         |  89 ++-
 .../translations/it_IT/kernel-hacking/hacking.rst  |   2 +-
 .../translations/it_IT/process/2.Process.rst       |  15 +-
 .../it_IT/process/7.AdvancedTopics.rst             |   8 +-
 .../it_IT/process/botching-up-ioctls.rst           | 249 +++++++++
 .../translations/it_IT/process/changes.rst         |  11 +
 .../translations/it_IT/process/email-clients.rst   |  69 ++-
 Documentation/translations/it_IT/process/index.rst |   1 +
 .../translations/it_IT/process/kernel-docs.rst     |   4 +-
 .../it_IT/process/maintainer-pgp-guide.rst         |   6 +-
 .../it_IT/process/submitting-patches.rst           |   2 +-
 .../translations/sp_SP/process/code-of-conduct.rst |  97 ++++
 .../translations/sp_SP/process/email-clients.rst   | 374 +++++++++++++
 Documentation/translations/sp_SP/process/index.rst |   4 +
 .../sp_SP/process/kernel-enforcement-statement.rst | 174 ++++++
 .../translations/sp_SP/process/magic-number.rst    |  90 +++
 Documentation/translations/zh_CN/PCI/msi-howto.rst |  11 +
 .../zh_CN/accounting/delay-accounting.rst          |   7 +-
 .../zh_CN/admin-guide/mm/damon/index.rst           |   1 +
 .../zh_CN/admin-guide/mm/damon/lru_sort.rst        | 263 +++++++++
 .../zh_CN/admin-guide/mm/damon/reclaim.rst         |   8 +-
 .../zh_CN/admin-guide/mm/damon/start.rst           |  12 +-
 .../zh_CN/admin-guide/mm/damon/usage.rst           |  68 ++-
 .../translations/zh_CN/admin-guide/mm/index.rst    |   2 +-
 .../translations/zh_CN/admin-guide/mm/ksm.rst      |  50 ++
 .../translations/zh_CN/core-api/kernel-api.rst     |  10 +-
 .../translations/zh_CN/core-api/mm-api.rst         |   2 +-
 .../translations/zh_CN/core-api/workqueue.rst      |   4 +-
 .../translations/zh_CN/dev-tools/kasan.rst         |  74 +--
 .../zh_CN/dev-tools/testing-overview.rst           |  27 +
 Documentation/translations/zh_CN/glossary.rst      |  36 ++
 Documentation/translations/zh_CN/index.rst         |   9 +
 Documentation/translations/zh_CN/mm/highmem.rst    |  20 +-
 Documentation/translations/zh_CN/mm/hmm.rst        |   2 +-
 .../translations/zh_CN/mm/hugetlbfs_reserv.rst     |   2 +-
 Documentation/translations/zh_CN/mm/numa.rst       |   2 +-
 Documentation/translations/zh_CN/mm/page_owner.rst |  17 +-
 .../translations/zh_CN/power/energy-model.rst      |  36 +-
 Documentation/translations/zh_CN/process/howto.rst |   2 +-
 Documentation/userspace-api/iommufd.rst            |   2 +-
 .../userspace-api/media/drivers/st-vgxy61.rst      |   2 +-
 .../media/rc/lirc-set-wideband-receiver.rst        |   2 +-
 Documentation/userspace-api/media/rc/rc-protos.rst |   2 +-
 Documentation/userspace-api/media/rc/rc-tables.rst |   2 +-
 .../userspace-api/media/v4l/dev-sliced-vbi.rst     |   2 +-
 .../media/v4l/ext-ctrls-codec-stateless.rst        |   2 +-
 .../userspace-api/media/v4l/ext-ctrls-jpeg.rst     |   2 +-
 .../userspace-api/media/v4l/hist-v4l2.rst          |   4 +-
 .../userspace-api/media/v4l/pixfmt-yuv-luma.rst    |   2 +-
 .../userspace-api/media/v4l/vidioc-cropcap.rst     |   2 +-
 Documentation/userspace-api/seccomp_filter.rst     |   2 +-
 .../userspace-api/sysfs-platform_profile.rst       |   2 +-
 Documentation/virt/index.rst                       |   6 +-
 .../virt/kvm/x86/amd-memory-encryption.rst         |   2 +-
 .../virt/kvm/x86/running-nested-guests.rst         |   2 +-
 Documentation/watchdog/hpwdt.rst                   |   8 +-
 Documentation/watchdog/index.rst                   |   6 +-
 Documentation/x86/resctrl.rst                      |  18 +-
 Documentation/x86/x86_64/mm.rst                    |   2 +-
 lib/Kconfig.debug                                  |   2 -
 scripts/kernel-doc                                 |  11 -
 199 files changed, 3339 insertions(+), 898 deletions(-)
 create mode 100644 Documentation/admin-guide/workload-tracing.rst
 create mode 100644 Documentation/sphinx/templates/kernel-toc.html
 create mode 100644 Documentation/translations/it_IT/process/botching-up-io=
ctls.rst
 create mode 100644 Documentation/translations/sp_SP/process/code-of-conduc=
t.rst
 create mode 100644 Documentation/translations/sp_SP/process/email-clients.=
rst
 create mode 100644 Documentation/translations/sp_SP/process/kernel-enforce=
ment-statement.rst
 create mode 100644 Documentation/translations/sp_SP/process/magic-number.r=
st
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/damon/l=
ru_sort.rst
 create mode 100644 Documentation/translations/zh_CN/glossary.rst
