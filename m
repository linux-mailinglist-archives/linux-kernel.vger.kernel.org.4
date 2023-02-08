Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9325F68F9C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjBHVb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjBHVbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:31:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F372A10A95;
        Wed,  8 Feb 2023 13:31:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 983DAB81FBB;
        Wed,  8 Feb 2023 21:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE33C433EF;
        Wed,  8 Feb 2023 21:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675891910;
        bh=rA4gQOEFjzOk984ttGkJ0iqLtjVnP14qiD/o3VUE7i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bP0/njXkd0bPDm6/oZMgT6Ptof/Ka2NfBb9jV2a9TNUWQ27Jf9GY0XvTU1TdWJ5w9
         IIYTVcy3pjk4y4/qZFtlpvV6Po9rkREmDAsJv2RY4M2DDPU+FYJUy4xyyk0P1sB/Pm
         u9kBL5TLrzkcz2jM4YwjWVIwOCXAuXkKtxeaNyrS7KVnszeCqKrilI5SvDK14t+dpr
         H1aWp06edFlxBeCjwduVWqT24ynyidxUTHQLFdNIcnDnvtN3DAWTgzmIw7W4Wcwk1m
         w76tflcqSAABRvhoxnp3XHgTPB3+PziXWR7eiEoBub9FHZKT1F2pwSvU2BSR5hstAL
         EPK5QfqzPi6ig==
Date:   Wed, 8 Feb 2023 21:31:44 +0000
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
Subject: Re: [PATCH 07/24] RISC-V: ACPI: Enable ACPI build infrastructure
Message-ID: <Y+QUwFIIj7tvrHpM@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-8-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UkPMmNX0YR0XBnLk"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-8-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UkPMmNX0YR0XBnLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:52:08PM +0530, Sunil V L wrote:
> Enable build infrastructure to add ACPI support for
> RISC-V.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d153e1cd890b..f664350679bc 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -12,6 +12,9 @@ config 32BIT
> =20
>  config RISCV
>  	def_bool y
> +	select ACPI_GENERIC_GSI if ACPI
> +	select ACPI_MCFG if (ACPI && PCI)

These brackets are not needed, right?

> +	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ARCH_CLOCKSOURCE_INIT
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> @@ -598,6 +601,7 @@ config EFI_STUB
>  config EFI
>  	bool "UEFI runtime support"
>  	depends on OF && !XIP_KERNEL
> +	select ARCH_SUPPORTS_ACPI if 64BIT
>  	select LIBFDT
>  	select UCS2_STRING
>  	select EFI_PARAMS_FROM_FDT
> @@ -703,3 +707,4 @@ source "drivers/cpufreq/Kconfig"
>  endmenu # "CPU Power Management"
> =20
>  source "arch/riscv/kvm/Kconfig"
> +source "drivers/acpi/Kconfig"

For consistency with the rest of the file, a newline before drivers
would be in order here.


--UkPMmNX0YR0XBnLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+QUwAAKCRB4tDGHoIJi
0rw5AQDDR6lnLoWhrmspoMPPN+hMhDSf8VsjqYTW0h7JY6VCtgD/Wzc177tWPb2s
yKCcO2mls+ZCX4eSFUDrTp1LKrw4MwU=
=uBfZ
-----END PGP SIGNATURE-----

--UkPMmNX0YR0XBnLk--
