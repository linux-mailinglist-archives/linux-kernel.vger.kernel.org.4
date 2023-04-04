Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150C66D6EA2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbjDDVFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbjDDVFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4344EEF;
        Tue,  4 Apr 2023 14:05:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79461637A5;
        Tue,  4 Apr 2023 21:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7703CC433D2;
        Tue,  4 Apr 2023 21:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680642303;
        bh=K+YWB6gtDBp8CY/sw1YdMADMAZus/ze/KCovhnmTEck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvZL46gPl/xyjGjJ3q1IGZT3hEDWU5Z1qRvJ34K5e+P+rh4U8Dulcd+kZdpBk/2fg
         EoDwLVwBfOvewMhUzO+qQ230d3TvGufRgNY7oJnYMFhMfGw5L0D0mCgXlYMgOHKi0J
         PuzMDNMxBK9E1lgGuog9v2Hsiyk740+qVIN+PaQsIacLtF79eZe4/mXsw7v2311Cv0
         vGVRMg689a/17buOafoebW1qYaNZhjqjV6Sni6lBzj8PimtBFJiosrY2ynzKiLUUWR
         GydYoC8hx9jgsCvNiEmeZ/E9TqX3I0P43gNjmi/7iwuSR1RKuyy9XwomTJEvPrGQJR
         TiSqGmVICEIfw==
Date:   Tue, 4 Apr 2023 22:04:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tom Rix <trix@redhat.com>, Weili Qian <qianweili@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Len Brown <lenb@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH V4 14/23] RISC-V: cpu: Enable cpuinfo for ACPI systems
Message-ID: <20230404-overlaid-flatterer-22731133a75f@spud>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-15-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zg/bxp6Ef08iSfBi"
Content-Disposition: inline
In-Reply-To: <20230404182037.863533-15-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zg/bxp6Ef08iSfBi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 11:50:28PM +0530, Sunil V L wrote:
> On ACPI based platforms, few details like ISA need to be read
> from the ACPI table. Enable cpuinfo on ACPI based systems.
>=20
> ACPI has nothing similar to DT compatible property for each CPU.

> SBI calls must be used to get vendor/arch/imp ID for any errata.

ecalls are used on DT systems for this too FYI, vendorid/archid/impid
are not contained in the DT.
Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Should probably have given that conditionally last time, sorry about
that.
Thanks,
Conor.

>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/kernel/cpu.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 8400f0cc9704..ace4752516d8 100644
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
> @@ -283,23 +285,35 @@ static void c_stop(struct seq_file *m, void *v)
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
> +
> +		print_mmu(m);
> +		if (!of_property_read_string(node, "compatible", &compat) &&
> +		    strcmp(compat, "riscv"))
> +			seq_printf(m, "uarch\t\t: %s\n", compat);
> +
> +		of_node_put(node);
> +	} else {
> +		if (!acpi_get_riscv_isa(NULL, cpu_id, &isa))
> +			print_isa(m, isa);
> +
> +		print_mmu(m);
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
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--zg/bxp6Ef08iSfBi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCyQ9wAKCRB4tDGHoIJi
0v51AQD/Jdo80g5XJuPuPzzfpYoAjR065ytz0121HJC/oU1PNgD7BeY4NQ7krey7
9Ah5lMqJDV5Ogs1mM3sF3tJs7eMPagQ=
=zA1D
-----END PGP SIGNATURE-----

--zg/bxp6Ef08iSfBi--
