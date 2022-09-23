Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251315E7982
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiIWLYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiIWLYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:24:15 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1225137461
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:23:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t70so11978421pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date;
        bh=REIOUlOZuR2Dd03PbSB7cFdrr86vzDy5is9HvQVwqOc=;
        b=KcgfRfVYGauuLgvui7owu3BU/Z7+CTtWQcE+Z60T6syawS10cHJ6WhG7LXHJNWDgwg
         eCa/OnHa3JwTrCdhZqkZUgtLpai2yUEh6sVG9sfGL46TNy378yMCoM1xdUcsQwOSROTU
         h45aPVLMjWRJJk0x5G5TRxVvJ7s8Sg3hD4Wh/v+T7Vj6zIDbBVTs1dN6fCJ0jUuXYdr8
         8wB1oI892OnaII7BNrGvL9XtRrMrt9m42aeXx7rSACgihwREAZN1y8iyya8ocwCA+8af
         /AFr5BrufxrnEreBcOdnl33LugE2l817Fp1KaRAWbL4S9tqf0dNHXvKWu1h70OTbJS1t
         JFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=REIOUlOZuR2Dd03PbSB7cFdrr86vzDy5is9HvQVwqOc=;
        b=rXDvCDq5XvlLCR/psFmbFbSYECgyIhLv/+zXw6qI5oIxEEfKcEZmNAIEuYEBOf1FA7
         LbcmAmM8VlVorAd1WU5R1nEn21ywuvXbISl6q5HSTR5FSJYBorj+ngKkqz2ZZI1ZNevC
         5QiC30GEhSinEXRk9jtok/B3DeJPRtMeXqqkm8kUHbyJh3BuTBNuNdRrwiGpv9IqtD2V
         qLhL/djca2kT/CY6QVJSbDx1AhzjMgqLZv9QWCPMuQy39prz+J1ETU9rm5FSYRvYwGeD
         HBYw7LtC0paocpg3LXgjAKkxgolKDi22j0CfHqg7qPm8xX0kpbF599xuCNcMpNtaaC6F
         Sowg==
X-Gm-Message-State: ACrzQf2jUSDbcbHrLmnHJaM4Y8YKVxn2aPMqj9Y5Tk7jgZvyVeN8i0y0
        wuT54g9TztFgQeY71X5JxL/qr8yxGRA7WSr4osA=
X-Google-Smtp-Source: AMsMyM7CmXeYHzs1yO8Rgy5zY3tySOuksEOeoUcxlJVMX6JPTm1TD0jUQF3NlmOdxcQ/TWXggYzC3Q==
X-Received: by 2002:a05:6a00:2488:b0:540:e5e5:ba48 with SMTP id c8-20020a056a00248800b00540e5e5ba48mr8677357pfv.51.1663932209555;
        Fri, 23 Sep 2022 04:23:29 -0700 (PDT)
Received: from localhost ([88.128.88.52])
        by smtp.gmail.com with ESMTPSA id r9-20020aa79629000000b00537eb0084f9sm6068167pfg.83.2022.09.23.04.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 04:23:28 -0700 (PDT)
Date:   Fri, 23 Sep 2022 04:23:28 -0700 (PDT)
X-Google-Original-Date: Fri, 23 Sep 2022 04:22:45 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.0-rc7
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-d96d9461-4a76-47d6-8a6c-fe0890247b0b@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 20e0fbab16003ae23a9e86a64bcb93e3121587ca:

  perf: RISC-V: fix access beyond allocated array (2022-09-08 13:50:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc7

for you to fetch changes up to c589e3ca27c9f608004b155d3acb2fab6f7a9f26:

  RISC-V: Avoid coupling the T-Head CMOs and Zicbom (2022-09-17 01:48:24 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.0-rc7

* A handful of build fixes for the T-Head errata, including some
  functional issues the compilers found.
* A fix for a nasty sigreturn bug.

----------------------------------------------------------------
Sorry in advance if something else has gone off the rails on this one, I had a
bit of an unplanned vacation this week and it's shaping up to be more tiring
than the conferences.  This is just what was there last week (without the
deadlock), I figured it'd be best to avoid delaying those any longer.

With any luck I'll be home tomorrow, so things should return to sanity
soon-ish.

----------------------------------------------------------------
Al Viro (1):
      riscv: fix a nasty sigreturn bug...

Heiko Stuebner (1):
      riscv: make t-head erratas depend on MMU

Palmer Dabbelt (2):
      RISC-V: Clean up the Zicbom block size probing
      RISC-V: Avoid coupling the T-Head CMOs and Zicbom

Randy Dunlap (1):
      riscv: fix RISCV_ISA_SVPBMT kconfig dependency warning

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/Kconfig.erratas          |  4 ++--
 arch/riscv/errata/thead/errata.c    |  1 +
 arch/riscv/include/asm/cacheflush.h |  5 +++++
 arch/riscv/kernel/setup.c           |  2 +-
 arch/riscv/kernel/signal.c          |  2 ++
 arch/riscv/mm/dma-noncoherent.c     | 23 +++++++++++++----------
 7 files changed, 25 insertions(+), 13 deletions(-)
