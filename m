Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA166B9A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjCNQEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjCNQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:04:37 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C982A54F6;
        Tue, 14 Mar 2023 09:04:23 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 50870E0017;
        Tue, 14 Mar 2023 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678809862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VzvoSA87yEUtF+tV1RSI+R4AM6DEhHX5TP5UQ8plIOc=;
        b=Mf7kF6fAwocwFnRSgH139yTFgwuKjJqXByVHbKuJCYcIvus7Q+p+nnSARLdf2u3y1lhBvv
        E0giuU+tv2ElM8Ui7R5XfrCYAmsz9pn9BIENV+MyJrXvGw2AQRngo8ezPizJ8dzyYKGf//
        uBsF0SwJ3i7l/7u/3bRcm9RAuaJBvI18qel5c1uTvFp6nooDaCFqtS+buXYs8sZMmQfd9B
        bFWO/Am/FKbpGfrdBFN9/nSlRmAGeNbZCp+x2GxTxCmUwgXU1ybYHcp6Jq4jbZzUzUfL4J
        y0A04F7q1E8AU2+AcGLuJmWn1v820ubStPcmoSwWyiqMV3Tn0ZGioFcKi3k5fw==
Date:   Tue, 14 Mar 2023 17:04:13 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joe Tessler <jrt@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Yong Deng <yong.deng@magewell.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 17/28] media: platform: sun6i-mipi-csi2: drop
 of_match_ptr for ID table
Message-ID: <ZBCa/SjuJj3LnZ55@aptenodytes>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <20230312131318.351173-17-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mCL4hlvlOht5eppU"
Content-Disposition: inline
In-Reply-To: <20230312131318.351173-17-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mCL4hlvlOht5eppU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Sun 12 Mar 23, 14:13, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
>=20
>   drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c:751:34: =
error: =E2=80=98sun6i_mipi_csi2_of_match=E2=80=99 defined but not used [-We=
rror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks good to me:
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Thanks !

Paul

> ---
>  drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2=
=2Ec b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
> index a220ce849b41..0851b6b4e1ff 100644
> --- a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
> +++ b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
> @@ -759,7 +759,7 @@ static struct platform_driver sun6i_mipi_csi2_platfor=
m_driver =3D {
>  	.remove	=3D sun6i_mipi_csi2_remove,
>  	.driver	=3D {
>  		.name		=3D SUN6I_MIPI_CSI2_NAME,
> -		.of_match_table	=3D of_match_ptr(sun6i_mipi_csi2_of_match),
> +		.of_match_table	=3D sun6i_mipi_csi2_of_match,
>  		.pm		=3D &sun6i_mipi_csi2_pm_ops,
>  	},
>  };
> --=20
> 2.34.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--mCL4hlvlOht5eppU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmQQmv0ACgkQ3cLmz3+f
v9F4tQf/c8SNKs/s9jh+SCYcb7LnsBT/jMWTrMfcIpvS6n8ytOrw1m5hW2dErbKo
aA+ODD31BjqVISeN9aDhSGcu7KVahfkt5vb+izqXoHS8RiRFYN2ulUcCOUwf30kn
rzD4t0QhdFmfegTq2WfFbKMcUYBY39R3BbRE3ZbyuzNT63BO0mGcuoC1ssnekVxR
4lj/mfgmMjy4+S54g6x6mwn1v3aVK9xkoCxeQo+arhJt9HieG4B0AL2R2eOyoUDa
UdVjvYd8owBs+thW9y4oY2R+SWMPrGJcZNOjljHVzwT2j7RK6VGMOiiDQDzU8iAC
hllLNwa3mx5T3fw3QMPZ+NhvyPy6Qg==
=/D8E
-----END PGP SIGNATURE-----

--mCL4hlvlOht5eppU--
