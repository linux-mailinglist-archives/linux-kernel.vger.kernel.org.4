Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4BF6A5A15
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjB1Nk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjB1Nk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:40:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B52C64F;
        Tue, 28 Feb 2023 05:40:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DBC1B80E19;
        Tue, 28 Feb 2023 13:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97A7C433D2;
        Tue, 28 Feb 2023 13:40:51 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.96-rt61
Date:   Tue, 28 Feb 2023 13:39:50 -0000
Message-ID: <167759159041.179258.17818107373821533412@puck.lan>
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
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.96-rt61 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: e73a1e3f64b939150cafb50f528c3b991d7f1c25

Or to build 5.15.96-rt61 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.96.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.96-rt61.patch.xz


Enjoy!
Clark

Changes from v5.15.95-rt60:
---

Alessandro Astone (2):
      binder: Address corner cases in deferred copy and fixup
      binder: Gracefully handle BINDER_TYPE_FDA objects with num_fds=0

Ankit Nautiyal (1):
      drm/edid: Fix minimum bpc supported with DSC1.2 for HDMI sink

Arnd Bergmann (1):
      binder: fix pointer cast warning

Bitterblue Smith (1):
      wifi: rtl8xxxu: gen2: Turn on the rate control

Christophe Leroy (1):
      powerpc: use generic version of arch_is_kernel_initmem_freed()

Clark Williams (2):
      Merge tag 'v5.15.96' into v5.15-rt
      'Linux 5.15.96-rt61'

Dave Hansen (1):
      uaccess: Add speculation barrier to copy_from_user()

Greg Kroah-Hartman (1):
      Linux 5.15.96

Jason A. Donenfeld (1):
      random: always mix cycle counter in add_latent_entropy()

Jim Mattson (1):
      KVM: VMX: Execute IBPB on emulated VM-exit when guest has IBRS

Kees Cook (1):
      ext4: Fix function prototype mismatch for ext4_feat_ktype

Linus Torvalds (1):
      bpf: add missing header file include

Lucas Stach (1):
      drm/etnaviv: don't truncate physical page address

Lukas Wunner (1):
      wifi: mwifiex: Add missing compatible string for SD8787

Marc Kleine-Budde (1):
      can: kvaser_usb: hydra: help gcc-13 to figure out cmd_len

Michael Ellerman (4):
      powerpc/vmlinux.lds: Ensure STRICT_ALIGN_SIZE is at least page aligned
      powerpc/vmlinux.lds: Add an explicit symbol for the SRWX boundary
      powerpc/64s/radix: Fix crash with unaligned relocated kernel
      powerpc/64s/radix: Fix RWX mapping with relocated kernel

Nathan Chancellor (4):
      kbuild: Add CONFIG_PAHOLE_VERSION
      scripts/pahole-flags.sh: Use pahole-version.sh
      lib/Kconfig.debug: Use CONFIG_PAHOLE_VERSION
      lib/Kconfig.debug: Allow BTF + DWARF5 with pahole 1.21+

Paul Moore (1):
      audit: update the mailing list in MAINTAINERS

Rahul Tanwar (5):
      clk: mxl: Switch from direct readl/writel based IO to regmap based IO
      clk: mxl: Remove redundant spinlocks
      clk: mxl: Add option to override gate clks
      clk: mxl: Fix a clk entry by adding relevant flags
      clk: mxl: syscon_node_to_regmap() returns error pointers

Sean Anderson (2):
      powerpc: dts: t208x: Mark MAC1 and MAC2 as 10G
      powerpc: dts: t208x: Disable 10G on MAC1 and MAC2

Sean Christopherson (2):
      KVM: x86: Fail emulation during EMULTYPE_SKIP on any exception
      KVM: SVM: Skip WRMSR fastpath on VM-Exit if next RIP isn't valid

Todd Kjos (2):
      binder: read pre-translated fds from sender buffer
      binder: defer copies of pre-patched txn data

Vladimir Oltean (1):
      Revert "net/sched: taprio: make qdisc_leaf() see the per-netdev-queue pfifo child qdiscs"

Zhang Wensheng (1):
      nbd: fix possible overflow on 'first_minor' in nbd_dev_add()

Zheng Wang (1):
      drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
---
MAINTAINERS                                        |   3 +-
 Makefile                                           |   2 +-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-2.dtsi |  44 +++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-3.dtsi |  44 +++
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |  20 +-
 arch/powerpc/include/asm/sections.h                |  14 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |  14 +-
 arch/powerpc/mm/book3s32/mmu.c                     |   2 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c           |  28 +-
 arch/x86/kvm/svm/svm.c                             |  10 +-
 arch/x86/kvm/vmx/nested.c                          |  11 +
 arch/x86/kvm/vmx/vmx.c                             |   6 +-
 arch/x86/kvm/x86.c                                 |   4 +-
 drivers/android/binder.c                           | 343 +++++++++++++++++++--
 drivers/block/nbd.c                                |  23 +-
 drivers/clk/x86/Kconfig                            |   5 +-
 drivers/clk/x86/clk-cgu-pll.c                      |  23 +-
 drivers/clk/x86/clk-cgu.c                          | 106 ++-----
 drivers/clk/x86/clk-cgu.h                          |  46 +--
 drivers/clk/x86/clk-lgm.c                          |  18 +-
 drivers/gpu/drm/drm_edid.c                         |   3 +-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c              |   4 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |  17 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |  33 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   8 +-
 fs/ext4/sysfs.c                                    |   7 +-
 include/linux/nospec.h                             |   4 +
 include/linux/random.h                             |   6 +-
 init/Kconfig                                       |   4 +
 kernel/bpf/core.c                                  |   3 +-
 lib/Kconfig.debug                                  |   4 +-
 lib/usercopy.c                                     |   7 +
 localversion-rt                                    |   2 +-
 net/sched/sch_taprio.c                             |   8 +-
 scripts/pahole-flags.sh                            |   2 +-
 scripts/pahole-version.sh                          |  13 +
 37 files changed, 661 insertions(+), 231 deletions(-)
---
