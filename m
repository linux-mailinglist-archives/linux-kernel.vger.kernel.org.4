Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B705E6E2610
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjDNOrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjDNOr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:47:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E31DB771
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:47:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id lh8so5522654plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681483648; x=1684075648;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZbO6NJvOaVKStbJdlSYehHBXU3D/5oXOhDJfErNUXU=;
        b=B2OR8p6sMCHYYYNwmlX2klbKphFqo/sC0AVIJ8XuBRD7NXow4x7Pa6OoQaWnDubodt
         aKFeUXCKIXaWRFDkkz8ccltI1xXH0EwRonQ3sBao8ytBQ8QYwnVvOPwYSJIy1D2xf6S/
         7lOIIEVtHPKu1K920NXEmXQMzUkXdvIvMbEv+DVsG4Ix8UOww65npZVdjfqP70qHHAae
         JOzAK8/AVBT5l1QgtCYPU1wf8AqCc0P57bmF7Cjp3DonXZGPRAVc3aFM9P8FOkiFIAiB
         wzUeAOUnD8QEYtzoP0wyX/QL11RXxSQkpbb5f+AJ98elhvMVgNYZvXM6BbkGqXBL+S97
         xR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681483648; x=1684075648;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZbO6NJvOaVKStbJdlSYehHBXU3D/5oXOhDJfErNUXU=;
        b=HeVkMXzcd9/RuGn0PQYv8X9SwmUZj7pd1yow/jQUjQRllUrGbvNfz76lXOdR7uNgOM
         Z1/fPhkPOdGqWFM2C4yQ/ZCK3BqO4Y/gcogrY6Pngwjkns8qCHJz/9ze7ujL3LtdIz48
         M8Ge4IzegZO7fGySRLRiDwAY6AttqaLZsv8QbU7pWeGbic1KxjWyL09mMX07vlCos1kj
         XknPJ8ncBY78gnxSemsBpncQOptjVVcQjjNKIo6R93qp3CzzpAYeY+Y7jhoGpSLWDSWo
         Uw8oQWgAwO24cy3wAXpHJatR0kFbZCDunE9czJjU6U/rvvGoU6//WEED4u1oddcDbzW5
         c05w==
X-Gm-Message-State: AAQBX9cieunFdWCpwWVbrXTG+LxGSrdKWng6OHwuIcR2xZ8oXSPiHWyJ
        iJV1QMgRTN/GR+2JYEKCnEQbenHRhCu3x8UivQM=
X-Google-Smtp-Source: AKy350YmRtd9NZMIKh9Bj3HvlXdM2jGfwYuKLX51qEHSQC0AHcCDL/gTNhbRnWCQZnk7w1S/VOOgLA==
X-Received: by 2002:a05:6a20:748b:b0:ee:a720:c721 with SMTP id p11-20020a056a20748b00b000eea720c721mr153368pzd.16.1681483647731;
        Fri, 14 Apr 2023 07:47:27 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id u13-20020aa7848d000000b0063b212638bdsm3111076pfn.220.2023.04.14.07.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:47:26 -0700 (PDT)
Date:   Fri, 14 Apr 2023 07:47:26 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Apr 2023 07:45:54 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.3-rc7
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-f47ee915-bbee-4c49-92ea-1d598355a0f3@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4622f159098e098611f393cccf73d52b007e70bc:

  Merge patch series "RISC-V: Fixes for riscv_has_extension[un]likely()'s alternative dependency" (2023-03-29 12:23:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc7

for you to fetch changes up to 1b50f956c8fe9082bdee4a9cfd798149c52f7043:

  riscv: No need to relocate the dtb as it lies in the fixmap region (2023-04-13 18:14:40 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.3-rc7

* A fix for a missing fence when generating the NOMMU sigreturn
  trampoline.
* A set of fixes for early DTB handling of reserved memory nodes.

----------------------------------------------------------------
Alexandre Ghiti (3):
      riscv: Move early dtb mapping into the fixmap region
      riscv: Do not set initial_boot_params to the linear address of the dtb
      riscv: No need to relocate the dtb as it lies in the fixmap region

Mathis Salmen (1):
      riscv: add icache flush for nommu sigreturn trampoline

 Documentation/riscv/vm-layout.rst |  6 +--
 arch/riscv/include/asm/fixmap.h   |  8 ++++
 arch/riscv/include/asm/pgtable.h  |  8 +++-
 arch/riscv/kernel/setup.c         |  6 +--
 arch/riscv/kernel/signal.c        |  9 ++++-
 arch/riscv/mm/init.c              | 82 +++++++++++++++++----------------------
 6 files changed, 62 insertions(+), 57 deletions(-)
