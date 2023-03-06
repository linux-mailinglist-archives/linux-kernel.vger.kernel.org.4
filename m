Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2313C6ACEBC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCFUA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCFUAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:00:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB5578CB4;
        Mon,  6 Mar 2023 12:00:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6B3B6CE178C;
        Mon,  6 Mar 2023 20:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2678DC433EF;
        Mon,  6 Mar 2023 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678132817;
        bh=AxHvlpfLjOwTANxLd6VrRMzYOYbF6/7K0BRwAsfJ/5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jw0+SFdAMe9+0fOo/UPDSu3Afj5VtMLemW89Xl7UltRJsH0v2o2rhJ9iQigg1SI8J
         nlHI+pLd6JxLLQXb48+ZQVGZVwltTuIeBssLJ4YafY67UlJohp+aVElTs1i+00Pjhp
         JjXrtjDp1dhlU0ElsgrLoCCOYIkK7afqp9bHAuzi1J9E17SP29FvYA3xKiMsEhJGmR
         MoAD1+W+JNNPZa5BIQ56Cg91VS24ZFIaNU6u3wZfUAGM/p3HEPyctqBDYJyyOx/ltm
         0SCTNzGGCkqAQdpHA+rKSfziJymxtuXoCdNDihvmnkRfkO7CgruKySrxUXglwx00Xh
         DUrJT7tzmRHew==
Date:   Mon, 6 Mar 2023 20:00:11 +0000
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
Subject: Re: [PATCH V3 06/20] RISC-V: Add support to build the ACPI core
Message-ID: <fd4999f9-a7d8-4f5e-be0f-91e1efbf21eb@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-7-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9+FvKgvIq+CWCBoo"
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-7-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9+FvKgvIq+CWCBoo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 07:06:33PM +0530, Sunil V L wrote:
> Enable ACPI core for RISC-V after adding architecture-specific
> interfaces and header files required to build the ACPI core.
>=20
> 1) Couple of header files are required unconditionally by the ACPI
> core. Add empty acenv.h and cpu.h header files.
>=20
> 2) If CONFIG_PCI is enabled, a few PCI related interfaces need to
> be provided by the architecture. Define dummy interfaces for now
> so that build succeeds. Actual implementation will be added when
> PCI support is added for ACPI along with external interrupt
> controller support.
>=20
> 3) A few globals and memory mapping related functions specific
> to the architecture need to be provided.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

> diff --git a/arch/riscv/include/asm/acenv.h b/arch/riscv/include/asm/acen=
v.h
> new file mode 100644
> index 000000000000..22123c5a4883
> --- /dev/null
> +++ b/arch/riscv/include/asm/acenv.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * RISC-V specific ACPICA environments and implementation
> + */
> +
> +#ifndef _ASM_ACENV_H
> +#define _ASM_ACENV_H
> +
> +/* It is required unconditionally by ACPI core */

Think I pointed out on v1 that this comment doesn't really make any
sense. s/It/This header/.

> +
> +#endif /* _ASM_ACENV_H */
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> new file mode 100644
> index 000000000000..0b52a190f71a
> --- /dev/null
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + *  Copyright (C) 2013-2014, Linaro Ltd.
> + *	Author: Al Stone <al.stone@linaro.org>
> + *	Author: Graeme Gregory <graeme.gregory@linaro.org>
> + *	Author: Hanjun Guo <hanjun.guo@linaro.org>
> + *
> + *  Copyright (C) 2021-2023, Ventana Micro Systems Inc.
> + *	Author: Sunil V L <sunilvl@ventanamicro.com>
> + */
> +
> +#ifndef _ASM_ACPI_H
> +#define _ASM_ACPI_H
> +
> +/* Basic configuration for ACPI */
> +#ifdef CONFIG_ACPI
> +
> +/* ACPI table mapping after acpi_permanent_mmap is set */
> +void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
> +#define acpi_os_ioremap acpi_os_ioremap
> +
> +#define acpi_strict 1   /* No out-of-spec workarounds on RISC-V */
                        ^^^
Kinda weird whitespace here, my editor noticed and my OCD won't let it
go unsaid :/ You used a tab before similar use comments later in this
patch.

> +extern int acpi_disabled;
> +extern int acpi_noirq;
> +extern int acpi_pci_disabled;
> +
> +static inline void disable_acpi(void)
> +{
> +	acpi_disabled =3D 1;
> +	acpi_pci_disabled =3D 1;
> +	acpi_noirq =3D 1;
> +}
> +
> +static inline void enable_acpi(void)
> +{
> +	acpi_disabled =3D 0;
> +	acpi_pci_disabled =3D 0;
> +	acpi_noirq =3D 0;
> +}
> +
> +/*
> + * The ACPI processor driver for ACPI core code needs this macro
> + * to find out this cpu was already mapped (mapping from CPU hardware
                 ^
missing word "whether"

> diff --git a/arch/riscv/include/asm/cpu.h b/arch/riscv/include/asm/cpu.h
> new file mode 100644
> index 000000000000..ea1a88b3d5f2
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpu.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _ASM_CPU_H
> +#define _ASM_CPU_H
> +
> +/* It is required unconditionally by ACPI core */

Same comment here, what is "it"?

> +
> +#endif /* _ASM_CPU_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 67f542be1bea..f979dc8cf47d 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -90,3 +90,5 @@ obj-$(CONFIG_EFI)		+=3D efi.o
>  obj-$(CONFIG_COMPAT)		+=3D compat_syscall_table.o
>  obj-$(CONFIG_COMPAT)		+=3D compat_signal.o
>  obj-$(CONFIG_COMPAT)		+=3D compat_vdso/
> +
> +obj-$(CONFIG_ACPI)              +=3D acpi.o

This file appears to be tab aligned (at least the other lines in the
diff are), so please tab align this one too.

Those are all nitpick things though, so w/ 'em fixed:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--9+FvKgvIq+CWCBoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAZGSwAKCRB4tDGHoIJi
0oqrAQDYd5f2BgFLmD42W5VN9nGvnggZqkeD7UtcmGSutrJRWQEAuy9U3AfHyxyR
DJXs7W6ZRRcuu4bWGRV3vwl8C6UZgws=
=xAHB
-----END PGP SIGNATURE-----

--9+FvKgvIq+CWCBoo--
