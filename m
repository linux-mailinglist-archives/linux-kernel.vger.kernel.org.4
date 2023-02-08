Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BCD68FA19
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjBHWKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 17:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjBHWKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:10:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB2531E34;
        Wed,  8 Feb 2023 14:10:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7FCA612DF;
        Wed,  8 Feb 2023 22:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1521AC433D2;
        Wed,  8 Feb 2023 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675894220;
        bh=XVxjVUrRTJMXekRe8IZaijGwGSF2ZmqoQLEohJud26E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFLRdU1oPEPaTBobg0kMQ3XiQfJjz+jfF8+6uIqJro3fQbM2JuiAoNJsVE1OzzODQ
         kb72fmJRHtI4mE2/wv+kQZ6ALpuIXyKYOXdubDZ75by/lvy0H7r9JBlvLRPrdSDAIY
         jb5FWhTayc6ogQ9reLsU6PrMosSevsh/9PWxObeEm068DdohrmZ3AfMGQ9EWEF9fQV
         teiR6pXveERO0S6U5iQmI9RPuyNOhTBiWdpdx3rS9xjtZGXqexOQqwsRyjU4ScYetd
         dbpBxl6ZUC0yZYQ0boy0YYZ76t1Eua9XLM2SDqZ9tlkunPIqD9v81BQOa7Ym0q06Zw
         uytPz1fsX9AOw==
Date:   Wed, 8 Feb 2023 22:10:14 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-doc@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH 13/24] RISC-V: ACPI: smpboot: Add ACPI support in
 smp_setup()
Message-ID: <Y+Qdxg8LBs5mbl4+@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-14-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mo18E0oC3+AOVGLw"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-14-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mo18E0oC3+AOVGLw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:52:14PM +0530, Sunil V L wrote:
> Add function to parse the RINTC structure in
> the MADT table and create the required initializations to
> enable SMP boot on ACPI based platforms.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/include/asm/acpi.h |  7 ++++
>  arch/riscv/kernel/smpboot.c   | 73 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 79 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index c5cb9f96d404..d1f1e53ec657 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -58,6 +58,13 @@ static inline bool acpi_has_cpu_in_madt(void)
>  }
> =20
>  static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> +
> +#ifdef CONFIG_ACPI_NUMA
> +int acpi_numa_get_nid(unsigned int cpu);
> +#else
> +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_N=
ODE; }
> +#endif /* CONFIG_ACPI_NUMA */
> +
>  #endif
> =20
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 26214ddefaa4..e48cf88d0bc1 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -8,6 +8,7 @@
>   * Copyright (C) 2017 SiFive
>   */
> =20
> +#include <linux/acpi.h>
>  #include <linux/arch_topology.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -70,6 +71,73 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  }
> =20
> +#ifdef CONFIG_ACPI
> +static unsigned int cpu_count =3D 1;
> +
> +static int __init
> +acpi_parse_rintc(union acpi_subtable_headers *header,
> +			     const unsigned long end)

This all fits on one line. And also avoids the checkpatch complaint from
what you have currently done...

> +{
> +	unsigned long hart;
> +	bool found_boot_cpu =3D false;
> +
> +	struct acpi_madt_rintc *processor;
> +
> +	processor =3D (struct acpi_madt_rintc *)header;

Why not combine the above two lines?

> +	/* RINTC entry which has !ACPI_MADT_ENABLED is not enabled so skip */

This comment is a bit -ENOPARSE. Please reword it in a way that is
understandable to mere mortals like myself.

> +	if (!(processor->flags & ACPI_MADT_ENABLED))
> +		return 0;
> +
> +	hart =3D processor->hart_id;
> +	if (hart < 0)
> +		return 0;

Newline here please

> +	if (hart =3D=3D cpuid_to_hartid_map(0)) {
> +		BUG_ON(found_boot_cpu);
> +		found_boot_cpu =3D 1;

This is a bool, why not assign a bool value to it so it looks more
intentional? I know this is copied from the dt code, but that should
really be on too IMO.

> +		early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
> +		return 0;
> +	}

And a newline here too...

> +	if (cpu_count >=3D NR_CPUS) {
> +		pr_warn("Invalid cpuid [%d] for hartid [%lu]\n",
> +			cpu_count, hart);
> +		return 0;
> +	}
> +
> +	cpuid_to_hartid_map(cpu_count) =3D hart;
> +	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
> +	cpu_count++;

=2E..and also here please!

> +	return 0;
> +}
> +
> +static void __init acpi_parse_and_init_cpus(void)
> +{
> +	int cpuid;
> +
> +	cpu_set_ops(0);

While I'm at it suggesting newline additions, adding them before
comments would be great too.

> +	/*
> +	 * do a walk of MADT to determine how many CPUs
> +	 * we have including disabled CPUs, and get information
> +	 * we need for SMP init.
> +	 */
> +	acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC,
> +				      acpi_parse_rintc, 0);
> +
> +	/*
> +	 * NUMA - TODO
> +	 */

TODO before merging, or TODO at some indeterminate point in the future?

Anyways, this is all nits & this largely seem to resemble the dt code,
so with the nits fixed (and an s/ACPI: // in $subject):
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +	for (cpuid =3D 1; cpuid < nr_cpu_ids; cpuid++) {
> +		if (cpuid_to_hartid_map(cpuid) !=3D INVALID_HARTID) {
> +			cpu_set_ops(cpuid);
> +			set_cpu_possible(cpuid, true);
> +		}
> +	}
> +}
> +#else
> +#define acpi_parse_and_init_cpus(...)	do { } while (0)
> +#endif
> +
>  static void __init of_parse_and_init_cpus(void)
>  {
>  	struct device_node *dn;
> @@ -118,7 +186,10 @@ static void __init of_parse_and_init_cpus(void)
> =20
>  void __init setup_smp(void)
>  {
> -	of_parse_and_init_cpus();
> +	if (acpi_disabled)
> +		of_parse_and_init_cpus();
> +	else
> +		acpi_parse_and_init_cpus();
>  }
> =20
>  static int start_secondary_cpu(int cpu, struct task_struct *tidle)
> --=20
> 2.38.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--mo18E0oC3+AOVGLw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+QdxgAKCRB4tDGHoIJi
0mYzAQCje2xPmfoUKUo3YwQThJBacTIIFH5J2oMBl6ngBZ+FdwD/SLgyM6yOKUw6
o1k5955yH/LsIcrq+z5XQy71gq8yRQ8=
=K1kC
-----END PGP SIGNATURE-----

--mo18E0oC3+AOVGLw--
