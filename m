Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8FE74B4A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjGGPvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGGPvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:51:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318A91723
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:51:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8a44ee159so10922265ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688745074; x=1691337074;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23cqmaEm1+rrwu4ItjV07c6c0kx8Bev4W0iEP8t8VCI=;
        b=U10ZQQZsDLQHXCqxVXq6yUQsji0YGHTfX2ZCsMxoVeh48lPWeUbidTGBNGS5mLBnZM
         P8XoZ8iExj7zEgD0S4gJ6qC9Jh7CrjjgLa9jQyS3Ud3ywSt7pSprhqrue1PYsxDah8rD
         nCdpomZDXWTJw8aj5BR2l2ufxGSYdCIKVYe0ILFVgNpZszjXevgxmKk6UfnzkfoTnPRQ
         vBcFynlRh1tNP13Ys+8Xu6tBZG2AL2c6iFDJXnJdqeICS20ivKmU4DI6RWDr+yWeIdDR
         Hsx6ydU0HIlF4PPwXaUhgMdRz08/SE2TnHKEzZEvjznxV7f0l1aEFgNUrz9F/CDV0Bll
         5E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745074; x=1691337074;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23cqmaEm1+rrwu4ItjV07c6c0kx8Bev4W0iEP8t8VCI=;
        b=CE1LjnNT/++J9FQnivYZ+MtbxT6QdjAsOhv/7Bjs/goM09VEOCWfGryANhFD/kp/8B
         8krO8/xtLJb5CSfheywRHVu09fBp/kT4tnxtOXK+lkKbkqhmdVoobWtshQwIvGVkU3eh
         K1ScI5YN1TDBChSiqwHFXIKW56XwiV+atz1DGnQQKgmPGBdQePIPzY74zH8Y1mHFLe1m
         OU8cVIzrqnIUXscBwfpJdFTLP2BdcxhSsN5pbnnfMUmko5mbZzofWupTjJLKy3xreyGN
         ENASAvG+qSYu6F+nFV6IOdYaWrSMTXzZ59pnFc9/y+Q9yLXMlBPsFX7CHHsjSeUf+kmb
         hgqg==
X-Gm-Message-State: ABy/qLblZUMPu5PfAZY0lkW9SXvgaxHmzI1NRG0x3wAFSwQDQVv5YbIE
        TNQMhdgdwMqkaRXn26To+LmRe6Z83QIlQ1Ygy74=
X-Google-Smtp-Source: APBJJlE3eojbqcmQROaqORyMFmvhpy4Zwg4fksxax5v7BA6ga0UBhHagU0OKgJqGLKZAwZtC3fMNGA==
X-Received: by 2002:a17:902:e5c1:b0:1b6:4bbd:c3a3 with SMTP id u1-20020a170902e5c100b001b64bbdc3a3mr4836177plf.52.1688745074445;
        Fri, 07 Jul 2023 08:51:14 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902694600b001b53d3d8f3dsm3415493plt.299.2023.07.07.08.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 08:51:13 -0700 (PDT)
Date:   Fri, 07 Jul 2023 08:51:13 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jul 2023 08:51:06 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.5 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-4bd23a4e-dd7c-4f62-90c8-804c137c2621@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-6.5-mw1'
The following changes since commit 533925cb760431cb496a8c965cfd765a1a21d37e:

  Merge tag 'riscv-for-linus-6.5-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2023-06-30 09:37:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-mw2

for you to fetch changes up to e8605e8fdf42642048b7e59141deaf8e4cf06d71:

  Merge patch series "riscv: some CMO alternative related clean up" (2023-07-06 10:32:38 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.5 Merge Window, Part 2

* A bunch of fixes/cleanups from the first part of the merge window,
  mostly related to ACPI and vector as those were large.
* Some documentation improvements, mostly related to the new code.
* The "riscv,isa" DT key is deprecated.
* Support for link-time dead code elimination.
* Support for minor fault registration in userfaultd.
* A handful of cleanups around CMO alternatives.

----------------------------------------------------------------
The batch from yesterday morning didn't make it to linux-next, I just screwed
up and forgot to move them off staging in time.  They're all fairly small and
still pass my tests, but I don't really like to skip linux-next so I figured
I'd say something.

Aside from that, things look fairly sane for what was a pretty large merge
window.  There's one outstanding bug related to mapping symbols that manifests
in some randconfigs, there's a fix out already [1].  That's not a merge window
regression though, so I think it's safe to proceed.  There's also a handful of
the normal merge window all{yes,mod}config issues, they have fixes on the lists
as well.

1: https://lore.kernel.org/all/437ac153-620c-2012-7ce3-66442b505972@infradead.org/

----------------------------------------------------------------
Andy Chiu (3):
      riscv: vector: only enable interrupts in the first-use trap
      riscv: vector: clear V-reg in the first-use trap
      selftests: Test RISC-V Vector's first-use handler

Ben Dooks (1):
      riscv: vdso: include vdso/vsyscall.h for vdso_data

Björn Töpel (1):
      riscv: Discard vector state on syscalls

Conor Dooley (2):
      RISC-V: drop error print from riscv_hartid_to_cpuid()
      dt-bindings: riscv: deprecate riscv,isa

Jisheng Zhang (6):
      riscv: move options to keep entries sorted
      riscv: vmlinux-xip.lds.S: remove .alternative section
      vmlinux.lds.h: use correct .init.data.* section name
      riscv: errata: thead: only set cbom size & noncoherent during boot
      riscv: mm: mark CBO relate initialization funcs as __init
      riscv: mm: mark noncoherent_supported as __ro_after_init

John Hubbard (1):
      mm: riscv: fix an unsafe pte read in huge_pte_alloc()

Marc Zyngier (1):
      risc-v: Fix order of IPI enablement vs RCU startup

Nick Desaulniers (1):
      riscv: disable HAVE_LD_DEAD_CODE_DATA_ELIMINATION for LLD

Palmer Dabbelt (5):
      RISC-V: Document that V registers are clobbered on syscalls
      RISC-V: Fix up some vector state related build failures
      Merge patch series "riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION"
      RISC-V: Document the ISA string parsing rules for ACPI
      Merge patch series "riscv: some CMO alternative related clean up"

Samuel Holland (1):
      riscv: Select HAVE_ARCH_USERFAULTFD_MINOR

Song Shuai (1):
      riscv: Enable ARCH_SUSPEND_POSSIBLE for s2idle

Woody Zhang (1):
      riscv: move memblock_allow_resize() after linear mapping is ready

Zhangjin Wu (1):
      riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION

 Documentation/devicetree/bindings/riscv/cpus.yaml  |  43 ++--
 .../devicetree/bindings/riscv/extensions.yaml      | 250 +++++++++++++++++++++
 Documentation/riscv/acpi.rst                       |  10 +
 Documentation/riscv/index.rst                      |   1 +
 Documentation/riscv/vector.rst                     |   8 +
 arch/riscv/Kconfig                                 |  18 +-
 arch/riscv/errata/thead/errata.c                   |   7 +-
 arch/riscv/include/asm/vector.h                    |  34 +++
 arch/riscv/include/uapi/asm/sigcontext.h           |   4 +
 arch/riscv/kernel/smp.c                            |   1 -
 arch/riscv/kernel/smpboot.c                        |   5 +-
 arch/riscv/kernel/traps.c                          |  10 +-
 arch/riscv/kernel/vdso.c                           |   1 +
 arch/riscv/kernel/vector.c                         |   1 +
 arch/riscv/kernel/vmlinux-xip.lds.S                |   6 -
 arch/riscv/kernel/vmlinux.lds.S                    |   6 +-
 arch/riscv/mm/cacheflush.c                         |   8 +-
 arch/riscv/mm/dma-noncoherent.c                    |   2 +-
 arch/riscv/mm/hugetlbpage.c                        |   6 +-
 arch/riscv/mm/init.c                               |   4 +-
 include/asm-generic/vmlinux.lds.h                  |   2 +-
 tools/testing/selftests/riscv/vector/.gitignore    |   1 +
 tools/testing/selftests/riscv/vector/Makefile      |   6 +-
 .../selftests/riscv/vector/v_initval_nolibc.c      |  68 ++++++
 24 files changed, 449 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/extensions.yaml
 create mode 100644 Documentation/riscv/acpi.rst
 create mode 100644 tools/testing/selftests/riscv/vector/v_initval_nolibc.c
