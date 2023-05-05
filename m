Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BFB6F8562
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjEEPRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjEEPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:17:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E39517FE1
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 08:16:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a5197f00e9so13572215ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683299818; x=1685891818;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qi8+DAICG+vLed8EX1L1dnfC/iwc4xCORjv2QSx+NJA=;
        b=kO1JPibf9QW516FD2BzxOrngO/w7aYSfXQt7QmWzO2apTEQFSz+MhWyeVOl0qbLlfa
         9p5jKCNOx4amvNI97/HGFQWuM6iiINeEKVg2Micw3fd/Hs5aXiHBCCnsJuyvYt70CNxa
         jgsGmPGt4SFbpeBQWXeCq9X2l55T+Vx+/PXbUdayC4OQPeS49xJjtE3s56QMjb3umRCc
         d1wSsLqIc8DZFgmS4ptdiB+ShTF9RgjvfnrwBCLLhaV6x9GCzO8KjoV2HE4QteY4BaHY
         OkXYnZQb8c0QRoFFHOEoaAAQ2OW0Pve8u69/ROTsyNnsC1qMKVMly+yfW9YegKa1T19g
         vANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683299818; x=1685891818;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qi8+DAICG+vLed8EX1L1dnfC/iwc4xCORjv2QSx+NJA=;
        b=R2yRSNC+53mCxNDPg/Qf5myjpg+hTpGwsAD/drE07GPk2SJDvtlsMHdqSscUXU5O7w
         ZS5khUM6xwLNOSikjpBahrCdbFTCXUnlViwGkv7QwefQxFnbVdHLhEGMdTBvv71nfSv3
         e9b+c/VWHCVRchMJDf6BXp+X11IrdYd4MSqWFsyx4p1qQs/MB6IjSRPL0ZsBFW2qGWn9
         XEEVmfkoR2jaDKuVYK05RefqtypBao20xHJ6DpPEJdM9A/Z2Tti0laG8AN7MJDjDwJ9G
         shhyAEeimOR4sSvA6yu+otpQ3yUSBWlwjrjIehRFhUyMYH8rzRUgQOKKgF1xFj0t9ALC
         8R1g==
X-Gm-Message-State: AC+VfDwpNzUih/uV5qowgf0GnFmVhlHfVBgn6+NJ2aB9g1x2ft1J01Is
        HO+Rf/B3W+4hIQnVP8MCqTaFljaofqeJ266R/Zg=
X-Google-Smtp-Source: ACHHUZ4OI5DVZy+77TbEw9EWcc14OKqfvOF/eStREFMp4pPfbvAZTIU+QvE9KAYe7uHT7Re3OVPLOQ==
X-Received: by 2002:a17:903:1c8:b0:1a6:f5d5:b809 with SMTP id e8-20020a17090301c800b001a6f5d5b809mr2314752plh.1.1683299818395;
        Fri, 05 May 2023 08:16:58 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id f2-20020a17090a8e8200b0025043a8185dsm27pjo.23.2023.05.05.08.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 08:16:58 -0700 (PDT)
Date:   Fri, 05 May 2023 08:16:58 -0700 (PDT)
X-Google-Original-Date: Fri, 05 May 2023 08:15:15 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.4 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-b783c0bb-3d23-4767-9c69-a39f805a8544@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-6.4-mw1'
The following changes since commit 89d77f71f493a3663b10fa812d17f472935d24be:

  Merge tag 'riscv-for-linus-6.4-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2023-04-28 16:55:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-mw2

for you to fetch changes up to c2d3c8441e3ddbfe41fea9282ddc6ee372e154cd:

  RISC-V: include cpufeature.h in cpufeature.c (2023-05-01 17:19:27 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.4 Merge Window, Part 2

* Support for hibernation.
* .rela.dyn has been moved to init.
* A fix for the SBI probing to allow for implementation-defined
  behavior.
* Various other fixes and cleanups throughout the tree.

----------------------------------------------------------------
There are still a few minor build issues with drivers, but patches are on the
lists.  Aside from that things look good with a merge from Linus' master as of
last night, I've got another test running now but I don't see anything scary.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Move .rela.dyn to the init sections

Andrew Jones (1):
      RISC-V: Align SBI probe implementation with spec

Conor Dooley (3):
      RISC-V: fixup in-flight collision with ARCH_WANT_OPTIMIZE_VMEMMAP rename
      dt-bindings: riscv: explicitly mention assumption of Zicsr & Zifencei support
      RISC-V: include cpufeature.h in cpufeature.c

Guo Ren (1):
      riscv: compat_syscall_table: Fixup compile warning

Nathan Chancellor (1):
      riscv: Adjust dependencies of HAVE_DYNAMIC_FTRACE selection

Palmer Dabbelt (1):
      Merge patch series "RISC-V Hibernation Support"

Randy Dunlap (1):
      RISC-V: fix sifive and thead section mismatches in errata

Sia Jee Heng (4):
      RISC-V: Change suspend_save_csrs and suspend_restore_csrs to public function
      RISC-V: Factor out common code of __cpu_resume_enter()
      RISC-V: mm: Enable huge page support to kernel_page_present() function
      RISC-V: Add arch functions to support hibernation/suspend-to-disk

Song Shuai (1):
      riscv: mm: remove redundant parameter of create_fdt_early_page_table

 Documentation/devicetree/bindings/riscv/cpus.yaml |   6 +
 arch/riscv/Kconfig                                |  23 +-
 arch/riscv/errata/sifive/errata.c                 |   8 +-
 arch/riscv/errata/thead/errata.c                  |   6 +-
 arch/riscv/include/asm/assembler.h                |  82 +++++
 arch/riscv/include/asm/sbi.h                      |   2 +-
 arch/riscv/include/asm/suspend.h                  |  22 ++
 arch/riscv/kernel/Makefile                        |   2 +
 arch/riscv/kernel/asm-offsets.c                   |   5 +
 arch/riscv/kernel/cpu_ops.c                       |   2 +-
 arch/riscv/kernel/cpufeature.c                    |   1 +
 arch/riscv/kernel/hibernate-asm.S                 |  77 ++++
 arch/riscv/kernel/hibernate.c                     | 427 ++++++++++++++++++++++
 arch/riscv/kernel/sbi.c                           |  17 +-
 arch/riscv/kernel/suspend.c                       |   4 +-
 arch/riscv/kernel/suspend_entry.S                 |  34 +-
 arch/riscv/kernel/vmlinux.lds.S                   |  12 +-
 arch/riscv/kvm/main.c                             |   2 +-
 arch/riscv/mm/init.c                              |   6 +-
 arch/riscv/mm/pageattr.c                          |   8 +
 drivers/cpuidle/cpuidle-riscv-sbi.c               |   2 +-
 drivers/perf/riscv_pmu_sbi.c                      |   2 +-
 22 files changed, 682 insertions(+), 68 deletions(-)
 create mode 100644 arch/riscv/include/asm/assembler.h
 create mode 100644 arch/riscv/kernel/hibernate-asm.S
 create mode 100644 arch/riscv/kernel/hibernate.c
