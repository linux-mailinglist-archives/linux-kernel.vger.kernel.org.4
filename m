Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037B57435CD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjF3Hc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjF3Hcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:32:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4010811F;
        Fri, 30 Jun 2023 00:32:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7DC7616D3;
        Fri, 30 Jun 2023 07:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0947C433C0;
        Fri, 30 Jun 2023 07:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688110373;
        bh=odjDHapv52yiwIorgPFPpyfEDiNSbN5pwFd1e9SWaqw=;
        h=From:To:Cc:Subject:Date:From;
        b=uUYB6OkG4akaG43sszBMuOWWKm7WLbNAdXU/bzGti2mp7MTOR05E/kjVhngbTZ53j
         z9GTDXu8+Gf8wbNikjZ0fDzc+MxJJ1JNeaTrsvHok8CHAb2OhCl4m+RlYu23XZ/J5I
         PGPd6wSIyiBF2hkOn9Qj/1Tghym5Y89BCrolUtQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 00/33] 6.1.37-rc3 review
Date:   Fri, 30 Jun 2023 09:32:49 +0200
Message-ID: <20230630072124.944461414@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.37-rc3.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.37-rc3
X-KernelTest-Deadline: 2023-07-02T07:21+00:00
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

This is the start of the stable review cycle for the 6.1.37 release.
There are 33 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 02 Jul 2023 07:21:12 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.37-rc3.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.37-rc3

Linus Torvalds <torvalds@linux-foundation.org>
    csky: fix up lock_mm_and_find_vma() conversion

Linus Torvalds <torvalds@linux-foundation.org>
    parisc: fix expand_stack() conversion

Linus Torvalds <torvalds@linux-foundation.org>
    sparc32: fix lock_mm_and_find_vma() conversion

Ricardo Cañuelo <ricardo.canuelo@collabora.com>
    Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe"

Mike Hommey <mh@glandium.org>
    HID: logitech-hidpp: add HIDPP_QUIRK_DELAYED_INIT for the T651.

Jason Gerecke <jason.gerecke@wacom.com>
    HID: wacom: Use ktime_t rather than int when dealing with timestamps

Ludvig Michaelsson <ludvig.michaelsson@yubico.com>
    HID: hidraw: fix data race on device refcount

Zhang Shurong <zhang_shurong@foxmail.com>
    fbdev: fix potential OOB read in fast_imageblit()

Linus Torvalds <torvalds@linux-foundation.org>
    mm: always expand the stack with the mmap write lock held

Linus Torvalds <torvalds@linux-foundation.org>
    execve: expand new process stack manually ahead of time

Liam R. Howlett <Liam.Howlett@oracle.com>
    mm: make find_extend_vma() fail if write lock not held

Linus Torvalds <torvalds@linux-foundation.org>
    powerpc/mm: convert coprocessor fault to lock_mm_and_find_vma()

Linus Torvalds <torvalds@linux-foundation.org>
    mm/fault: convert remaining simple cases to lock_mm_and_find_vma()

Ben Hutchings <ben@decadent.org.uk>
    arm/mm: Convert to using lock_mm_and_find_vma()

Ben Hutchings <ben@decadent.org.uk>
    riscv/mm: Convert to using lock_mm_and_find_vma()

Ben Hutchings <ben@decadent.org.uk>
    mips/mm: Convert to using lock_mm_and_find_vma()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Convert to using lock_mm_and_find_vma()

Linus Torvalds <torvalds@linux-foundation.org>
    arm64/mm: Convert to using lock_mm_and_find_vma()

Linus Torvalds <torvalds@linux-foundation.org>
    mm: make the page fault mmap locking killable

Linus Torvalds <torvalds@linux-foundation.org>
    mm: introduce new 'lock_mm_and_find_vma()' page fault helper

Peng Zhang <zhangpeng.00@bytedance.com>
    maple_tree: fix potential out-of-bounds access in mas_wr_end_piv()

Oliver Hartkopp <socketcan@hartkopp.net>
    can: isotp: isotp_sendmsg(): fix return error fix on TX path

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Cure kexec() vs. mwait_play_dead() breakage

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Use dedicated cache-line for mwait_play_dead()

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Remove pointless wmb()s from native_stop_other_cpus()

Tony Battersby <tonyb@cybernetics.com>
    x86/smp: Dont access non-existing CPUID leaf

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Make stop_other_cpus() more robust

Borislav Petkov (AMD) <bp@alien8.de>
    x86/microcode/AMD: Load late on both threads too

Tony Luck <tony.luck@intel.com>
    mm, hwpoison: when copy-on-write hits poison, take page offline

Tony Luck <tony.luck@intel.com>
    mm, hwpoison: try to recover from copy-on write faults

Paolo Abeni <pabeni@redhat.com>
    mptcp: ensure listener is unhashed before updating the sk status

David Woodhouse <dwmw@amazon.co.uk>
    mm/mmap: Fix error return in do_vmi_align_munmap()

Liam R. Howlett <Liam.Howlett@oracle.com>
    mm/mmap: Fix error path in do_vmi_align_munmap()


-------------

Diffstat:

 Makefile                             |   4 +-
 arch/alpha/Kconfig                   |   1 +
 arch/alpha/mm/fault.c                |  13 +--
 arch/arc/Kconfig                     |   1 +
 arch/arc/mm/fault.c                  |  11 +--
 arch/arm/Kconfig                     |   1 +
 arch/arm/mm/fault.c                  |  63 +++-----------
 arch/arm64/Kconfig                   |   1 +
 arch/arm64/mm/fault.c                |  46 ++--------
 arch/csky/Kconfig                    |   1 +
 arch/csky/mm/fault.c                 |  22 ++---
 arch/hexagon/Kconfig                 |   1 +
 arch/hexagon/mm/vm_fault.c           |  18 +---
 arch/ia64/mm/fault.c                 |  36 ++------
 arch/loongarch/Kconfig               |   1 +
 arch/loongarch/mm/fault.c            |  16 ++--
 arch/m68k/mm/fault.c                 |   9 +-
 arch/microblaze/mm/fault.c           |   5 +-
 arch/mips/Kconfig                    |   1 +
 arch/mips/mm/fault.c                 |  12 +--
 arch/nios2/Kconfig                   |   1 +
 arch/nios2/mm/fault.c                |  17 +---
 arch/openrisc/mm/fault.c             |   5 +-
 arch/parisc/mm/fault.c               |  23 +++--
 arch/powerpc/Kconfig                 |   1 +
 arch/powerpc/mm/copro_fault.c        |  14 +--
 arch/powerpc/mm/fault.c              |  39 +--------
 arch/riscv/Kconfig                   |   1 +
 arch/riscv/mm/fault.c                |  31 +++----
 arch/s390/mm/fault.c                 |   5 +-
 arch/sh/Kconfig                      |   1 +
 arch/sh/mm/fault.c                   |  17 +---
 arch/sparc/Kconfig                   |   1 +
 arch/sparc/mm/fault_32.c             |  32 ++-----
 arch/sparc/mm/fault_64.c             |   8 +-
 arch/um/kernel/trap.c                |  11 +--
 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/cpu.h           |   2 +
 arch/x86/include/asm/smp.h           |   2 +
 arch/x86/kernel/cpu/microcode/amd.c  |   2 +-
 arch/x86/kernel/process.c            |  28 +++++-
 arch/x86/kernel/smp.c                |  73 ++++++++++------
 arch/x86/kernel/smpboot.c            |  81 ++++++++++++++++--
 arch/x86/mm/fault.c                  |  52 +-----------
 arch/xtensa/Kconfig                  |   1 +
 arch/xtensa/mm/fault.c               |  14 +--
 drivers/hid/hid-logitech-hidpp.c     |   2 +-
 drivers/hid/hidraw.c                 |   9 +-
 drivers/hid/wacom_wac.c              |   6 +-
 drivers/hid/wacom_wac.h              |   2 +-
 drivers/iommu/amd/iommu_v2.c         |   4 +-
 drivers/iommu/io-pgfault.c           |   2 +-
 drivers/thermal/mtk_thermal.c        |  14 +--
 drivers/video/fbdev/core/sysimgblt.c |   2 +-
 fs/binfmt_elf.c                      |   6 +-
 fs/exec.c                            |  38 +++++----
 include/linux/highmem.h              |  26 ++++++
 include/linux/mm.h                   |  21 ++---
 lib/maple_tree.c                     |  11 +--
 mm/Kconfig                           |   4 +
 mm/gup.c                             |   6 +-
 mm/memory.c                          | 159 ++++++++++++++++++++++++++++++++---
 mm/mmap.c                            | 154 +++++++++++++++++++++++++--------
 mm/nommu.c                           |  17 ++--
 net/can/isotp.c                      |   5 +-
 net/mptcp/pm_netlink.c               |   1 +
 net/mptcp/protocol.c                 |  26 ++++--
 67 files changed, 682 insertions(+), 559 deletions(-)


