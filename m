Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69E72E944
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbjFMRRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238243AbjFMRRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:17:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC451BC7;
        Tue, 13 Jun 2023 10:17:46 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE28D66003AC;
        Tue, 13 Jun 2023 18:17:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686676665;
        bh=gMG2FfpKe71fmWv1vKsLmtB7XJwJXTd5CwCVd3EL7oQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsLkahxRkYtcu/fv8qvCDtd0Q5ndJk/96fvE2riTxtzSdfqFiOXpqHpkFbYlY/6wt
         jsYbWV43G6x27j58/22LgKJS1XiIE64RsuEQ8FZXNteL1L2H7bdYKMlnf0Y3U17eB6
         RCcLp5URjyEJU7uQ4q2/utkwL7bxvzmin5JhzrnTknZ1pd8AT9bTz2Q4Qbv4vB+6wP
         w7xtBKl5aS3hsca0LqPQBRL7J4XVIksQmMRlnHIz+UfExS/5uIqxWtA8Ey0rP7SPVX
         XNFUX1+QqvNjuIRN6JevEj7J+gRa0FWdiNFhJJ1aay5i5cuOToHZBnOF3Bpl0vqxgf
         5v3IMOMluA8KA==
Received: by mercury (Postfix, from userid 1000)
        id 3EECC1066FC6; Tue, 13 Jun 2023 19:17:43 +0200 (CEST)
Date:   Tue, 13 Jun 2023 19:17:43 +0200
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
Subject: Re: [PATCH v5 17/25] PM / devfreq: rockchip-dfi: make register
 stride SoC specific
Message-ID: <20230613171743.ohey4rehoyph3a7p@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-18-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bfnjfsphhjzirrn4"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-18-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bfnjfsphhjzirrn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:45AM +0200, Sascha Hauer wrote:
> The currently supported RK3399 has a stride of 20 between the channel
> specific registers. Upcoming RK3588 has a different stride, so put
> the stride into driver data to make it configurable.
> While at it convert decimal 20 to hex 0x14 for consistency with RK3588
> which has a register stride 0x4000 and we want to write that in hex
> as well.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/devfreq/event/rockchip-dfi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 88145688e3d9c..a872550a7caf5 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -112,6 +112,7 @@ struct rockchip_dfi {
>  	int active_events;
>  	int burst_len;
>  	int buswidth[DMC_MAX_CHANNELS];
> +	int ddrmon_stride;
>  };
> =20
>  static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
> @@ -189,13 +190,13 @@ static void rockchip_dfi_read_counters(struct rockc=
hip_dfi *dfi, struct dmc_coun
>  		if (!(dfi->channel_mask & BIT(i)))
>  			continue;
>  		c->c[i].read_access =3D readl_relaxed(dfi_regs +
> -				DDRMON_CH0_RD_NUM + i * 20);
> +				DDRMON_CH0_RD_NUM + i * dfi->ddrmon_stride);
>  		c->c[i].write_access =3D readl_relaxed(dfi_regs +
> -				DDRMON_CH0_WR_NUM + i * 20);
> +				DDRMON_CH0_WR_NUM + i * dfi->ddrmon_stride);
>  		c->c[i].access =3D readl_relaxed(dfi_regs +
> -				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
> +				DDRMON_CH0_DFI_ACCESS_NUM + i * dfi->ddrmon_stride);
>  		c->c[i].clock_cycles =3D readl_relaxed(dfi_regs +
> -				DDRMON_CH0_COUNT_NUM + i * 20);
> +				DDRMON_CH0_COUNT_NUM + i * dfi->ddrmon_stride);
>  	}
>  }
> =20
> @@ -661,6 +662,8 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
>  	dfi->buswidth[0] =3D FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH0, val) =3D=
=3D 0 ? 4 : 2;
>  	dfi->buswidth[1] =3D FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH1, val) =3D=
=3D 0 ? 4 : 2;
> =20
> +	dfi->ddrmon_stride =3D 0x14;
> +
>  	return 0;
>  };
> =20
> --=20
> 2.39.2
>=20

--bfnjfsphhjzirrn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSIpLYACgkQ2O7X88g7
+povnQ//af60vdeKzEdCrmnusnPimIC4F3EmXyhFm1e/IzxqdKe8PwyUVXnNMGvQ
7vdweoS/t/0mCOiEaW0BEe1VKtnTCSVk52IHpkgyIilHWF5AoTnGok+2aB4O+mgI
LdEluwvrQ+YCDS0KHUVXJMPRrgPytNBumCl6ABV1Ly/I5QK6fzOVZJWMeSAuei/X
UZc55scwUPlMIJBORYsdsEuneXF5kR8E3EWXUlmZYgtSLTxRZd4gm31UQNV5GI7K
wmxJc6LZkcXA71c9QTiDM4yRS9ITsAjCSbqHgRqR8bpLMD/EF7t+VXpjOrnG12iO
OGc0G2hvxqjbMtG/efdCpXuWhcErherm0mRee5NpAnQGMJT/RuIzKAReUVKbRuka
jGSVInBRnQ6y18Mfj0EQ+1t5d53w7CtGKEibHBDph3dGh/A5TuU3CzSDXf4VHJCW
yhfXaJ6E3ELufDOSggjVtxOGfjgmF3mI9xpzsmdEnyO8Mjm0gXbiKEb4k6nu5193
rO6gG5S3q8Z/dN4nlkaznK3PoRx0CjMHpfUwKHebq5DZmvV0chp2ZtnorZ5HC28c
8MPWF0N4P99zELuUHHRT5ICMCm9XJpt+igToOvv6vibsUckLKdiCff/+d5cvDrDk
X+hkjH0q79Hma6jQQv3AUhjZesVI1qfZX/lShzH+0hyRPUFHyJQ=
=jil1
-----END PGP SIGNATURE-----

--bfnjfsphhjzirrn4--
