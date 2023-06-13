Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407B072E89E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjFMQiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFMQiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:38:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FA910F7;
        Tue, 13 Jun 2023 09:38:04 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 21E7E6606F02;
        Tue, 13 Jun 2023 17:38:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686674283;
        bh=pAMc5iIUtVNKAg7A2xXHcXeT2iJlD2eyigzNX+2SXVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHYbci7Fy2C4/fK/8u5aECl4sm7JqHiHbe3gYscnvAK2kr1ohhdjEIucrPkWhpBzi
         4ZlwXVRJm4f3BzSOYDgX/Nn1WTRXORQygFg7e/C76S5+vDp04jI91bXhltKwPAkcPc
         QQwdJieOk5C5W5C0bFNyvYz90OxeA8fR2v671QJ+3JzVkwnA9woROnVDLzBQVDbaCW
         FYAiIXjUi83rXadKFELr0e38gBDbm5t8yyDXNFh2tyQrTYBn4jfeualtnY9ZUf+6ds
         FZHint8JYEOVTHk1wtdX1TsuKNTDErHrEzck8diSSPLDxw7Mxe87+WiNl2PA72OHPu
         c8GOjHSqBkw9w==
Received: by mercury (Postfix, from userid 1000)
        id E0ED81066FBA; Tue, 13 Jun 2023 18:28:54 +0200 (CEST)
Date:   Tue, 13 Jun 2023 18:28:54 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 05/25] PM / devfreq: rockchip-dfi: dfi store raw
 values in counter struct
Message-ID: <20230613162854.ng65n5fpm4ndag6w@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-6-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="umejpk3kmtdxm6a5"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-6-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--umejpk3kmtdxm6a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:33AM +0200, Sascha Hauer wrote:
> When adding perf support to the DFI driver the perf part will
> need the raw counter values, so move the fixed * 4 factor to
> rockchip_dfi_get_event().
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/devfreq/event/rockchip-dfi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 6b1ef29df7048..680f629da64fc 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -97,7 +97,7 @@ static int rockchip_dfi_get_busier_ch(struct devfreq_ev=
ent_dev *edev)
>  	/* Find out which channel is busier */
>  	for (i =3D 0; i < RK3399_DMC_NUM_CH; i++) {
>  		dfi->ch_usage[i].access =3D readl_relaxed(dfi_regs +
> -				DDRMON_CH0_DFI_ACCESS_NUM + i * 20) * 4;
> +				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
>  		dfi->ch_usage[i].total =3D readl_relaxed(dfi_regs +
>  				DDRMON_CH0_COUNT_NUM + i * 20);
>  		tmp =3D dfi->ch_usage[i].access;
> @@ -149,7 +149,7 @@ static int rockchip_dfi_get_event(struct devfreq_even=
t_dev *edev,
> =20
>  	busier_ch =3D rockchip_dfi_get_busier_ch(edev);
> =20
> -	edata->load_count =3D dfi->ch_usage[busier_ch].access;
> +	edata->load_count =3D dfi->ch_usage[busier_ch].access * 4;
>  	edata->total_count =3D dfi->ch_usage[busier_ch].total;
> =20
>  	return 0;
> --=20
> 2.39.2
>=20

--umejpk3kmtdxm6a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSImUYACgkQ2O7X88g7
+pq+hBAAoMxu3TG9fMaD7egSKi5bGMv6DrZQnN+ppfmPo+2sX+h0wzA3Bd/UTRpc
mhsxF72Z1zoiLH4/NyCcs0Mu9soUDF8HOvqGbqEaxkuDy4YausNhGfAtyCcP+BVq
HOUZJon3Ue1NUz1L1T4frD9ndsyMzjMzTa+5GzF/pqtUHCYpdAQkjEl9MBA2WmE2
OFmh1IhinCGk7ztjez2lO/DXWTAU+pbCNo924uPEZcEB7MA/8eWCuvivIfsVqYCg
HLd41PP9Z6bL63QN7ehpLp8yaSsOIvt0IRBbOUBIzdc+L/oIBtiqJKWeNXwxyKal
nqpXQf9qTRCMdA3A98M3w9fdHSX2UXHCWq7Wc38eueZWg9oqtv4O2/07F7lZlEyL
oaWU4uED2CRk642pewQgDsinLzJl8+38RwtTRXfCghjMnMXMgDEUsICw/OA9PrVh
HvH+uxnECmjjuGRMaCGcwXv9RffCRCdPxQUJ6cETrSYteEqWntEL2HHpTYlnAnE6
TYK4zqdmVqYozJK+Qq8CjlZZ9OynhLKItWkJki1ObzJLeth/CLbpxBVaI4Av/efn
uj86MNSLSSWtTvp360SYJ/Xea1RtXRCrbORuIhIwVCRyG0KhdeaBSIteL6nfSsg7
+GZUGaGlMF2u8Sh9yfs7dcWV+EaAe3gfypdu/U+RmWBTEhK6ako=
=WHIx
-----END PGP SIGNATURE-----

--umejpk3kmtdxm6a5--
