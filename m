Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21823691243
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBIUyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBIUyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:54:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506F45AB06;
        Thu,  9 Feb 2023 12:54:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CA6061BD6;
        Thu,  9 Feb 2023 20:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D842EC433EF;
        Thu,  9 Feb 2023 20:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675976057;
        bh=JvtF9Km1ksiv9ZA0ap4rOqNOIgZmMUugZRJ2td2mHhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITRnAoqspNlb3tJ9FIUd/8R1cQCMMahJSlyFEjTJXjsClv1nLHjCSjWqT/aHGC1oc
         BCVIGGLdx4sGe6/EFTbn9GgRjBf8Ip2CFqQPfIGNv8Sk3QJwtydFE5knh2wBEZVI+z
         zI3NAl4BdVcCe2Nc1e7bHODhVTAjOH/bW4ologlCaK3V/K7uZm/m6IiUND+KKbvcir
         9+aXU1J5TK/ff0Tw6XboSnACXdXs/mArEdrM7zYDx4R+5sSG8+ulPHtku33APZOFeI
         jMIwul5uq2T5sHo4CIIc2B9tJyQFCGWeJlAngDh5p0QEfvxRKIqjV6y1FGAmvIokVG
         gmCTgxnvUnQkw==
Date:   Thu, 9 Feb 2023 20:54:11 +0000
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
Subject: Re: [PATCH 15/24] clocksource/timer-riscv: Refactor
 riscv_timer_init_dt()
Message-ID: <Y+Vdc09bWb9CTXyt@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-16-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8h8914KTtxY4WtKQ"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-16-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8h8914KTtxY4WtKQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sunil,

On Mon, Jan 30, 2023 at 11:52:16PM +0530, Sunil V L wrote:
> Refactor the timer init function such that few things can be shared by
> both DT and ACPI based platforms.
>=20
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

What did Anup do here? He's not author or co-author, so the SoB chain
looks incorrect.

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/clocksource/timer-riscv.c | 79 +++++++++++++++----------------
>  1 file changed, 37 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index 1b4b36df5484..4016c065a01c 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -119,61 +119,28 @@ static irqreturn_t riscv_timer_interrupt(int irq, v=
oid *dev_id)
>  	return IRQ_HANDLED;
>  }
> =20
> -static int __init riscv_timer_init_dt(struct device_node *n)
> +static int __init riscv_timer_init_common(void)
>  {
> -	int cpuid, error;
> -	unsigned long hartid;
> -	struct device_node *child;
> -	struct irq_domain *domain;
> -
> -	error =3D riscv_of_processor_hartid(n, &hartid);
> -	if (error < 0) {
> -		pr_warn("Not valid hartid for node [%pOF] error =3D [%lu]\n",
> -			n, hartid);
> -		return error;
> -	}
> -
> -	cpuid =3D riscv_hartid_to_cpuid(hartid);
> -	if (cpuid < 0) {
> -		pr_warn("Invalid cpuid for hartid [%lu]\n", hartid);
> -		return cpuid;
> -	}
> -
> -	if (cpuid !=3D smp_processor_id())
> -		return 0;
> +	int error;
> +	struct fwnode_handle *intc_fwnode =3D riscv_get_intc_hwnode();
> +	struct irq_domain *domain =3D NULL;
> =20
> -	child =3D of_find_compatible_node(NULL, NULL, "riscv,timer");
> -	if (child) {
> -		riscv_timer_cannot_wake_cpu =3D of_property_read_bool(child,
> -					"riscv,timer-cannot-wake-cpu");
> -		of_node_put(child);
> -	}

Uhh, where did this code go?
Unless I've badly missed something, this has vanished in the patch.

> =20
> -	domain =3D NULL;
> -	child =3D of_get_compatible_child(n, "riscv,cpu-intc");
> -	if (!child) {
> -		pr_err("Failed to find INTC node [%pOF]\n", n);
> -		return -ENODEV;
> -	}
> -	domain =3D irq_find_host(child);
> -	of_node_put(child);
> +	domain =3D irq_find_matching_fwnode(intc_fwnode, DOMAIN_BUS_ANY);
>  	if (!domain) {
> -		pr_err("Failed to find IRQ domain for node [%pOF]\n", n);
> +		pr_err("Failed to find INTC node [%pfwP]\n", intc_fwnode);
>  		return -ENODEV;
>  	}
> =20
>  	riscv_clock_event_irq =3D irq_create_mapping(domain, RV_IRQ_TIMER);
>  	if (!riscv_clock_event_irq) {
> -		pr_err("Failed to map timer interrupt for node [%pOF]\n", n);
> -		return -ENODEV;
> +		pr_err("Failed to map timer interrupt for node [%pfwP]\n",
> +			intc_fwnode);
>  	}
> =20
> -	pr_info("%s: Registering clocksource cpuid [%d] hartid [%lu]\n",
> -	       __func__, cpuid, hartid);
>  	error =3D clocksource_register_hz(&riscv_clocksource, riscv_timebase);
>  	if (error) {
> -		pr_err("RISCV timer register failed [%d] for cpu =3D [%d]\n",
> -		       error, cpuid);
> +		pr_err("clocksource register failed [%d]\n", error);

If you're changing this, s/register/registration/ to be grammatically
correct I suppose.

>  		return error;
>  	}
> =20
> @@ -199,7 +166,35 @@ static int __init riscv_timer_init_dt(struct device_=
node *n)
>  		static_branch_enable(&riscv_sstc_available);
>  	}
> =20
> +	pr_info("timer registered using %s\n",
> +		(static_branch_likely(&riscv_sstc_available)) ?
> +		"RISC-V Sstc" : "RISC-V SBI");

Why is this needed? Isn't there a print like 3 lines above here that
says "Timer interrupt in S-mode is available via sstc extension"?

> +
>  	return error;
>  }
> =20
> +static int __init riscv_timer_init_dt(struct device_node *n)
> +{
> +	int cpuid, error;
> +	unsigned long hartid;
> +
> +	error =3D riscv_of_processor_hartid(n, &hartid);
> +	if (error < 0) {
> +		pr_warn("Not valid hartid for node [%pOF] error =3D [%lu]\n",

While you're already moving this, may as well fix the grammar IMO.
s/Not valid/Invalid/

Cheers,
Conor.

> +			n, hartid);
> +		return error;
> +	}
> +
> +	cpuid =3D riscv_hartid_to_cpuid(hartid);
> +	if (cpuid < 0) {
> +		pr_warn("Invalid cpuid for hartid [%lu]\n", hartid);
> +		return cpuid;
> +	}
> +
> +	if (cpuid !=3D smp_processor_id())
> +		return 0;
> +
> +	return riscv_timer_init_common();
> +}
> +
>  TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
> --=20
> 2.38.0
>=20

--8h8914KTtxY4WtKQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+VdcwAKCRB4tDGHoIJi
0vfxAP9RZQGZEX7Y4ZgLFKvXN/0/gIJZuerkA4XQkDspYSkg8AD9G1YqTtZ6WpVW
0oeOQ7K3iWcMHOdT/zMy4JZcnKnHSA0=
=054u
-----END PGP SIGNATURE-----

--8h8914KTtxY4WtKQ--
