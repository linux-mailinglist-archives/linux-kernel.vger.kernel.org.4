Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50A68F87D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBHT7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjBHT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:59:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6E837B77;
        Wed,  8 Feb 2023 11:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DE5E617C5;
        Wed,  8 Feb 2023 19:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09504C433EF;
        Wed,  8 Feb 2023 19:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675886346;
        bh=0L/axqFrTla1CjyJcAYNEtPZxT9IS5v2UY5FZZEsCkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFqrMlQmq/8t32iG+XK1RwRmiNQkaDdASAMhJ5U2dk/ihWKkwE4y7Bjji7Hg96vyU
         WAZZKauygf7/Uyzr2hM76BT/f/d3qklXvwqLPiTW0awBdxYYkyirs561FZmYIsljS+
         /7/zSLfvTStUgDEIzQ2biuTb0GlGVrU4WAp6C6ROgv97vMdpUgfC+nNbur0eBEA7rD
         iLIjN+lSEOLmNSWuRRnOdtl7SH7zLEwqzJpQ5VnVaaN+PW9JobJDXunpOEGP53oDF7
         OkZEIHrssruZ/bBCJ0Kz253RcOWxNqKNOXSTjss1a1ZeePJ+s37UxXWbVZIIxvh/jf
         /XMOZ8E+BF8xA==
Date:   Wed, 8 Feb 2023 19:59:00 +0000
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
        Atish Patra <atishp@rivosinc.com>,
        Robert Moore <robert.moore@intel.com>,
        acpica-devel@lists.linuxfoundation.org
Subject: Re: [PATCH 02/24] ACPICA: MADT: Add RISC-V INTC interrupt controller
Message-ID: <Y+P/BDbP68vNTOao@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-3-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C3CfOFtGyHgf+Q8p"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-3-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C3CfOFtGyHgf+Q8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:52:03PM +0530, Sunil V L wrote:
> The ECR to add RISC-V INTC interrupt controller is approved by
> the UEFI forum and will be availabl in the next revision of

nit: available

> the ACPI specification.
>=20
> This patch is not yet merged in ACPICA but a PR is raised.
>=20
> ACPICA PR: https://github.com/acpica/acpica/pull/804

I had a quick check with git grep, and as this doesn't appear to be a
regular pattern in the history, so could you please make this a regular
Link: trailer?

Cheers,
Conor.

> Reference: Mantis ID: 2348
>=20
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: acpica-devel@lists.linuxfoundation.org
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  include/acpi/actbl2.h | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index b2973dbe37ee..c432fd15db65 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -891,7 +891,8 @@ enum acpi_madt_type {
>  	ACPI_MADT_TYPE_MSI_PIC =3D 21,
>  	ACPI_MADT_TYPE_BIO_PIC =3D 22,
>  	ACPI_MADT_TYPE_LPC_PIC =3D 23,
> -	ACPI_MADT_TYPE_RESERVED =3D 24,	/* 24 to 0x7F are reserved */
> +	ACPI_MADT_TYPE_RINTC =3D 24,
> +	ACPI_MADT_TYPE_RESERVED =3D 25,	/* 25 to 0x7F are reserved */
>  	ACPI_MADT_TYPE_OEM_RESERVED =3D 0x80	/* 0x80 to 0xFF are reserved for O=
EM use */
>  };
> =20
> @@ -1250,6 +1251,24 @@ enum acpi_madt_lpc_pic_version {
>  	ACPI_MADT_LPC_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved =
*/
>  };
> =20
> +/* 24: RISC-V INTC */
> +struct acpi_madt_rintc {
> +	struct acpi_subtable_header header;
> +	u8 version;
> +	u8 reserved;
> +	u32 flags;
> +	u64 hart_id;
> +	u32 uid;		/* ACPI processor UID */
> +};
> +
> +/* Values for RISC-V INTC Version field above */
> +
> +enum acpi_madt_rintc_version {
> +	ACPI_MADT_RINTC_VERSION_NONE =3D 0,
> +	ACPI_MADT_RINTC_VERSION_V1 =3D 1,
> +	ACPI_MADT_RINTC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
> +};
> +
>  /* 80: OEM data */
> =20
>  struct acpi_madt_oem_data {
> --=20
> 2.38.0
>=20

--C3CfOFtGyHgf+Q8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+P/BAAKCRB4tDGHoIJi
0oxgAP9WC8kaZpNByCNLjTup93CdqUIB1TlRT73uQ3yz9WixvQD/Rvbx0KtjGQdl
xUQvPl6J6xLQx7FkEo52jziNk7hw9wU=
=J+2F
-----END PGP SIGNATURE-----

--C3CfOFtGyHgf+Q8p--
