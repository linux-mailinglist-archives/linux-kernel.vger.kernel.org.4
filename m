Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEC85B890F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiINNWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINNWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:22:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA1433E14;
        Wed, 14 Sep 2022 06:22:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lc7so34752618ejb.0;
        Wed, 14 Sep 2022 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yltKltf7k/7Tv+cdX8h0XekrBKlh8zMo8autSmjZLU0=;
        b=kBxV1j5nmwEloGjCh2JKhKc6TeL58lPYtvXafeefOjlkuzqEtU+N4mly45K/vE+QY6
         2GCodj96R0kUJSzTdg4LTS8l7P6x/+wGM8yx8mw2Yh35oQW9Ha5575+OTh8NJ9z31Lwe
         /GbUKIMxq7rrkY/k62Ro9eSKql6kIe3wRAqxsxX/HkUYw5ZJR61jyvSw9swX1I6HXHEI
         Dz0a6KJV2T4mWxtxJ3wJgx1ZTEy46MKcnRr5GzxJIvFDYiYF3nN0mS/CaEFTE/r2Hsb+
         gc0nlexKACM4NMZW4k5TLAvh/8DhPAJe4e6/vbSo7tGvNWYLR7IFaZZTjJxfDu42aUT/
         YdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yltKltf7k/7Tv+cdX8h0XekrBKlh8zMo8autSmjZLU0=;
        b=ARrEgvCvgFlqZAHzsfpIn9RDVJkh0PS9cFSFBrqJS8JWGLUspVg5Mmw5gK9W+XfXQC
         gF2h/r4YqYvwe5TPbGeVl4ko7A064/3LmJgkvprQxeKz8VmsTILmk+gR5VbPlZghvq5u
         0uLb/cYE8XlotuM4zk7rLH/gONrtjt8OUV0UzWb6fJaPfJFH0XCSpigHLPXAheA/Elci
         T0JjWlGaK+OdVWsfY7tldF0XHc0mqSPKZQev/y59Hvuzdigk0kccMK1IdRCaNn7rmwI7
         CjyGDZ4bZLPh9waisG3uel6FbIXxB7fHa9ZaG3YjbkaDiHFqO9dMvvmbw/3XXtzmFEt1
         fPfw==
X-Gm-Message-State: ACgBeo0D3Cixj+WORu+TpAyliTuhnoD2GUgK3gqnbA8Ygcs0mnsqclJ1
        gKlCTW8NKBoF+aczkWp/2ho=
X-Google-Smtp-Source: AA6agR6VgLqUn9OpIcHsEgk5kdfaUNkXl71KV8hNsGjjAguPU1YK/yjY0Aqm6SKCzWPITQgSGy86Dg==
X-Received: by 2002:a17:907:7609:b0:770:8665:dfd4 with SMTP id jx9-20020a170907760900b007708665dfd4mr23289215ejc.494.1663161765088;
        Wed, 14 Sep 2022 06:22:45 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b00731582babcasm7665552eja.71.2022.09.14.06.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 06:22:44 -0700 (PDT)
Date:   Wed, 14 Sep 2022 15:22:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: Re: [PATCH] gpio: tegra186: Check GPIO pin permission before access.
Message-ID: <YyHVoihMuKNRFXAS@orome>
References: <20220914122110.7246-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EpbKDgucfAHb34B5"
Content-Disposition: inline
In-Reply-To: <20220914122110.7246-1-pshete@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EpbKDgucfAHb34B5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2022 at 05:51:10PM +0530, Prathamesh Shete wrote:
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
>  drivers/gpio/gpio-tegra186.c | 71 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)

I like where this is heading, however I think there's a little more room
for improvement, see below.

>=20
> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
> index 54d9fa7da9c1..e6fc3c9b1e9f 100644
> --- a/drivers/gpio/gpio-tegra186.c
> +++ b/drivers/gpio/gpio-tegra186.c
> @@ -26,6 +26,22 @@
> =20
>  #define TEGRA186_GPIO_INT_ROUTE_MAPPING(p, x) (0x14 + (p) * 0x20 + (x) *=
 4)
> =20
> +#define  TEGRA186_GPIO_VM_REG			0x00

I'd leave out the _REG suffix. It's redundant.

> +#define  TEGRA186_GPIO_VM_RW_MASK		0x03
> +#define  TEGRA186_GPIO_SCR_REG			0x04

Same here.

> +#define  TEGRA186_GPIO_SCR_DIFF			0x08

Maybe name this something like: TEGRA186_GPIO_SCR_PIN_SIZE to be a
little more specific. The VM and SCR registers above are both per-pin,
so the size of the per-pin window is 8 bytes.

> +#define  TEGRA186_GPIO_SCR_BASE_DIFF		0x40

And then this would equivalently be TEGRA186_GPIO_SCR_PORT_SIZE. This is
the per-port window, where each port can have a maximum of 8 pins, so 8
* 8 =3D 0x40 bytes.

> +#define  TEGRA186_GPIO_SCR_SEC_WEN		BIT(28)
> +#define  TEGRA186_GPIO_SCR_SEC_REN		BIT(27)
> +#define  TEGRA186_GPIO_SCR_SEC_G1W		BIT(9)
> +#define  TEGRA186_GPIO_SCR_SEC_G1R		BIT(1)
> +#define  TEGRA186_GPIO_FULL_ACCESS		(TEGRA186_GPIO_SCR_SEC_WEN | \
> +						 TEGRA186_GPIO_SCR_SEC_REN | \
> +						 TEGRA186_GPIO_SCR_SEC_G1R | \
> +						 TEGRA186_GPIO_SCR_SEC_G1W)

Maybe TEGRA186_GPIO_SCR_SEC_FULL_ACCESS for consistency? It's a bit of a
mouthful, but the single line where this is used still fits within the
100 characters limit, so seems fine.

> +#define  TEGRA186_GPIO_SCR_SEC_ENABLE		(TEGRA186_GPIO_SCR_SEC_WEN | \
> +						 TEGRA186_GPIO_SCR_SEC_REN)

I'd also put the _SIZE definitions after all the register field
definitions so they don't get mistaken for a register offset or field
definition.

> +
>  /* control registers */
>  #define TEGRA186_GPIO_ENABLE_CONFIG 0x00
>  #define  TEGRA186_GPIO_ENABLE_CONFIG_ENABLE BIT(0)
> @@ -77,6 +93,7 @@ struct tegra_gpio_soc {
>  	unsigned int num_irqs_per_bank;
> =20
>  	const struct tegra186_pin_range *pin_ranges;
> +	bool has_vm_support;

I had hoped that we could perhaps avoid this flag. So according to the
register documentation, the AON variants of the controller have a single
64 KiB page that contains both SCR and GPIO registers, whereas the VM-
capable variants (i.e. MAIN) contain SCR and GPIO registers in separate
64 KiB pages.

Now, unfortunately we've "abused" the "security" entry of the "reg"
property in DT to workaround the slight quirk that the GPIO registers
are offset by 4 KiB into the single 64 KiB page on AON. That's nifty on
one hand because it allows the driver to function in the same way as the
MAIN variant, but it's also not entirely accurate from a hardware
description point of view.

So while we currently have this in DT:

	gpio@c2f0000 {
		compatible =3D "nvidia,tegra234-gpio-aon";
		reg-names =3D "security", "gpio";
		reg =3D <0x0c2f0000 0x1000>;
		      <0x0c2f1000 0x1000>;
		...
	};

We should really have:

	gpio@c2f0000 {
		compatible =3D "nvidia,tegra234-gpio-aon";
		reg-names =3D "gpio";
		reg =3D <0x0c2f0000 0x10000>;
		...
	};

We could then, based on the absence of the "security" register region
derive in the driver that all "gpio" region accesses need to be offset
by that 4 KiB region.

That's a little difficult to do because of backwards-compatibility
requirements, so I'm tempted to just stick with what we have right now.
Alternatively we could also try to derive from the "security" region
size whether it's a full VM set of security registers, or whether its
the limited AON set.

The has_vm_support flag isn't all that bad, though, so I don't have a
strong objection here.

>  	unsigned int num_pin_ranges;
>  	const char *pinmux;
>  	bool has_gte;
> @@ -129,6 +146,45 @@ static void __iomem *tegra186_gpio_get_base(struct t=
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
> +	offset =3D port->bank * 0x1000 + port->port * TEGRA186_GPIO_SCR_BASE_DI=
FF;
> +
> +	return gpio->secure + offset + pin * TEGRA186_GPIO_SCR_DIFF;
> +}
> +
> +static inline bool tegra186_gpio_is_accessible(struct tegra_gpio *gpio, =
u32 pin)
> +{
> +	void __iomem *secure;
> +	u32 val;
> +
> +	secure =3D tegra186_gpio_get_secure_base(gpio, pin);
> +
> +	if (gpio->soc->has_vm_support) {
> +		val =3D readl(secure + TEGRA186_GPIO_VM_REG);
> +		if ((val & TEGRA186_GPIO_VM_RW_MASK) !=3D TEGRA186_GPIO_VM_RW_MASK)
> +			return false;
> +	}
> +
> +	val =3D __raw_readl(secure + TEGRA186_GPIO_SCR_REG);
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
>  static int tegra186_gpio_get_direction(struct gpio_chip *chip,
>  				       unsigned int offset)
>  {
> @@ -136,6 +192,9 @@ static int tegra186_gpio_get_direction(struct gpio_ch=
ip *chip,
>  	void __iomem *base;
>  	u32 value;
> =20
> +	if (!tegra186_gpio_is_accessible(gpio, offset))
> +		return -EPERM;

It shouldn't be necessary to do this for every accessor function. In
general it should be enough to make sure the GPIO request fails for an
inaccessible GPIO. Interestingly there's already a feature built into
gpiolib that allows us to do exactly that. The gpiochip can implement
the ->init_valid_mask() callback, which can be used to mark certain pins
as invalid. See the gpio-aspeed-sgpio.c and gpio-bd71815.c for examples,
although the former seems to be completely redundant (the mask is all-
ones by default already) and the latter is quite simple.

For Tegra specifically I think what we want is to loop over all pins,
call tegra186_gpio_is_accessible() and if that returns false, call
bitmap_clear() for that specific pin.

With that the changes in the accessors here and below should not be
needed anymore and the gpiolib code should take care of everything.

> +
>  	base =3D tegra186_gpio_get_base(gpio, offset);
>  	if (WARN_ON(base =3D=3D NULL))
>  		return -ENODEV;
> @@ -154,6 +213,9 @@ static int tegra186_gpio_direction_input(struct gpio_=
chip *chip,
>  	void __iomem *base;
>  	u32 value;
> =20
> +	if (!tegra186_gpio_is_accessible(gpio, offset))
> +		return -EPERM;
> +
>  	base =3D tegra186_gpio_get_base(gpio, offset);
>  	if (WARN_ON(base =3D=3D NULL))
>  		return -ENODEV;
> @@ -177,6 +239,9 @@ static int tegra186_gpio_direction_output(struct gpio=
_chip *chip,
>  	void __iomem *base;
>  	u32 value;
> =20
> +	if (!tegra186_gpio_is_accessible(gpio, offset))
> +		return -EPERM;
> +
>  	/* configure output level first */
>  	chip->set(chip, offset, level);
> =20
> @@ -293,6 +358,10 @@ static void tegra186_gpio_set(struct gpio_chip *chip=
, unsigned int offset,
>  	void __iomem *base;
>  	u32 value;
> =20
> +	if (!tegra186_gpio_is_accessible(gpio, offset)){
> +		pr_err("GPIO not accessible\n");
> +		return;
> +	}
>  	base =3D tegra186_gpio_get_base(gpio, offset);
>  	if (WARN_ON(base =3D=3D NULL))
>  		return;
> @@ -1042,6 +1111,7 @@ static const struct tegra_gpio_soc tegra194_main_so=
c =3D {
>  	.num_pin_ranges =3D ARRAY_SIZE(tegra194_main_pin_ranges),
>  	.pin_ranges =3D tegra194_main_pin_ranges,
>  	.pinmux =3D "nvidia,tegra194-pinmux",
> +	.has_vm_support =3D true,
>  };
> =20
>  #define TEGRA194_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
> @@ -1067,6 +1137,7 @@ static const struct tegra_gpio_soc tegra194_aon_soc=
 =3D {
>  	.instance =3D 1,
>  	.num_irqs_per_bank =3D 8,
>  	.has_gte =3D true,
> +	.has_vm_support =3D false,
>  };

Don't we need to set this for Tegra186 and Tegra234 as well?

Thierry

--EpbKDgucfAHb34B5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMh1Z8ACgkQ3SOs138+
s6E6vQ//dk6vIYALqf0KjN5AZ1MATevZE7ASuxBkZIorQIu8MB0EkFvAaX3/RnBi
v+srKCNhhunwYAWee55gvkEgbhkImUy5+dBgGnULniHw44MlvWJKTTB5zFPrwH4h
A9ZHVtRwjj9TUttTIZ137RfL3HZ86vGJzA/gv8TiE+GEUR2JYDXQkRaoGgZ7hsqw
aXkqOMCHEw/jpNyiDi5LGTPPPkUqEcmuXrrUV2f/ncNzq29RFGMHt/QfFvv7ofMt
XCMPwvccdJWy22ffO81bHkezWfjgVcJsZSjeHAY1nBlSvG2j3adxZpQhMYaLmy85
TTRdq4I/zNp/kkVSMez4zgvmZMpLDZMZyMq91pqT7CUlagaUkm25zfLh6imKB5zt
MFcBQfil1QCGMKFKAQM7/VCCm9fB/MkEQd9pbmCfWyu27DLjigidNraF6Dr9gIW7
8SsFy+79zYWj2z2GDyP4xfqw45EEFzmEfCUJZqnNaPRCkz0esx2voQoRddB5pAvm
VFLeVHg8C5A4Vx9K6T9v1qEhjAWOt887/KTvcsybSqHPkQ4mwJDHOe1NF0qJseDi
E/0RN2bjc3FvSdYds9jOwe5yH3rElOyF5OlFNJOuDVNZlhNP28YFG7NxI4Mnf7wt
a7FtSFDVhiqYDRgKiax0EyIEzcViYSFGysI7u9/qPwO0caQ1Hng=
=QG8n
-----END PGP SIGNATURE-----

--EpbKDgucfAHb34B5--
