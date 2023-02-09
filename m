Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFD16912D7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 22:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjBIVyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 16:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBIVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:54:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C2D65682;
        Thu,  9 Feb 2023 13:54:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B965661BEC;
        Thu,  9 Feb 2023 21:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005C7C433D2;
        Thu,  9 Feb 2023 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675979645;
        bh=vQHM1OmRYQezs1QT58/QKDPYGkARYmj/V8EfqvpU9KA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/CbRAFl/FjApouvB+esmVUq7gObd6qZ/xcLA4A6i65tY6b0Gxojs/OtF/+nB98KN
         xUpYxlVxQ+qPH2ANzPmkQ87lBdTAzhrrj5L5QMsAKcooENRKVUG4W2GKsk1gtbNDlH
         OG4qjl/tHwwyhj1fpba0ZbdLRCjGnxHOhAOa8O49mJL8f15k1iKQk/hp3AZbbd6LTm
         gzA0rBN8vVyi7vtNr+BFQFc+mrSsgr2ROd2mFt24+LJOSOMFxpv+alvXaNTgHMgnn3
         J5C1e3xM9bJcOSwoIG+EcGz6YTC6hdcCGLgKdzReC44y2XXR9R09AYoggMy3r7xWUI
         nLfI1o9XZ1Ldw==
Date:   Thu, 9 Feb 2023 21:53:59 +0000
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
Subject: Re: [PATCH 21/24] RISC-V: ACPI: Add ACPI initialization in
 setup_arch()
Message-ID: <Y+Vrd88ShoaDc0Pv@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-22-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ult5KqiXxhzSQt3L"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-22-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ult5KqiXxhzSQt3L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:52:22PM +0530, Sunil V L wrote:
> Initialize ACPI tables for RISC-V during boot.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/kernel/setup.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 4335f08ffaf2..5b4ad1baf664 100644
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
> +
> +	/* Parse the ACPI tables for possible boot-time configuration */
> +	acpi_boot_table_init();
> +	if (acpi_disabled) {
>  #if IS_ENABLED(CONFIG_BUILTIN_DTB)

I only poked it with a stick, but I think this `#if IS_ENABLED()` can
be changed to a normal `if (IS_ENABLED())` while you're already
modifying this code.

> -	unflatten_and_copy_device_tree();
> +		unflatten_and_copy_device_tree();
>  #else
> -	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> -		unflatten_device_tree();
> -	else
> -		pr_err("No DTB found in kernel mappings\n");
> +		if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> +			unflatten_device_tree();
> +		else
> +			pr_err("No DTB found in kernel mappings\n");
>  #endif
> +	} else {
> +		early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa)));
> +	}
> +
>  	early_init_fdt_scan_reserved_mem();
>  	misc_mem_init();
> =20
> --=20
> 2.38.0
>=20

--ult5KqiXxhzSQt3L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+VrdwAKCRB4tDGHoIJi
0qvyAP0cVO26J79g8D/az7U6nEgBc35prUqYssgqN0BxemUAWQD/Q+WSgRCcQlie
1kN+R1JSC4Db+QOviUFUJJ8F20DlTA8=
=0d4o
-----END PGP SIGNATURE-----

--ult5KqiXxhzSQt3L--
