Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003495F64C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiJFLFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiJFLFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:05:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2945E3135E;
        Thu,  6 Oct 2022 04:05:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z3so1286655edc.10;
        Thu, 06 Oct 2022 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SWj+08Nh6gkacuObeofoo80owftzdWimdlCVryl1eqo=;
        b=quNWaGl9LqL5qFvHqWNTpdUoIPDi6pC1wBdiIe31yXUCwDPp3szjQV9GZJb0dsBMB8
         f4iftHXkZm9zxr/8oQuoqhumRJ9oq/WaSfAdTK1S9kQ9uGaHcJ1JgvccnT1Uesiq+Ztl
         9mRXjgl9pB/92eM2LbAa9vitZwL9uVATNu9SvXCRYYZ5E5Rr9V3ZfVjiNuu/IFuKYnqi
         sBmbBO0UoJP+3fJhjuxZo6RMTbpgHrKc7HJ1K77Eht3NnD6QqO4iG/KN71GWP2GnOjva
         Ag6GVuOx37MXhkQEz4qhZ/3Ecg3JSw29NDdnXIIl3GZRxBXQAjibIa/XG0r0Lvf5QKf9
         5/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SWj+08Nh6gkacuObeofoo80owftzdWimdlCVryl1eqo=;
        b=DwB8UgnaFc+04vKvzcCcCkLwTUHXHgCyPV24v1ouJako20qufShsiXcQbxOJYoZIId
         EKIezjvycVVmdqxA1CoXD53qxG3Pq7hO2l/rebbg1ZvWpGxYuy4LFhZwTivH9dPC6WXa
         DbTZC9hNRr7hmpoiMecU7Gf7716PL0mziDVfq4ZsWm8VFLUX2eicN5Ml0up4Z/ixdC3a
         KWqBm7rcLoCyoCys1NJENhGwMc/wQtkhhhmuQQj/nflkkNY4MYywbM/73nLzzZWAZ4eJ
         LPJywwYJlsgigtHKn2NosYyas+3qMjXwn/q70xSfE6MNLQmUXtHeRrvmkInBJPis36qd
         js6g==
X-Gm-Message-State: ACrzQf3qxFy7ZS5PR+7hXnear+/j290s+rHM/IuTXY/UDPmJNSujLcju
        2JfUx7jZQWrnwRWaQZaNtJ4=
X-Google-Smtp-Source: AMsMyM5FmaVUK8IRl2IifqJqWbb12QuQZvx1CzopJn1qkQ7i2wV/7f05khpiPqEnxvrLDKRqppbd/A==
X-Received: by 2002:a05:6402:500d:b0:459:3e56:e6f9 with SMTP id p13-20020a056402500d00b004593e56e6f9mr4057876eda.367.1665054305305;
        Thu, 06 Oct 2022 04:05:05 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lb9-20020a170907784900b0073ddd36ba8csm10198373ejc.145.2022.10.06.04.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 04:05:04 -0700 (PDT)
Date:   Thu, 6 Oct 2022 13:05:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        jonathanh@nvidia.com, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: Re: [PATCH v2] gpio: tegra186: Check GPIO pin permission before
 access.
Message-ID: <Yz62XmiH8YG3Dtsf@orome>
References: <YyHVoihMuKNRFXAS@orome>
 <20221004074845.29583-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wIueMpqElCFwwyGl"
Content-Disposition: inline
In-Reply-To: <20221004074845.29583-1-pshete@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wIueMpqElCFwwyGl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 04, 2022 at 01:18:45PM +0530, Prathamesh Shete wrote:
> This change checks if we have the necessary permission to
> access the GPIO. For devices that have support for virtualisation
> we need to check both the TEGRA186_GPIO_VM_REG and the
> TEGRA186_GPIO_SCR_REG registers. For device that do not have
> virtualisation support for GPIOs we only need to check the
> TEGRA186_GPIO_SCR_REG register.
>=20
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/gpio/gpio-tegra186.c | 74 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)

This looks mostly good. A few small comments, see below.

> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
> index 54d9fa7da9c1..34b6c287d608 100644
> --- a/drivers/gpio/gpio-tegra186.c
> +++ b/drivers/gpio/gpio-tegra186.c
> @@ -26,6 +26,22 @@
> =20
>  #define TEGRA186_GPIO_INT_ROUTE_MAPPING(p, x) (0x14 + (p) * 0x20 + (x) *=
 4)
> =20
> +#define  TEGRA186_GPIO_VM			0x00
> +#define  TEGRA186_GPIO_VM_RW_MASK		0x03
> +#define  TEGRA186_GPIO_SCR			0x04
> +#define  TEGRA186_GPIO_SCR_PIN_SIZE		0x08
> +#define  TEGRA186_GPIO_SCR_PORT_SIZE		0x40
> +#define  TEGRA186_GPIO_SCR_SEC_WEN		BIT(28)
> +#define  TEGRA186_GPIO_SCR_SEC_REN		BIT(27)
> +#define  TEGRA186_GPIO_SCR_SEC_G1W		BIT(9)
> +#define  TEGRA186_GPIO_SCR_SEC_G1R		BIT(1)
> +#define  TEGRA186_GPIO_FULL_ACCESS		(TEGRA186_GPIO_SCR_SEC_WEN | \
> +						 TEGRA186_GPIO_SCR_SEC_REN | \
> +						 TEGRA186_GPIO_SCR_SEC_G1R | \
> +						 TEGRA186_GPIO_SCR_SEC_G1W)
> +#define  TEGRA186_GPIO_SCR_SEC_ENABLE		(TEGRA186_GPIO_SCR_SEC_WEN | \
> +						 TEGRA186_GPIO_SCR_SEC_REN)
> +
>  /* control registers */
>  #define TEGRA186_GPIO_ENABLE_CONFIG 0x00
>  #define  TEGRA186_GPIO_ENABLE_CONFIG_ENABLE BIT(0)
> @@ -77,6 +93,7 @@ struct tegra_gpio_soc {
>  	unsigned int num_irqs_per_bank;
> =20
>  	const struct tegra186_pin_range *pin_ranges;
> +	bool has_vm_support;

You've placed this right between two fields that clearly belong
together. Best to add new fields towards the end of the structure if
they are not related to any of the other fields.

>  	unsigned int num_pin_ranges;
>  	const char *pinmux;
>  	bool has_gte;
> @@ -129,6 +146,58 @@ static void __iomem *tegra186_gpio_get_base(struct t=
egra_gpio *gpio,
>  	return gpio->base + offset + pin * 0x20;
>  }
> =20
> +static void __iomem *tegra186_gpio_get_secure_base(struct tegra_gpio *gp=
io,
> +					    unsigned int pin)
> +{
> +	const struct tegra_gpio_port *port;
> +	unsigned int offset;
> +
> +	port =3D tegra186_gpio_get_port(gpio, &pin);
> +	if (!port)
> +		return NULL;
> +
> +	offset =3D port->bank * 0x1000 + port->port * TEGRA186_GPIO_SCR_PORT_SI=
ZE;
> +
> +	return gpio->secure + offset + pin * TEGRA186_GPIO_SCR_PIN_SIZE;
> +}
> +
> +static inline bool tegra186_gpio_is_accessible(struct tegra_gpio *gpio, =
u32 pin)

Pin offsets are "unsigned int" in the rest of the driver, so please
stick to that here as well.

> +{
> +	void __iomem *secure;
> +	u32 val;

The drivers uses "u32 value;" everywhere else, so best stick to that for
consistency.

> +
> +	secure =3D tegra186_gpio_get_secure_base(gpio, pin);
> +
> +	if (gpio->soc->has_vm_support) {
> +		val =3D readl(secure + TEGRA186_GPIO_VM);
> +		if ((val & TEGRA186_GPIO_VM_RW_MASK) !=3D TEGRA186_GPIO_VM_RW_MASK)
> +			return false;
> +	}
> +
> +	val =3D __raw_readl(secure + TEGRA186_GPIO_SCR);
> +
> +	if ((val & TEGRA186_GPIO_SCR_SEC_ENABLE) =3D=3D 0)
> +		return true;
> +
> +	if ((val & TEGRA186_GPIO_FULL_ACCESS) =3D=3D TEGRA186_GPIO_FULL_ACCESS)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int tegra186_init_valid_mask(struct gpio_chip *chip,
> +		unsigned long *valid_mask, unsigned int ngpios)
> +{
> +	struct tegra_gpio *gpio =3D gpiochip_get_data(chip);
> +	int j;

Make that unsigned int to match the type of ngpios.

> +
> +	for (j =3D 0; j < ngpios; j++) {
> +		if (!tegra186_gpio_is_accessible(gpio, j))
> +			clear_bit(j, valid_mask);
> +	}
> +	return 0;
> +}
> +
>  static int tegra186_gpio_get_direction(struct gpio_chip *chip,
>  				       unsigned int offset)
>  {
> @@ -763,6 +832,7 @@ static int tegra186_gpio_probe(struct platform_device=
 *pdev)
>  	gpio->soc =3D device_get_match_data(&pdev->dev);
>  	gpio->gpio.label =3D gpio->soc->name;
>  	gpio->gpio.parent =3D &pdev->dev;
> +	gpio->gpio.init_valid_mask =3D tegra186_init_valid_mask;

Maybe slot this in before the gpio->gpio.add_pin_ranges assignment
further below in this function to keep things ordered a bit better.

> =20
>  	/* count the number of banks in the controller */
>  	for (i =3D 0; i < gpio->soc->num_ports; i++)
> @@ -1042,6 +1112,7 @@ static const struct tegra_gpio_soc tegra194_main_so=
c =3D {
>  	.num_pin_ranges =3D ARRAY_SIZE(tegra194_main_pin_ranges),
>  	.pin_ranges =3D tegra194_main_pin_ranges,
>  	.pinmux =3D "nvidia,tegra194-pinmux",
> +	.has_vm_support =3D true,
>  };
> =20
>  #define TEGRA194_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
> @@ -1067,6 +1138,7 @@ static const struct tegra_gpio_soc tegra194_aon_soc=
 =3D {
>  	.instance =3D 1,
>  	.num_irqs_per_bank =3D 8,
>  	.has_gte =3D true,
> +	.has_vm_support =3D false,
>  };
> =20
>  #define TEGRA234_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
> @@ -1111,6 +1183,7 @@ static const struct tegra_gpio_soc tegra234_main_so=
c =3D {
>  	.name =3D "tegra234-gpio",
>  	.instance =3D 0,
>  	.num_irqs_per_bank =3D 8,
> +	.has_vm_support =3D true,
>  };
> =20
>  #define TEGRA234_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
> @@ -1136,6 +1209,7 @@ static const struct tegra_gpio_soc tegra234_aon_soc=
 =3D {
>  	.name =3D "tegra234-gpio-aon",
>  	.instance =3D 1,
>  	.num_irqs_per_bank =3D 8,
> +	.has_vm_support =3D false,

It's not technically necessary to initialize 0/false fields because
that's what they end up with if you don't initialize them at all. I do
like to be explicit, so no objection from me on this. However, since we
are being explicit, we should set this new field for Tegra186 and
Tegra241 as well.

Thierry

--wIueMpqElCFwwyGl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM+tlwACgkQ3SOs138+
s6Ez+w/9FpeFqssyODdvFPPaSJVoQhx8Avcx4WK/cItqBnM+tB1fygrgpl6A2sh5
XvZKOzhET0TCtFLpftfonlG+3elynFYdOEqugG9vcFTcS7vffxXt9dj5tJX62k7X
7dbonYK9jvNhy26oEjOe2NOaRk6BOR4KNVC8TYwXZcJizq4Z6m/8apk8hiYLIzd8
vonhilY/oeA7ac4QtL2JOtN1zmIzUKc0Gmz55ZwOMAhJAZag3zJpsE1dBLDQc96k
ncDV+v99WFsghH9hdwWGLXf9rvvPkoQFWzayeE6kKMlFVLRnTZE5sYomAAfJfFF1
TfDcW6P3aj32VCCBq6Jtrlq0Z3LLgbBZyPTJKqTMj1JK+7a7ruDa9RObMCrifPcC
C4hb1R/F3t7NF/FJOjA3DnWilMwNZV8Ez8ux6FTiVWVMPPyBKnLns7YbFYpOyWd/
LjD2yKuWhEfAUA0te8GlRBvO4fgm8VxaJqbfK3aOwRZT+n1ZiSCrR1PQMih9GSbE
PzunC2qRpyr28AoUpII1IqCAYzs/Xz3FBh7XipIQSH1vEQPSzJwwdQXGyhmZTKvl
aMPL6CAngZsnntATEEMtatiZPnGcJHl63J74cxYXkMrAY9AbEZCaxrjKInOhnIcL
hEWwUhEXlVozq1FlSZSicZ2YpLNb8tQcF5Sr4N1S/Quu3tVuuR0=
=wN8V
-----END PGP SIGNATURE-----

--wIueMpqElCFwwyGl--
