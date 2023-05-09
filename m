Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642B66FCD05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjEIRuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjEIRuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74FF3C3A;
        Tue,  9 May 2023 10:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5671E62B20;
        Tue,  9 May 2023 17:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C601C433EF;
        Tue,  9 May 2023 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683654615;
        bh=rVSz+Tb3H1/HHESESFxVFjW2CxxTsz7vH2xOqzNlQXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWUmzHG8xFjWpRkUn7jxvkUG21EZyVRmvIHAfaVcDHRGM9jMRutvis8vhLLUy4O6s
         TNfr8CkW+0xFnginSyEkOvFBFvpfOmfhA5nD3ARTrQ70JeNf4ZdFCI5HaO0KOLYccW
         vQdtgGdmg/tQ5H63l/yZA/IRiWefyI99JD7UG/jkDkK98gs8oeXFAAGuZ3x/WUQl08
         dJVCQI52RgYMOfw8/KVYJ1KtUhhMWuPE0OU99QGXVBQFCtLEJXKyVpOEh03tYK0nnO
         JOdA+2jhGLcjwX9OUN+wPeWnGy/ROl2o4urTxQBEOvfJ3/SX8Fmf+xvybwL/5Cz17z
         qRmXV8na65m5w==
Date:   Tue, 9 May 2023 18:50:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V5 08/21] RISC-V: ACPI: Cache and retrieve the RINTC
 structure
Message-ID: <20230509-atlantic-writing-3ceea38e050e@spud>
References: <20230508115237.216337-1-sunilvl@ventanamicro.com>
 <20230508115237.216337-9-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VyG74+KZvewY8TZ5"
Content-Disposition: inline
In-Reply-To: <20230508115237.216337-9-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VyG74+KZvewY8TZ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sunil,

On Mon, May 08, 2023 at 05:22:24PM +0530, Sunil V L wrote:
> RINTC structures in the MADT provide mapping between the hartid
> and the CPU. This is required many times even at run time like
> cpuinfo. So, instead of parsing the ACPI table every time, cache
> the RINTC structures and provide a function to get the correct
> RINTC structure for a given cpu.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

=46rom this patch until "RISC-V: Add ACPI initialization in
setup_arch()" (which is 19/21), the series fails to build.

allmodconfig, clang-16:
=2E./arch/riscv/include/asm/acpi.h:22:23: error: unknown type name 'acpi_ph=
ysical_address'; did you mean 'efi_physical_addr_t'?
=2E./arch/riscv/include/asm/acpi.h:22:51: error: unknown type name 'acpi_si=
ze'

rv32_defconfig, clang-16:
arch/riscv/kernel/setup.c:297:7: error: use of undeclared identifier 'acpi_=
disabled'; did you mean '__cpu_disable'?
arch/riscv/kernel/setup.c:297:7: warning: address of function '__cpu_disabl=
e' will always evaluate to 'true' [-Wpointer-bool-conversion]

I ballsed up a toolchain upgrade to gcc-13, so the whole series is
showing build issues on patchwork for the gcc configurations:
https://patchwork.kernel.org/project/linux-riscv/list/?series=3D745787

However, I suspect that the same patches that fail for clang-16 will
fail for gcc-13 too, once I have fixed that!

Cheers,
Conor.

> ---
>  arch/riscv/include/asm/acpi.h | 10 ++++++++
>  arch/riscv/kernel/acpi.c      | 45 +++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c     |  4 ++++
>  3 files changed, 59 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 9be52b6ffae1..6519529c8bdf 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -59,6 +59,16 @@ static inline bool acpi_has_cpu_in_madt(void)
> =20
>  static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> =20
> +void acpi_init_rintc_map(void);
> +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> +u32 get_acpi_id_for_cpu(int cpu);
> +#else
> +static inline void acpi_init_rintc_map(void) { }
> +static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> +{
> +	return NULL;
> +}
> +
>  #endif /* CONFIG_ACPI */
> =20
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 81d448c41714..89e142611c84 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -24,6 +24,51 @@ EXPORT_SYMBOL(acpi_disabled);
>  int acpi_pci_disabled =3D 1;	/* skip ACPI PCI scan and IRQ initializatio=
n */
>  EXPORT_SYMBOL(acpi_pci_disabled);
> =20
> +static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> +
> +static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, co=
nst unsigned long end)
> +{
> +	struct acpi_madt_rintc *rintc =3D (struct acpi_madt_rintc *)header;
> +	int cpuid;
> +
> +	if (!(rintc->flags & ACPI_MADT_ENABLED))
> +		return 0;
> +
> +	cpuid =3D riscv_hartid_to_cpuid(rintc->hart_id);
> +	/*
> +	 * When CONFIG_SMP is disabled, mapping won't be created for
> +	 * all cpus.
> +	 * CPUs more than num_possible_cpus, will be ignored.
> +	 */
> +	if (cpuid >=3D 0 && cpuid < num_possible_cpus())
> +		cpu_madt_rintc[cpuid] =3D *rintc;
> +
> +	return 0;
> +}
> +
> +/*
> + * Instead of parsing (and freeing) the ACPI table, cache
> + * the RINTC structures since they are frequently used
> + * like in  cpuinfo.
> + */
> +void __init acpi_init_rintc_map(void)
> +{
> +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, =
0) <=3D 0) {
> +		pr_err("No valid RINTC entries exist\n");
> +		BUG();
> +	}
> +}
> +
> +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> +{
> +	return &cpu_madt_rintc[cpu];
> +}
> +
> +u32 get_acpi_id_for_cpu(int cpu)
> +{
> +	return acpi_cpu_get_madt_rintc(cpu)->uid;
> +}
> +
>  /*
>   * __acpi_map_table() will be called before paging_init(), so early_iore=
map()
>   * or early_memremap() should be called here to for ACPI table mapping.
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 9fb839074e16..a44c7fcde12f 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -21,6 +21,7 @@
>  #include <linux/efi.h>
>  #include <linux/crash_dump.h>
> =20
> +#include <asm/acpi.h>
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cpu_ops.h>
> @@ -293,6 +294,9 @@ void __init setup_arch(char **cmdline_p)
>  	setup_smp();
>  #endif
> =20
> +	if (!acpi_disabled)
> +		acpi_init_rintc_map();
> +
>  	riscv_init_cbo_blocksizes();
>  	riscv_fill_hwcap();
>  	apply_boot_alternatives();
> --=20
> 2.34.1
>=20

--VyG74+KZvewY8TZ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFqHzwAKCRB4tDGHoIJi
0vwIAP42h0wsHOgAHQ3WyuVw8G1XFBezccQwODC76RxofaL0TAEA+V+4IuPaUdHr
5H2An4OZhjeskB4ClsRk3M+rqDqMXAc=
=OVlw
-----END PGP SIGNATURE-----

--VyG74+KZvewY8TZ5--
