Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877AA74491D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjGANKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 09:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGANKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 09:10:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F43C11;
        Sat,  1 Jul 2023 06:10:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B762860B6D;
        Sat,  1 Jul 2023 13:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88ABC433C7;
        Sat,  1 Jul 2023 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688217048;
        bh=2FfhhZvhXaZttWQuqFYDEZ3PCX9WU3A+y5zDn4gz3NQ=;
        h=From:To:Cc:Subject:Date:From;
        b=2Bfnzne5ibFzQaFm9O1qJlq5QWbrveybnKHA+0GlvIPj1J8h5hTJg0UMCMew3CJbG
         HehDZEl42TwSxwhFd71+0l2swxuHAb0yVRRWR3gIfQHbNkYQcNGTKD9e01DAkOmLI+
         PTIOglyH/miDnjfFQ9vrXVKTMOl/dz6pYS6TRsBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.4.1
Date:   Sat,  1 Jul 2023 15:10:39 +0200
Message-ID: <2023070140-refreeze-rake-ddd3@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.4.1 kernel.

All users of the 6.4 kernel series must upgrade.

The updated 6.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                  |    2 
 arch/alpha/Kconfig                        |    1 
 arch/alpha/mm/fault.c                     |   13 ---
 arch/arc/Kconfig                          |    1 
 arch/arc/mm/fault.c                       |   11 --
 arch/arm/Kconfig                          |    1 
 arch/arm/mm/fault.c                       |   63 +++-----------
 arch/arm64/Kconfig                        |    1 
 arch/arm64/mm/fault.c                     |   47 +----------
 arch/csky/Kconfig                         |    1 
 arch/csky/mm/fault.c                      |   22 +----
 arch/hexagon/Kconfig                      |    1 
 arch/hexagon/mm/vm_fault.c                |   18 ----
 arch/ia64/mm/fault.c                      |   36 +-------
 arch/loongarch/Kconfig                    |    1 
 arch/loongarch/mm/fault.c                 |   16 +--
 arch/m68k/mm/fault.c                      |    9 +-
 arch/microblaze/mm/fault.c                |    5 -
 arch/mips/Kconfig                         |    1 
 arch/mips/mm/fault.c                      |   12 --
 arch/nios2/Kconfig                        |    1 
 arch/nios2/mm/fault.c                     |   17 ----
 arch/openrisc/mm/fault.c                  |    5 -
 arch/parisc/mm/fault.c                    |   23 ++---
 arch/powerpc/Kconfig                      |    1 
 arch/powerpc/mm/copro_fault.c             |   14 ---
 arch/powerpc/mm/fault.c                   |   39 ---------
 arch/riscv/Kconfig                        |    1 
 arch/riscv/mm/fault.c                     |   31 +++----
 arch/s390/mm/fault.c                      |    5 -
 arch/sh/Kconfig                           |    1 
 arch/sh/mm/fault.c                        |   17 ----
 arch/sparc/Kconfig                        |    1 
 arch/sparc/mm/fault_32.c                  |   32 +------
 arch/sparc/mm/fault_64.c                  |    8 +
 arch/um/kernel/trap.c                     |   11 +-
 arch/x86/Kconfig                          |    1 
 arch/x86/include/asm/cpu.h                |    2 
 arch/x86/include/asm/smp.h                |    2 
 arch/x86/kernel/cpu/microcode/amd.c       |    2 
 arch/x86/kernel/process.c                 |   28 +++++-
 arch/x86/kernel/smp.c                     |   73 ++++++++++-------
 arch/x86/kernel/smpboot.c                 |   81 +++++++++++++++++--
 arch/x86/mm/fault.c                       |   52 ------------
 arch/xtensa/Kconfig                       |    1 
 arch/xtensa/mm/fault.c                    |   14 ---
 drivers/cpufreq/amd-pstate.c              |    2 
 drivers/hid/hid-logitech-hidpp.c          |    2 
 drivers/hid/hidraw.c                      |    9 +-
 drivers/hid/wacom_wac.c                   |    6 -
 drivers/hid/wacom_wac.h                   |    2 
 drivers/iommu/amd/iommu_v2.c              |    4 
 drivers/iommu/iommu-sva.c                 |    2 
 drivers/thermal/mediatek/auxadc_thermal.c |   14 ---
 drivers/video/fbdev/core/sysimgblt.c      |    2 
 fs/binfmt_elf.c                           |    6 -
 fs/exec.c                                 |   38 +++++---
 include/linux/mm.h                        |   17 +---
 lib/maple_tree.c                          |   11 +-
 mm/Kconfig                                |    4 
 mm/gup.c                                  |   14 ++-
 mm/khugepaged.c                           |    7 -
 mm/memory.c                               |  127 ++++++++++++++++++++++++++++++
 mm/mmap.c                                 |  121 ++++++++++++++++++++++++----
 mm/nommu.c                                |   18 +++-
 net/can/isotp.c                           |    5 -
 66 files changed, 611 insertions(+), 525 deletions(-)

Ben Hutchings (3):
      mips/mm: Convert to using lock_mm_and_find_vma()
      riscv/mm: Convert to using lock_mm_and_find_vma()
      arm/mm: Convert to using lock_mm_and_find_vma()

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Load late on both threads too

Greg Kroah-Hartman (1):
      Linux 6.4.1

Hugh Dickins (1):
      mm/khugepaged: fix regression in collapse_file()

Jason Gerecke (1):
      HID: wacom: Use ktime_t rather than int when dealing with timestamps

Liam R. Howlett (1):
      mm: make find_extend_vma() fail if write lock not held

Linus Torvalds (12):
      mm: introduce new 'lock_mm_and_find_vma()' page fault helper
      mm: make the page fault mmap locking killable
      arm64/mm: Convert to using lock_mm_and_find_vma()
      mm/fault: convert remaining simple cases to lock_mm_and_find_vma()
      powerpc/mm: convert coprocessor fault to lock_mm_and_find_vma()
      execve: expand new process stack manually ahead of time
      mm: always expand the stack with the mmap write lock held
      gup: add warning if some caller would seem to want stack expansion
      sparc32: fix lock_mm_and_find_vma() conversion
      parisc: fix expand_stack() conversion
      csky: fix up lock_mm_and_find_vma() conversion
      xtensa: fix NOMMU build with lock_mm_and_find_vma() conversion

Ludvig Michaelsson (1):
      HID: hidraw: fix data race on device refcount

Michael Ellerman (1):
      powerpc/mm: Convert to using lock_mm_and_find_vma()

Mike Hommey (1):
      HID: logitech-hidpp: add HIDPP_QUIRK_DELAYED_INIT for the T651.

Oliver Hartkopp (1):
      can: isotp: isotp_sendmsg(): fix return error fix on TX path

Peng Zhang (1):
      maple_tree: fix potential out-of-bounds access in mas_wr_end_piv()

Ricardo Cañuelo (1):
      Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe"

Thomas Gleixner (4):
      x86/smp: Make stop_other_cpus() more robust
      x86/smp: Remove pointless wmb()s from native_stop_other_cpus()
      x86/smp: Use dedicated cache-line for mwait_play_dead()
      x86/smp: Cure kexec() vs. mwait_play_dead() breakage

Tony Battersby (1):
      x86/smp: Dont access non-existing CPUID leaf

Wyes Karny (1):
      cpufreq: amd-pstate: Make amd-pstate EPP driver name hyphenated

Zhang Shurong (1):
      fbdev: fix potential OOB read in fast_imageblit()

