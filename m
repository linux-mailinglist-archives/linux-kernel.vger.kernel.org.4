Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D369E5B3A93
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiIIOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIIOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:20:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61A65A815
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:20:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q3so1658435pjg.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date;
        bh=oec0hsn7Vj6Lsi1D1urX59gL9xUdYb6/NenHblk0y/o=;
        b=sQybks/LaONptfza6aKqOLqmzdWZ+YRsbNpztiVSRq/JMZqw6IUFIcSL1W42H1D0gS
         IBgrn4SVMGLdtfh3jVS8FVWYUL/bh+TJjfponh4iCftkW4/LIb2ot7NC8DvmKQIsymDe
         e8P4k9ZYAF6dLnmPV0MytOGFIS1FdnrekusF6EiiA6NTA23s/aptALhthYfB2gKoycvi
         8xkBm5cqaJJT66V2VmF7ztWStW348CP+8Rn0Pm/iQRFSxqb0qZ4jmuj7uLFcel+BelNM
         nXLLjfn+yFnlKEpuTTmhTDk5aD8AKT8Umz+sHaUJWyf093LFMVl7pGfT5O+0REb4qE0e
         6M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oec0hsn7Vj6Lsi1D1urX59gL9xUdYb6/NenHblk0y/o=;
        b=3M90SPK2bNPSfIFx+L+3THYBXXm6/1SqLyvTfKJd+Li9E+dO1c60h78qLNNlUGxZ8m
         MuvTHZRlqqvVuvXAmUwNUoCu+truUPoz8geRuxdlRg2mAiLGecRODM1gorn+KwF60Fk/
         ECWF+mjtR0DkxCmGrq0qUTdwGR610coPpcJF09YlHzwslDluUOewF2KdrId9sXb7YeU5
         aF6woqJt/lUS9QdaIBFiDsRe6S+yyxWwv06TIUJW5aP5Df3TdkomUecFCOvhH8Ae77dc
         tXhAgUtnVwB5c1EZUTcY5ppQNprNV6vhxMM7FyBFF9S5XYoRAVu0KbXEprBXCMTo52jh
         YulA==
X-Gm-Message-State: ACgBeo0OGH18zTkzLrnRJRPPARAZRByVU3NYH6zHVg/P+/Q/6Xa37Hc1
        JkuMq05M2D9s0Y2+j7+YfArjlg==
X-Google-Smtp-Source: AA6agR6IU8iIBjl6/ctV6IYJtquGCshoeNTNDKJPa1vOlXqfcdxv4Ia1rnI8eabDPxhgPB8cWlYCRQ==
X-Received: by 2002:a17:902:7082:b0:177:f7fc:5290 with SMTP id z2-20020a170902708200b00177f7fc5290mr6787355plk.143.1662733218057;
        Fri, 09 Sep 2022 07:20:18 -0700 (PDT)
Received: from localhost ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id n26-20020a63a51a000000b0041c49af8156sm604549pgf.6.2022.09.09.07.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:20:17 -0700 (PDT)
Date:   Fri, 09 Sep 2022 07:20:17 -0700 (PDT)
X-Google-Original-Date: Fri, 09 Sep 2022 07:20:13 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.0-rc5
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-8b892856-b176-48da-8f9b-869810e0cf26@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1709c70c31e05e6e87b2ffa0a2b4cc0da4b2c513:

  Merge branch 'riscv-variable_fixes_without_kvm' of git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git into fixes (2022-08-25 16:38:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc5

for you to fetch changes up to 20e0fbab16003ae23a9e86a64bcb93e3121587ca:

  perf: RISC-V: fix access beyond allocated array (2022-09-08 13:50:25 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.0-rc5

* A pair of device tree fixes for the Polarfire SOC.
* A fix to avoid overflowing the PMU counter array when firmware
  incorrectly reports the number of supported counters, which manifests
  on OpenSBI versions prior to 1.1.

----------------------------------------------------------------
Conor Dooley (2):
      dt-bindings: riscv: sifive-l2: add a PolarFire SoC compatible
      riscv: dts: microchip: use an mpfs specific l2 compatible

Palmer Dabbelt (1):
      Merge tag 'dt-fixes-for-palmer-6.0-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git into fixes

Sergey Matyukevich (1):
      perf: RISC-V: fix access beyond allocated array

 .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 79 ++++++++++++++--------
 arch/riscv/boot/dts/microchip/mpfs.dtsi            |  2 +-
 drivers/perf/riscv_pmu_sbi.c                       |  2 +-
 3 files changed, 51 insertions(+), 32 deletions(-)
