Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C67691219
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjBIUav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBIUat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:30:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B694660E48;
        Thu,  9 Feb 2023 12:30:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CDD2B822F4;
        Thu,  9 Feb 2023 20:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF30C433D2;
        Thu,  9 Feb 2023 20:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675974646;
        bh=e3gDRdsYumU0V7wuKmL/JJmRTnqZh9NF45/6OEcupz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObEzotjVubNfM01B84NNBYG1qo26B9tmubw1/LmOU5J00M9SWdQZjQKOnYo4LXkX6
         1e5rWhOCXzWlIENvVb62FROWmczclkS224xU3HNbekCqeejZqhyNk7rftyeoK9ZDV/
         J8PqdAPIbFNJ6tlp6C7g0TlDHfSS0I3uRUbcjLXq9KzNV7oDq4ED5G5GMjXTNNJNzy
         /YCN67s2SFa1TwMaLGyznWJk8jOzDnzqCdyW3BD7gSvHsIz6/fBBx+cIm4uMErB9Wr
         Q6eAeExbv7650Km7en169zGchKAcka5q3ZkNuno1mqriOSAjPYiYsgBB5Art9RomXk
         5bdXaOAl+9vpw==
Date:   Thu, 9 Feb 2023 20:30:40 +0000
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
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 14/24] RISC-V: ACPI: smpboot: Add function to retrieve
 the hartid
Message-ID: <Y+VX8EclC1cE2fdI@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-15-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/IAbprJ0ojDzJd5b"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-15-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/IAbprJ0ojDzJd5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sunil, Drew,

@drew, a question below that I'm sorta aiming at you...

On Mon, Jan 30, 2023 at 11:52:15PM +0530, Sunil V L wrote:
> hartid is in RINTC structuire in MADT table. Instead of parsing

Nit: missing articles before RINTC and MADT. Also typo "structure".

Perhaps you'd benefit from a spell checker in your git editor.

> the ACPI table every time we need for a cpu, cache it and provide
> a function to read it.
>=20
> This is similar to acpi_get_madt_gicc() in arm64.

-ENOTFOUND, do you mean acpi_cpu_get_madt_gicc()?

>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/include/asm/acpi.h | 14 +++++++++++++-
>  arch/riscv/kernel/smpboot.c   | 21 +++++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index d1f1e53ec657..69a880b7257a 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -65,6 +65,18 @@ int acpi_numa_get_nid(unsigned int cpu);
>  static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_N=
ODE; }
>  #endif /* CONFIG_ACPI_NUMA */
> =20
> -#endif
> +struct acpi_madt_rintc *acpi_get_madt_rintc(int cpu);
> +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> +static inline u32 get_acpi_id_for_cpu(int cpu)
> +{
> +	return	acpi_cpu_get_madt_rintc(cpu)->uid;
> +}
> +#else
> +static inline u32 get_acpi_id_for_cpu(int cpu)
> +{
> +	return -1;
> +}
> +
> +#endif /* CONFIG_ACPI */
> =20
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index e48cf88d0bc1..3a8b7a9eb5ac 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -73,6 +73,25 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> =20
>  #ifdef CONFIG_ACPI
>  static unsigned int cpu_count =3D 1;
> +static unsigned int intc_count;
> +static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> +
> +struct acpi_madt_rintc *acpi_get_madt_rintc(int cpu)
> +{
> +	return &cpu_madt_rintc[cpu];
> +}
> +
> +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> +{
> +	int i;

Since we are C11 now, you don't even need to declare this outside of the
loop, right?

> +
> +	for (i =3D 0; i < NR_CPUS; i++) {

@drew, perhaps you know since you were fiddling not too long ago with
cpumask stuff - at what point does for_each_possible_cpu() become
usable?
I had a bit of a poke & couldn't immediately tell if it'd be okay to use
it here.

> +		if (riscv_hartid_to_cpuid(cpu_madt_rintc[i].hart_id) =3D=3D cpu)
> +			return &cpu_madt_rintc[i];
> +	}
> +	return NULL;

Another nit: newline before return please :)

> +}
> +EXPORT_SYMBOL_GPL(acpi_cpu_get_madt_rintc);
> =20
>  static int __init
>  acpi_parse_rintc(union acpi_subtable_headers *header,
> @@ -92,6 +111,8 @@ acpi_parse_rintc(union acpi_subtable_headers *header,
>  	hart =3D processor->hart_id;
>  	if (hart < 0)
>  		return 0;
> +
> +	cpu_madt_rintc[intc_count++] =3D *processor;
>  	if (hart =3D=3D cpuid_to_hartid_map(0)) {
>  		BUG_ON(found_boot_cpu);
>  		found_boot_cpu =3D 1;
> --=20
> 2.38.0
>=20

--/IAbprJ0ojDzJd5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+VX8AAKCRB4tDGHoIJi
0r7FAP4mzn2lR8zMpvukT7FXR/JrLLAqcDH+l3BCT6afCecnVQEAxW5tBLxQ5BAv
MIr2O07UCa1aYCinVanhPH/8yj2ETgM=
=kGhZ
-----END PGP SIGNATURE-----

--/IAbprJ0ojDzJd5b--
