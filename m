Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC5B73E1E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjFZORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjFZOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:17:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49B11BE4;
        Mon, 26 Jun 2023 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687789002; x=1719325002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EOL0bYi5YqXT5l339gZWbhX8NGlzc7WUULnLm/RbjRE=;
  b=ZEdEYGHeMyd3TippX6VX8bfqIzD6vmEeydX8Z+8i+70CZJRcS72CqGp0
   PjX+AwwUWmJxQj7U69RkxFmmRG/c4GIajDOj2maDqb1JhEEAUziXXGZ7u
   ZLjW1AMxu4oRZ2d+NpysX/GyIrK/kPBvYOb6PJP9AuDS6TIcTAOyRVxDf
   mcR2LQUTN1CYmuafqNmdfFq0OfjN9ow4n27/QF/kGWJdY/JIw3q+d5/gW
   5tz19jIrAiibIqFZ7e6apbdCGUDIn4HzdWEzlXT3y+En4krLM3Q90fZtm
   TpGkgLkSFUDkV7xPky1q9sTmNo8ubs/4Y7VZU1G2DT4HeqQqFz564iaS6
   w==;
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="asc'?scan'208";a="219871761"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 07:15:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 07:15:23 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 26 Jun 2023 07:15:19 -0700
Date:   Mon, 26 Jun 2023 15:14:51 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Evan Green <evan@rivosinc.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Yangyu Chen <cyy@cyyself.name>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/2] RISC-V: Probe for unaligned access speed
Message-ID: <20230626-veneering-superglue-751719bd967c@wendy>
References: <20230623222016.3742145-1-evan@rivosinc.com>
 <20230623222016.3742145-2-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1MEGOhFv0/yGwOYN"
Content-Disposition: inline
In-Reply-To: <20230623222016.3742145-2-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1MEGOhFv0/yGwOYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Evan,

Some minor nitpickery comments & one actual one.

On Fri, Jun 23, 2023 at 03:20:15PM -0700, Evan Green wrote:
> Rather than deferring misaligned access speed determinations to a vendor

Could you pick a consistent word to use? You've got "unaligned",
"misaligned" and "noalign" sprinkled through out the series.

> function, let's probe them and find out how fast they are. If we
> determine that a misaligned word access is faster than N byte accesses,
> mark the hardware's misaligned access as "fast".
>=20
> Fix the documentation as well to reflect this bar. Previously the only
> SoC that returned "fast" was the THead C906. The change to the
> documentation is more a clarification, since the C906 is fast in the
> sense of the corrected documentation.
>=20
> Signed-off-by: Evan Green <evan@rivosinc.com>
> ---
>=20
>  Documentation/riscv/hwprobe.rst     |  8 +--
>  arch/riscv/include/asm/cpufeature.h |  2 +
>  arch/riscv/kernel/Makefile          |  1 +
>  arch/riscv/kernel/copy-noalign.S    | 71 ++++++++++++++++++++++++++
>  arch/riscv/kernel/copy-noalign.h    | 13 +++++
>  arch/riscv/kernel/cpufeature.c      | 78 +++++++++++++++++++++++++++++
>  arch/riscv/kernel/smpboot.c         |  2 +
>  7 files changed, 171 insertions(+), 4 deletions(-)
>  create mode 100644 arch/riscv/kernel/copy-noalign.S
>  create mode 100644 arch/riscv/kernel/copy-noalign.h
>=20
> diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprob=
e.rst
> index 19165ebd82ba..710325751766 100644
> --- a/Documentation/riscv/hwprobe.rst
> +++ b/Documentation/riscv/hwprobe.rst
> @@ -88,12 +88,12 @@ The following keys are defined:
>      always extremely slow.
> =20
>    * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are su=
pported
> -    in hardware, but are slower than the cooresponding aligned accesses
> -    sequences.

Nice, fixed the typo by removing the offender ;)

> +    in hardware, but are slower than N byte accesses, where N is the nat=
ive
> +    word size.
> =20
>    * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are su=
pported
> -    in hardware and are faster than the cooresponding aligned accesses
> -    sequences.
> +    in hardware and are faster than N byte accesses, where N is the nati=
ve
> +    word size.
> =20
>    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses=
 are
>      not supported at all and will generate a misaligned address fault.
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 23fed53b8815..b8e917176616 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -30,4 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
>  /* Per-cpu ISA extensions. */
>  extern struct riscv_isainfo hart_isa[NR_CPUS];
> =20
> +void check_misaligned_access(int cpu);
> +
>  #endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index a42951911067..f934d7ab7840 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -34,6 +34,7 @@ extra-y +=3D vmlinux.lds
>  obj-y	+=3D head.o
>  obj-y	+=3D soc.o
>  obj-$(CONFIG_RISCV_ALTERNATIVE) +=3D alternative.o
> +obj-y	+=3D copy-noalign.o
>  obj-y	+=3D cpu.o
>  obj-y	+=3D cpufeature.o
>  obj-y	+=3D entry.o
> diff --git a/arch/riscv/kernel/copy-noalign.S b/arch/riscv/kernel/copy-no=
align.S
> new file mode 100644
> index 000000000000..3807fc2324b2
> --- /dev/null
> +++ b/arch/riscv/kernel/copy-noalign.S
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2023 Rivos Inc. */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +
> +	.text
> +
> +/* void __copy_words_unaligned(void *, const void *, size_t) */
> +/* Performs a memcpy without aligning buffers, using word loads and stor=
es. */
> +/* Note: The size is truncated to a multiple of 8 * SZREG */
> +ENTRY(__copy_words_unaligned)
> +	andi a4, a2, ~((8*SZREG)-1)
> +	beqz a4, 2f
> +	add a3, a1, a4
> +1:
> +	REG_L a4,       0(a1)
> +	REG_L a5,   SZREG(a1)
> +	REG_L a6, 2*SZREG(a1)
> +	REG_L a7, 3*SZREG(a1)
> +	REG_L t0, 4*SZREG(a1)
> +	REG_L t1, 5*SZREG(a1)
> +	REG_L t2, 6*SZREG(a1)
> +	REG_L t3, 7*SZREG(a1)
> +	REG_S a4,       0(a0)
> +	REG_S a5,   SZREG(a0)
> +	REG_S a6, 2*SZREG(a0)
> +	REG_S a7, 3*SZREG(a0)
> +	REG_S t0, 4*SZREG(a0)
> +	REG_S t1, 5*SZREG(a0)
> +	REG_S t2, 6*SZREG(a0)
> +	REG_S t3, 7*SZREG(a0)
> +	addi a0, a0, 8*SZREG
> +	addi a1, a1, 8*SZREG
> +	bltu a1, a3, 1b
> +
> +2:
> +	ret
> +END(__copy_words_unaligned)
> +
> +/* void __copy_bytes_unaligned(void *, const void *, size_t) */
> +/* Performs a memcpy without aligning buffers, using only byte accesses.=
 */
> +/* Note: The size is truncated to a multiple of 8 */
> +ENTRY(__copy_bytes_unaligned)
> +	andi a4, a2, ~(8-1)
> +	beqz a4, 2f
> +	add a3, a1, a4

Could you align operands for ASM please, to make this a little easier to
read?

> +1:
> +	lb a4, 0(a1)
> +	lb a5, 1(a1)
> +	lb a6, 2(a1)
> +	lb a7, 3(a1)
> +	lb t0, 4(a1)
> +	lb t1, 5(a1)
> +	lb t2, 6(a1)
> +	lb t3, 7(a1)
> +	sb a4, 0(a0)
> +	sb a5, 1(a0)
> +	sb a6, 2(a0)
> +	sb a7, 3(a0)
> +	sb t0, 4(a0)
> +	sb t1, 5(a0)
> +	sb t2, 6(a0)
> +	sb t3, 7(a0)
> +	addi a0, a0, 8
> +	addi a1, a1, 8
> +	bltu a1, a3, 1b
> +
> +2:
> +	ret
> +END(__copy_bytes_unaligned)
> diff --git a/arch/riscv/kernel/copy-noalign.h b/arch/riscv/kernel/copy-no=
align.h
> new file mode 100644
> index 000000000000..99fbb9c763e0
> --- /dev/null
> +++ b/arch/riscv/kernel/copy-noalign.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 Rivos, Inc.
> + */
> +#ifndef __RISCV_KERNEL_COPY_NOALIGN_H
> +#define __RISCV_KERNEL_COPY_NOALIGN_H
> +
> +#include <linux/types.h>
> +
> +void __copy_words_unaligned(void *dst, const void *src, size_t size);
> +void __copy_bytes_unaligned(void *dst, const void *src, size_t size);
> +
> +#endif /* __RISCV_KERNEL_COPY_NOALIGN_H */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index bdcf460ea53d..3f7200dcc00c 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -19,11 +19,21 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwcap.h>
> +#include <asm/hwprobe.h>
>  #include <asm/patch.h>
>  #include <asm/processor.h>
>  #include <asm/vector.h>
> =20
> +#include "copy-noalign.h"
> +
>  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
> +#define MISALIGNED_ACCESS_JIFFIES_LG2 1
> +#define MISALIGNED_BUFFER_SIZE 0x4000
> +#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> +

I think this blank line is misplaced, it should go after NUM_ALPHA_EXTS
instead of (or as well as) here.

> +#define MISALIGNED_COPY_MBS(_count) \
> +	((HZ * (_count) * MISALIGNED_COPY_SIZE) >> \
> +	 (20 + MISALIGNED_ACCESS_JIFFIES_LG2))
> =20
>  unsigned long elf_hwcap __read_mostly;
> =20
> @@ -396,6 +406,74 @@ unsigned long riscv_get_elf_hwcap(void)
>  	return hwcap;
>  }
> =20
> +void check_misaligned_access(int cpu)
> +{
> +	unsigned long j0, j1;
> +	struct page *page;
> +	void *dst;
> +	void *src;
> +	long word_copies =3D 0;
> +	long byte_copies =3D 0;
> +	long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;

Is this not a change from current behaviour, that may actually lead to
incorrect reporting. Presently, only T-Head stuff sets a speed, so
hwprobe falls back to UNKNOWN for everything else. With this, we will
get slow set, for anything failing the test.
Slow is defined as "Misaligned accesses are supported in hardware, but
are slower than the cooresponding aligned accesses sequences (sic)", but
you have no way of knowing, based on the test you are performing, whether
the hardware supports it or if it is emulated by firmware.
Perhaps that is not relevant to userspace, but wanted to know your
thoughts.

> +
> +	page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
> +	if (!page) {
> +		pr_warn("Can't alloc pages to measure memcpy performance");
> +		return;
> +	}
> +
> +	/* Make a misaligned destination buffer. */
> +	dst =3D (void *)((unsigned long)page_address(page) | 0x1);
> +	/* Misalign src as well, but differently (off by 1 + 2 =3D 3). */
> +	src =3D dst + (MISALIGNED_BUFFER_SIZE / 2);
> +	src +=3D 2;
> +	/* Do a warmup. */
> +	__copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +	preempt_disable();
> +	j0 =3D jiffies;
> +	while ((j1 =3D jiffies) =3D=3D j0)
> +		cpu_relax();
> +
> +	while (time_before(jiffies,
> +			   j1 + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {

Does this not fit in 100 chars?

> +
> +		__copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +		word_copies +=3D 1;
> +	}
> +
> +	__copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +	j0 =3D jiffies;
> +	while ((j1 =3D jiffies) =3D=3D j0)
> +		cpu_relax();
> +
> +	while (time_before(jiffies,
> +			   j1 + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {

Ditto here, no?

Cheers,
Conor.

--1MEGOhFv0/yGwOYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJmdWwAKCRB4tDGHoIJi
0iWSAP4xarrlPG4R9SkLJFxVubg2IFOuYkh5xuvlZV+pd0+1zgD/UCRP7ocj6ZPy
guF6fu4HqRSO9y5bxS8fFD2xYLWmlQk=
=pvWh
-----END PGP SIGNATURE-----

--1MEGOhFv0/yGwOYN--
