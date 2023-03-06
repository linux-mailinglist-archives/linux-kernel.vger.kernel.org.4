Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260B16ACF98
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCFUxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCFUxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:53:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3C537B5D;
        Mon,  6 Mar 2023 12:53:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3F5B61181;
        Mon,  6 Mar 2023 20:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A56BC433EF;
        Mon,  6 Mar 2023 20:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678136026;
        bh=NakG+udHMujvBinBm81ENcDUa1LVQK5yEc/6FYz+Xdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmNOkiEmw3CbWQXoNrxqi2pSqbVn+B/k3COrtrHaP6YvsyrDLlP/qnQSUlmGKSJ7Q
         APTsyEKJPnGa4llzwnbIOih90BLO4v1BntbC/9z3yo2zEJdVInTOeg4tHBQfyUwpfg
         5XzXuonl9i+rtQPki9sOSFrxfCvFHCFUzIMhXaEcg34ZTEJdz2SUocf7dwkXkJI9DI
         GP9pXhbf+CXMOVi5LJJNKTOO/LFGlddwfSV+eiPVwmsoXl0EVgmC+7xltZEnBlrvA6
         GUoPA4abjE7ucG/Jdg4dyJV6/OjJmWBWtq73AeCrdPQJR2kmBUZtYaYGJB/L12aunM
         lpPm6RnueFiiQ==
Date:   Mon, 6 Mar 2023 20:53:40 +0000
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
Subject: Re: [PATCH V3 14/20] irqchip/riscv-intc: Add ACPI support
Message-ID: <d975f22b-8251-4656-a038-22e7b0e8e2e9@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-15-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CI5s8v9JZULMfQYG"
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-15-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CI5s8v9JZULMfQYG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 07:06:41PM +0530, Sunil V L wrote:
> Add support for initializing the RISC-V INTC driver on ACPI
> platforms.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/irqchip/irq-riscv-intc.c | 77 +++++++++++++++++++++++++++-----
>  1 file changed, 65 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index f229e3e66387..f522510dc1f3 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -6,6 +6,7 @@
>   */
> =20
>  #define pr_fmt(fmt) "riscv-intc: " fmt
> +#include <linux/acpi.h>
>  #include <linux/atomic.h>
>  #include <linux/bits.h>
>  #include <linux/cpu.h>
> @@ -112,6 +113,30 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
>  	return intc_domain->fwnode;
>  }
> =20
> +static int __init riscv_intc_init_common(struct fwnode_handle *fn)
> +{
> +	int rc;
> +
> +	intc_domain =3D irq_domain_create_linear(fn, BITS_PER_LONG,
> +					       &riscv_intc_domain_ops, NULL);
> +	if (!intc_domain) {
> +		pr_err("unable to add IRQ domain\n");
> +		return -ENXIO;
> +	}
> +
> +	rc =3D set_handle_irq(&riscv_intc_irq);
> +	if (rc) {
> +		pr_err("failed to set irq handler\n");
> +		return rc;
> +	}
> +
> +	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
> +
> +	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> +
> +	return 0;
> +}
> +
>  static int __init riscv_intc_init(struct device_node *node,
>  				  struct device_node *parent)
>  {
> @@ -133,24 +158,52 @@ static int __init riscv_intc_init(struct device_nod=
e *node,
>  	if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id())
>  		return 0;
> =20
> -	intc_domain =3D irq_domain_add_linear(node, BITS_PER_LONG,
> -					    &riscv_intc_domain_ops, NULL);
> -	if (!intc_domain) {
> -		pr_err("unable to add IRQ domain\n");
> -		return -ENXIO;
> -	}
> -
> -	rc =3D set_handle_irq(&riscv_intc_irq);
> +	rc =3D riscv_intc_init_common(of_node_to_fwnode(node));
>  	if (rc) {
> -		pr_err("failed to set irq handler\n");
> +		pr_err("failed to initialize INTC\n");

The early return paths from riscv_intc_init_common() all print
something, is also printing here redundant?

This seems fine to me otherwise though,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>  		return rc;
>  	}
> =20
> -	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
> +	return 0;
> +}
> =20
> -	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> +IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
> +
> +#ifdef CONFIG_ACPI
> +
> +static int __init riscv_intc_acpi_init(union acpi_subtable_headers *head=
er,
> +				       const unsigned long end)
> +{
> +	int rc;
> +	struct fwnode_handle *fn;
> +	struct acpi_madt_rintc *rintc;
> +
> +	rintc =3D (struct acpi_madt_rintc *)header;
> +
> +	/*
> +	 * The ACPI MADT will have one INTC for each CPU (or HART)
> +	 * so riscv_intc_acpi_init() function will be called once
> +	 * for each INTC. We only do INTC initialization
> +	 * for the INTC belonging to the boot CPU (or boot HART).
> +	 */
> +	if (riscv_hartid_to_cpuid(rintc->hart_id) !=3D smp_processor_id())
> +		return 0;
> +
> +	fn =3D irq_domain_alloc_named_fwnode("RISCV-INTC");
> +	if (!fn) {
> +		pr_err("unable to allocate INTC FW node\n");
> +		return -ENOMEM;
> +	}
> +
> +	rc =3D riscv_intc_init_common(fn);
> +	if (rc) {
> +		pr_err("failed to initialize INTC\n");
> +		return rc;
> +	}
> =20
>  	return 0;
>  }
> =20
> -IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
> +IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,
> +		     ACPI_MADT_RINTC_VERSION_V1, riscv_intc_acpi_init);
> +#endif
> --=20
> 2.34.1
>=20

--CI5s8v9JZULMfQYG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAZS0wAKCRB4tDGHoIJi
0p5wAQDMIB8ZaMou3I/1DIHkuNvM2PtliLr1P2CRNSwcuxUCFQEA8bQs3OHXrkzg
V2r/9AWgzAMTWAbaAat7a7p5UkFxzgk=
=ZgiL
-----END PGP SIGNATURE-----

--CI5s8v9JZULMfQYG--
