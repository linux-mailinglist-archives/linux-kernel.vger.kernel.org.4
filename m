Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902436C8029
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjCXOpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjCXOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:44:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A757C19137
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:44:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so5268399pjp.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679669097;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZXUPhMi1ETDwZe5lY9GB/SQK/ctMF989jSe1q7ilEo=;
        b=VT0WWYHZM0c6swX/cYjunSRPofSmuS3/hHpt0Y8bB4EeHbgzKWTreQKbGb+hHOADKs
         q/T480zMx+/n00LaEj8chlCkZzzf874vpzKDHOIQVB+EXB8BUG24LsaJHl1tA1dI14W3
         jN9NxWfE86v9zmFicFXHS2Ae2Ozq0PYaFnrgjKccYoTCpbkcSbw++X9/PvZnfSnRxq4T
         INRSp01LOTdb/3xl9gRdOAgequdCxNBoXvgGC4rlwy1xh3zz3AWfl8a92JObpJb6yWVj
         EmVGZqUfIEi6db/IznuHwTgW7TAkVo1sjKcMCHPMqZp5S9D5TK7nOZbCzlfF94c8IP1g
         O+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679669097;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZXUPhMi1ETDwZe5lY9GB/SQK/ctMF989jSe1q7ilEo=;
        b=IeZ7N+qtS4uNvkxQDNiNuvlWfHj1EqP/KjwPt2NIh2rNv7K/LvRQJjzwBYswjyOuBw
         uTgfy75HOwz6DLE1E1I+rBfk5+ewLxgkocOxNgk9izhtFoAc6q9+AHLe0GBAAFBijAJa
         il5EfY7gkeAI7PQSeGZTTet7iU6PsO1ougFwecyWh7huU4DKULlF9jTmuV+emAaisvYx
         D7vn8WolNoaQAWoE2WrFnV+H09RW5ENjGG+pmx7zy/0jXx3DD4bbjjDGxPn+5IrV8G5P
         LldLHf0nZuHqFgqj14n58+9d6a1LBLCjnXVnp6+8FP3sU47RZEjxDhU18EZqvuhTqvRe
         34Fg==
X-Gm-Message-State: AAQBX9eF/529TaRTyOOEkE1K9Uuly3lpVLQmzUyAU1baoI8hIoYZWNol
        SqzXpRFtTU0PUqSmfOpaxwVnLXiw8h+rPx1B/V4=
X-Google-Smtp-Source: AKy350bt+TteTHm7dnhroYzhJ0u8eIFGFhXPPksXeIxCNwVC689tSlL6Daby7LAaHZbHN3BNz6Pmpw==
X-Received: by 2002:a17:903:1103:b0:19f:67b1:67e with SMTP id n3-20020a170903110300b0019f67b1067emr3734746plh.49.1679669097085;
        Fri, 24 Mar 2023 07:44:57 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001a064cff3c5sm14260697plp.43.2023.03.24.07.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 07:44:56 -0700 (PDT)
Date:   Fri, 24 Mar 2023 07:44:56 -0700 (PDT)
X-Google-Original-Date: Fri, 24 Mar 2023 07:44:36 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.3-rc4
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-4d782094-e4c0-4626-a038-78e17e33b19e@palmer-ri-x1c9>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 47dd902aaee9b9341808a3a994793199e7eddb88:

  RISC-V: mm: Support huge page in vmalloc_fault() (2023-03-14 19:15:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc4

for you to fetch changes up to e89c2e815e76471cb507bd95728bf26da7976430:

  riscv: Handle zicsr/zifencei issues between clang and binutils (2023-03-23 12:52:49 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.3-rc4

* A fix to match the CSR ASID masking rules when passing ASIDs to
  firmware.
* Force GCC to use ISA 2.2, to avoid a host of compatibily issues
  between toolchains.

----------------------------------------------------------------
Dylan Jhong (1):
      riscv: mm: Fix incorrect ASID argument when flushing TLB

Nathan Chancellor (1):
      riscv: Handle zicsr/zifencei issues between clang and binutils

 arch/riscv/Kconfig                | 22 ++++++++++++++++++++++
 arch/riscv/Makefile               | 10 ++++++----
 arch/riscv/include/asm/tlbflush.h |  2 ++
 arch/riscv/mm/context.c           |  2 +-
 arch/riscv/mm/tlbflush.c          |  2 +-
 5 files changed, 32 insertions(+), 6 deletions(-)
