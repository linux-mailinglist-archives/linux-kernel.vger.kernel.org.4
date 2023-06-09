Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284A5729D30
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbjFIOpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjFIOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:45:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5FD269A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:45:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-652426346bbso1523685b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686321907; x=1688913907;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slFfiATLS6KbBGeLkwlt6rux1fUkrlOTmgnn5cG9CUU=;
        b=NBQfYFvKoeRVP9NiYWPQiuQIo9tTte0YRhBCFqqBsXYgbxXDjqjGELgNcsRAEuxg6p
         s9ljX5t/VBwWQP+l3rtZ2ilmf1fBZikRPYr6+p+5gbQ5et0D7pz5SRCfp2wHLhI0HpIZ
         iOS+5vp/GGUUmH81geer8O6pIl0MCjEP8HDqqv5uXe75zkDDZgpAbz/Sb5ZckgBzxiij
         9IfZdRfL7FkZzW4EqjaKOgnXn3PAkCMj6qqPhPY2IPr9+aqSR5nN+4ebkEgi8M/9Vkxi
         R/QUfWaaNR9AzMU2EwA7gi1VuNalSRZDtQYlSLV2Ns28S9MITFIABQ2ZTx9dQzQGEqTt
         xY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321907; x=1688913907;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slFfiATLS6KbBGeLkwlt6rux1fUkrlOTmgnn5cG9CUU=;
        b=DLF3/wcyo0Vmwr8/9lLeHDSttUFooUvSrhtHWMVrYKR6sND2OquKnsf58jihIiQNYM
         /V6tdYW51rM3HgwlDFMbzajRUoLemT+M7VWxe5UKYBTaJeMYNHA8+zau7qmTocztQkb6
         GZr8YiLSzBUpemkWPoTfuUsCAq90ysq6q39RXEtAuNewaYQycT1SEp9GzibM0X0zRcIq
         QoiosX/4DDwt2lJnhxnb4+h0sssade3nAZhbGPKIjk3H2t32OAV9mGMqQ5Kar4ZwbleU
         WohEyHa70WXRFIPxRvacHHn25z/s0YtjYmlgiJXhDXxQSf0Ju9ZV0bVxtHpxSZPcTSU4
         BTLg==
X-Gm-Message-State: AC+VfDx5JeZZLmij3WcFxoXdSqKbPDTVOng6Qcv/bvCOgmc2YwQ+XkOQ
        rRecy9rZtpTGwg6mqQaNs4B4V4dNkWSsQvrU1Nc=
X-Google-Smtp-Source: ACHHUZ6EhjBUnoZdMxi0gY/CYXsdhcsyJVfrTEIeo4192q9SlJICqoj//ZSLF38CXNFBwpvKpjlEvQ==
X-Received: by 2002:a05:6a00:21c9:b0:654:4989:f2b with SMTP id t9-20020a056a0021c900b0065449890f2bmr1335985pfj.1.1686321907024;
        Fri, 09 Jun 2023 07:45:07 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78503000000b00639fc7124c2sm2845387pfn.148.2023.06.09.07.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:45:06 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:45:06 -0700 (PDT)
X-Google-Original-Date: Fri, 09 Jun 2023 07:44:23 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.4-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-bf5e8144-98a0-441d-b6df-63978648c75a@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6966d7988c4fb6af3e395868e9800c07f9e98a30:

  riscv: Implement missing huge_ptep_get (2023-06-01 18:15:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-rc6

for you to fetch changes up to 99a670b2069c725a7b50318aa681d9cae8f89325:

  riscv: fix kprobe __user string arg print fault issue (2023-06-08 10:23:19 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.4-rc6

* A fix to avoid ISA-disallowed privilege mappings that can result from
  WRITE+EXEC mmap requests from userspace.
* A fix for kfence to handle the huge pages.
* A fix to avoid converting misaligned VAs to huge pages.
* ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE has been selected so kprobe can
  understand user pointers.

----------------------------------------------------------------
Alexandre Ghiti (2):
      riscv: Fix kfence now that the linear mapping can be backed by PUD/P4D/PGD
      riscv: Check the virtual alignment before choosing a map size

Hsieh-Tseng Shen (1):
      riscv: mm: Ensure prot of VM_WRITE and VM_EXEC must be readable

Ruan Jinjie (1):
      riscv: fix kprobe __user string arg print fault issue

 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/kfence.h  | 33 ---------------------------
 arch/riscv/include/asm/pgtable.h |  3 +--
 arch/riscv/mm/init.c             | 48 +++++++++++++++++++++++++++++++---------
 4 files changed, 39 insertions(+), 46 deletions(-)
