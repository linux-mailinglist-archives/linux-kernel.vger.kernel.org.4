Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF5C68F954
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjBHU7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjBHU72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:59:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2502746149;
        Wed,  8 Feb 2023 12:58:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EF0C617D8;
        Wed,  8 Feb 2023 20:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74079C433D2;
        Wed,  8 Feb 2023 20:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675889917;
        bh=is7gAcM4IfXeI9zTDQOH+ZBqX7CZjmQ/2MN9YP35cLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiFgJb1iiW27AV/2rEeQBKIERZZfGo59uOJsYnseCldl0hBawxcEl0JzXDBJPSUQq
         N8BJmzuQKSSBsO26MRXix85nIu6BHtN5e7SAc2bXwUDqvoGBJ7onSL8D0TLFWuQchJ
         wJ7AK1yvpMaiF3q0Ic2yILcGB740jAxOCDhP/ylZsNrJbDYhu4Le1pnTc0eu5TsXDQ
         zZEvQRN0w0Vy0Ei15md9ntpoIakzmXZXVWI6yBe1qAI4F0e3cdaUs0VS7UzEH7xVnf
         fTcuAIA8evElWcDloXzofUXl8Oxwx4LGNVISq2fB5RmEVy1bSyIGIslohmhjViFw5O
         6fv3PYFOtQhaQ==
Date:   Wed, 8 Feb 2023 20:58:31 +0000
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
Subject: Re: [PATCH 05/24] RISC-V: ACPI: Add basic functions to build ACPI
 core
Message-ID: <Y+QM9zQyJfSgzc7R@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-6-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G6iH+nsAGGTrccE5"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-6-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G6iH+nsAGGTrccE5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:52:06PM +0530, Sunil V L wrote:
> Introduce acpi.c and its related header files to provide
> fundamental needs of extern variables and functions for ACPI core.
> 	- asm/acpi.h for arch specific variables and functions needed by
> 	  ACPI driver core;
> 	- acpi.c - Add function to initialize ACPI tables.
> 	- acpi.c for RISC-V related ACPI implementation for ACPI driver
> 	  core;
>=20
> Code is mostly leveraged from ARM64.



> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c

> + * __acpi_map_table() will be called before page_init(), so early_iorema=
p()

rg "\bpage_init\("
arch/riscv/kernel/acpi.c
54: * __acpi_map_table() will be called before page_init(), so early_iorema=
p()

arch/arm64/kernel/acpi.c
86: * __acpi_map_table() will be called before page_init(), so early_iorema=
p()

This function doesn't appear to exist, perhaps what you are looking for is
paging_init()?

> + * or early_memremap() should be called here to for ACPI table mapping.
> + */
> +void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long =
size)
> +{
> +	if (!size)
> +		return NULL;
> +
> +	return early_memremap(phys, size);
> +}

> +void __init acpi_boot_table_init(void)
> +{
> +	/*
> +	 * Enable ACPI instead of device tree unless
> +	 * - ACPI has been disabled explicitly (acpi=3Doff), or
> +	 * - firmware has not populated ACPI ptr in EFI system table
> +	 */
> +
> +	if (param_acpi_off || (efi.acpi20 =3D=3D EFI_INVALID_TABLE_ADDR))

There's an extraneous set of () around the second item here.

> +		goto done;
> +	/*

A small nit: a newline before opening the comment block here please!

--G6iH+nsAGGTrccE5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+QM9wAKCRB4tDGHoIJi
0tBAAP9pCCCIuo63d+MxWCA9/GEjrIteo5FBQkb46nsK6rFoQQD9GWwpeqTDTdZZ
yn4rtKagNMNS8BXjeK5XiMvqUTfJMAY=
=cGBw
-----END PGP SIGNATURE-----

--G6iH+nsAGGTrccE5--
