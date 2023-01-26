Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599A967CB11
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjAZMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjAZMpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:45:53 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CA53C29E;
        Thu, 26 Jan 2023 04:45:49 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id me3so4698969ejb.7;
        Thu, 26 Jan 2023 04:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FCFYtWUQP7YZSD2bSYpnKSDHJhXLIcuGKjaBrblv/o=;
        b=HwOb5ekyj/73Vrq1+CmBjw79letwxYvL1tvjqzYGgtzCXgt+GZSCMtv6TWci31lTpi
         TCOQt/8T0ur+bEZvcsJSWMLLvwhnNV9gDRcB9YOZczFmnQh01K2gqjQvYv69fNErsYzk
         hW+3Zqpv9yYGBkagqp0OmYlXQ4zjgalEubTy9kxJThNU7zjzukiZ4ivAT8VaHSBDArV7
         5jVqZwRZuhLplSZdJDoGGLXeeR+95v9cylD8iX+g0m1H653FBhmgs5bSC/0PZLP+8sN2
         u6mqNhJgKQgnQOdHQoYwoBe32enp0ZGOlaDr42bhyxBzbDNFakaTy5UNXsJNEWJLlYQ+
         6HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FCFYtWUQP7YZSD2bSYpnKSDHJhXLIcuGKjaBrblv/o=;
        b=WrRnf09WHFQ9wsIybU2vHi919/M4LeALWcvzbhxdCDtUEW4CqG07rczu615whWDQ6g
         7thspNoF+w9dFYy7rcbeLes530OP69TU4q4A99bdaC12UKGjdc39jzFWVNvepGReBmSU
         kWjhwMlPbqJa+TxcyXhhq8dFYirZtcNant2ab5cqDP5USNMPIKGPkyHAbWVXE+M1TPVN
         MJCLinilw92P4Uk9SIf0Noi1hD1bqjxNXQ1wP9X8ckSm+ZL9OJfxQiO5zVa4QV2tiYoB
         qOT82PsBGgS74UwdyhPs/rASOZHqTzR4P3V5hAkxOgiBnyna6cIMOPUvJJ3ocLuQfR3R
         BYmA==
X-Gm-Message-State: AO0yUKU036bn0KSrs071NKgVCz+5mBQOwNJuRpd/agkKUgwqdy1wCWx7
        edLxQ5UwpOYGeziu2475P61Aceuinzs=
X-Google-Smtp-Source: AK7set9rnQmxqteLXa/LHEOon567larfBCk2A34cacOe8q4briCydO6nBpdandlx7Lg6SELaY2rdVw==
X-Received: by 2002:a17:906:d0c2:b0:878:5fdc:3850 with SMTP id bq2-20020a170906d0c200b008785fdc3850mr2119869ejb.48.1674737147805;
        Thu, 26 Jan 2023 04:45:47 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gn19-20020a1709070d1300b0087862f45a29sm545286ejc.174.2023.01.26.04.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 04:45:47 -0800 (PST)
Date:   Thu, 26 Jan 2023 13:45:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Tom Rix <trix@redhat.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, jonathanh@nvidia.com,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: tegra186: remove unneeded loop in
 tegra186_gpio_init_route_mapping()
Message-ID: <Y9J1+fEErNzaN0fq@orome>
References: <20230125212631.749094-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hpFkZqyqoVYLb6Bp"
Content-Disposition: inline
In-Reply-To: <20230125212631.749094-1-trix@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hpFkZqyqoVYLb6Bp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2023 at 01:26:31PM -0800, Tom Rix wrote:
> Reviewing the j loop over num_irqs_per_bank, in the code previous
> to the fixes: commit, every j was used. now only when j =3D=3D 0.
> If only j =3D=3D 0 is used, there is no need for the loop.
>=20
> Fixes: 210386804745 ("gpio: tegra186: Support multiple interrupts per ban=
k")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpio/gpio-tegra186.c | 40 ++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
> index 9941f35af823..14c872b6ad05 100644
> --- a/drivers/gpio/gpio-tegra186.c
> +++ b/drivers/gpio/gpio-tegra186.c
> @@ -677,7 +677,7 @@ static const struct of_device_id tegra186_pmc_of_matc=
h[] =3D {
>  static void tegra186_gpio_init_route_mapping(struct tegra_gpio *gpio)
>  {
>  	struct device *dev =3D gpio->gpio.parent;
> -	unsigned int i, j;
> +	unsigned int i;
>  	u32 value;
> =20
>  	for (i =3D 0; i < gpio->soc->num_ports; i++) {
> @@ -699,27 +699,23 @@ static void tegra186_gpio_init_route_mapping(struct=
 tegra_gpio *gpio)
>  			 * On Tegra194 and later, each pin can be routed to one or more
>  			 * interrupts.
>  			 */
> -			for (j =3D 0; j < gpio->num_irqs_per_bank; j++) {
> -				dev_dbg(dev, "programming default interrupt routing for port %s\n",
> -					port->name);
> -
> -				offset =3D TEGRA186_GPIO_INT_ROUTE_MAPPING(p, j);
> -
> -				/*
> -				 * By default we only want to route GPIO pins to IRQ 0. This works
> -				 * only under the assumption that we're running as the host kernel
> -				 * and hence all GPIO pins are owned by Linux.
> -				 *
> -				 * For cases where Linux is the guest OS, the hypervisor will have
> -				 * to configure the interrupt routing and pass only the valid
> -				 * interrupts via device tree.
> -				 */
> -				if (j =3D=3D 0) {
> -					value =3D readl(base + offset);
> -					value =3D BIT(port->pins) - 1;
> -					writel(value, base + offset);
> -				}
> -			}
> +			dev_dbg(dev, "programming default interrupt routing for port %s\n",
> +				port->name);
> +
> +			offset =3D TEGRA186_GPIO_INT_ROUTE_MAPPING(p, 0);
> +
> +			/*
> +			 * By default we only want to route GPIO pins to IRQ 0. This works
> +			 * only under the assumption that we're running as the host kernel
> +			 * and hence all GPIO pins are owned by Linux.
> +			 *
> +			 * For cases where Linux is the guest OS, the hypervisor will have
> +			 * to configure the interrupt routing and pass only the valid
> +			 * interrupts via device tree.
> +			 */
> +			value =3D readl(base + offset);
> +			value =3D BIT(port->pins) - 1;
> +			writel(value, base + offset);

This was supposed to be a placeholder so that a more complex routing
could be added later on. Maybe adding "j" to the debug message would
have made that a bit clearer.

Anyway, no complex routing has been needed so far, so I don't have a
strong objection to this. We can always add it back if we ever need it.

On the other hand, we don't do much in the loop, so leaving it as-is
wouldn't be harmful either.

I'll leave it up to Linus and Bartosz to decide. If they want to pick it
up:

Acked-by: Thierry Reding <treding@nvidia.com>

--hpFkZqyqoVYLb6Bp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPSdfYACgkQ3SOs138+
s6GpZw/+Kc64MG4sQ0jny86UO9mDaWC1dXVlfbAZNtpjFUPZyD4bGTjl59O5cuO+
qvo7GDjGKLEZVNstArWRbhcscIdorCaHAzH5tnfHdx2DLUJxOeXcFsxKt3/gDpao
00Xi0TSipXG9I4Vd7LkejT/21IU60s+DU01y5nzFZ1CVziz2R3C9/sDWmCs+jU7O
8WHKU6dmxYz0ahG0x9v+7D5ol3Ha/0fF8h15jnjGquYeq0poZQXk7d0gBi+xjWvY
xEp9HiOt+PDvdxEuNwSecC8hqQHtpU87WDCFm18dC7vzsmgNc4DNi4X+f+G7kg0z
GoS6+xOdb+vtbAdX00v/kIpsqRsYCx1qBVNB3F2qrpEz7mplV+DUcn5apXcQ/yCh
9wO9rAPrla9m/xDRsz/RScMtnihbR3ZMIw5nk7lXSIuZ8L3siBMCAfZa4FnSK6Gq
c/wopq6HF1Y8ZS1BMBTjtDS9n9Vyb797nNhTUH+SAcpj8xfbwiMpGtzfPs390gWF
MDeW11BFnPOsJVaO4BN9jus7Km7UJr4D3lIkuL8tFg7eFO9zUMHnz0gAMlQndOWL
FK9eOuRhRf1NDlE7AlUboCAt1AspD9P8ReIWXv8h9FZcKu+NkLfmKJl3lo4E1iwP
MSmkTNSO8cRq5wZ/L72Utoe0POzUruc33/LXeXWslWkzZRw1+hY=
=Azhb
-----END PGP SIGNATURE-----

--hpFkZqyqoVYLb6Bp--
