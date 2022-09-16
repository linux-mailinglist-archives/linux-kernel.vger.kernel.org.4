Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145105BB040
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiIPPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiIPPbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:31:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD25A5C74
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:31:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ge9so9913201pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date;
        bh=J3xtITp+FBk+leJje4oS/ahkcyhlokVvO9Au9VXbS3o=;
        b=APflXrQEeSAodR3aW/lHhrwTb0mv3QkoUrwkaCnf/Ud/yluQnz5uHcshFadb2HNBE/
         djbfv95JFohSBTsE5jxKqvazVEkKwRv2XIdt6vCzrywIdfttazkSDbngEQa5xp6FhPpL
         wyl3kCEqZ4tI+ztRYolMLRr9Idle/BtYCpfN0tB8U0VjXuqyl8GAt4PBTyZVOOfMT/6k
         A5V+K4jHZMWwAtpoBPriW9iuKaHcDcTszC9IlQhaSv8YbXOLtif8xW5FQ8161MCR22aZ
         i5Zz7WiI6zyVH6AJzrwRHgCF47s/6hKMa79Jx03cU98aAyZ47bqk8Qd6zWigc/OoAyjV
         Zvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J3xtITp+FBk+leJje4oS/ahkcyhlokVvO9Au9VXbS3o=;
        b=oxUG1XTgazlRjRciG9nMhm5ROGEi109ydM7K2KH/tb3KRE0koSvSEQLik1xKT8/F+v
         iXNkmdYqOQbjfrn5UFmknLxJ5apg5QHAx9HjB/eYM85fkelsxXt5TGSJcsOIKNjl8toG
         wEbp3RHX9VPCNzW4LkRfdl40s1lFqTyG1aFFrqKzZE5Jw+4j9ZYqUKm92PA+T1eu7Jic
         Zb9i601Ae7268vcHO4aj1MyfhwuUhNegLExLsVhlK/GQXt93856T3tfgRF17wJHOvNAm
         F8DZ1SfKpMRWRNj7FaDi53WYTgbLjupV2Od1rCLsSXXoFPHW1PjE1bRj5rb1UrRmwHjA
         vDbQ==
X-Gm-Message-State: ACrzQf2rcQq+X0mxUHE3H4PjCqA3lWVYXs0NtWfNyUz62+8Ae28JI8RK
        XGGBxb7h06Mtig0Hcnm7byfV1j8qagCnGh71wZI=
X-Google-Smtp-Source: AMsMyM4Ns3o4TFKs5G1Mi+Ut5fApuqBRUPOUPJZktW5nwF6kbMgiaWfy2K/4RD98XhshOQ5nyfY+hQ==
X-Received: by 2002:a17:902:b194:b0:176:d229:83bd with SMTP id s20-20020a170902b19400b00176d22983bdmr380983plr.174.1663342279425;
        Fri, 16 Sep 2022 08:31:19 -0700 (PDT)
Received: from localhost (vpn-konference.ms.mff.cuni.cz. [195.113.20.101])
        by smtp.gmail.com with ESMTPSA id n18-20020a170903111200b00174d4fabe76sm14979760plh.214.2022.09.16.08.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:31:19 -0700 (PDT)
Date:   Fri, 16 Sep 2022 08:31:19 -0700 (PDT)
X-Google-Original-Date: Fri, 16 Sep 2022 08:31:08 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.0-rc6
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-f5d21762-1321-4d35-927c-d47e0749abc0@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 20e0fbab16003ae23a9e86a64bcb93e3121587ca:

  perf: RISC-V: fix access beyond allocated array (2022-09-08 13:50:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc6

for you to fetch changes up to 5b5f6556027ccb04c731988923c051fd2b2bad18:

  RISC-V: Avoid coupling the T-Head CMOs and Zicbom (2022-09-16 02:59:06 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.0-rc6

* A handful of build fixes for the T-Head errata, including some
  functional issues the compilers found.
* A fix to avoid bad page permission initialization, which manifests on
  systems that may load modules early.
* A fix for a nasty sigreturn bug.

----------------------------------------------------------------
I have one merge conflict as a result of a treewide fix, I'm getting some odd
output from just showing the merge (it's showing some of the fix too), but I
think the merge itself is OK.  My fix is to keep the write lock

-       mmap_read_lock(mm);
++      mmap_write_lock(mm);
 +      ret = walk_page_range_novma(mm, start, end, &pageattr_ops, NULL,
 +                                  &masks);
-       mmap_read_unlock(mm);
++      mmap_write_unlock(mm);

----------------------------------------------------------------
Al Viro (1):
      riscv: fix a nasty sigreturn bug...

Heiko Stuebner (1):
      riscv: make t-head erratas depend on MMU

Palmer Dabbelt (2):
      RISC-V: Clean up the Zicbom block size probing
      RISC-V: Avoid coupling the T-Head CMOs and Zicbom

Randy Dunlap (1):
      riscv: fix RISCV_ISA_SVPBMT kconfig dependency warning

Vladimir Isaev (1):
      riscv: Fix permissions for all mm's during mm init

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/Kconfig.erratas          |  4 +--
 arch/riscv/errata/thead/errata.c    |  1 +
 arch/riscv/include/asm/cacheflush.h |  5 +++
 arch/riscv/include/asm/set_memory.h | 20 +++---------
 arch/riscv/kernel/setup.c           | 13 +-------
 arch/riscv/kernel/signal.c          |  2 ++
 arch/riscv/mm/dma-noncoherent.c     | 23 ++++++++------
 arch/riscv/mm/init.c                | 29 ++++++++++++++---
 arch/riscv/mm/pageattr.c            | 62 ++++++++++++++++++++++++++++++++-----
 10 files changed, 107 insertions(+), 53 deletions(-)
