Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C48A6AD009
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCFVRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCFVRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:17:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D7574313;
        Mon,  6 Mar 2023 13:17:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E2E260C03;
        Mon,  6 Mar 2023 21:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D14C4339B;
        Mon,  6 Mar 2023 21:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678137460;
        bh=wSaQ1angfsAOIZ6JP6ZiMFA9+exAxA4Z70DBQooJak0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+CUUL2GjljKxVebr2unVC4wW4Dmj+JSWL2RAn1mJ8rj72IBVbcjAq6wBz96xeGEm
         dWwAsLcjFCToZTrwoH/y671tif1pt7qU4xvl2/tbR67AMYAaDGnBlG4juzmS3q/jN9
         /5gBUucQ5l3iF4JKcZMEFrzxBu5s2Y3dBk0HybVSUIJYtuCGNas5mK+QqWud7Paguv
         xeYkjhOtsAkWRXLHnWNQwoU2Ji7FkWMnFWIBEEviKuPoj2mugSOu1BvyfJ8cCNL5Ym
         hlT/J/GWR39uLj23dtmpBDv2lE3wIv49JDRm2nPaCD4G58IISmeAdgBPRvtgubOcjo
         ZbOidWRfuQ/tg==
Date:   Mon, 6 Mar 2023 21:17:34 +0000
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
Subject: Re: [PATCH V3 18/20] RISC-V: Add ACPI initialization in setup_arch()
Message-ID: <b38179fe-f1b8-4146-ae22-11e8bbbd500e@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-19-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EIryT2fP1CbWR+C6"
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-19-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EIryT2fP1CbWR+C6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 07:06:45PM +0530, Sunil V L wrote:
> Initialize the ACPI core for RISC-V during boot.
>=20
> ACPI tables and interpreter are initialized based on
> the information passed from the firmware and the value of
> the kernel parameter 'acpi'.
>=20
> With ACPI support added for RISC-V, the kernel parameter 'acpi'
> is also supported on RISC-V. Hence, update the documentation.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---

> +static int __init acpi_fadt_sanity_check(void)
> +{
> +	struct acpi_table_header *table;
> +	struct acpi_table_fadt *fadt;
> +	acpi_status status;
> +	int ret =3D 0;
> +
> +	/*
> +	 * FADT is required on riscv; retrieve it to check its presence
> +	 * and carry out revision and ACPI HW reduced compliancy tests
> +	 */
> +	status =3D acpi_get_table(ACPI_SIG_FADT, 0, &table);
> +	if (ACPI_FAILURE(status)) {
> +		const char *msg =3D acpi_format_exception(status);
> +
> +		pr_err("Failed to get FADT table, %s\n", msg);
> +		return -ENODEV;
> +	}
> +
> +	fadt =3D (struct acpi_table_fadt *)table;
> +
> +	/*
> +	 * Revision in table header is the FADT Major revision, and there
> +	 * is a minor revision of FADT.

What is the point of this part of the comment? Isn't it obvious from the
below code that you expect a major and minor revision?
If feel like you're trying to make a point in it, but the point has been
lost :/

> +	 *
> +	 * TODO: Currently, we check for 6.5 as the minimum version to check
> +	 * for HW_REDUCED flag. However, once RISC-V updates are released in
> +	 * the ACPI spec, we need to update this check for exact minor revision
> +	 */
> +	if (table->revision < 6 || (table->revision =3D=3D 6 && fadt->minor_rev=
ision < 5)) {
> +		pr_err(FW_BUG "Unsupported FADT revision %d.%d, should be 6.5+\n",
> +		       table->revision, fadt->minor_revision);
> +	}
> +
> +	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
> +		pr_err("FADT not ACPI hardware reduced compliant\n");
> +		ret =3D -EINVAL;
> +	}
> +
> +	/*
> +	 * acpi_get_table() creates FADT table mapping that
> +	 * should be released after parsing and before resuming boot
> +	 */
> +	acpi_put_table(table);
> +	return ret;
> +}

> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2d45a416d283..7b2b065a9f70 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -8,6 +8,7 @@
>   *  Nick Kossifidis <mick@ics.forth.gr>
>   */
> =20
> +#include <linux/acpi.h>
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/memblock.h>
> @@ -276,14 +277,22 @@ void __init setup_arch(char **cmdline_p)
> =20
>  	efi_init();
>  	paging_init();
> -#if IS_ENABLED(CONFIG_BUILTIN_DTB)
> -	unflatten_and_copy_device_tree();
> -#else
> -	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> -		unflatten_device_tree();
> -	else
> -		pr_err("No DTB found in kernel mappings\n");
> -#endif
> +
> +	/* Parse the ACPI tables for possible boot-time configuration */
> +	acpi_boot_table_init();
> +	if (acpi_disabled) {
> +		if (IS_ENABLED(CONFIG_BUILTIN_DTB)) {
> +			unflatten_and_copy_device_tree();
> +		} else {
> +			if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> +				unflatten_device_tree();
> +			else
> +				pr_err("No DTB found in kernel mappings\n");
> +		}
> +	} else {
> +		early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa)));
> +	}
> +
>  	early_init_fdt_scan_reserved_mem();
>  	misc_mem_init();

Thanks for removing the ifdeffery :)
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--EIryT2fP1CbWR+C6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAZYbgAKCRB4tDGHoIJi
0k0zAQCbBzFvKICyIrAsPcX8dLiJz0Ofva7w3fryNn/wqbvRxAD+Ilt6kQSAqc1a
TmdQ6P76jU5amOA0cxsa523SitIqswg=
=P3Nh
-----END PGP SIGNATURE-----

--EIryT2fP1CbWR+C6--
