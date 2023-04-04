Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4102E6D6EE9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbjDDVZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbjDDVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:25:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11BB1701;
        Tue,  4 Apr 2023 14:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87C5063A1F;
        Tue,  4 Apr 2023 21:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD27C433D2;
        Tue,  4 Apr 2023 21:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680643547;
        bh=hAopZSHpcyvh1rorTXdf3DGzRj2r95oUiXaa6N2Aivw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrPS1xYQcfgbbli7ENWa19ts7ncgOPdC8p4skjF6wasxeBmojqrfOmhUA/mubgPr3
         uDhfyMvg8HqXtQmyO1MVQ13N74r+uQncxbP96FqgsGUXyRUwaIGryb90rRsnC3FCD6
         JHxb2j81ykhZRfKu2vGmouDAfXp2texoZ1eQ9xHceizZ7wH+t5cztBR1HsLjlHSpLY
         TnIDZczL0uZGDid2WqRf5aULJURGKO/h4Q9R8dIpvX5/Y8YIT4WYu6mvxXVNq7jCNd
         DPOFtDOJHfDrEbDRRVsHSPMWTiC7LOLhuA6tbhRDX5dQOs8vRBkBAVw4rVFBwr6ThM
         4xlNiZL9xia/w==
Date:   Tue, 4 Apr 2023 22:25:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tom Rix <trix@redhat.com>, Weili Qian <qianweili@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <lenb@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <apatel@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH V4 16/23] clocksource/timer-riscv: Refactor
 riscv_timer_init_dt()
Message-ID: <20230404-flatware-ditto-e5c71d5a36c2@spud>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-17-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2/wGGnLCOQw3+kxM"
Content-Disposition: inline
In-Reply-To: <20230404182037.863533-17-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2/wGGnLCOQw3+kxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 11:50:30PM +0530, Sunil V L wrote:
> Refactor the timer init function such that few things can be
> shared by both DT and ACPI based platforms.
>=20
> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Forget an R-b or drop it intentionally from v3?
https://lore.kernel.org/linux-riscv/c2c1bdb5-aee6-4f4c-9f7d-073917e75b88@sp=
ud/
Please say why if you drop or ignore tags between versions.

If this is in fact the same as v3, here's the missing tag:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

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
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--2/wGGnLCOQw3+kxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCyV0gAKCRB4tDGHoIJi
0rJlAP9rogaXV3ucgTvCBAZkBYR+WpLBvWckZ0of2CS8edy2CwD5Ac7q7WeS6lvT
0PKSn5nYFRIl9RObVenJC1edFkd2nAg=
=mydC
-----END PGP SIGNATURE-----

--2/wGGnLCOQw3+kxM--
