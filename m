Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53B36D6F11
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjDDVjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbjDDVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2218D3A8C;
        Tue,  4 Apr 2023 14:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9C226375E;
        Tue,  4 Apr 2023 21:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B6EC433D2;
        Tue,  4 Apr 2023 21:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680644344;
        bh=XOaw+ianizkDnYdonJkTw/dihp/a3DtdF6mVStpByng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgNvRurcBL7n/ioKUCt9Nw9UtdE4zMZA4C94FXvLwsgHcT+kZpgBSUWQr+G/zO270
         XWWgEKhJ6H3Dgo0+h5GDZDEZ9S+NIaSQFpRMpu4aXDrqmohup0CdgaAfVHdQ9BplhV
         mfMqX8ZIhHE2Zmy8IxCFYlI5Ul6GeEUhV3ilxBg1RIeGvXN3ICXZQDx77KYAaT2kPf
         IJ4n8Td/i9q8bKNSQPWBlHF9SHdIVnyfqhLNmPHk6yPWkW/mEE2+Fbu4dCEb9IdbFv
         CcYO1+2/7ApcZLHCvAL05nDlVi+MLMJexbYt/UVK06s+AjO/nHQNF5TVsyM90l8b07
         b9QgBLaaCOIOQ==
Date:   Tue, 4 Apr 2023 22:38:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Weili Qian <qianweili@huawei.com>,
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
Subject: Re: [PATCH V4 19/23] RISC-V: Add ACPI initialization in setup_arch()
Message-ID: <20230404-escalator-fridge-daf9aaffad12@spud>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-20-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DDYTghOmxEGb/QCp"
Content-Disposition: inline
In-Reply-To: <20230404182037.863533-20-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DDYTghOmxEGb/QCp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 11:50:33PM +0530, Sunil V L wrote:
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
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

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

I'm probably forgetting something, but this seems very non-obvious to
me:
Why are you running early_init_dt_verify() when ACPI is enabled?
I think that one deserves a comment so that next time someone looks at
this (that doesn't live in ACPI land) they've know exactly why this is
like it is.

Doubly so since this is likely to change with some of Alex's bits moving
the dtb back into the fixmap.

Cheers,
Conor.

--DDYTghOmxEGb/QCp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCyY7wAKCRB4tDGHoIJi
0ineAP9dZt8LzP73Mz2ZBF25vpCS8jxlJLO9KoLcg8eN+crkiwD+JxJx2myjXj1D
jLO/jiH2JZVRpKsN4XE2HwxmyjOrxwQ=
=T2nq
-----END PGP SIGNATURE-----

--DDYTghOmxEGb/QCp--
