Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05D373F319
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjF0D7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjF0D7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F3E44;
        Mon, 26 Jun 2023 20:58:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B861D60FF6;
        Tue, 27 Jun 2023 03:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF10C433C9;
        Tue, 27 Jun 2023 03:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687838329;
        bh=Qvg53iRHK677atEVAfDalv5RAzv8yxt+yIoZTClXuY8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SF0vkCa1a31Vq4A/OdZ+O4laiaX5mr0pUi8pz2j9qgoXbGHg4R++lAPbCF9DW+bnw
         sB2u3mU6ypCcM27MU+rsx+YSC+zq/hAjRX2XDiJ2ESbhOtGgRazGxZ9zWN91PtqGOr
         kiYW9RxTf5d3apEiGJFqB8gzTYyddRyYznUg+mFasbtO2Mhf/7n9YHN7p2uMctxjn0
         hDJkVVYvpE7o/JKHe4zJkxQZYO6xw0xwKxIq1TiwFWvbRhByuoiZ4dCwAqkZi2Gil/
         ZNtScuSHpRRzGjf6Sl8RswtkDoj1VfYjUdysrv6Ual1cTY0kQs1WfdDDpzcRDTFr2m
         1WZvSdTsGnEJQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51d884a22e7so3836589a12.3;
        Mon, 26 Jun 2023 20:58:49 -0700 (PDT)
X-Gm-Message-State: AC+VfDyIriIsuJXA8Ot2KgZqhATlaklcbv/sZ5zKHe9EiUnxCx2ZVvJw
        7gL6+5inlM9+McvN1qwSoJOKZplZ0bIXqi5nD48=
X-Google-Smtp-Source: ACHHUZ6tFhxjDYOjpMONuDPjp8EaEMUNfw9lHyngn1nJim3MfmSBZsxsLl+tideo5TKawOXHoVggNqnOqH3qpMWyJtA=
X-Received: by 2002:aa7:c50b:0:b0:51d:91cc:32e8 with SMTP id
 o11-20020aa7c50b000000b0051d91cc32e8mr4864827edq.29.1687838327264; Mon, 26
 Jun 2023 20:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230625095644.3156349-1-kernel@xen0n.name>
In-Reply-To: <20230625095644.3156349-1-kernel@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 27 Jun 2023 11:58:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Z0oF9wZnYxwHS=fHDD_nY8wyzx3m8GEGi-PgMtkU1NA@mail.gmail.com>
Message-ID: <CAAhV-H6Z0oF9wZnYxwHS=fHDD_nY8wyzx3m8GEGi-PgMtkU1NA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] LoongArch: Preliminary ClangBuiltLinux enablement
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thanks.

Huacai

On Sun, Jun 25, 2023 at 5:56=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> From: WANG Xuerui <git@xen0n.name>
>
> Hi,
>
> It's been a long time since the LoongArch port was upstreamed to LLVM,
> and there seems to be evidence that Linux was successfully built with
> Clang inside Loongson roughly around that time; however, a lot has
> changed since then, and the Linux/LoongArch codebase now makes use of
> more novel features that necessitate further work. (The enablement work
> is tracked at [1].)
>
> With this patch series and a patched LLVM/Clang/LLD ([2][3][4][5]), a
> working kernel can be built with `make LLVM=3D1`. Although currently
> support for CONFIG_RELOCATABLE and CONFIG_MODULE is still TODO, we've
> decided to post the series early to hopefully reduce the rebase
> burden. The series contains several useful cleanups anyway.
>
> Regarding how to merge this: because only Patch 8 is outside
> arch/loongarch, I'd prefer the series to get merged through Huacai's
> tree. The series applies cleanly on top of next-20230622.
>
> Thanks go to the ClangBuiltLinux team, and LoongArch toolchain
> maintainers from Loongson and the community alike; without your help
> this would come much later, if at all (my free time has been steadily
> dwindling this year already).
>
> Your comments are welcome!
>
> [1]: https://github.com/ClangBuiltLinux/linux/issues/1787
> [2]: https://reviews.llvm.org/D153609
> [3]: https://reviews.llvm.org/D138135
> [4]: https://reviews.llvm.org/D150196
> [5]: https://reviews.llvm.org/D153707
>
> Changes in v3:
>
> - Squashed the two CFLAGS patches into one, and removed the CC_IS_CLANG
>   check in favor of a feature detection approach (Huacai and Ruoyao)
> - Removed unnecessary BUILD_BUG_ONs in the invtlb wrappers, and made
>   them __always_inline (Ruoyao and Bibo)
> - Linked to the explanation regarding the Clang triple's "libc" part
>   (Nick)
> - Fixed a wrong punctuation in commit message of Patch 4
>
> Changes in v2:
>
> - Merged the two FCSR-related patches, now using the same approach for
>   assembly and C (given that the inline asm codepath cannot be removed
>   right away), also change terminology: register "class" instead of
>   "bank"
> - Restored signatures of invtlb wrappers for ease of rebase (potentially
>   downstream product kernels?)
> - Removed -G0 switches altogether (turned out it's useless upon closer
>   look)
> - Fix -mabi and -msoft-float handling in the CFLAGS patch; two more LLVM
>   patches are now necessary (the [4] and [5] links above) but the
>   original and correct CFLAGS arrangement now works
>
> WANG Rui (2):
>   LoongArch: Calculate various sizes in the linker script
>   LoongArch: extable: Also recognize ABI names of registers
>
> WANG Xuerui (6):
>   LoongArch: Prepare for assemblers with proper FCSR class support
>   LoongArch: Make the CPUCFG and CSR ops simple aliases of compiler
>     built-ins
>   LoongArch: Simplify the invtlb wrappers
>   LoongArch: Tweak CFLAGS for Clang compatibility
>   LoongArch: Mark Clang LTO as working
>   Makefile: Add loongarch target flag for Clang compilation
>
>  arch/loongarch/Kconfig                 |  5 ++
>  arch/loongarch/Makefile                | 21 +++++---
>  arch/loongarch/include/asm/fpregdef.h  |  7 +++
>  arch/loongarch/include/asm/gpr-num.h   | 30 +++++++++++
>  arch/loongarch/include/asm/loongarch.h | 72 +++++++-------------------
>  arch/loongarch/include/asm/percpu.h    |  6 ++-
>  arch/loongarch/include/asm/tlb.h       | 43 +++++++--------
>  arch/loongarch/kernel/efi-header.S     |  6 +--
>  arch/loongarch/kernel/head.S           |  8 +--
>  arch/loongarch/kernel/traps.c          |  2 +-
>  arch/loongarch/kernel/vmlinux.lds.S    |  7 +++
>  arch/loongarch/lib/dump_tlb.c          |  6 +--
>  arch/loongarch/vdso/Makefile           |  2 +-
>  scripts/Makefile.clang                 |  1 +
>  14 files changed, 118 insertions(+), 98 deletions(-)
>
> --
> 2.40.0
>
