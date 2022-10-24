Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BDF60B3DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiJXRSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJXRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:18:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F7C2A25F;
        Mon, 24 Oct 2022 08:53:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so10296287wms.0;
        Mon, 24 Oct 2022 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbDwJ7wvAUkhD1OcyTr/yjGyh92hqX3W/8ifm0JLlBU=;
        b=JVyPXgCSH3tJQcxC6yJuJZDLmlQMpY9+7NvO2ibypMYpCzSEhz0PKaeict2Eem7RVq
         6d4HEnbRMheXvVTm6Nz06d7i2wxAKqO8eqzMXINIWRGibI/qHsNtG4eLybGs/CyJ+K0J
         lHPngM62fQOS+xMTJjaQ8xthvpx/of07x8qCMLitR5FNMOI0d+/XD2yCSa+7g9BentdN
         Nl6hs4SFwd2SzyMtgEgYZFMvwhjEw1jnzw3cN8hpJXtIRF6fSHPimoMpDpcarPOv809S
         zVA0KbYHvJME96+g5zXEAU6MTVH9a8AorP/rs6NFhKKuJCAhCVZ212zZL3+97ZI3+IGA
         5uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbDwJ7wvAUkhD1OcyTr/yjGyh92hqX3W/8ifm0JLlBU=;
        b=RW0yHlgUS1CCoJbk8DzrNR5yCIKQulQ7iMSRUZ5vwh2iSHuMOdEbr2SkNWWeJx3Q5o
         cw/VxbYUrPhnnNfOtPnylFdJZrkbMaDQmMJkeilvwncMcxTGORBHfib8Iw5YDWv2iUjQ
         kWOGN96pZkpFXGgzKmMcUZ1asFMTA6yUEuOU5Q1MEhZ0iWsi/3vwU54GDf6dDCQtjMw4
         uDYnq7y9MDLoE7EE6jlhJlIGa8Im8jk/s1i2rWQf6RDNhgHFeuKl1Y3f9J/pvqw1ZR5L
         mHlCrev7fueS55hir+m8yu8IOd5pueMT5hzbpdnQQMtXauCMIjFGxWu9joNH9BNaJ3GI
         Odkg==
X-Gm-Message-State: ACrzQf2t5q92t45IVs6jQK/pCpNAwGKsGjWb21g0NDIs1xRIiwmCBiNb
        4e5mck0XHYgOybM40iibmyX1A7s91p0=
X-Google-Smtp-Source: AMsMyM4ibbYeSmYuLZtdL2590VPkTSOLbiPc+BzORbth6dxnpg1pkgkpbVCoY44500sZAF1ZzSvWyw==
X-Received: by 2002:a1c:f009:0:b0:3b4:9398:49c9 with SMTP id a9-20020a1cf009000000b003b4939849c9mr43310896wmb.174.1666620130862;
        Mon, 24 Oct 2022 07:02:10 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b003b4ff30e566sm20189398wms.3.2022.10.24.07.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 07:02:09 -0700 (PDT)
Date:   Mon, 24 Oct 2022 16:02:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        smangipudi@nvidia.com, Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: Re: [PATCH] gpio: tegra186: Check PMC driver status before any
 request
Message-ID: <Y1aa3/oJA2ElSGp0@orome>
References: <20220912133309.18506-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WWUO7I5ImHJZcyZm"
Content-Disposition: inline
In-Reply-To: <20220912133309.18506-1-pshete@nvidia.com>
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


--WWUO7I5ImHJZcyZm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 12, 2022 at 07:03:09PM +0530, Prathamesh Shete wrote:
> This patch fixes the issue where even if pmc driver
> status is disabled still we are invoking pmc driver
> to process some request

s/pmc/PMC/ twice above. Also, this is slightly misleading. We're not
"invoking" the PMC driver, but rather we're trying to look up the IRQ
domain that the PMC driver would've registered if it had been enabled.
So perhaps reword this to more accurately reflect that.

>=20
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/gpio/gpio-tegra186.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
> index 54d9fa7da9c1..efd508ba07a6 100644
> --- a/drivers/gpio/gpio-tegra186.c
> +++ b/drivers/gpio/gpio-tegra186.c
> @@ -895,7 +895,7 @@ static int tegra186_gpio_probe(struct platform_device=
 *pdev)
>  		tegra186_gpio_init_route_mapping(gpio);
> =20
>  	np =3D of_find_matching_node(NULL, tegra186_pmc_of_match);
> -	if (np) {
> +	if (of_device_is_available(np)) {
>  		irq->parent_domain =3D irq_find_host(np);
>  		of_node_put(np);

This now leaks a reference to np if np is found but not available. So
this should be something like:

	if (np) {
		if (of_device_is_available(np)) {
			irq->parent_domain =3D irq_find_host(np);
			of_node_put(np);

			if (!irq->parent_domain)
				return -EPROBE_DEFER;
		} else {
			of_node_put(np);
		}
	}

or:

	if (np) {
		if (of_device_is_available(np))
			irq->parent_domain =3D irq_find_host(np);

		of_node_put(np);

		if (of_device_is_available(np) && !irq->parent_domain)
			return -EPROBE_DEFER;
	}

The former is a little nicer because it doesn't check availability
twice.

Thierry

--WWUO7I5ImHJZcyZm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNWmt8ACgkQ3SOs138+
s6FgJRAAnKzSEP41yRfOaOvjtZaYVNHq7iZ+pMv4cuRTh9/5P46v0OcJyAFD6h4M
HrRrOhhXvJO6gTwylItsVxq0JIhhxzatNRGfVnUt4JhbycWpn7gJ/hdGx9JljdIG
E5Vd+2uD1y9ZQA+NSEJPQDJLwu6uqR9HuAnH5KB+JUvqDF4GI8W/xlOjrhOISdSH
YYBPw1kbnZYPfjCdcu9NJR6z8gITIMmlY4WeCS29HmkFgNa2ak3gv9Nvvgx9Q+fQ
WwGmSfT6G0QcBbVvDL9z7wugbXwKtlppomU0eGwJ61IAlMKCExoEbFEDqW1PoLYc
a6MXMmH0bVoHvcdH13tDbLlw0T8C29WZs2ZQPpxEvNv+cVbYLJmRhQUsQrBh+6fC
MeNsnJkoFZVf48sc9+RNi5ThjVHKCkkJ+nQJh+oXrva5gofwD+hPazbZv+Qz3pmz
/QaGuhMFp2dM7cDcgyHYQLf+R1kujXfS/rUvUBnIOtm110VhH22RV8cBktFP5rzI
smNqGx9UWoOKUQiSRYv2/r7mxwxUxJm9icexY02TxqVNCss0NPG7z4sGDggiJxhk
Tg/02gPDOE9t6giIhurr/wvaR2fVcNXTkNUmVygYr/VMcW0O8Zq4AIwkgvAI1skb
Ik0ZsL6p8LYIYdPy/tNaBPEGHaKR7JuHvxNYlEAPHhKiZtkeIC0=
=6xUl
-----END PGP SIGNATURE-----

--WWUO7I5ImHJZcyZm--
