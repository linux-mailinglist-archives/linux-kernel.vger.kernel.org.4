Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F776A12D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBWWbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBWWbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:31:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C04C5FC9;
        Thu, 23 Feb 2023 14:31:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A5846179B;
        Thu, 23 Feb 2023 22:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5405DC433D2;
        Thu, 23 Feb 2023 22:31:32 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.95-rt60
Date:   Thu, 23 Feb 2023 22:30:53 -0000
Message-ID: <167719145359.927110.6042354623217506278@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.95-rt60 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 14158de40ffbfb732e9fefbed801fad50f785fd5

Or to build 5.15.95-rt60 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.95.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.95-rt60.patch.xz


Enjoy!
Clark

Changes from v5.15.94-rt59:
---

Aaron Thompson (1):
      Revert "mm: Always release pages to the buddy allocator in memblock_free_late()."

Alex Deucher (1):
      drm/amd/display: Properly handle additional cases where DCN is not supported

Amit Engel (1):
      nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association

Andrew Morton (1):
      revert "squashfs: harden sanity check in squashfs_read_xattr_id_table"

Andrey Konovalov (1):
      net: stmmac: do not stop RX_CLK in Rx LPI state for qcs404 SoC

Arnd Bergmann (2):
      ASoC: cs42l56: fix DT probe
      platform/x86/amd: pmc: add CONFIG_SERIO dependency

Baowen Zheng (1):
      flow_offload: fill flags to action structure

Ben Skeggs (1):
      drm/nouveau/devinit/tu102-: wait for GFW_BOOT_PROGRESS == COMPLETED

Bo Liu (1):
      ALSA: hda/conexant: add a new hda codec SN6180

Cezary Rojewski (1):
      ALSA: hda: Do not unset preset when cleaning up codec

Clark Williams (2):
      Merge tag 'v5.15.95' into v5.15-rt
      'Linux 5.15.95-rt60'

Cristian Ciocaltea (1):
      net: stmmac: Restrict warning on disabling DMA store and fwd mode

Dan Carpenter (1):
      net: sched: sch: Fix off by one in htb_activate_prios()

Darrick J. Wong (2):
      xfs: purge dquots after inode walk fails during quotacheck
      xfs: don't leak btree cursor when insrec fails after a split

Dave Chinner (8):
      xfs: zero inode fork buffer at allocation
      xfs: fix potential log item leak
      xfs: detect self referencing btree sibling pointers
      xfs: set XFS_FEAT_NLINK correctly
      xfs: validate v5 feature fields
      xfs: avoid unnecessary runtime sibling pointer endian conversions
      xfs: don't assert fail on perag references on teardown
      xfs: assert in xfs_btree_del_cursor should take into account error

Eduard Zingerman (1):
      selftests/bpf: Verify copy_register_state() preserves parent/live fields

Felix Riemann (1):
      net: Fix unwanted sign extension in netdev_stats_to_stats64()

Florian Westphal (1):
      netfilter: nft_tproxy: restrict to prerouting hook

Gaosheng Cui (1):
      nvmem: core: add error handling for dev_set_name

Greg Kroah-Hartman (2):
      kvm: initialize all of the kvm_debugregs structure before sending it to userspace
      Linux 5.15.95

Guillaume Nault (2):
      ipv6: Fix datagram socket connection with DSCP.
      ipv6: Fix tcp socket connection with DSCP.

Guo Ren (1):
      riscv: kprobe: Fixup misaligned load text

Hangyu Hua (1):
      net: openvswitch: fix possible memory leak in ovs_meter_cmd_set()

Hans de Goede (2):
      platform/x86: touchscreen_dmi: Add Chuwi Vi8 (CWI501) DMI match
      platform/x86: amd-pmc: Fix compilation when CONFIG_DEBUGFS is disabled

Hyunwoo Kim (1):
      net/rose: Fix to not accept on connected socket

Isaac J. Manjarres (1):
      of: reserved_mem: Have kmemleak ignore dynamically allocated reserved mem

Jakub Kicinski (1):
      net: mpls: fix stale pointer if allocation fails during device rename

Jakub Sitnicki (1):
      bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself

Jason Xing (3):
      ixgbe: allow to increase MTU to 3K with XDP enabled
      i40e: add double of VLAN header when computing the max MTU
      ixgbe: add double of VLAN header when computing the max MTU

Johannes Zink (1):
      net: stmmac: fix order of dwmac5 FlexPPS parametrization sequence

Kailang Yang (1):
      ALSA: hda/realtek - fixed wrong gpio assigned

Kees Cook (1):
      net: sched: sch: Bounds check priority

Kuniyuki Iwashima (2):
      tcp: Fix listen() regression in 5.15.88.
      dccp/tcp: Avoid negative sk_forward_alloc by ipv6_pinfo.pktoptions.

Leo Li (1):
      drm/amd/display: Fail atomic_check early on normalize_zpos error

Mario Limonciello (3):
      ACPI / x86: Add support for LPS0 callback handler
      platform/x86: amd-pmc: Correct usage of SMU version
      platform/x86/amd: pmc: Disable IRQ1 wakeup for RN/CZN

Masami Hiramatsu (1):
      kprobes: treewide: Cleanup the error messages for kprobes

Matt Roper (1):
      drm/i915/gen11: Wa_1408615072/Wa_1407596294 should be on GT list

Michael Chan (1):
      bnxt_en: Fix mqprio and XDP ring checking logic

Mike Kravetz (1):
      hugetlb: check for undefined shift on 32 bit architectures

Miko Larsson (1):
      net/usb: kalmia: Don't pass act_len in usb_bulk_msg error path

Misono Tomohiro (1):
      selftest/lkdtm: Skip stack-entropy test if lkdtm is not available

Munehisa Kamata (1):
      sched/psi: Fix use-after-free in ep_remove_wait_queue()

Natalia Petrova (1):
      i40e: Add checking for null for nlmsg_find_attr()

Paolo Abeni (2):
      mptcp: fix locking for in-kernel listener creation
      mptcp: do not wait for bare sockets' timeout

Paul Cercueil (1):
      mmc: jz4740: Work around bug on JZ4760(B)

Pedro Tammela (3):
      net/sched: tcindex: update imperfect hash filters respecting rcu
      net/sched: act_ctinfo: use percpu stats
      net/sched: tcindex: search key must be 16 bits

Pierre-Louis Bossart (3):
      ASoC: Intel: sof_rt5682: always set dpcm_capture for amplifiers
      ASoC: Intel: sof_cs42l42: always set dpcm_capture for amplifiers
      ASoC: SOF: Intel: hda-dai: fix possible stream_tag leak

Pietro Borrello (1):
      sctp: sctp_sock_filter(): avoid list_entry() on possibly empty list

Qian Yingjin (1):
      mm/filemap: fix page end in filemap_get_read_batch

Rafał Miłecki (1):
      net: bgmac: fix BCM5358 support by setting correct flags

Raviteja Goud Talla (1):
      drm/i915/gen11: Moving WAs to icl_gt_workarounds_init()

Russell King (Oracle) (3):
      nvmem: core: fix cleanup after dev_set_name()
      nvmem: core: fix registration vs use race
      nvmem: core: fix return value

Ryusuke Konishi (1):
      nilfs2: fix underflow in second superblock position calculations

Sanket Goswami (1):
      platform/x86: amd-pmc: Export Idlemask values based on the APU

Seth Jenkins (1):
      aio: fix mremap after fork null-deref

Shunsuke Mie (1):
      tools/virtio: fix the vringh test for virtio ring changes

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw: Add RX DMA Channel Teardown Quirk

Thomas Gleixner (1):
      alarmtimer: Prevent starvation by small intervals and SIG_IGN

Vasily Gorbik (1):
      s390/decompressor: specify __decompress() buf len to avoid overflow

Yang Yingliang (2):
      mmc: sdio: fix possible resource leaks in some error paths
      mmc: mmc_spi: fix error handling in mmc_spi_probe()
---
Makefile                                           |   2 +-
 arch/arm/probes/kprobes/core.c                     |   4 +-
 arch/arm64/kernel/probes/kprobes.c                 |   5 +-
 arch/csky/kernel/probes/kprobes.c                  |  10 +-
 arch/mips/kernel/kprobes.c                         |  11 +-
 arch/riscv/kernel/probes/kprobes.c                 |  17 +-
 arch/s390/boot/compressed/decompressor.c           |   2 +-
 arch/s390/kernel/kprobes.c                         |   4 +-
 arch/x86/kvm/x86.c                                 |   3 +-
 drivers/acpi/x86/s2idle.c                          |  40 +++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  17 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |  32 ++--
 .../gpu/drm/nouveau/nvkm/subdev/devinit/tu102.c    |  23 +++
 drivers/mmc/core/sdio_bus.c                        |  17 +-
 drivers/mmc/core/sdio_cis.c                        |  12 --
 drivers/mmc/host/jz4740_mmc.c                      |  10 ++
 drivers/mmc/host/mmc_spi.c                         |   8 +-
 drivers/net/ethernet/broadcom/bgmac-bcma.c         |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  28 ++--
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |   2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  12 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h           |   1 +
 drivers/net/usb/kalmia.c                           |   8 +-
 drivers/nvme/target/fc.c                           |   4 +-
 drivers/nvmem/core.c                               |  41 ++---
 drivers/of/of_reserved_mem.c                       |   3 +-
 drivers/platform/x86/Kconfig                       |   1 +
 drivers/platform/x86/amd-pmc.c                     | 116 ++++++++++++++
 drivers/platform/x86/touchscreen_dmi.c             |   9 ++
 fs/aio.c                                           |   4 +
 fs/nilfs2/ioctl.c                                  |   7 +
 fs/nilfs2/super.c                                  |   9 ++
 fs/nilfs2/the_nilfs.c                              |   8 +-
 fs/squashfs/xattr_id.c                             |   2 +-
 fs/xfs/libxfs/xfs_ag.c                             |   3 +-
 fs/xfs/libxfs/xfs_btree.c                          | 175 ++++++++++++++++-----
 fs/xfs/libxfs/xfs_inode_fork.c                     |  12 +-
 fs/xfs/libxfs/xfs_sb.c                             |  70 +++++++--
 fs/xfs/xfs_bmap_item.c                             |   2 +
 fs/xfs/xfs_icreate_item.c                          |   1 +
 fs/xfs/xfs_qm.c                                    |   9 +-
 fs/xfs/xfs_refcount_item.c                         |   2 +
 fs/xfs/xfs_rmap_item.c                             |   2 +
 include/linux/acpi.h                               |  10 +-
 include/linux/hugetlb.h                            |   5 +-
 include/linux/stmmac.h                             |   1 +
 include/net/sock.h                                 |  13 ++
 kernel/kprobes.c                                   |  36 ++---
 kernel/sched/psi.c                                 |   7 +-
 kernel/time/alarmtimer.c                           |  33 +++-
 localversion-rt                                    |   2 +-
 mm/filemap.c                                       |   5 +-
 mm/memblock.c                                      |   8 +-
 net/core/dev.c                                     |   2 +-
 net/core/sock_map.c                                |  61 +++----
 net/dccp/ipv6.c                                    |   7 +-
 net/ipv4/inet_connection_sock.c                    |   1 +
 net/ipv6/datagram.c                                |   2 +-
 net/ipv6/tcp_ipv6.c                                |  11 +-
 net/mpls/af_mpls.c                                 |   4 +
 net/mptcp/pm_netlink.c                             |  10 +-
 net/mptcp/protocol.c                               |   9 ++
 net/mptcp/subflow.c                                |   2 +-
 net/netfilter/nft_tproxy.c                         |   8 +
 net/openvswitch/meter.c                            |   4 +-
 net/rose/af_rose.c                                 |   8 +
 net/sched/act_bpf.c                                |   2 +-
 net/sched/act_connmark.c                           |   2 +-
 net/sched/act_ctinfo.c                             |   6 +-
 net/sched/act_gate.c                               |   2 +-
 net/sched/act_ife.c                                |   2 +-
 net/sched/act_ipt.c                                |   2 +-
 net/sched/act_mpls.c                               |   2 +-
 net/sched/act_nat.c                                |   2 +-
 net/sched/act_pedit.c                              |   2 +-
 net/sched/act_police.c                             |   2 +-
 net/sched/act_sample.c                             |   2 +-
 net/sched/act_simple.c                             |   2 +-
 net/sched/act_skbedit.c                            |   2 +-
 net/sched/act_skbmod.c                             |   2 +-
 net/sched/cls_tcindex.c                            |  34 +++-
 net/sched/sch_htb.c                                |   5 +-
 net/sctp/diag.c                                    |   4 +-
 sound/pci/hda/hda_bind.c                           |   2 +
 sound/pci/hda/hda_codec.c                          |   1 -
 sound/pci/hda/patch_conexant.c                     |   1 +
 sound/pci/hda/patch_realtek.c                      |   2 +-
 sound/soc/codecs/cs42l56.c                         |   6 -
 sound/soc/intel/boards/sof_cs42l42.c               |   3 +
 sound/soc/intel/boards/sof_rt5682.c                |   5 +-
 sound/soc/sof/intel/hda-dai.c                      |   8 +-
 .../selftests/bpf/verifier/search_pruning.c        |  36 +++++
 tools/testing/selftests/lkdtm/stack-entropy.sh     |  16 +-
 tools/virtio/linux/bug.h                           |   8 +-
 tools/virtio/linux/build_bug.h                     |   7 +
 tools/virtio/linux/cpumask.h                       |   7 +
 tools/virtio/linux/gfp.h                           |   7 +
 tools/virtio/linux/kernel.h                        |   1 +
 tools/virtio/linux/kmsan.h                         |  12 ++
 tools/virtio/linux/scatterlist.h                   |   1 +
 tools/virtio/linux/topology.h                      |   7 +
 107 files changed, 935 insertions(+), 295 deletions(-)
---
