Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7417D74DDED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjGJTJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjGJTJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:09:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88CE1705
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:08:21 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666edfc50deso3093742b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1689016090; x=1691608090;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voVX6LNoZ/J8bMuhFyaOWgRv6Zq5UVw3bcxlCreIau0=;
        b=1tKrKVjLsZlhy8odFljy5A7wgwOCceiEXO0WXFWKcEbHGeOAOez2StDWYQKKXYaf0u
         KxvJRa87HdcA5pB0okif7Z0b35z8cc2tLASh5d+miBIE6Bs9KUTlrUUm/kzyEOS8+Tw2
         NETrfXnOhywt/LmYyBC7fKj+hbGw6hbAZA0MR/Lqbpdhr1EE77xQjHZdwp5lpyZmyN0f
         5KtlxzprTcf99MCiVS+GKMHENseXkS5L+25K1U3M8luzAxoJFRGfhUGNiWxu9e94kPSL
         MmJ14tdvNpj9MMRH58e0MXWxAcen7uRtBbWunqMeVRUHOUsBD5opsT7ROZtyvI8tD/e1
         pFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689016090; x=1691608090;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voVX6LNoZ/J8bMuhFyaOWgRv6Zq5UVw3bcxlCreIau0=;
        b=dKptsIyCh+4pkck9An/lSY1HYH/cCZec0XZiJ4DWlMXdzFs0xLGVUvi6WQmvSprKrr
         LTthKs1Gm0eRBAAn63PtRxLvAjUjf/T/15O1kjjFK9gabsVByRoGTHPl96DVWeWZlS1G
         j2T6jGrjG6ndjlKdP10REA/Geq46r2uPJ3NsGNS+lGk1fHS2GjnBbsRItasuk7BkDiLz
         QlOJu/gTZ5doN9FqaRAF4TpqqvoQLh4FX+l/mgfvlM//tQXaMsvGfVHy/S1P8r59EshD
         mDaZmDX/B+D7UrrYPBMsgSRyUwxQTDGB1Ijgq3AiwXac4YYxP9XcMfGyxrqd2A8aZMUh
         Chzw==
X-Gm-Message-State: ABy/qLZe8ylgBjknAr/ttDJqcpVnwlrF6t/iKKQwRLkFMCx3Ky62Mqdf
        ydjaobf+28SmyvDMl4o0d+kQTw==
X-Google-Smtp-Source: APBJJlE1fEH2sHOVo9utDEMzkiIiKOHtiey9zE83fpGfTKSsuED5sR/xEAs2EL4vldSYbhB1R9O4yw==
X-Received: by 2002:a17:902:db10:b0:1b8:a936:1915 with SMTP id m16-20020a170902db1000b001b8a9361915mr20863454plx.22.1689016090010;
        Mon, 10 Jul 2023 12:08:10 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902da8d00b001ac95be5081sm219080plx.307.2023.07.10.12.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:08:09 -0700 (PDT)
Date:   Mon, 10 Jul 2023 12:08:09 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Jul 2023 12:07:23 PDT (-0700)
Subject:     Re: [PATCH v2 0/6] riscv: KCFI support
In-Reply-To: <20230710183544.999540-8-samitolvanen@google.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        keescook@chromium.org, nathan@kernel.org, ndesaulniers@google.com,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, samitolvanen@google.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     samitolvanen@google.com
Message-ID: <mhng-2fe7822f-f869-4513-b8a6-7da21ce5ccd8@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 11:35:45 PDT (-0700), samitolvanen@google.com wrote:
> This series adds KCFI support for RISC-V. KCFI is a fine-grained
> forward-edge control-flow integrity scheme supported in Clang >=16,
> which ensures indirect calls in instrumented code can only branch to
> functions whose type matches the function pointer type, thus making
> code reuse attacks more difficult.
>
> Patch 1 implements a pt_regs based syscall wrapper to address
> function pointer type mismatches in syscall handling. Patches 2 and 3
> annotate indirectly called assembly functions with CFI types. Patch 4
> implements error handling for indirect call checks. Patch 5 disables
> CFI for arch/riscv/purgatory. Patch 6 finally allows CONFIG_CFI_CLANG
> to be enabled for RISC-V.
>
> Note that Clang 16 has a generic architecture-agnostic KCFI
> implementation, which does work with the kernel, but doesn't produce
> a stable code sequence for indirect call checks, which means
> potential failures just trap and won't result in informative error
> messages. Clang 17 includes a RISC-V specific back-end implementation
> for KCFI, which emits a predictable code sequence for the checks and a
> .kcfi_traps section with locations of the traps, which patch 5 uses to
> produce more useful errors.
>
> The type mismatch fixes and annotations in the first three patches
> also become necessary in future if the kernel decides to support
> fine-grained CFI implemented using the hardware landing pad
> feature proposed in the in-progress Zicfisslp extension. Once the
> specification is ratified and hardware support emerges, implementing
> runtime patching support that replaces KCFI instrumentation with
> Zicfisslp landing pads might also be feasible (similarly to KCFI to
> FineIBT patching on x86_64), allowing distributions to ship a unified
> kernel binary for all devices.
>
> ---
>
> Changes in v2:
>   - Rebased on 6.5-rc1.
>   - Sorted Kconfig entries alphabetically.
>
>
> Sami Tolvanen (6):
>   riscv: Implement syscall wrappers
>   riscv: Add types to indirectly called assembly functions
>   riscv: Add ftrace_stub_graph
>   riscv: Add CFI error handling
>   riscv/purgatory: Disable CFI
>   riscv: Allow CONFIG_CFI_CLANG to be selected
>
>  arch/riscv/Kconfig                       |  3 +
>  arch/riscv/include/asm/cfi.h             | 22 ++++++
>  arch/riscv/include/asm/insn.h            | 10 +++
>  arch/riscv/include/asm/syscall.h         |  5 +-
>  arch/riscv/include/asm/syscall_wrapper.h | 87 ++++++++++++++++++++++++
>  arch/riscv/kernel/Makefile               |  2 +
>  arch/riscv/kernel/cfi.c                  | 77 +++++++++++++++++++++
>  arch/riscv/kernel/compat_syscall_table.c |  8 ++-
>  arch/riscv/kernel/mcount.S               |  9 ++-
>  arch/riscv/kernel/suspend_entry.S        |  5 +-
>  arch/riscv/kernel/sys_riscv.c            |  6 ++
>  arch/riscv/kernel/syscall_table.c        |  8 ++-
>  arch/riscv/kernel/traps.c                |  4 +-
>  arch/riscv/purgatory/Makefile            |  4 ++
>  14 files changed, 238 insertions(+), 12 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cfi.h
>  create mode 100644 arch/riscv/include/asm/syscall_wrapper.h
>  create mode 100644 arch/riscv/kernel/cfi.c
>
>
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5

Thanks, this generally LGTM it was just a bit late for the last merge 
window.  I'm still poking around to make sure there's no fallout in rc1, 
this is in the queue (but there's some other stuff too).
