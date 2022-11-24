Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB37638023
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKXUWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXUWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:22:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F0297379;
        Thu, 24 Nov 2022 12:22:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7C76B82900;
        Thu, 24 Nov 2022 20:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD3CC433D6;
        Thu, 24 Nov 2022 20:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669321323;
        bh=bbc1mWNbqU6lQapGVFaaUlUseWtvQkuYpamywwpjrHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3buWyLLznmNRcU6+mxcGpwSsueyRw+r7g74TgHlOxD7fcb/E6POc16vBx0QFmwRp
         7VL6paj4Y3y6jZ5qgKTf0EvX+4XZyHzIyKim7Yj840/XwD5gdHnBED1WisROo7bWCE
         HaNcDAybTbNnt/z3FgSs/KXpoLTkixBq2CYXZUmO34m/g/mxNe5F3RTU3KJYnuqPsa
         tItNpZTXRsw1t4ekSpVGgGmziZ9uECkenU2P2kpyJzBw4Q+vk4zH2xqd8274LNQNJJ
         AsvYawfMJDno1HFGrOXXlwi5Z/9obKG218PbITG/07nWuM6sQSsd2BIX8PU8cZ/MsH
         Ly0eV1k20Q4Xg==
Date:   Thu, 24 Nov 2022 20:21:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 3/7] riscv: errata: Add Andes alternative ports
Message-ID: <Y3/SZPjzXsd8dfkl@spud>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124172207.153718-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 05:22:03PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add required ports of the Alternative scheme for Andes CPU cores.

You've got a lot of nice info in your cover letter that would be nice in
the git history. Could you add some of the commentary about why the
Andes cache needs special handling from there to this commit message
please?

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC v3 -> v4
> * New patch
> ---
>  arch/riscv/Kconfig.erratas           | 22 +++++++++
>  arch/riscv/errata/Makefile           |  1 +
>  arch/riscv/errata/andes/Makefile     |  1 +
>  arch/riscv/errata/andes/errata.c     | 68 ++++++++++++++++++++++++++++
>  arch/riscv/include/asm/alternative.h |  3 ++
>  arch/riscv/include/asm/errata_list.h |  5 ++
>  arch/riscv/kernel/alternative.c      |  5 ++
>  7 files changed, 105 insertions(+)
>  create mode 100644 arch/riscv/errata/andes/Makefile
>  create mode 100644 arch/riscv/errata/andes/errata.c

> diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
> new file mode 100644
> index 000000000000..ec3e052ca8c7
> --- /dev/null
> +++ b/arch/riscv/errata/andes/errata.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Erratas to be applied for Andes CPU cores
> + *
> + *  Copyright (C) 2022 Renesas Electronics Corporation.
> + *
> + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include <asm/alternative.h>
> +#include <asm/cacheflush.h>
> +#include <asm/errata_list.h>
> +#include <asm/patch.h>
> +#include <asm/vendorid_list.h>
> +
> +static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)

To the lay reader, what's an "iocp" when it's at home? "I/O coherency
port"? Again, commit message would be a good place for the introduction
of that term :)

> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
> +		return false;
> +
> +	if (arch_id != 0x8000000000008a45 || impid != 0x500)

Can you #define these?

> +		return false;
> +
> +	riscv_cbom_block_size = 1;
> +	riscv_noncoherent_supported();
> +
> +	return true;
> +}
> +
> +static u32 andes_errata_probe(unsigned int stage, unsigned long archid, unsigned long impid)
> +{
> +	u32 cpu_req_errata = 0;
> +

I read some code and when it does the opposite of what I'd expect, I
feel inclined to add a comment. In this case, you're probing for the
presence of the port `probe_iocp()`, but the interesting case is when
you don't find it. You can leave it uncommented if you like, but even
something like the below I think fits.

	/*
	 * In the absence of the I/O Coherency Port, access to certain peripherals
	 * requires vendor specific DMA handling.
	 */
> +	if (errata_probe_iocp(stage, archid, impid))
> +		cpu_req_errata |= BIT(ERRATA_ANDESTECH_NO_IOCP);
> +
> +	return cpu_req_errata;
> +}
> +
> +void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> +					      unsigned long archid, unsigned long impid,
> +					      unsigned int stage)
> +{
> +	u32 cpu_req_errata = andes_errata_probe(stage, archid, impid);
> +	struct alt_entry *alt;
> +	u32 tmp;
> +
> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return;
> +
> +	for (alt = begin; alt < end; alt++) {
> +		if (alt->vendor_id != ANDESTECH_VENDOR_ID)
> +			continue;
> +		if (alt->errata_id >= ERRATA_ANDESTECH_NUMBER)
> +			continue;
> +
> +		tmp = (1U << alt->errata_id);

Is this not BIT(alt->errata_id)?

> +		if (cpu_req_errata & tmp) {
> +			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> +
> +			riscv_alternative_fix_auipc_jalr(alt->old_ptr, alt->alt_len,
> +							 alt->old_ptr - alt->alt_ptr);
> +		}
> +	}
> +}
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> index 6511dd73e812..d8012af30cbd 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -46,6 +46,9 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  			     unsigned long archid, unsigned long impid,
>  			     unsigned int stage);
> +void andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> +			     unsigned long archid, unsigned long impid,
> +			     unsigned int stage);
>  
>  void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  				 unsigned int stage);
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 4180312d2a70..2ba7e6e74540 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -9,6 +9,11 @@
>  #include <asm/csr.h>
>  #include <asm/vendorid_list.h>
>  
> +#ifdef CONFIG_ERRATA_ANDES
> +#define ERRATA_ANDESTECH_NO_IOCP	0
> +#define ERRATA_ANDESTECH_NUMBER		1
> +#endif

Not a question for you, but I wonder why we even bother wrapping these
defines.

> +
>  #ifdef CONFIG_ERRATA_SIFIVE
>  #define	ERRATA_SIFIVE_CIP_453 0
>  #define	ERRATA_SIFIVE_CIP_1200 1
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> index a7d26a00beea..4ded3e9aa3bc 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -47,6 +47,11 @@ static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufacturer_inf
>  	case THEAD_VENDOR_ID:
>  		cpu_mfr_info->patch_func = thead_errata_patch_func;
>  		break;
> +#endif
> +#ifdef CONFIG_ERRATA_ANDES
> +	case ANDESTECH_VENDOR_ID:
> +		cpu_mfr_info->patch_func = andes_errata_patch_func;
> +		break;
>  #endif
>  	default:
>  		cpu_mfr_info->patch_func = NULL;
> -- 
> 2.25.1
> 
