Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC272E9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjFMRbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjFMRbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:31:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0050F1BF9;
        Tue, 13 Jun 2023 10:31:08 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BFD6A6606EC6;
        Tue, 13 Jun 2023 18:24:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686677078;
        bh=4rasFY34I/XTUiOf9VJ79l/mxOmZFAZu43QjJc0pgJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1sykmhm4gIpYvUkVjvTX9a1XM2iB8Dm1WECS5cIyLzyd0qYVLBb7B+LwsjW44jb/
         tPHb+WN3B2wpvpUTc4BhlYZI4XM/PLLsOMlTlH/euIbAvLOcmJ6x+/VVXVP+izcifH
         1Ya9dZa7b4Jfz9woAVMqOh0kAHMnPR43cOQQEd9bAXBY2SQt5IWGWmCO7fEouM8Iox
         p4zCtA9v13n4d6zhb+JMHprOOk+Jp3Y2qLr9OA94NvvI9p+xeQxF0tBHDsrkQbAyTJ
         aZu/GExwl2vceio6G8BEShDyl4ReTUscNVTG/1t5GwD/mmziABdJEl6uy+Zuu9B0CA
         0d1aOfxMbqIow==
Received: by mercury (Postfix, from userid 1000)
        id B0D0F1066FC6; Tue, 13 Jun 2023 19:24:36 +0200 (CEST)
Date:   Tue, 13 Jun 2023 19:24:36 +0200
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
Subject: Re: [PATCH v5 18/25] PM / devfreq: rockchip-dfi: account for
 multiple DDRMON_CTRL registers
Message-ID: <20230613172436.ah5oyhnt6sbxj5hf@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-19-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qcgjuyhdjwqhjjno"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-19-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qcgjuyhdjwqhjjno
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:46AM +0200, Sascha Hauer wrote:
> The currently supported RK3399 has a set of registers per channel, but
> it has only a single DDRMON_CTRL register. With upcoming RK3588 this
> will be different, the RK3588 has a DDRMON_CTRL register per channel.
>=20
> Instead of expecting a single DDRMON_CTRL register, loop over the
> channels and write the channel specific DDRMON_CTRL register. Break
> out early out of the loop when there is only a single DDRMON_CTRL
> register like on the RK3399.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/devfreq/event/rockchip-dfi.c | 72 ++++++++++++++++++----------
>  1 file changed, 48 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index a872550a7caf5..23d66fe737975 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -113,12 +113,13 @@ struct rockchip_dfi {
>  	int burst_len;
>  	int buswidth[DMC_MAX_CHANNELS];
>  	int ddrmon_stride;
> +	bool ddrmon_ctrl_single;
>  };
> =20
>  static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
>  {
>  	void __iomem *dfi_regs =3D dfi->regs;
> -	int ret =3D 0;
> +	int i, ret =3D 0;
> =20
>  	mutex_lock(&dfi->mutex);
> =20
> @@ -132,29 +133,41 @@ static int rockchip_dfi_enable(struct rockchip_dfi =
*dfi)
>  		goto out;
>  	}
> =20
> -	/* clear DDRMON_CTRL setting */
> -	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN | DDRMON_CTRL_=
SOFTWARE_EN |
> -		       DDRMON_CTRL_HARDWARE_EN), dfi_regs + DDRMON_CTRL);
> +	for (i =3D 0; i < DMC_MAX_CHANNELS; i++) {
> +		u32 ctrl =3D 0;
> =20
> -	/* set ddr type to dfi */
> -	switch (dfi->ddr_type) {
> -	case ROCKCHIP_DDRTYPE_LPDDR2:
> -	case ROCKCHIP_DDRTYPE_LPDDR3:
> -		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR23, DDRMON_CTRL_DDR_TYPE=
_MASK),
> -			       dfi_regs + DDRMON_CTRL);
> -		break;
> -	case ROCKCHIP_DDRTYPE_LPDDR4:
> -	case ROCKCHIP_DDRTYPE_LPDDR4X:
> -		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR4, DDRMON_CTRL_DDR_TYPE_=
MASK),
> -			       dfi_regs + DDRMON_CTRL);
> -		break;
> -	default:
> -		break;
> -	}
> +		if (!(dfi->channel_mask & BIT(i)))
> +			continue;
> =20
> -	/* enable count, use software mode */
> -	writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN, DDRMON_CTRL_SOFTW=
ARE_EN),
> -		       dfi_regs + DDRMON_CTRL);
> +		/* clear DDRMON_CTRL setting */
> +		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN |
> +			       DDRMON_CTRL_SOFTWARE_EN | DDRMON_CTRL_HARDWARE_EN),
> +			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
> +
> +		/* set ddr type to dfi */
> +		switch (dfi->ddr_type) {
> +		case ROCKCHIP_DDRTYPE_LPDDR2:
> +		case ROCKCHIP_DDRTYPE_LPDDR3:
> +			ctrl =3D DDRMON_CTRL_LPDDR23;
> +			break;
> +		case ROCKCHIP_DDRTYPE_LPDDR4:
> +		case ROCKCHIP_DDRTYPE_LPDDR4X:
> +			ctrl =3D DDRMON_CTRL_LPDDR4;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		writel_relaxed(HIWORD_UPDATE(ctrl, DDRMON_CTRL_DDR_TYPE_MASK),
> +			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
> +
> +		/* enable count, use software mode */
> +		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN, DDRMON_CTRL_SOFT=
WARE_EN),
> +			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
> +
> +		if (dfi->ddrmon_ctrl_single)
> +			break;
> +	}
>  out:
>  	mutex_unlock(&dfi->mutex);
> =20
> @@ -164,6 +177,7 @@ static int rockchip_dfi_enable(struct rockchip_dfi *d=
fi)
>  static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
>  {
>  	void __iomem *dfi_regs =3D dfi->regs;
> +	int i;
> =20
>  	mutex_lock(&dfi->mutex);
> =20
> @@ -174,8 +188,17 @@ static void rockchip_dfi_disable(struct rockchip_dfi=
 *dfi)
>  	if (dfi->usecount > 0)
>  		goto out;
> =20
> -	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
> -		       dfi_regs + DDRMON_CTRL);
> +	for (i =3D 0; i < DMC_MAX_CHANNELS; i++) {
> +		if (!(dfi->channel_mask & BIT(i)))
> +			continue;
> +
> +		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
> +			      dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
> +
> +		if (dfi->ddrmon_ctrl_single)
> +			break;
> +	}
> +
>  	clk_disable_unprepare(dfi->clk);
>  out:
>  	mutex_unlock(&dfi->mutex);
> @@ -663,6 +686,7 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
>  	dfi->buswidth[1] =3D FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH1, val) =3D=
=3D 0 ? 4 : 2;
> =20
>  	dfi->ddrmon_stride =3D 0x14;
> +	dfi->ddrmon_ctrl_single =3D true;
> =20
>  	return 0;
>  };
> --=20
> 2.39.2
>=20

--qcgjuyhdjwqhjjno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSIplQACgkQ2O7X88g7
+poSVQ/8CdcfkOAIJEK9UNTf1vpgujtEuSeIYOsifZifSXVZO6S73Qkzec3iYFDw
iI0H8DmfO3dOI/bj8viBWFSkHIK/zYe3LHgyEst9l7gbg0gxsClOuUIyhV7MoZpi
/+o+GDHzbxO0murEnOpwGfJgyVoPODrTmN+2ZsHDZWRUK1hoeL3q4seJ+bNwmHOw
RIoLx/fRkpQrI6+cjg0QalJyRavazv2niUBa0Too8ogPxPLo+e8yYVTQhvddER6k
Jb+7LTnx6yUY1LQt0SgBTWrmHkS8b3wYG32fEbKsU/hYQguHQ+kD8rGFW0LaKBzQ
y3yfqsXnQxAGcHdJtsg+vbxzdJ5JgvgdPEgKtJoWKT9i7veWf/5gt9enNU0bLL52
qz2uuc7lZgJ4OzWakd2lcPYL6iN32NAs8a9hAF52cXtzRyqH3LgH1QXAXoiDUWvg
Le/vlsw4mu6Ltz/AytwZNVUT3HPWVPuwRc9YuYGnTaP+NsOceqUVZn4dylmVDc7k
uqPMnYakS26rkDrJVoeflgyjtj3ekXFZN9SjIhk5WpSJBKPHy4+h4Vf1Sr0nvlT/
XHZ83IZ3WU9JEJvoXIj8wOHFm2WzCOiqz/3EhHrJbikAboE1nDQFXzIhXCORVWU7
vssSowYyNQ5FIrFIAGSTlGrf8LlWrjwsb3R6VC2OeXN2Dg19+RE=
=eEfi
-----END PGP SIGNATURE-----

--qcgjuyhdjwqhjjno--
