Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79E16D2366
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjCaPBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjCaPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:01:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D982D31D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:01:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id le6so21449745plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680274876;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTy0yiSfXZlT5wIkvPYiG31Ealo7FixMuHymNzLfkvg=;
        b=JFOIyU6yZBmDZV/8jNTFshY27fnyJIp3C9d5aMcbwRfPjpXXaEfLZ6oCpv8Ckn+3GY
         k+rszx935imT7OrnqnQOnCcWVr7AqZ+QKTe6fCt519sPOaOozbC7LI8QnIC5XOwc95R6
         4RSnlXWwBlXL4tk5XnVi9T5MT9bR9tTdX+xYOysDlzQ/JpdVA4doBuFd4s8OmakT/6KA
         F6rs00Cb/vLSwm7P9GiHE5tTSbGaKGD7VSgKKP/3+k1UVYY0vywC2HDNY9z3vnxNj8V2
         NRmjfO96B8tZ868CcFq8uIsqndXjbOWqQWzzKHocrw1WmKo3X49ZgsogjIaWJwbDpmYW
         3cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274876;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTy0yiSfXZlT5wIkvPYiG31Ealo7FixMuHymNzLfkvg=;
        b=sw2WvVrfS3ClBuZUsOS1/11hPBqTk+rOwejvErunyy55cMPzi4s6xAtfKX8F/1XNXH
         Le/OkUpfZ21PXeDqsEuabtdLUi1i/VAyIlIPedz1O4xuwoKy5EVm8IQBdm0/VK7eav37
         D8762xQITZnNzxiFKzSuKy59gHUP3t7SzEMbv13rPbEYMrevQo09j+7qHA3v9Pd6Hpz5
         SGv495DH7UaRLH4m/GbleGSQshO4B4N4qqHJGiAX8BgrKebgtJAbb/8nOgeJJGgZVLmE
         3k09wvQi9F7vHej9ADv1565qAr76C+IXBqaRrgdG5Gqq46g2zprlI7uBZuEae2lwmaTI
         Bo6w==
X-Gm-Message-State: AO0yUKVn/W6fV/vwfKHqmewRqytrexVuYP7TJSukElEicAlFs3cWgH+W
        q+wX5WzLppf5WuqJ2BvCS3hSgeEqLmFzdlcxT4o=
X-Google-Smtp-Source: AK7set+SiqHaknAdisHnyCLvjse4REU4FBdc5BLp8Hcnx3nqtXvN76Gx8oxEFOIp3JpZ3+5L6Q9y9Q==
X-Received: by 2002:a05:6a20:3aaa:b0:d8:e105:eb25 with SMTP id d42-20020a056a203aaa00b000d8e105eb25mr24609038pzh.7.1680274875775;
        Fri, 31 Mar 2023 08:01:15 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id c22-20020a62e816000000b005cdbd9c8825sm1910085pfi.195.2023.03.31.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 08:01:05 -0700 (PDT)
Date:   Fri, 31 Mar 2023 08:01:05 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Mar 2023 08:00:56 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.3-rc5
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-39dd74a6-0889-4b33-b276-201f02823d17@palmer-ri-x1c9>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e89c2e815e76471cb507bd95728bf26da7976430:

  riscv: Handle zicsr/zifencei issues between clang and binutils (2023-03-23 12:52:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc5

for you to fetch changes up to 4622f159098e098611f393cccf73d52b007e70bc:

  Merge patch series "RISC-V: Fixes for riscv_has_extension[un]likely()'s alternative dependency" (2023-03-29 12:23:00 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.3-rc5

* A fix for FPU probing in XIP kernels.
* Always enable the alternative framework for non-XIP kernels.

----------------------------------------------------------------
Conor Dooley (2):
      RISC-V: add non-alternative fallback for riscv_has_extension_[un]likely()
      RISC-V: always select RISCV_ALTERNATIVE for non-xip kernels

Palmer Dabbelt (1):
      Merge patch series "RISC-V: Fixes for riscv_has_extension[un]likely()'s alternative dependency"

 arch/riscv/Kconfig             | 12 +++++-----
 arch/riscv/Kconfig.erratas     |  6 ++---
 arch/riscv/include/asm/hwcap.h | 50 +++++++++++++++++++++++++-----------------
 3 files changed, 38 insertions(+), 30 deletions(-)
