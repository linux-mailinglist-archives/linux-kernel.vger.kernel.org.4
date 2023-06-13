Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754AD72E871
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243165AbjFMQWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243075AbjFMQWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:22:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE761BEC;
        Tue, 13 Jun 2023 09:22:20 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1FC0E6606EF9;
        Tue, 13 Jun 2023 17:22:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686673339;
        bh=MADM0OvComNnVgRiTtbdHEXJKTfQ5wtfSsTHqpNZ7+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cG7lOXdeYoK/EWOb0ByXUM8o7LL/QXTRtRP9r7fzeNr2SsPnglx5QGOR2u3xtyLzq
         +/9z8neWmJLvxJn9IbHrX6FoDT2HVS9fLS+DYBK/KgGJrs4hc/rNKAe3Gia6PUH1PF
         DuiU3FnEmYEo3ffkyXG98y8h6UvIHVgChwrKPAMKTNe0gDZmRds060hnSmKWWYJUNx
         aVaoB2GlaSx6iiBc9rEBLQsTlfOOWSGE6pPsq4XEpO9Ez6sS2sYagf445F0h6fQN9E
         V/qB43D5b4bdatSJIlqKzPheZeKdgmCBy3WKCGpoVhYRUFS9t5CsyBZADZeBV6Rl6+
         chCQ8hfE8NNlQ==
Received: by mercury (Postfix, from userid 1000)
        id 3BC991066FBA; Tue, 13 Jun 2023 18:22:17 +0200 (CEST)
Date:   Tue, 13 Jun 2023 18:22:17 +0200
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
Subject: Re: [PATCH v5 02/25] PM / devfreq: rockchip-dfi: Embed desc into
 private data struct
Message-ID: <20230613162217.auqdeogoxs35fuqe@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-3-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jfxv54ui2trftfa7"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-3-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jfxv54ui2trftfa7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:30AM +0200, Sascha Hauer wrote:
> No need for an extra allocation, just embed the struct
> devfreq_event_desc into the private data struct.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/devfreq/event/rockchip-dfi.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 74893c06aa087..467f9f42d38f7 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -49,7 +49,7 @@ struct dmc_usage {
>   */
>  struct rockchip_dfi {
>  	struct devfreq_event_dev *edev;
> -	struct devfreq_event_desc *desc;
> +	struct devfreq_event_desc desc;
>  	struct dmc_usage ch_usage[RK3399_DMC_NUM_CH];
>  	struct device *dev;
>  	void __iomem *regs;
> @@ -204,14 +204,10 @@ static int rockchip_dfi_probe(struct platform_devic=
e *pdev)
> =20
>  	data->dev =3D dev;
> =20
> -	desc =3D devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
> -	if (!desc)
> -		return -ENOMEM;
> -
> +	desc =3D &data->desc;
>  	desc->ops =3D &rockchip_dfi_ops;
>  	desc->driver_data =3D data;
>  	desc->name =3D np->name;
> -	data->desc =3D desc;
> =20
>  	data->edev =3D devm_devfreq_event_add_edev(&pdev->dev, desc);
>  	if (IS_ERR(data->edev)) {
> --=20
> 2.39.2
>=20

--jfxv54ui2trftfa7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSIl7gACgkQ2O7X88g7
+pqavg//eGagVO58ELSDQgmcdseNzq5Z+G6qMNxVtz7FQsw+l/RWj2SPWK2u4g/a
sQ2WAQyE2/f/VIt3kp0evIvau8xhc77d84NCfuNOYHeWKsmnH81opNj5n5PiGAzK
iNwCRyecDGgOvar0ZqK+4RWS/+h0K//WH/dq85ssVMkkFye8GMTlYszbDWka5p98
BGQNHW7EuT8qCsni4haqU0CfW9/P0fSMPBjjygittVYlXu1Om2VCTBZpeB9uF6iQ
4hMJx9ih76+K4kQBMvxArKQOkZYBGYIUfjY97lH/YKZvrGf88Hm5RV2HiWzhN9v2
GUmxqlq/A2pyPBhlbRhZZNf/0At99qGKIUwyffLW5+6YLFgAtAysRleRmd2BpkXn
WrVsggohh0L0oaW4RWKeyT6/ZtcJ5qD9e1vari6JF0S+5+W+1CHtvEY+yQa3kekD
WVuc1HtRNeqkqjgiO9I051BOepkIrb6RTGJPi6Rsotz5QIQatW7GzhwUhhT0cDUs
f3ZcRjTvABqOfEVq4Y+ybEpcrhmlUW4hUPJjNsztf86D4mwAtUaRebpFof8NkJVn
9g3322XfKBBxRfMlnwYVeT7oNuMurn7YuyUvfydFSNyuxXYUdQEDj+Y2UQ2luBi8
IVunO3oplN9wAXOJHhYUsS//sGUeDNhcD7YwzSdxVnOs4ow2DVg=
=XyGu
-----END PGP SIGNATURE-----

--jfxv54ui2trftfa7--
