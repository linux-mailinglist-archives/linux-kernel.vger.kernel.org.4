Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A02A640B44
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiLBQxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiLBQxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:53:17 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E35AC7D3E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:53:15 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id s196so4846996pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxL3i93yHy4CBcLBEC/lZOli4Zd30E4xkmWEMKmX6UU=;
        b=Q5fZTvlo9IHzUB1gibPX2necq7Hc7LSBbjGfKMrN+Wtpq22AltCWdZO9t2ycvKQmbN
         Fdr33ngY1tGLVNltrNnjYMas070ID18EyX8f4v6b2t8pbRpv/16tWv5Th6WRlKlfKO/b
         d/AUTnwFK1aC7BMLqmBxoFnEgU2kE7LcdLs/dZNOh+YUIw7DzsFvouiCQ95O3dFYvyKX
         glFyvpOTiNtJJoNlby/SA0R7al2pm2OH0ei9qrBCjtzQjnlSneECKGYyLBvTKgV+MI/w
         rWElJvCfrJ13BHjsSwqWTNyfS6nkbOmbQg7jfCEkwkUK7pbAJokDQSc2L2pjUUZxcXsf
         5hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxL3i93yHy4CBcLBEC/lZOli4Zd30E4xkmWEMKmX6UU=;
        b=1fGHrXVWOqzvwbZaGoDMNW2Io+CHFEtqO9BJ2sz2TUCoYmsHJBv2GfnRWIlCqraSyV
         L/SsOMXHV6ZG2/DSo6HmWSMFT6g31WuOuEhH19M5m4UxUlZv69QEzHMkDWgg4Qp9kB5v
         4qrpi7S/AMXXULgrvlWv8gMeP3hhhAzNZBYUqlrS8H7aVeqY7W8p4EPrOZYbZuCiGfMG
         tzP8W+JPNPdRduS8IBm27wYi3Dxreeg3o1ddRKA4MRucAUiej6Z9mmpUGPF5kDA7j+W6
         a1FmiUQJ9BCOEnFA1iT0BvQP3ruDIJpoytV8Tl/5WECAp7OJr7AyBD9+nyeYLVejKdte
         1znw==
X-Gm-Message-State: ANoB5pl4DM+Fsf3B3Wtg3DZ2yPi+jiAjf0qJe7HqgUpCo82vgiEcwgg7
        T65u0l/M26P3aRlMOelltJwtlA==
X-Google-Smtp-Source: AA0mqf4XcprkvnKP2t8i2b2ADdMpFdyCSdNy15ayzXdHGp4oVDTGkKl6zCFZG3OUUv1Ua75MAiJixg==
X-Received: by 2002:a05:6a00:1d83:b0:56d:c342:ea5e with SMTP id z3-20020a056a001d8300b0056dc342ea5emr52763220pfw.71.1669999994875;
        Fri, 02 Dec 2022 08:53:14 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a15-20020aa78e8f000000b005743cdde1a7sm5303787pfr.82.2022.12.02.08.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:53:14 -0800 (PST)
Date:   Fri, 02 Dec 2022 08:53:14 -0800 (PST)
X-Google-Original-Date: Fri, 02 Dec 2022 08:52:57 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 6.1-rc8
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-ade5e352-1239-4324-aab5-e2fb6a575c25@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fcae44fd36d052e956e69a64642fc03820968d78:

  RISC-V: vdso: Do not add missing symbols to version section in linker script (2022-11-10 15:06:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-rc8

for you to fetch changes up to 39cefc5f6cd25d555e0455b24810e9aff365b8d6:

  RISC-V: Fix a race condition during kernel stack overflow (2022-12-01 11:38:39 -0800)

----------------------------------------------------------------
RISC-V Fixes for 6.1-rc8

* A build-time fix for the NR_CPUS Kconfig SBI version dependency.
* A pair of fixes to early memory initialization, to fix page
  permissions in EFI and post-initmem-free.
* A build-time fix for the VDSO, to avoid trying to profile the VDSO
  functions.
* A pair of fixes for kexec crash handling, to fix multi-core and
  interrupt related initialization inside the crash kernel.
* A fix to avoid a race condition when handling multiple concurrect
  kernel stack overflows.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Sync efi page table's kernel mappings before switching

Björn Töpel (1):
      riscv: mm: Proper page permissions after initmem free

Guo Ren (2):
      riscv: kexec: Fixup irq controller broken in kexec crash path
      riscv: kexec: Fixup crash_smp_send_stop without multi cores

Jisheng Zhang (2):
      riscv: fix race when vmap stack overflow
      riscv: vdso: fix section overlapping under some conditions

Palmer Dabbelt (2):
      Merge patch series "riscv: kexec: Fxiup crash_save percpu and machine_kexec_mask_interrupts"
      RISC-V: Fix a race condition during kernel stack overflow

Samuel Holland (1):
      riscv: Fix NR_CPUS range conditions

 arch/riscv/Kconfig                |  6 +--
 arch/riscv/include/asm/asm.h      |  1 +
 arch/riscv/include/asm/efi.h      |  6 ++-
 arch/riscv/include/asm/pgalloc.h  | 11 +++--
 arch/riscv/include/asm/smp.h      |  3 ++
 arch/riscv/kernel/entry.S         | 13 ++++++
 arch/riscv/kernel/machine_kexec.c | 46 ++++++++++++++-----
 arch/riscv/kernel/setup.c         |  9 ++--
 arch/riscv/kernel/smp.c           | 97 ++++++++++++++++++++++++++++++++++++++-
 arch/riscv/kernel/traps.c         | 18 ++++++++
 arch/riscv/kernel/vdso/Makefile   |  1 +
 11 files changed, 187 insertions(+), 24 deletions(-)
