Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3316ACFD7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCFVJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjCFVJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:09:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AAC206BF;
        Mon,  6 Mar 2023 13:09:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22E3F60B84;
        Mon,  6 Mar 2023 21:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5523C433EF;
        Mon,  6 Mar 2023 21:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678136957;
        bh=D7hWlHPkxCHLmVrT+DiT6xkGdDskW5thK7niBxeh04M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJWPEujZmIUYE6OUHwuuyaWs5gYoiX4mwLmxqbrcHALw1Ox54QKIpzoH9FueSBEGh
         /DthUfR3FQvRQExHZWC8w3zsDF8GuKihsyq6/+UGMI+E1SKQr8rzjz4dwuPc+Bt+vG
         ZsY9Ll9URemzFEKiU2ctO3x9wG1m0YzHJEW7lxr9Rw1HejeoBf5h2WORWwofq9wC3Z
         LRVcKmO7vapRRHJgCmEQO/HusrwP0bnR4rKRTWaK2JQdkO97QAojCUOfQjA4iH7A+9
         TeEWxynFs1m+xVi9yPWPXd+7DPjrFhqmYnUowWzhc7MNPI1BiPPvBK4fkPD1bHuqzl
         EtBoSD8wWFh5Q==
Date:   Mon, 6 Mar 2023 21:09:11 +0000
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
Subject: Re: [PATCH V3 17/20] RISC-V: time.c: Add ACPI support for time_init()
Message-ID: <0cceafc3-522b-4ce0-9016-e931c818adec@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-18-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9ueEUgWWOucslAoO"
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-18-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9ueEUgWWOucslAoO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 07:06:44PM +0530, Sunil V L wrote:
> On ACPI based platforms, timer related information is
> available in RHCT. Add ACPI based probe support to the
> timer initialization.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/kernel/time.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> index babaf3b48ba8..2c29543549c3 100644
> --- a/arch/riscv/kernel/time.c
> +++ b/arch/riscv/kernel/time.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2017 SiFive
>   */
> =20
> +#include <linux/acpi.h>
>  #include <linux/of_clk.h>
>  #include <linux/clockchips.h>
>  #include <linux/clocksource.h>
> @@ -18,17 +19,27 @@ EXPORT_SYMBOL_GPL(riscv_timebase);
>  void __init time_init(void)
>  {
>  	struct device_node *cpu;
> +	struct acpi_table_rhct *rhct;
> +	acpi_status status;
>  	u32 prop;
> =20
> -	cpu =3D of_find_node_by_path("/cpus");
> -	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
> -		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\=
n");
> -	of_node_put(cpu);
> -	riscv_timebase =3D prop;
> +	if (acpi_disabled) {
> +		cpu =3D of_find_node_by_path("/cpus");
> +		if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
> +			panic("RISC-V system with no 'timebase-frequency' in DTS\n");

I appreciate that it was like this before, but a newline here (and in
the corresponding spot below) would be nice.
That's a minor nit though, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +		of_node_put(cpu);
> +		riscv_timebase =3D prop;
> +		of_clk_init(NULL);
> +	} else {
> +		status =3D acpi_get_table(ACPI_SIG_RHCT, 0, (struct acpi_table_header =
**)&rhct);
> +		if (ACPI_FAILURE(status))
> +			panic("RISC-V ACPI system with no RHCT table\n");
> +		riscv_timebase =3D rhct->time_base_freq;
> +		acpi_put_table((struct acpi_table_header *)rhct);
> +	}
> =20
>  	lpj_fine =3D riscv_timebase / HZ;
> =20
> -	of_clk_init(NULL);
>  	timer_probe();
> =20
>  	tick_setup_hrtimer_broadcast();
> --=20
> 2.34.1
>=20

--9ueEUgWWOucslAoO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAZWdwAKCRB4tDGHoIJi
0tRbAP9sV9/i+Nt5TFgt3D3dQu0MRkMmaWwMmRuG9k6Af62B0QD/cYMZAGC8XVRw
vGCpsH5Ygi+gGrH6Cok66aQs9RTt+wU=
=S8pz
-----END PGP SIGNATURE-----

--9ueEUgWWOucslAoO--
