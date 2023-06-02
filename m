Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DFD72059D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbjFBPLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbjFBPLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:11:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3325710EB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:11:16 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-650c8cb68aeso1289647b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685718664; x=1688310664;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUpuQWKRHIidXNA4DyjcQWmeIqFB0FVeYLmWHizrF0I=;
        b=Fl9gcNXjBUsfsmxeYAoxAIXTCPlsu0s5aU5YG/OOCLk2J+DQBEKl2RUib9lkUQM3HO
         UQlwHfTA+HzNu9ScGocv6YIhaotzxP3MEGHY0l5bLjJy7nUM2BwG5Wc1qCnwWcewI0hT
         raLuf3dk+I8SW23Wt2ob7WrDOWxUtAXN8bdJp1EjZcp4AV72afbMOCXeTq06mhGJLYVD
         3IANHu964sknbWTegN+CoyD5ESKjs9mz3Hi91RDzNDoVHflFOCi451eJm7Mp3RZb8GAn
         jwK94MsdWHXp40Fp45Vq9awQ3lFASiezh8GlQyPVZT0woohVBNpESXXeUmxzQ9eCAdBl
         Bzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685718664; x=1688310664;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUpuQWKRHIidXNA4DyjcQWmeIqFB0FVeYLmWHizrF0I=;
        b=QgIgji9Fiv5PQvSaPV/e5nHmnq+FVKDSgE8YMbZsNuMzm+lAlxWGsVheZ4UXhL2162
         76A2yLYZaxAQNfv6WZRUXeB70aKRxVCoAY9ALTWBdhM18k2LogD42OFwCRbhCGKbxNnY
         Lnf7uPoSgykmwQQGmOd1lV8aUbYZTQkCEbvif0dE4viJ9y397M+OFaj7Uk9JXCopYKUI
         FquyBFcwrrCQ11BZ4sYJJJFPYd5QPuhjezZPUY6o7U1TmdbPT4W3bHJhJJcBc/jsv7v9
         TwAI3PWRW8+tcnNskOL6S15R6vUyKjHlK3IcfmtgEA2XdE8OxLho+8dwPTtSAIHyPXSV
         Z0hw==
X-Gm-Message-State: AC+VfDyPLvm4fnqKEwUBpUnG4lbzy7+vH/P/i8+oVh8JW7c8jmHMLkzC
        GZ7pXEB/WDEqoSQt2eM5j25/k7DHtPErRolj6Io=
X-Google-Smtp-Source: ACHHUZ6uUn04qfFdZi+AmNnMf1L2hZCcnH3HEoEsUOq4w4NIbmUpUix5tJwJtTC07AEt49bzWiWYLg==
X-Received: by 2002:a05:6a20:729c:b0:103:946d:8a4c with SMTP id o28-20020a056a20729c00b00103946d8a4cmr10362789pzk.5.1685718663734;
        Fri, 02 Jun 2023 08:11:03 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id c3-20020a656183000000b0053b92b26412sm1269351pgv.14.2023.06.02.08.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:11:03 -0700 (PDT)
Date:   Fri, 02 Jun 2023 08:11:03 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Jun 2023 08:10:40 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.4-rc5
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-78f8e789-4700-4d48-b64e-11ed75a3a048@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3b90b09af5be42491a8a74a549318cfa265b3029:

  riscv: Fix orphan section warnings caused by kernel/pi (2023-05-09 18:20:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-rc5

for you to fetch changes up to 6966d7988c4fb6af3e395868e9800c07f9e98a30:

  riscv: Implement missing huge_ptep_get (2023-06-01 18:15:37 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.4-rc5

* A build warning fix for BUILTIN_DTB=y.
* Hibernation support is hidden behind NONPORTABLE, as it depends on
  some undocumented early boot behavior and breaks on most platforms.
* A fix for relocatable kernels on systems with early boot errata.
* A fix to properly handle perf callchains for kernel tracepoints.
* A pair of fixes for NAPOT to avoid inconsistencies between PTEs and
  handle hardware that sets arbitrary A/D bits.

----------------------------------------------------------------
Alexandre Ghiti (4):
      riscv: Fix unused variable warning when BUILTIN_DTB is set
      riscv: Fix relocatable kernels with early alternatives using -fno-pie
      riscv: Fix huge_ptep_set_wrprotect when PTE is a NAPOT
      riscv: Implement missing huge_ptep_get

Conor Dooley (1):
      RISC-V: mark hibernation as nonportable

Ism Hong (1):
      riscv: perf: Fix callchain parse error with kernel tracepoint events

 arch/riscv/Kconfig                  |  5 ++++-
 arch/riscv/errata/Makefile          |  4 ++++
 arch/riscv/include/asm/hugetlb.h    |  3 +++
 arch/riscv/include/asm/perf_event.h |  7 +++++++
 arch/riscv/kernel/Makefile          |  4 ++++
 arch/riscv/mm/hugetlbpage.c         | 30 +++++++++++++++++++++++++++++-
 arch/riscv/mm/init.c                |  2 +-
 7 files changed, 52 insertions(+), 3 deletions(-)
