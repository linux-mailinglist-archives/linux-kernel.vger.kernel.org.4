Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8264D63B2CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiK1UMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiK1UME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:12:04 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D1A22B3B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:12:00 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id w37so5804986pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M3hsvZmsRJ+Zyf2Ap7EqB/ctmjyXnmHpZWJb10knc0k=;
        b=WOaJzEscT0ssf37HvQjaxXmBSVsyI9lnys/H5psU1t6RKkI9snj3nnO4+e5Unbb6Pu
         CFuhxV7d7DWcdUat+VBlt6p5HHLEj2Ji03eG1f+SYRrKctRvdXshO8I76ReqC/xtw2SP
         P9RGNKGhf6KJOqnfghUtHWWnxL+eAegWiTrf6Y2O6ec9cGeFMTuugLZMffI6D0gSGpE4
         2OqgMzn19m/pN09ZQFe7Cw/t5+ax9a1g9JiP+uzKPT4zgQQXY939nQGnIyBoDc4yY7Bj
         wpf9ll9V3UYODruZ1kfu2RlVU50c/2tyn38dnXZFPibI8BAHyQMSJP5QmSrEtGJagrjv
         VmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3hsvZmsRJ+Zyf2Ap7EqB/ctmjyXnmHpZWJb10knc0k=;
        b=Ogcbxwvjs19ksqawq0OS9aCrYvVofMxTAcyOXlzPRkHTE3Q9CkhtMH4BeuhgWBKJk5
         mQEX3lIHanuND22yXVv+72PwfaK2rXnDdJctEIsC4d41CI9N2k7pwyy4c+p6T1v57XNh
         XRQ0A5xn8fGMu2iGSV/D7pLEKRqftYk6O4sbZgUNIrTvRS5qY4I8DVi1MgDUA9iYzUJa
         bDSXzgNsDKf7GdhyL+tffbVZvVjGxxsnRgpBeBHSV1g1FdEplKrjGueRLyszXf8SWQ2E
         LxxkfYYMH6Qv3/WqnT3V/mlH6mlaDo5ksQ7SHyfx/xgCijo+qMW5vSrx8X4EqKgbfcbh
         hU7g==
X-Gm-Message-State: ANoB5plNyO0k3AAm+ZCsk8Mu5t1IV3BlUjrbxSu6R9uUAR/j3ixj3oMD
        84iPJau1An0mYbZMteD9g637/GV93Sj8BkJCzOEDgw==
X-Google-Smtp-Source: AA0mqf6UGrhJcqE7QehgjRYcZVoAsAaD/+W27044VdbhNpH5sgmnawRrfidw/E22GiOZbZBQNjyChoGFd2ruFp/IaHc=
X-Received: by 2002:aa7:820a:0:b0:574:a642:ad40 with SMTP id
 k10-20020aa7820a000000b00574a642ad40mr20302955pfi.42.1669666319934; Mon, 28
 Nov 2022 12:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20221128152442.3403-1-jszhang@kernel.org>
In-Reply-To: <20221128152442.3403-1-jszhang@kernel.org>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Mon, 28 Nov 2022 12:11:49 -0800
Message-ID: <CAHBxVyHg0fU9msnV4vgp4oK6aZZv+nc9mFTbTRjHNsgJAG0eyg@mail.gmail.com>
Subject: Re: [PATCH] riscv: head: use 0 as the default text_offset
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 7:34 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Commit 0f327f2aaad6 ("RISC-V: Add an Image header that boot loader can
> parse.") adds an image header which "is based on ARM64 boot image
> header and provides an opportunity to combine both ARM64 & RISC-V
> image headers in future.". At that time, arm64's default text_offset
> is 0x80000, this is to give "512 KB of guaranteed BSS space to put
> the swapper page tables" as commit cfa7ede20f13 ("arm64: set TEXT_OFFSET
> to 0x0 in preparation for removing it entirely") pointed out, but
> riscv doesn't need the space, so use 0 as the default text_offset.
>
> Before this patch, booting linux kernel on Sipeed bl808 M1s Dock
> with u-boot booti cmd:
> [    0.000000] OF: fdt: Ignoring memory range 0x50000000 - 0x50200000
> ...
> [    0.000000]   DMA32    [mem 0x0000000050200000-0x0000000053ffffff]
> As can be seen, 2MB DDR(0x50000000 - 0x501fffff) can't be used by
> linux.
>
> After this patch, the 64MB DDR is fully usable by linux
> [    0.000000]   DMA32    [mem 0x0000000050000000-0x0000000053ffffff]
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/head.S | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index b865046e4dbb..ef95943f7a70 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -38,18 +38,8 @@ ENTRY(_start)
>         .word 0
>  #endif
>         .balign 8
> -#ifdef CONFIG_RISCV_M_MODE
> -       /* Image load offset (0MB) from start of RAM for M-mode */
> +       /* Image load offset (0MB) from start of RAM */
>         .dword 0
> -#else
> -#if __riscv_xlen == 64
> -       /* Image load offset(2MB) from start of RAM */
> -       .dword 0x200000
> -#else
> -       /* Image load offset(4MB) from start of RAM */
> -       .dword 0x400000
> -#endif
> -#endif

NACK.
RV64 needs to boot at a 2MB aligned address and RV32 needs to boot at
a 4MB aligned address.
The firmware is assumed to live at the start of DRAM for Linux running
in S-mode.


>         /* Effective size of kernel image */
>         .dword _end - _start
>         .dword __HEAD_FLAGS
> --
> 2.37.2
>
