Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A42D68F875
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjBHT4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBHT4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:56:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16A34ED0D;
        Wed,  8 Feb 2023 11:56:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EDBA61739;
        Wed,  8 Feb 2023 19:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB6AC433EF;
        Wed,  8 Feb 2023 19:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675886162;
        bh=Nj7MhMOma/HhW6EJVI/dLGhU2fOrQO9qpmLNfI/Who4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FcEo3DMVV4Y7zsWygtvXpZ31miHsh4fX1lyo9Z2R7rBcUexvI/yMFmEMPUd3Casfk
         Q8sYLT2sNaRJ+9Qj1Ve8Oeu+XmdS78gf2n/DymN3UiJ3KylKavgJql5I1RgwZFZE4v
         KQ/ZeE4ZoUSn8q16KrBtyXmkjbCo3xpQvUGOGd+D5/U9PdPRTh8vCxo16SVlZBcGMg
         Ebb7W28UH1pG2cszbdgIbDeGYQsRypqEhkW1xRlWEcXdaLm0acZp0rn7qSFCoXE2ry
         sU9GYsazGaEWdMj/aFnHMqQELDmjQSTFfHBMPg7Fwyc09MWDZET2zmaaZtoT6FmaPE
         qkDpl8yODLD9g==
Date:   Wed, 8 Feb 2023 19:55:56 +0000
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
Subject: Re: [PATCH 04/24] RISC-V: ACPI: Add empty headers to enable ACPI core
Message-ID: <Y+P+TF1MJ2OnwHVX@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-5-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NmY+w7HCTBD70FFj"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-5-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NmY+w7HCTBD70FFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:52:05PM +0530, Sunil V L wrote:
> Few header files are required unconditionally by ACPI core.

nit: A few. Without the article this has a different meaning.

> So add empty header files for now and update it when needed.

s/ and update it when needed// ;)

>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/include/asm/acenv.h | 17 +++++++++++++++++
>  arch/riscv/include/asm/cpu.h   |  9 +++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 arch/riscv/include/asm/acenv.h
>  create mode 100644 arch/riscv/include/asm/cpu.h
>=20
> diff --git a/arch/riscv/include/asm/acenv.h b/arch/riscv/include/asm/acen=
v.h
> new file mode 100644
> index 000000000000..bbc38ecdf753
> --- /dev/null
> +++ b/arch/riscv/include/asm/acenv.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * RISC-V specific ACPICA environments and implementation
> + *
> + * Copyright (C) 2014, Linaro Ltd.
> + *   Author: Hanjun Guo <hanjun.guo@linaro.org>
> + *   Author: Graeme Gregory <graeme.gregory@linaro.org>
> + * Copyright (C) 2023, Ventana Micro Systems Inc.
> + *   Author: Sunil V L <sunilvl@ventanamicro.com>

More out of idle curiosity than anything else, but what, may I ask, is
copyrightable about 2 empty files?
Triply so given there are !3! contributors to said empty file!

> + */
> +
> +#ifndef _ASM_ACENV_H
> +#define _ASM_ACENV_H
> +
> +/* It is required unconditionally by ACPI core, update it when needed. */

How come this file gets a comment and the other doesn't?
Also the comment doesn't really make much sense to me in a vacuum, and
ideally would read like:
"This header is required unconditionally by the ACPI core"
That is, if a comment is really even needed.

Cheers,
Conor.

> +
> +#endif /* _ASM_ACENV_H */
> diff --git a/arch/riscv/include/asm/cpu.h b/arch/riscv/include/asm/cpu.h
> new file mode 100644
> index 000000000000..51ec1a89a7a9
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpu.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2014 ARM Ltd.
> + * Copyright (C) 2023 Ventana Micro Systems Inc.
> + */
> +#ifndef __ASM_CPU_H
> +#define __ASM_CPU_H
> +
> +#endif /* __ASM_CPU_H */
> --=20
> 2.38.0
>=20

--NmY+w7HCTBD70FFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+P+TAAKCRB4tDGHoIJi
0lCXAQCMJNnnXM92WRsao6hIMtmCm8CiXSb5vBbh41ZMlT//rgD8DVM5pRplyPUB
oIfuBKsZMkhJ3PwPcrbDHKHeWNlxLgg=
=8eKC
-----END PGP SIGNATURE-----

--NmY+w7HCTBD70FFj--
