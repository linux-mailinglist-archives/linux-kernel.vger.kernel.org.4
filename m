Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E92625FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiKKQ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiKKQ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:58:48 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758662BF4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:58:47 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y4so4690902plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYSSEXPwNN5u2j3n4bUYzsFQHmcrk65kX58qhVbQYMY=;
        b=W4BhOVK2/noP8zzUmqFmtsrMiWmVnlZve2pz/mntzK8k9IoiTI5kCSGXiBzsY1z1gi
         0BdYW/y8Ir8RCx6zAS8zqPlSZokMJU7ZeNiM5Suv4noYBKulUwfKWGpZR/iz0jf/ykiG
         ASEDiFjRqDpHR0XNf8idDq2789NbuGvMqOtIFAgcO4SfBA/4MCsdVZBjMw5U0z+kwEM6
         eyuTHE3+SsX/9GLSxieqAkzFFc1aGMx5n+DPjECceOtUFE66HnPMSNYrHoN3xjeHJ4lv
         a0mr+XadDI4gBOP6CPhYe/1AF6VhVho+XTo3WZ93ruh3zePJJcQGlFS1oEizJ4bMnSbO
         vIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYSSEXPwNN5u2j3n4bUYzsFQHmcrk65kX58qhVbQYMY=;
        b=ASNDLBqP8RvjKKCVc5cabZgBK1JWa9mh5tuAakz38FMaVRou8WUUhzqD8Cr5jsSVPn
         5F+LTCP7/wy+M7FbJedjOYdbQAB5C5DClmy2cyWJ9+A5tZ01eJqXsV+vwRKU8VNunJxM
         RzpUR2nT6uw12tEAtSPTrfmO2hr2QujOZS3umATImARdNLCp7PB1IwjZLFcQNjHJF1su
         8eGlN7LWhvQrGjt84zTUNG5Mv5xtP9wGqfoSzF7Y2sC69/fmRqNfmfuQagm5GyQlRa/g
         LIMRO11cDXYGNsY4ZxlpuD3Ty0CCfDHMQnZxClocLqsmQdepCaxSYnyvH0J1LQ+1SdBR
         tFZQ==
X-Gm-Message-State: ANoB5plmChTZJiwT2qRCiba3SaHIQzoZbpxQueP86AuAataCowjn7hkm
        phcGTTaORnSVfEzopTmu8MhEGQoQIi/4cQ==
X-Google-Smtp-Source: AA0mqf46tMhNW+0g1fP7XCrL/EIuUsTpa3qmBUZ7KgocDJoJzAlT8yeqDtKQfdrDKz0vQIM1/xaKtg==
X-Received: by 2002:a17:903:2113:b0:186:b063:339 with SMTP id o19-20020a170903211300b00186b0630339mr3388647ple.70.1668185926815;
        Fri, 11 Nov 2022 08:58:46 -0800 (PST)
Received: from localhost ([135.180.227.92])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b00178143a728esm1916305pll.275.2022.11.11.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:58:46 -0800 (PST)
Date:   Fri, 11 Nov 2022 08:58:46 -0800 (PST)
X-Google-Original-Date: Fri, 11 Nov 2022 08:48:38 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 6.1-rc5
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-a9c9d14d-1da7-4c8d-b117-b207616f77a4@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d14e99bf95510fa2d6affc371ad68161afc1dc8e:

  RISC-V: Fix /proc/cpuinfo cpumask warning (2022-10-27 15:23:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-rc5

for you to fetch changes up to fcae44fd36d052e956e69a64642fc03820968d78:

  RISC-V: vdso: Do not add missing symbols to version section in linker script (2022-11-10 15:06:14 -0800)

----------------------------------------------------------------
RISC-V Fixes for 6.1-rc5

* A fix to add the missing PWM LEDs into the  SiFive HiFive Unleashed
  device tree.
* A fix to fully clear a task's registers on creation, as they end up in
  userspace and thus leak kernel memory.
* A pair of VDSO-related build fixes that manifest on recent LLVM-based
  toolchains.
* A fix to our early init to ensure the DT is adequately processed
  before reserved memory nodes are processed.

----------------------------------------------------------------
I did get one soft lockup earlier this week, but it doesn't seem to reliably
reproduce and happens without these patches.

----------------------------------------------------------------
Conor Dooley (1):
      riscv: fix reserved memory setup

Emil Renner Berthing (1):
      riscv: dts: sifive unleashed: Add PWM controlled LEDs

Jisheng Zhang (2):
      riscv: process: fix kernel info leakage
      riscv: vdso: fix build with llvm

Nathan Chancellor (1):
      RISC-V: vdso: Do not add missing symbols to version section in linker script

 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 38 ++++++++++++++++++++++
 arch/riscv/kernel/process.c                        |  2 ++
 arch/riscv/kernel/setup.c                          |  1 +
 arch/riscv/kernel/vdso/Makefile                    |  5 ++-
 arch/riscv/kernel/vdso/vdso.lds.S                  |  2 ++
 arch/riscv/mm/init.c                               |  1 -
 6 files changed, 47 insertions(+), 2 deletions(-)
