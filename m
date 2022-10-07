Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E435F7C6F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJGRsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJGRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:47:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E0E9E0DF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:47:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h13so4087322pfr.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcci2pupu9UurkJQkRA8mm21LocCWexyJenAk7+j02c=;
        b=JBaA3MUxHIauaERF+xT/NXVKefe2nI5Rs5pahUR+KKkSu/ximGTDyQa3CWCyEwR3LK
         aLJxtuFehllLGRa+RLC+bANZRd4zc5cmfHdl2NWKs3FE1/P2S9OjYQCrPO24tGnUKL7d
         tDlaHjZ6G70mgkKQnri+vaoLMAOfLTPoTOPGHo0ZnNmtcDijbEZmqaOqZsFWlFoxeIzM
         6NGZNegTPS/cHr3C1Kutpuke6AvKX4tc5IYExuqH0S2TwNNmrzJzf5sWRTnF7HetplX+
         lS6GKq1Fthn/AQqsEVzXde7WWcqszyKfNs1jh0l3KO9kCjYgJTCj6nMOaCZc/CQkHWdp
         cQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcci2pupu9UurkJQkRA8mm21LocCWexyJenAk7+j02c=;
        b=jSvqyfZ9qyGo7W9THR0wpRzC+ROQaBMVStfJWEkYPRZMWGhN+f7nJ8yNv+fxrxjGEp
         pvy0sF9gS+fWLa/2nmyHcJOmEkBM+ZwqGeSMtXE94DqyufkCyUu/90ibXXSrUhBmWBKk
         ut7JkuPrZPW20Z1mJc2EW96LVe/n/ZG2LP88UEfO1DxqughbfO43EsLxvqbN2sUykjpO
         s+UcRNS+LPkZgJzdQWfCW4whEaIdwUOvwbvAkxn5Vvgaps6ydYnm0OnuypAt5lZDOJnW
         Zfe6BxswdfQ37x9TXk8lJYYYohvbrdHjK9th1A3U4eVLhzpevjzTOiTSLvDXaKsPSIsu
         QitQ==
X-Gm-Message-State: ACrzQf2gwEy+TNrDTCa0UHUX9FmnHD6oifiLhLcZ11b3ZN1Hx3VNxB/g
        EMbUujTGYPzV/7PuMJkFNa1rZ7H+tN/6KA==
X-Google-Smtp-Source: AMsMyM7aAF88sHZdlMks90qeAjzp+bL0loKjCg1pJNWkvU4lQiJVetrYk08jOW3Kn1td4kBT6515Pg==
X-Received: by 2002:a05:6a00:ac6:b0:530:3197:48b6 with SMTP id c6-20020a056a000ac600b00530319748b6mr6538447pfl.80.1665164877695;
        Fri, 07 Oct 2022 10:47:57 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902d2c800b0017fe9b038fdsm1700718plc.14.2022.10.07.10.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 10:47:57 -0700 (PDT)
Date:   Fri, 07 Oct 2022 10:47:57 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Oct 2022 10:43:57 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.1 Merge Window, Part 1
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-6190fb79-f9f6-41bd-90f3-d4d6009d41a5@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-mw1

for you to fetch changes up to 87f81e66e2e84c7e6056413703d732a99c20c09b:

  riscv: enable THP_SWAP for RV64 (2022-10-06 20:03:48 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.1 Merge Window, Part 1

* Improvements to the CPU topology subsystem, which fix some issues
  where RISC-V would report bad topology information.
* The default NR_CPUS has increased to XLEN, and the maximum
  configurable value is 512.
* The CD-ROM filesystems have been enabled in the defconfig.
* Support for THP_SWAP has been added for rv64 systems.

There are also a handful of cleanups and fixes throughout the tree.

----------------------------------------------------------------
I will almost certainly have a part 2 for next week, but I'm not sure how big
it will be: between the conferences and COVID things have been a mess on my
end, that's clearly made this first week pretty small but it's also meant a lot
of stuff on the lists still needs work.  There's also some stuff that's pending
on conflicts, though, so I figured it'd be best to just send this today to make
handling those easier.

I'm still seeing some of these KASAN/pcpu_alloc related panics, but it doesn't
seem like they're more common with these than they are on 6.0 so I think it's
OK to just call these safe.  Aside from that things seem fine with this merged
into master from this morning.

----------------------------------------------------------------
Anup Patel (2):
      cpuidle: riscv-sbi: Fix CPU_PM_CPU_IDLE_ENTER_xyz() macro usage
      RISC-V: Increase range and default value of NR_CPUS

Conor Dooley (2):
      arm64: topology: move store_cpu_topology() to shared code
      riscv: topology: fix default topology reporting

Heinrich Schuchardt (1):
      riscv: enable CD-ROM file systems in defconfig

Jisheng Zhang (2):
      riscv: compat: s/failed/unsupported if compat mode isn't supported
      riscv: enable THP_SWAP for RV64

Palmer Dabbelt (2):
      Merge tag 'riscv-topo-on-6.0-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ into for-next
      RISC-V: Print SSTC in canonical order

Sergey Matyukevich (2):
      perf: RISC-V: exclude invalid pmu counters from SBI calls
      perf: RISC-V: throttle perf events

 arch/arm64/kernel/topology.c        | 40 -------------------------------------
 arch/riscv/Kconfig                  | 12 +++++++----
 arch/riscv/configs/defconfig        |  3 +++
 arch/riscv/kernel/cpu.c             |  2 +-
 arch/riscv/kernel/process.c         |  2 +-
 arch/riscv/kernel/smpboot.c         |  3 ++-
 drivers/base/arch_topology.c        | 19 ++++++++++++++++++
 drivers/cpuidle/cpuidle-riscv-sbi.c |  7 ++++++-
 drivers/perf/riscv_pmu_legacy.c     |  4 ++--
 drivers/perf/riscv_pmu_sbi.c        | 31 ++++++++++++++++++----------
 include/linux/perf/riscv_pmu.h      |  2 +-
 11 files changed, 63 insertions(+), 62 deletions(-)
