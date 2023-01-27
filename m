Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B362767EC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjA0Ri6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjA0Ri4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:38:56 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C29E76AD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:38:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id x5so2283943plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKlQkDrU+FhDbUHr7ll6e+3docJw0mBRlDmwBYrsumA=;
        b=xkfdi7YffwB8EjLS+KtM0e9bLfU15C64FOlzTDdw6MuEIij4bQzHcNu3ai04eWWnYo
         H5ZSdMYBefho9TroiIhksOw9SKWTlwu8XpZ9xN0NNDBBo5fZzYFIgGv8WqxJsFslKZRR
         D/ZPgsYWPSLx8EItWAzivik+QMWS/r5cVxqDMBKhZmQQEgb4b4BVZhuDntKOI4l9pPvT
         fWp3JeQJRTzW30iiypOF2sz3Kj+Sf1p3n3ncLVGNF0BFxMnZitUna1qqGjWG6tJfrdb1
         7F2mt+iYySNyypv2Og1nFXPLiqVSEUkovwv/4g+SLwi7xB1Zw1cb+I4zm7cJKBbzQN9t
         0Usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKlQkDrU+FhDbUHr7ll6e+3docJw0mBRlDmwBYrsumA=;
        b=KcwtoRqXf5kFde+gEcwTvLAdcLKym+8xK4zVQZc37iha7Kce7MaUAVvFz7EOTA/Irv
         9oiI1jrYdjjaK6vs0E9RqWcNONBbUXUN1W5SULHAfsTZKd1u0UitmFmTs3tOsJCXq3CZ
         1iTXH25wuXjQ4BkVoey8APliCvKottFIR9ntl6TugT499d18lAhacKNVPIyXbZQ/Ssyi
         IVUb9TUmV8wz8pr3f1wtfniT6P/JribFwWN8HVN4d/b4OOdLTIr2OYkCc7GmpgcXwN61
         uWjZ203XkIA8D8P4hldz6oO42pChjTRnKQ+Z5UU2LKLCErtLGSsjlGeRK4etS2a3J9X/
         MLZQ==
X-Gm-Message-State: AO0yUKVDO5hn29SwOgpEEKEOmRFdqGGjfhXzMpZwzHAZ0F//O6Bh5lOm
        pIrRIKjzXHl5y1cAHTrJHtKfmM1+VH2/ItP2
X-Google-Smtp-Source: AK7set9Z0LxYy822GwxaEBoObkgqDRCDK0h9v5fq4KLiffFD1N57M/xUiETVvje5Q5g3Vf+eMN8SAQ==
X-Received: by 2002:a17:902:d48e:b0:194:d4d1:2928 with SMTP id c14-20020a170902d48e00b00194d4d12928mr6716274plg.50.1674841134811;
        Fri, 27 Jan 2023 09:38:54 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d34c00b00194b37940edsm3108039plk.268.2023.01.27.09.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:38:54 -0800 (PST)
Date:   Fri, 27 Jan 2023 09:38:54 -0800 (PST)
X-Google-Original-Date: Fri, 27 Jan 2023 09:38:12 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 6.2-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-e9212465-c032-4266-b8ea-a40f2bdcc767@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b9b916aee6715cd7f3318af6dc360c4729417b94:

  riscv: uaccess: fix type of 0 variable on error in get_user() (2023-01-05 12:30:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-rc6

for you to fetch changes up to c1d6105869464635d8a2bcf87a43c05f4c0cfca4:

  riscv: Move call to init_cpu_topology() to later initialization stage (2023-01-25 07:20:00 -0800)

----------------------------------------------------------------
RISC-V Fixes for 6.2-rc6

* A few DT bindings fixes to more closely align the ISA string
  requirements between the bindings and the ISA manual.
* A handful of build error/warning fixes.
* A fix to move init_cpu_topology() later in the boot flow, so it can
  allocate memory.
* The IRC channel is now in the MAINTAINERS file, so it's easier to
  find.

----------------------------------------------------------------
Conor Dooley (3):
      dt-bindings: riscv: fix underscore requirement for multi-letter extensions
      dt-bindings: riscv: fix single letter canonical order
      MAINTAINERS: add an IRC entry for RISC-V

Heiko Stuebner (1):
      RISC-V: fix compile error from deduplicated __ALTERNATIVE_CFG_2

Ley Foon Tan (1):
      riscv: Move call to init_cpu_topology() to later initialization stage

Liao Chang (1):
      riscv/kprobe: Fix instruction simulation of JALR

Masahiro Yamada (1):
      riscv: fix -Wundef warning for CONFIG_RISCV_BOOT_SPINWAIT

Palmer Dabbelt (1):
      Merge patch series "riscv,isa fixups"

 Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
 MAINTAINERS                                       | 1 +
 arch/riscv/include/asm/alternative-macros.h       | 2 +-
 arch/riscv/kernel/head.S                          | 2 +-
 arch/riscv/kernel/probes/simulate-insn.c          | 4 ++--
 arch/riscv/kernel/smpboot.c                       | 3 ++-
 6 files changed, 8 insertions(+), 6 deletions(-)
