Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A72A6ACFD0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCFVGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCFVG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:06:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA9B4FA9C;
        Mon,  6 Mar 2023 13:06:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3A3F60A10;
        Mon,  6 Mar 2023 21:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E8FC433D2;
        Mon,  6 Mar 2023 21:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678136779;
        bh=idi/6s5Qo9QDBdVMI12wKo77YC0Au3UM5k9rnmjlsKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jadhch3R6vjQ+nSfoA7Uwab3TYTynSl6yBMobTbxxx6m/03OWG9QugHFMZ4oeq/p9
         677UGJFLAPZN5A5yAggWck4JZfPvZmwgYBaa5B4LRBVQAjopUy9Qq0os5fW71fwZuY
         D5jAPnNOtvbi0GUxZ8FZqCPeF+1mT9VS9NMxv0inkqkPkSf2Zhy36NDRo4fM7h7UPN
         5SXmsxCytFSw7VpK6OiVeGdt61CVLt8dms+iGw4gCb1gKj4tmRsdL5EYySh/zK0LKS
         vGQpvv3COzj4Pt4AE3OruZHCsHCALMVcrIYy8YEkriYV+6dLIZsMB32fIeSnhl3d2c
         7DZ+wW9B2jVPQ==
Date:   Mon, 6 Mar 2023 21:06:13 +0000
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
Subject: Re: [PATCH V3 16/20] clocksource/timer-riscv: Add ACPI support
Message-ID: <567aac52-8b84-47a9-9faf-b27ff1a1963e@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-17-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KUsNw6CACrWxwcHM"
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-17-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KUsNw6CACrWxwcHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 07:06:43PM +0530, Sunil V L wrote:
> Initialize the timer driver based on RHCT table on ACPI based
> platforms.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

The SBI spec allows for implementations where the timer cannot wake the
cpu. You previously said "We have plans to add a flag in RHCT. But that
still needs approval.", so could you please convert this to a more
concrete wording and put the explanation for why this is missing into
the commit message?

Cheers,
Conor.

> ---
>  drivers/clocksource/timer-riscv.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index cecc4662293b..da3071b387eb 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -10,6 +10,7 @@
> =20
>  #define pr_fmt(fmt) "riscv-timer: " fmt
> =20
> +#include <linux/acpi.h>
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
>  #include <linux/cpu.h>
> @@ -207,3 +208,13 @@ static int __init riscv_timer_init_dt(struct device_=
node *n)
>  }
> =20
>  TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
> +
> +#ifdef CONFIG_ACPI
> +static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
> +{
> +	return riscv_timer_init_common();
> +}
> +
> +TIMER_ACPI_DECLARE(aclint_mtimer, ACPI_SIG_RHCT, riscv_timer_acpi_init);
> +
> +#endif
> --=20
> 2.34.1
>=20

--KUsNw6CACrWxwcHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAZVxQAKCRB4tDGHoIJi
0ghAAP4lpF2feMoFrQxas6vkJHXKFiI7ARMvhKONsSV8xUNn7wEAkI8McxF1J2fl
c4aLJfk6KJvLtcvGqjczoc+H9X2Rfw0=
=A6TU
-----END PGP SIGNATURE-----

--KUsNw6CACrWxwcHM--
