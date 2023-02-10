Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3C86922E3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjBJQCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjBJQCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:02:49 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874D37DB3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:02:48 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so5895409pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaqwXRPrI5sbbJVNLmvBI0AeZg1+M73dtQ44DcOiCqc=;
        b=NMgbXVBNwme30CwDvGpeFtT+IZ4it29HuIxNc1pA0xqt0WNs2b2T73wC1gQPue2rdK
         5K0hFwCjXnaRIxqUaZN7NmmxIbSxExvljFCwmeLmBYffiyOE4OpCdjx2kAq4htd/8GrL
         x3HKCiazNefW3PzpmYQsOiaDF6a7mFRgFQT2sNBTIuQTuKy/Y7vA2l5r0Qa6eZoiMClT
         +OvNCEb5j/2M0yMd4YQJwSxaLcQQkplc4sg5j4Zgr5YCr3IRzL4ZNoIPHd2/GojMW815
         slIEwbXD0AHMYBH3uJ7ia5iH+CD5rImrjp/jz+UT4m0kGB5FujJ369R7EY1BZEuWkmXz
         3j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaqwXRPrI5sbbJVNLmvBI0AeZg1+M73dtQ44DcOiCqc=;
        b=0CcZCysynC2e8tM2M+B9nAd8l/9DvXnR0MKxZPwldMGz56LIDEH7AJ42jNsu6TosFs
         uggNd8S2Fs3YcESISThZs/IPs+R5VQTe4jbV2s1aFNj2ZlDWDZPcu/0BhlpZTniUcFhC
         7UJKfzcRhaU2CWjXqxngy97fHwB9w4/VKMPha4JmdyHIR8oJV45c8N1ICa9kjJUDXDwi
         MrgbVZDv6r+VjEr7JgfQjmmOQ7lUmFn+YXUhc9RWxmS8yQYXv2wmGZqsAwART409vwQY
         0wbWds+Tk7Lv7XxVcN7Hsv91nNCgMIrASIyBB1KjOTHWcUUuDGY5uecUX68aUF5wIKiH
         8vew==
X-Gm-Message-State: AO0yUKUCxfUjyQrfGhGpn0wVpDP6xfHaK0mWahAryw4+W9fIgJmF11JV
        g5IM9P14r3Jbkc2Y2bxGc9Q/aw==
X-Google-Smtp-Source: AK7set9DTBJu0iGl1ax1QOru1P3DEdmdcW52K66jaMAbjtlN2tKkBngFnFNYStGBb26Vn177DLsqpQ==
X-Received: by 2002:a17:903:120b:b0:194:58c7:ab79 with SMTP id l11-20020a170903120b00b0019458c7ab79mr19241650plh.63.1676044967850;
        Fri, 10 Feb 2023 08:02:47 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b0019682e27995sm2902975plb.223.2023.02.10.08.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:02:47 -0800 (PST)
Date:   Fri, 10 Feb 2023 08:02:47 -0800 (PST)
X-Google-Original-Date: Fri, 10 Feb 2023 08:02:04 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 6.2-rc8
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-6912c0cd-33ec-4209-8a38-3da4be55fd88@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2f394c0e7d1129a35156e492bc8f445fb20f43ac:

  riscv: disable generation of unwind tables (2023-02-01 20:51:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-rc8

for you to fetch changes up to 950b879b7f0251317d26bae0687e72592d607532:

  riscv: Fixup race condition on PG_dcache_clean in flush_icache_pte (2023-02-09 11:40:32 -0800)

----------------------------------------------------------------
RISC-V Fixes for 6.2-rc8

* A fix to avoid partial TLB fences for huge pages, which are disallowed
  by the ISA.
* A fix to to avoid missing a frame when dumping stacks.
* A fix to avoid misaligned accesses (and possibly overflows) in
  kprobes.
* A fix for a race condition in tracking page dirtiness.

----------------------------------------------------------------
This is a little bigger that I'd hope for this late in the cycle, but they're
all pretty concrete fixes and the only one that's bigger than a few lines is
pmdp_collapse_flush() (which is almost all boilerplate/comment).  It's also all
bug fixes for issues that have been around for a while.

So I think it's not all that scary, just bad timing.

----------------------------------------------------------------
Guo Ren (2):
      riscv: kprobe: Fixup misaligned load text
      riscv: Fixup race condition on PG_dcache_clean in flush_icache_pte

Liu Shixin (1):
      riscv: stacktrace: Fix missing the first frame

Mayuresh Chitale (1):
      riscv: mm: Implement pmdp_collapse_flush for THP

 arch/riscv/include/asm/pgtable.h   |  4 ++++
 arch/riscv/kernel/probes/kprobes.c |  8 +++++---
 arch/riscv/kernel/stacktrace.c     |  3 ++-
 arch/riscv/mm/cacheflush.c         |  4 +++-
 arch/riscv/mm/pgtable.c            | 20 ++++++++++++++++++++
 5 files changed, 34 insertions(+), 5 deletions(-)
