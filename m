Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4A16A93D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjCCJXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjCCJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:23:26 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E80F1024C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:22:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so5577898pjh.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 01:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677835331;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gstt+n0gCQKeffrpPBhAfFrZ9VxfVRPA9JoQZ/jtG04=;
        b=HdZXRHvCHR/TSxGMJITFUNA38SEYISysqtDu4UIgHaR/cs8nUNFGt00X/+Z+ta4AXh
         gFJZCJuS12ddakhhY8CN+GtMfSQ/KOgzPhye8iMY8YjwNBvv/WS9LP9nJEhi2SzxVeSQ
         ucAnFUtAn9StuyWkFs3bd7ortPHgzsnsKoc8Vhlm1JT3Lv3XrWqS21/SZKdiqWGDCTUK
         K6dqqltPo6S2lRXNx8CFcnttt0o+Gp0/g7FdFwtZC0bogyNTN0TZ0JHp10FLVx4FspFq
         k02dY+JMsBJBrC1aS6ZMP9oNEHjFHidIabzkZZlRiKN+LTiJ85IUCzJ+Zfqfq0ZMppQM
         JYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677835331;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gstt+n0gCQKeffrpPBhAfFrZ9VxfVRPA9JoQZ/jtG04=;
        b=QJLYEzunLSbOwAIhD+D48K57pjyYRYAImd5YXeTo8ilIJo5sWsicROwlDRWBZ57SW7
         glEzQ1K6hgEo0Aun+8Z4I5ifXGZIj1CDRmPaEuObrl2S1/aSKrXERahlZytH9ciFvg9m
         CtG6gixIY9ILOPGI/QcMm+cBxiG6d+yKAtrs4+pmaup9fqNQfXoNYpPjNLm5HxmDfRTu
         q7z6tWXtUwvbr/ERrSCl53yqep7xhIg/PU9pY2YMZ7nihbixLu1EG2+Z+a52+3Pq8XdZ
         ltxKPXhlHpMJWKuSR+xQ5KANthLvwSU8sB9jBDXFC7Q9LnNUhVxokq6q98IYxGxHxi1P
         C8CQ==
X-Gm-Message-State: AO0yUKVoLcmarrpo/lR/S5XaAHLvI/tgYdFdZMyfYclvFdn0IK+d5d5k
        G5TF3OOWp17CMdEwro2+h6RnxRl2QEkNF1L4
X-Google-Smtp-Source: AK7set/aSyGLKdJb8hYj08rU2sX4fP4u4hiIcjstljxBqnQReD/ETGqE+QcTJ80syGSpbfNj+ErJYA==
X-Received: by 2002:a17:90b:3b4f:b0:237:5dc6:ce14 with SMTP id ot15-20020a17090b3b4f00b002375dc6ce14mr1001648pjb.7.1677835331485;
        Fri, 03 Mar 2023 01:22:11 -0800 (PST)
Received: from localhost ([135.180.224.71])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090ad38900b00233ebcb52a6sm2929885pju.36.2023.03.03.01.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 01:22:11 -0800 (PST)
Date:   Fri, 03 Mar 2023 01:22:11 -0800 (PST)
X-Google-Original-Date: Fri, 03 Mar 2023 01:21:35 PST (-0800)
Subject: [GIT PULL] RISC-V Patches for the 6.3 Merge Window, Part 2
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-030bb7f3-2a9b-4061-8f41-e3e20c9b1671@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-6.3-mw1'
The following changes since commit 01687e7c935ef70eca69ea2d468020bc93e898dc:

  Merge tag 'riscv-for-linus-6.3-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2023-02-25 11:14:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-mw2

for you to fetch changes up to 61fc1ee8be26bc192d691932b0a67eabee45d12f:

  riscv: Bump COMMAND_LINE_SIZE value to 1024 (2023-03-01 18:35:43 -0800)

----------------------------------------------------------------
RISC-V Patches for the 6.3 Merge Window, Part 2

* Some cleanups and fixes for the Zbb-optimized string routines.
* Support for custom (vendor or implementation defined) perf events.
* COMMAND_LINE_SIZE has been increased to 1024.

----------------------------------------------------------------
This is very small for a second week's merge window for me.  That's actually
been a goal of mine for a while now.  I'd love to say it's because everything
went smoothly, but it's actually because the bigger bits I tried to pick up
this week was sufficiently broken that it just didn't come together.  Maybe
that's because we've got a lot more testing and review these days, or maybe
it's because there's enough other stuff going on that things just couldn't get
fixed up in time.

Either way, this should make for a pleasantly calm Friday in RISC-V land.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Bump COMMAND_LINE_SIZE value to 1024

Björn Töpel (1):
      riscv, lib: Fix Zbb strncmp

Heiko Stuebner (1):
      RISC-V: improve string-function assembly

Mayuresh Chitale (1):
      drivers/perf: RISC-V: Allow programming custom firmware events

 arch/riscv/include/uapi/asm/setup.h |  8 ++++++++
 arch/riscv/lib/strcmp.S             |  6 ++++--
 arch/riscv/lib/strlen.S             | 10 +++++-----
 arch/riscv/lib/strncmp.S            | 20 ++++++++++----------
 drivers/perf/riscv_pmu_sbi.c        |  7 ++-----
 5 files changed, 29 insertions(+), 22 deletions(-)
 create mode 100644 arch/riscv/include/uapi/asm/setup.h
