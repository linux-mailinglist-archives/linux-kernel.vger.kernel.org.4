Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5768B611A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJ1Slg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJ1Sle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:41:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F713237F82
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:41:33 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so10630963pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsTgJLrX7K95YgJ1S9Ds5IL+IAplewL1J/fAJJQXyII=;
        b=v1GtW7utyd3bbfbep3QDuKfccWB/JumKSM+Da2BFIUewslryZyGSUex4kW+pJ/iY6X
         1sTL8J5JIExK72UTnSAduVDWOSECQw97mWtJRn/sqYkTfsa42mWyo23+0DInr+6of7vS
         qkFrfX6LQPa/C2CuM4EKqd3raapwl9akdvaBQEro0Ll8niHHvEe05e09hz4d8WBJ49Vh
         FvGTwj8vdlev5ceutoi40hrHmbw+Deb17Nz58y+3ASkFkSWruVyX0euEkMoDkbNKfUV5
         yJMGLhFqEzKOG9qrxPj1KhcVys/CTkdNZONn7V+ZU5d02j3aeiumxnSK7GnaKnnxKVhW
         vN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsTgJLrX7K95YgJ1S9Ds5IL+IAplewL1J/fAJJQXyII=;
        b=7VeFFrTEXDP3kTYJ0VPuG84t9JcYA/3gCgV0A3KA7tGvfX4FDJXbKNyprYCTEFSyf5
         qeKNLB9qVnEEIEQJZO4am6krAn/2ScVUCuukIrNFOrVzF78VsDn+chvXVto9KUB1yNUd
         eQfI7pD5I9zZCprq+ZK22uFj2EjZOkAHta35sGsDo6IYo2AHyrogUd5m8eg5GhSRtcGV
         +/lWBVi//U0x+FWzyLu1sYV+dLoa16n2+rotTlZ5DqnXqmu8gN3PLHG5OyYdwdNhrZhT
         2OWJYVl0SL1kbwTdSWwvvwSYZXZlgzTo93lfI9XDPcOUJW45BRmAHwjwC8xGvhQlhbQY
         k3ew==
X-Gm-Message-State: ACrzQf1j/HUwXk7Z1fx32oHTykk9frchPUZVkfCGULkblgxqA2EGa9tf
        8EhH2YZHlWP4nQkDL2yqwK3nmZan6Hykpg==
X-Google-Smtp-Source: AMsMyM7ngFOvsflzJJ6T6B59IVAH05aw8a7lUB0rCzg/ELkFfJ3WwJ7TdOYNHQcozfCBEtU3RyWwZg==
X-Received: by 2002:a17:902:d486:b0:186:cf83:4ba8 with SMTP id c6-20020a170902d48600b00186cf834ba8mr361510plg.154.1666982492564;
        Fri, 28 Oct 2022 11:41:32 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b001780a528540sm3449760plg.93.2022.10.28.11.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:41:32 -0700 (PDT)
Date:   Fri, 28 Oct 2022 11:41:32 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Oct 2022 11:41:01 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.1-rc3
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-d47a53b0-2125-467d-a9ff-c17fd41d646b@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-rc3

for you to fetch changes up to d14e99bf95510fa2d6affc371ad68161afc1dc8e:

  RISC-V: Fix /proc/cpuinfo cpumask warning (2022-10-27 15:23:19 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.1-rc3

* A fix for a build warning in the jump_label code.
* One of the git://github -> https://github cleanups, for the SiFive
  drivers.
* A fix for the kasan initialization code, this still likely warrants
  some cleanups but that's a bigger problem and at least this fixes the
  crashes in the short term.
* A pair of fixes for extension support detection on mixed LLVM/GNU
  toolchains.
* A fix for a runtime warning in the /proc/cpuinfo code.

----------------------------------------------------------------
Andrew Jones (1):
      RISC-V: Fix /proc/cpuinfo cpumask warning

Conor Dooley (2):
      riscv: fix detection of toolchain Zicbom support
      riscv: fix detection of toolchain Zihintpause support

Jisheng Zhang (1):
      riscv: jump_label: mark arguments as const to satisfy asm constraints

Palmer Dabbelt (2):
      MAINTAINERS: git://github.com -> https://github.com for sifive
      Merge patch series "Fix RISC-V toolchain extension support detection"

Qinglin Pan (1):
      riscv: mm: add missing memcpy in kasan_init

 MAINTAINERS                             |  2 +-
 arch/riscv/Kconfig                      | 17 +++++++++++++----
 arch/riscv/Makefile                     |  6 ++----
 arch/riscv/include/asm/jump_label.h     |  8 ++++----
 arch/riscv/include/asm/vdso/processor.h |  2 +-
 arch/riscv/kernel/cpu.c                 |  3 +++
 arch/riscv/mm/kasan_init.c              |  7 ++++++-
 7 files changed, 30 insertions(+), 15 deletions(-)
