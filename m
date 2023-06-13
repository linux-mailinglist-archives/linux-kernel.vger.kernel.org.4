Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8B972E92A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbjFMRQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjFMRQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:16:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B0E19BF;
        Tue, 13 Jun 2023 10:16:27 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AFF5666003AC;
        Tue, 13 Jun 2023 18:16:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686676586;
        bh=5AxaalXzVaJFUkSTDi3Tm4IeWzb4tfj/SGsHptGfdcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqW70nOZWRTeu1NehigYLVIKDoDs5kENOcbMF9f0Sk19xKMpYE5PB811THrIbcmB8
         e05QQS1DlIr6lTdPQyaGrgazfR7h41QVcP8snBVb6Vu0lxK87Hf5BcbGemt30lVnUJ
         Gt1Or5sLzy7uAwqh1lm+43r4BmEGAl7EWKTgJMRhw06PH8I5PCwCLVkOdUxv/rmJxB
         yj0RPZ0IHiTNcsq7zi+y8SuAuQ176tnuyGe22m6xQvmaHEhbxDBqbRYFHushn9TUoK
         Q5yOzOAtFp/b+zWRuwJBDc27aaUdW+VeJxcYDfiUvGVSrUl9BcsdL8183/3XCyW6dT
         +VEoAMpdcJNDw==
Received: by mercury (Postfix, from userid 1000)
        id 1C1551066FC6; Tue, 13 Jun 2023 19:16:24 +0200 (CEST)
Date:   Tue, 13 Jun 2023 19:16:24 +0200
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
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 15/25] PM / devfreq: rockchip-dfi: give variable a
 better name
Message-ID: <20230613171624.mrosctprljlz4g46@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-16-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pfxobpnuncen6xuh"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-16-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pfxobpnuncen6xuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:43AM +0200, Sascha Hauer wrote:
> struct dmc_count_channel::total counts the clock cycles of the DDR
> controller. Rename it accordingly to give the reader a better idea
> what this is about. While at it, at some documentation to struct
> dmc_count_channel.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/devfreq/event/rockchip-dfi.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 8a7af7c32ae0d..50e497455dc69 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -46,9 +46,14 @@
>  #define DDRMON_CH1_COUNT_NUM		0x3c
>  #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
> =20
> +/**
> + * struct dmc_count_channel - structure to hold counter values from the =
DDR controller
> + * @access:       Number of read and write accesses
> + * @clock_cycles: DDR clock cycles
> + */
>  struct dmc_count_channel {
>  	u32 access;
> -	u32 total;
> +	u32 clock_cycles;
>  };
> =20
>  struct dmc_count {
> @@ -150,7 +155,7 @@ static void rockchip_dfi_read_counters(struct rockchi=
p_dfi *dfi, struct dmc_coun
>  			continue;
>  		count->c[i].access =3D readl_relaxed(dfi_regs +
>  				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
> -		count->c[i].total =3D readl_relaxed(dfi_regs +
> +		count->c[i].clock_cycles =3D readl_relaxed(dfi_regs +
>  				DDRMON_CH0_COUNT_NUM + i * 20);
>  	}
>  }
> @@ -182,29 +187,29 @@ static int rockchip_dfi_get_event(struct devfreq_ev=
ent_dev *edev,
>  	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
>  	struct dmc_count count;
>  	struct dmc_count *last =3D &dfi->last_event_count;
> -	u32 access =3D 0, total =3D 0;
> +	u32 access =3D 0, clock_cycles =3D 0;
>  	int i;
> =20
>  	rockchip_dfi_read_counters(dfi, &count);
> =20
>  	/* We can only report one channel, so find the busiest one */
>  	for (i =3D 0; i < DMC_MAX_CHANNELS; i++) {
> -		u32 a, t;
> +		u32 a, c;
> =20
>  		if (!(dfi->channel_mask & BIT(i)))
>  			continue;
> =20
>  		a =3D count.c[i].access - last->c[i].access;
> -		t =3D count.c[i].total - last->c[i].total;
> +		c =3D count.c[i].clock_cycles - last->c[i].clock_cycles;
> =20
>  		if (a > access) {
>  			access =3D a;
> -			total =3D t;
> +			clock_cycles =3D c;
>  		}
>  	}
> =20
>  	edata->load_count =3D access * 4;
> -	edata->total_count =3D total;
> +	edata->total_count =3D clock_cycles;
> =20
>  	dfi->last_event_count =3D count;
> =20
> --=20
> 2.39.2
>=20

--pfxobpnuncen6xuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSIpGcACgkQ2O7X88g7
+pqCyA/+LtQycD7o9vOEa1QsxI1Jhpp/ODV1N1n7SFabrVZ5oq92CcyFBpHUhTIR
taIWvyae1XLKz6HJNoEGzA6xQqEDdGqXLCrRmfbx59QaeJOfJGt0fcIQ4t0WbhvH
Y4KcUebYaBZnVCzdzJFCbScrpcKfk4hcSgMFHy5KAHGTRF2USYhcUBgS3wO7r8Ph
OSOnFDmx8/styjdpVQIVpWnTrM4Jx1zs79u2TP669ddq5Fsqd0mcifUUbcYwXXws
ySQyTDC14N1TztxQzpe5g4/IVej6TnVXB+EKbPc/B+8ZFXc0qjUQaJJNsKx08HXM
a39Ifgbbf7qvxxx3mzGqDP+bVtU7gmGIzGBiYbyjNP4tu7fgn9nunshEzGllKCr6
BmdAp3HIe63572BKHiMlofA60WCiewzgZhGCLlMUCUsyChB96xBfR0Sc/YZ01CIx
02iUBC3HlscYwdcXsREd2uW5No+zjSEdlgDP+o2ecArNxDV63fPo2e7pFQdBAjle
Jl2xtYDMCTzdERc+woA7q8aMXupEwImo1stBVMtnMyU/SRa9peApx9/s43is7aas
SB1GSQ2/hjrcAW9HTiqVhFVpVfu7poGhtVlKouk7C7o7uf82uAnZ8trILzHdgN27
kR0rmWM+VUx8nIDLTP5RKO4VrAVhfWCLuKCYQd95a8PTPhwIdI4=
=HV39
-----END PGP SIGNATURE-----

--pfxobpnuncen6xuh--
