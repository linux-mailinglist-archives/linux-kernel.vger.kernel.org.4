Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799CB6B9AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjCNQFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCNQE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:04:57 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B4683F9;
        Tue, 14 Mar 2023 09:04:54 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5259EE000A;
        Tue, 14 Mar 2023 16:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678809893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c2+H7wt3YGMoJy1kI08Oezx1jFQC9X+jtLDpoYMlXss=;
        b=ohgih14REmXqm2YF0JReNRyzYFa6p8DeLxCOosBOjCP69WgwLl4SrXk9XakcXKF0kd9xwy
        iMCvNea8EW5AtPT1hqpXjAuy/hc08syMWVHptjb3t3f/VlI/gwsFTpM/GkF3gADXnCx7Sa
        heStzYo3ZsO4uFShLISuSNrbNPDvvUn/SwHvbVuXlTsShQXYB2aIQPMGAR3hifMfAzym1f
        vvExPpy3d7rvd/a5XYG/A7SnTG3bNwlMZpT47oWKVFLprwab4fy8qdRnSHXwrSrhA3RsMQ
        HriELQR7raePfh3IEayUhBeiw+dLQhEZAA6NXmgA3hYX14DWwAULtDN/5eNAeg==
Date:   Tue, 14 Mar 2023 17:04:48 +0100
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
Subject: Re: [PATCH 18/28] media: platform: sun8i-a83t-mipi-csi2: drop
 of_match_ptr for ID table
Message-ID: <ZBCbIILFhcDMIg+h@aptenodytes>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <20230312131318.351173-18-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VxKfudML6kIseEz3"
Content-Disposition: inline
In-Reply-To: <20230312131318.351173-18-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VxKfudML6kIseEz3
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
>   drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.=
c:818:34: error: =E2=80=98sun8i_a83t_mipi_csi2_of_match=E2=80=99 defined bu=
t not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks good to me:
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Thanks !

Paul

> ---
>  .../platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t=
_mipi_csi2.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t=
_mipi_csi2.c
> index cd2e92ae2293..1f0cc7b1ba47 100644
> --- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_c=
si2.c
> +++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_c=
si2.c
> @@ -826,7 +826,7 @@ static struct platform_driver sun8i_a83t_mipi_csi2_pl=
atform_driver =3D {
>  	.remove	=3D sun8i_a83t_mipi_csi2_remove,
>  	.driver	=3D {
>  		.name		=3D SUN8I_A83T_MIPI_CSI2_NAME,
> -		.of_match_table	=3D of_match_ptr(sun8i_a83t_mipi_csi2_of_match),
> +		.of_match_table	=3D sun8i_a83t_mipi_csi2_of_match,
>  		.pm		=3D &sun8i_a83t_mipi_csi2_pm_ops,
>  	},
>  };
> --=20
> 2.34.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--VxKfudML6kIseEz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmQQmyAACgkQ3cLmz3+f
v9FJ+wf/Vs+zvL4HtIgKv1HYr45R/bI+XzRQ4edLJ+86siTyMIe6/xFs4hPJqnc/
Kuop0jFCkE6h2zK7PLMPUxXZrLAThJRzd6YcMHKFN2JutU93IMSmu5Uz6R7NvnOd
a0EpxMMQ8VZw+1bth4K5ttM6ZOI7uNuhD6ipUvXq7QLifzs9UJ7392zOtafnn0Sd
vHbZ+ADRZzdCYpp4MjkR5rMxMyxBUpQ8PchA4eANo+Uq+gCKQWkoWGW9DSQ84eJN
I8+xB1hddqMNyazPRNC+r01B6GydbodK+KdDjbE8xgLGy7Q1V4NPbmV1UkH+p+Oa
pO1TUIhFzI6T+zb/bNmkmLiKPBkdmA==
=crX/
-----END PGP SIGNATURE-----

--VxKfudML6kIseEz3--
