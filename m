Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DE0744E04
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjGBNrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 09:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBNru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 09:47:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC750E55;
        Sun,  2 Jul 2023 06:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66C3C60C20;
        Sun,  2 Jul 2023 13:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895FAC433C7;
        Sun,  2 Jul 2023 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688305667;
        bh=/7Rj/iZ9wDoGuWO9iGHfXACyhHiqIO75YFgG4pG1HuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrTxwbwoTY/TcXHc+T8Da5l6gvMSoYRAD5lrWpFfNqgSU5kgIxDDqiGhrb6XGK8V/
         zTU5WL/gkgRJ4M57CsirKsDN3v1urmNvI0oXZErHSVJL9Y5/QpuYB6rv3C7wM9lVB0
         x7QGIwMqO/bYCWBU104kSAB/06epjIYhjluIxj/l88uMMAw1rVeV6dTzwDGUmpQrFN
         yQeXLA7bmJ6WE5cbl5BDQ5iN0LoR5/owsQXSeqqd20OwMW9Y04qX4EAV2NeZQBEOFk
         4jZtarOSU4u1z2SEnea3i1A125DHUVCJYVwkeQhnKOMd3lHVTZlCXezK4BDvOqTnHA
         wZANz5fUObRMQ==
Date:   Sun, 2 Jul 2023 14:47:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yunhui Cui <cuiyunhui@bytedance.com>
Cc:     ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, alexghiti@rivosinc.com,
        sunilvl@ventanamicro.com
Subject: Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
Message-ID: <20230702-headway-dreamlike-d7ba39ac4910@spud>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kMsgyIL00Rp7iZh4"
Content-Disposition: inline
In-Reply-To: <20230702095735.860-1-cuiyunhui@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kMsgyIL00Rp7iZh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,
%subject: riscv: obtain ACPI RSDP from FFI.

This subject is a bit unhelpful because FFI would commonly mean "foreign
function interface" & you have not yet introduced it. It seems like it
would be better to do s/FFI/devicetree/ or similar.
Please also drop the full stop from the commit messages ;)

Please use a cover letter for multi-patch series & include changelogs.

+CC Sunil, Alex:

Can you guys please take a look at this & see if it is something that we
want to do (ACPI without EFI)?

On Sun, Jul 02, 2023 at 05:57:32PM +0800, Yunhui Cui wrote:
> 1. We need to enable the ACPI function on RISC-V.

RISC-V already supports ACPI, the "we" in this commit message is
confusing. Who is "we"? Bytedance?

> When booting with
> Coreboot, we encounter two problems:
> a. Coreboot does not support EFI


> b. On RISC-V, only the DTS channel can be used.

We support ACPI, so this seems inaccurate. Could you explain it better
please?

> 2. Based on this, we have added an interface for obtaining firmware
> information transfer through FDT, named FFI.

Please use the long form of "FFI" before using the short form, since you
are inventing this & noone knows what it means yet.

> 3. We not only use FFI to pass ACPI RSDP, but also pass other
> firmware information as an extension.

This patch doesn't do that though?

> +RISC-V FDT FIRMWARE INTERFACE (FFI) SUPPORT
> +M:     Yunhui Cui cuiyunhui@bytedance.com
> +S:     Maintained
> +F:     arch/riscv/include/asm/ffi.h
> +F:     arch/riscv/kernel/ffi.c

Please add this in alphabetical order, these entries have recently been
resorted. That said, maintainers entry for a trivial file in arch code
seems a wee bit odd, seems like it would be better suited rolled up into
your other entry for the interface, like how Ard's one looks for EFI?

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b49793cf34eb..2e1c40fb2300 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -785,6 +785,16 @@ config EFI
>  	  allow the kernel to be booted as an EFI application. This
>  	  is only useful on systems that have UEFI firmware.
> =20
> +config FFI
> +	bool "Fdt firmware interface"
> +	depends on OF
> +	default y
> +	help
> +	  Added an interface to obtain firmware information transfer
> +	  through FDT, named FFI. Some bootloaders do not support EFI,
> +	  such as coreboot.
> +	  We can pass firmware information through FFI, such as ACPI.

I don't understand your Kconfig setup. Why don't you just have one
option (the one from patch 2/3), instead of adding 2 different but
similarly named options?

>  config CC_HAVE_STACKPROTECTOR_TLS
>  	def_bool $(cc-option,-mstack-protector-guard=3Dtls -mstack-protector-gu=
ard-reg=3Dtp -mstack-protector-guard-offset=3D0)
> =20
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index f71ce21ff684..f9d1625dd159 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -15,6 +15,8 @@
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
> =20
> +#include <asm/ffi.h>
> +
>  typedef u64 phys_cpuid_t;
>  #define PHYS_CPUID_INVALID INVALID_HARTID
> =20
> @@ -66,6 +68,13 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
>  		       unsigned int cpu, const char **isa);
> =20
>  static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_N=
ODE; }
> +
> +#define ACPI_HAVE_ARCH_GET_ROOT_POINTER

How come this is not set in Kconfig like HAVE_FOO options usually are?

> +static inline u64 acpi_arch_get_root_pointer(void)
> +{
> +	return acpi_rsdp;
> +}
> +
>  #else
>  static inline void acpi_init_rintc_map(void) { }
>  static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> diff --git a/arch/riscv/include/asm/ffi.h b/arch/riscv/include/asm/ffi.h
> new file mode 100644
> index 000000000000..847af02abd87
> --- /dev/null
> +++ b/arch/riscv/include/asm/ffi.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_FFI_H
> +#define _ASM_FFI_H
> +
> +extern u64 acpi_rsdp;

/stuff/linux/drivers/acpi/osl.c:178:22: error: redefinition of 'acpi_rsdp' =
with a different type: 'unsigned long' vs 'u64' (aka 'unsigned long long')

Fails to build when Kexec is enabled.

> +extern void ffi_init(void);
> +
> +#endif /* _ASM_FFI_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 506cc4a9a45a..274e06f4da33 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_CRASH_CORE)	+=3D crash_core.o
>  obj-$(CONFIG_JUMP_LABEL)	+=3D jump_label.o
> =20
>  obj-$(CONFIG_EFI)		+=3D efi.o
> +obj-$(CONFIG_FFI)              +=3D ffi.o

This file uses tabs for alignment, not spaces.

>  obj-$(CONFIG_COMPAT)		+=3D compat_syscall_table.o
>  obj-$(CONFIG_COMPAT)		+=3D compat_signal.o
>  obj-$(CONFIG_COMPAT)		+=3D compat_vdso/
> diff --git a/arch/riscv/kernel/ffi.c b/arch/riscv/kernel/ffi.c
> new file mode 100644
> index 000000000000..c5ac2b5d9148
> --- /dev/null
> +++ b/arch/riscv/kernel/ffi.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ffi.c - FDT FIRMWARE INTERFACE
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/libfdt.h>
> +
> +u64 acpi_rsdp;
> +
> +void __init ffi_acpi_root_pointer(void)
> +{
> +	int cfgtbl, len;
> +	fdt64_t *prop;
> +
> +	cfgtbl =3D fdt_path_offset(initial_boot_params, "/cfgtables");
> +	if (cfgtbl < 0) {
> +		pr_info("firmware table not found.\n");
> +		return;
> +	}
> +
> +	prop =3D fdt_getprop_w(initial_boot_params, cfgtbl, "acpi_phy_ptr", &le=
n);
> +	if (!prop || len !=3D sizeof(u64))
> +		pr_info("acpi_rsdp not found.\n");
> +	else
> +		acpi_rsdp =3D fdt64_to_cpu(*prop);
> +
> +	pr_debug("acpi rsdp: %llx\n", acpi_rsdp);

Same comments here about undocumented DT properties and pr_*()s that
likely are not wanted (or correct).

> +}
> +
> +void __init ffi_init(void)
> +{
> +	ffi_acpi_root_pointer();

What happens if, on a system with "normal" ACPI support, ffi_init() is
called & ffi_acpi_root_pointer() calls things like fdt_path_offset()?

> +}
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 971fe776e2f8..5a933d6b6acb 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -36,6 +36,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/kasan.h>
>  #include <asm/efi.h>
> +#include <asm/ffi.h>
> =20
>  #include "head.h"
> =20
> @@ -279,6 +280,7 @@ void __init setup_arch(char **cmdline_p)
>  	parse_early_param();
> =20
>  	efi_init();
> +	ffi_init();

What provides ffi_init() if CONFIG_FFI is disabled?

>  	paging_init();
> =20
>  	/* Parse the ACPI tables for possible boot-time configuration */

Cheers,
Conor.

--kMsgyIL00Rp7iZh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKF//QAKCRB4tDGHoIJi
0gMTAPsFVCQFdXhKcADENs99hMaWFluxFBwo4rAMVF8yOgKqsgD/X+viS5AfOI8j
XBPyfx1TWVqW7Lsdyiz+IBTzhPFGbA0=
=PtH3
-----END PGP SIGNATURE-----

--kMsgyIL00Rp7iZh4--
