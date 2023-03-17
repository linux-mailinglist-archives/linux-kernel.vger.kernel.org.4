Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAB6BEBF1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjCQO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCQO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:57:04 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58177C5AFF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:56:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so5462824pjp.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679064987;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQHsigL4cQeMNE4+tPguPwfbc2xlhbaQJTlCbEWAZT4=;
        b=zKHIK6ocR2nVQtQTWI4jJliZiBKjnCjGE89AeVrr1muLN7dWHQSQGuU6p1OCBDl/3u
         0FMLH2W73H0tmATOEHg8BTkNp7ZcUoKlpujkPpFOI9c7y/MFHl2YxTND1rbq5B0lLgVT
         4mvMXpG45F0vnzyZnYOrwUpenqa6nAqnqrkZyv5kD9Kp/sGvW7ccCAd6/c7am9NRlLCn
         iphYmwxGSqROWtSBdf/gSKGh0nM2NtyhIvpW7Kieiey8W09iXtWFLoGB9wp9kAQhDwaY
         39FSE35+/lZCdiXrYI72kyG8BIhed6dxrQ2h8dPLrshaBdbAzbMWvwcA+RYxU8KkQvy7
         pdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679064987;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQHsigL4cQeMNE4+tPguPwfbc2xlhbaQJTlCbEWAZT4=;
        b=r3fArpaw5WHLzdnapyF+WvoLssG9T/R85Y/y7YBEdvi1ohOok0Grkxc+HEAC5McD2z
         KDdARNJrDagqMxJaZg9RHsEeIN65RGWXv0f84LQKYihEYace0XXI5V/e013/lZVa3aqw
         eQz6mzxLkEBLXjcx/ay07DrUM+KYB8ogIqPmCSr7IWd6P5klHW07ZazGXFLY0XkxRbxK
         BpuRMzTJ9V3RcBp4p57x4Y6oAfqhT3MJP/l9je12Q6L4cytGDLEOv43yGkRbb7Qy+kJ4
         uF6UR2CAGz5diNKY3DYiMiwJPHPy3igjZBQ6ChUhZnR5CkOKeRuiU6cPe9jXnvssHqoL
         yZIg==
X-Gm-Message-State: AO0yUKVs8Ir7NX/D5fJ3byDdMpaytL5a2w197HLI4eMj3U63Wc+Bxjn+
        jaYjx18rxDPii7mawkeqar0jLYMMECmjR/ZLbhc=
X-Google-Smtp-Source: AK7set+ZrtvKJ9Fu+LSwEV8uEmI/ZaXcoD479/0/hN9DRyDvUSOtMTW9YZWta19/mwLcDjC8K+GF8g==
X-Received: by 2002:a17:90b:3a91:b0:237:24eb:99d8 with SMTP id om17-20020a17090b3a9100b0023724eb99d8mr9222625pjb.19.1679064987283;
        Fri, 17 Mar 2023 07:56:27 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id f11-20020a63510b000000b0050be183459bsm1577727pgb.34.2023.03.17.07.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:56:26 -0700 (PDT)
Date:   Fri, 17 Mar 2023 07:56:26 -0700 (PDT)
X-Google-Original-Date: Fri, 17 Mar 2023 07:56:23 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.3-rc3
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-70404d20-e840-40df-a6d9-0d67003e3ca3@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2a8db5ec4a28a0fce822d10224db9471a44b6925:

  RISC-V: Don't check text_mutex during stop_machine (2023-03-09 14:58:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc3

for you to fetch changes up to 47dd902aaee9b9341808a3a994793199e7eddb88:

  RISC-V: mm: Support huge page in vmalloc_fault() (2023-03-14 19:15:34 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.3-rc3

* A pair of fixes to the ASID allocator to avoid leaking stale mappings
  between tasks.
* A fix to the vmalloc fault handler to tolerate huge pages.

----------------------------------------------------------------
Dylan Jhong (1):
      RISC-V: mm: Support huge page in vmalloc_fault()

Guo Ren (1):
      riscv: asid: Fixup stale TLB entry cause application crash

Palmer Dabbelt (1):
      Merge patch series "riscv: asid: switch to alternative way to fix stale TLB entries"

Sergey Matyukevich (1):
      Revert "riscv: mm: notify remote harts about mmu cache updates"

 arch/riscv/include/asm/mmu.h      |  2 --
 arch/riscv/include/asm/tlbflush.h | 18 ------------------
 arch/riscv/mm/context.c           | 40 +++++++++++++++++++--------------------
 arch/riscv/mm/fault.c             |  5 +++++
 arch/riscv/mm/tlbflush.c          | 28 ++++++++++++++++-----------
 5 files changed, 42 insertions(+), 51 deletions(-)
