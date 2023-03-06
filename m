Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F23A6ACFB2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCFVBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCFVBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:01:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AB93C7B9;
        Mon,  6 Mar 2023 13:01:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FBEBB8112C;
        Mon,  6 Mar 2023 21:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3FEC433D2;
        Mon,  6 Mar 2023 21:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678136468;
        bh=yqidNwgp7HCd2mFZnWBGnmFlAErUVkw5CNhyg4udVxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVYEPC7fl+EPjpQBV09cn3eYFU4yvIjPx82G6PRN9v4dGWM7tA0Uf7g4KCQsAVEJZ
         BMS0RlGS+jbVJ4CmY6Rjl/RJz8595YaL3wny6SgyYMrT2CvdGFBArTzlZIavyXPdBX
         8EIZy/xbp1NUQbcZontIMKh8PuZf6msVDD6hDu67oEXxH4GIDc1uig2GhK3/FIJxIc
         DgHcPz4QZSWidhO6pwVizj6S7vePesaNQNPuTu+N83Zj8/20XzDOvpKIwG0mVaC/7W
         d1gNKYsQp+cUVKRBBFdF1QMsoLKZAZLuBM/m/fCAluemq3ibDzOc3u+OyXltmDog7Z
         nZgpgP2KMoQKA==
Date:   Mon, 6 Mar 2023 21:01:02 +0000
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
Subject: Re: [PATCH V3 15/20] clocksource/timer-riscv: Refactor
 riscv_timer_init_dt()
Message-ID: <c2c1bdb5-aee6-4f4c-9f7d-073917e75b88@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-16-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AQdH4wZIprRDoHja"
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-16-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AQdH4wZIprRDoHja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 07:06:42PM +0530, Sunil V L wrote:
> Refactor the timer init function such that few things can be
> shared by both DT and ACPI based platforms.
>=20
> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/clocksource/timer-riscv.c | 81 +++++++++++++++----------------
>  1 file changed, 40 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index 5f0f10c7e222..cecc4662293b 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -124,61 +124,28 @@ static irqreturn_t riscv_timer_interrupt(int irq, v=
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
> +	int error;
>  	struct irq_domain *domain;
> +	struct fwnode_handle *intc_fwnode =3D riscv_get_intc_hwnode();
> =20
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
> -
> -	child =3D of_find_compatible_node(NULL, NULL, "riscv,timer");
> -	if (child) {
> -		riscv_timer_cannot_wake_cpu =3D of_property_read_bool(child,
> -					"riscv,timer-cannot-wake-cpu");
> -		of_node_put(child);
> -	}
> -
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
> +		pr_err("Failed to find irq_domain for INTC node [%pfwP]\n",
> +		       intc_fwnode);
>  		return -ENODEV;
>  	}
> =20
>  	riscv_clock_event_irq =3D irq_create_mapping(domain, RV_IRQ_TIMER);
>  	if (!riscv_clock_event_irq) {
> -		pr_err("Failed to map timer interrupt for node [%pOF]\n", n);
> +		pr_err("Failed to map timer interrupt for node [%pfwP]\n", intc_fwnode=
);
>  		return -ENODEV;
>  	}
> =20
> -	pr_info("%s: Registering clocksource cpuid [%d] hartid [%lu]\n",
> -	       __func__, cpuid, hartid);
>  	error =3D clocksource_register_hz(&riscv_clocksource, riscv_timebase);
>  	if (error) {
> -		pr_err("RISCV timer register failed [%d] for cpu =3D [%d]\n",
> -		       error, cpuid);
> +		pr_err("RISCV timer registration failed [%d]\n", error);
>  		return error;
>  	}
> =20
> @@ -207,4 +174,36 @@ static int __init riscv_timer_init_dt(struct device_=
node *n)
>  	return error;
>  }
> =20
> +static int __init riscv_timer_init_dt(struct device_node *n)
> +{
> +	int cpuid, error;
> +	unsigned long hartid;
> +	struct device_node *child;
> +
> +	error =3D riscv_of_processor_hartid(n, &hartid);
> +	if (error < 0) {
> +		pr_warn("Invalid hartid for node [%pOF] error =3D [%lu]\n",
> +			n, hartid);

I know this was there initially, but why is this (and the one below) a
pr_warn() if we're aborting the init if we hit the condition? :thinking:

It's not your doing though, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

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
> +	child =3D of_find_compatible_node(NULL, NULL, "riscv,timer");
> +	if (child) {
> +		riscv_timer_cannot_wake_cpu =3D of_property_read_bool(child,
> +					"riscv,timer-cannot-wake-cpu");
> +		of_node_put(child);
> +	}
> +
> +	return riscv_timer_init_common();
> +}
> +
>  TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
> --=20
> 2.34.1
>=20

--AQdH4wZIprRDoHja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAZUjgAKCRB4tDGHoIJi
0mZPAQCogioAGeu/rH7vLjcGivv0bAimROIjihyABpXi3fiJ0AEAmUe5cTGCAW1k
wL1pBsU4gSGXk9HUSJpK0vRRT/x7OgA=
=fi1h
-----END PGP SIGNATURE-----

--AQdH4wZIprRDoHja--
