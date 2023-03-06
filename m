Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C86ACF4C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCFUjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCFUjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:39:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E170C2F7B4;
        Mon,  6 Mar 2023 12:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DA4BB81114;
        Mon,  6 Mar 2023 20:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379B7C433D2;
        Mon,  6 Mar 2023 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678135146;
        bh=PVgRqovCZodL9qTvWRaSXFxiEeGWYfaF6T2aECGZlt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwwKf0IusDpHRBtWEk5oFKRldF0xSr1q0tYY1A1uywwJyltm0EedRrvMFi+KDTEs3
         SO7BQ3oSCA/w5Qw3EPgrM2qN+67SOJCrXZimzWEZFR3ZK5T20WBkUxTDHKG5zT0Wni
         CBc+9emJW147nVO/4Vqqiy1Dt1+10d8hfOSzRmZAk1dJbu5rinEXH13MuwKQ9bsWB3
         bloix29Q83UkDaOjJDLfYlIN8VDjD9AHN1LVHNh2f2VIxQbrKcuttIQLmaRiwCzPJn
         pFsQfz+gIZ1fThi79Xol7OCcj/es1nHn3nTkAB5GP98iCLQQL1Cm3JBktDnNXA9CZM
         eRn+BYTbC15Tg==
Date:   Mon, 6 Mar 2023 20:39:00 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 13/20] RISC-V: cpu: Enable cpuinfo for ACPI systems
Message-ID: <91d0a681-68fb-4ca2-a7cc-2c231ab25ed1@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-14-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zzb142uoY8YvG8ro"
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-14-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zzb142uoY8YvG8ro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 07:06:40PM +0530, Sunil V L wrote:
> On ACPI based platforms, few details like ISA need to be read
> from the ACPI table. Enable cpuinfo on ACPI based systems.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/riscv/kernel/cpu.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 8400f0cc9704..80101bf77dab 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -3,10 +3,12 @@
>   * Copyright (C) 2012 Regents of the University of California
>   */
> =20
> +#include <linux/acpi.h>
>  #include <linux/cpu.h>
>  #include <linux/init.h>
>  #include <linux/seq_file.h>
>  #include <linux/of.h>
> +#include <asm/acpi.h>
>  #include <asm/csr.h>
>  #include <asm/hwcap.h>
>  #include <asm/sbi.h>
> @@ -283,23 +285,32 @@ static void c_stop(struct seq_file *m, void *v)
>  static int c_show(struct seq_file *m, void *v)
>  {
>  	unsigned long cpu_id =3D (unsigned long)v - 1;
> -	struct device_node *node =3D of_get_cpu_node(cpu_id, NULL);
>  	struct riscv_cpuinfo *ci =3D per_cpu_ptr(&riscv_cpuinfo, cpu_id);
> +	struct device_node *node;
>  	const char *compat, *isa;
> =20
>  	seq_printf(m, "processor\t: %lu\n", cpu_id);
>  	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
> -	if (!of_property_read_string(node, "riscv,isa", &isa))
> -		print_isa(m, isa);
> -	print_mmu(m);
> -	if (!of_property_read_string(node, "compatible", &compat)
> -	    && strcmp(compat, "riscv"))
> -		seq_printf(m, "uarch\t\t: %s\n", compat);
> +
> +	if (acpi_disabled) {
> +		node =3D of_get_cpu_node(cpu_id, NULL);
> +		if (!of_property_read_string(node, "riscv,isa", &isa))
> +			print_isa(m, isa);
> +		print_mmu(m);
> +		if (!of_property_read_string(node, "compatible", &compat) &&
> +		    strcmp(compat, "riscv"))
> +			seq_printf(m, "uarch\t\t: %s\n", compat);
> +		of_node_put(node);

While you're touching this stuff, would you mind decorating it with some
whitespace between if statements?

> +	} else {
> +		if (!acpi_get_riscv_isa(NULL, get_acpi_id_for_cpu(cpu_id), &isa))
> +			print_isa(m, isa);
> +		print_mmu(m);

I assume ACPI has no equivalent of the compatible from which to generate
uarch?
A note as to why this is not present in the commit message would likely
be helpful to us ACPI-heathens.

> +	}
> +
>  	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
>  	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
>  	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
>  	seq_puts(m, "\n");
> -	of_node_put(node);
> =20
>  	return 0;
>  }
> --=20
> 2.34.1
>=20

--zzb142uoY8YvG8ro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAZPZAAKCRB4tDGHoIJi
0gAUAP9ghb1SIE+EY/YVOJ6Au3GSpDggAd99Usj07O5jxwnYNQEA0j7jQvGY3hBr
IPRaTd9yJJgoaSqzkLykWGI0J+50/AI=
=vGFP
-----END PGP SIGNATURE-----

--zzb142uoY8YvG8ro--
