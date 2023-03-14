Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56E36B9A91
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjCNQDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCNQDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:03:17 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240BD25BAF;
        Tue, 14 Mar 2023 09:03:08 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 02D474000A;
        Tue, 14 Mar 2023 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678809787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PfjFZ5rXzr3BIOF/GtTdCC+o1HvEGjF/qwaSlO3r/Sk=;
        b=Sf8NBWQgwLcalyizQeDgcbWTJBfhbNu7MgV+yCyqYvr7LR05IJHLkXzBdrWUIumTxANHn+
        hB2lPIAKzi7PvefYp99DwN8aiv6h6xV84w1Z29T02/TP3Z/1CoDzcU/bFRHCZs0SWhsz2N
        BhCaPOG/prYzw8L5sgOQMkCl+63t9qSqxMcHFEs+O8k1jdyCuZ+C0saia/3u12WSv1LMHF
        ZFr1XpWb4UCCE8eYDePcW5uZtlAtB+j3qPKWw2aBAQiJIRucxMto3eeBgeDn10TFk9xtTh
        H931WYtAY7hVHHwBcZoKAzGdAAp678EK8Juf6ZsL5nqnuoAnLe1pE+od7WFhKQ==
Date:   Tue, 14 Mar 2023 17:02:56 +0100
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
Subject: Re: [PATCH 16/28] media: platform: sun6i-csi: drop of_match_ptr for
 ID table
Message-ID: <ZBCasA/J2Ci6OEZw@aptenodytes>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <20230312131318.351173-16-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Il/EvjUmeeGoz4+Y"
Content-Disposition: inline
In-Reply-To: <20230312131318.351173-16-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Il/EvjUmeeGoz4+Y
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
>   drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c:401:34: error: =E2=
=80=98sun6i_csi_of_match=E2=80=99 defined but not used [-Werror=3Dunused-co=
nst-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks good to me:
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Thanks !

Paul

> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers=
/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index e3e6650181c8..187a2419da96 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -429,7 +429,7 @@ static struct platform_driver sun6i_csi_platform_driv=
er =3D {
>  	.remove	=3D sun6i_csi_remove,
>  	.driver	=3D {
>  		.name		=3D SUN6I_CSI_NAME,
> -		.of_match_table	=3D of_match_ptr(sun6i_csi_of_match),
> +		.of_match_table	=3D sun6i_csi_of_match,
>  		.pm		=3D &sun6i_csi_pm_ops,
>  	},
>  };
> --=20
> 2.34.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Il/EvjUmeeGoz4+Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmQQmrAACgkQ3cLmz3+f
v9G0UQgAgqkiTU6DCCn3MAsOxs7XlE6PTVir0WIBXYAO1uUS6eNKjIyBKLCVmKwL
iTgalBnhTb3SW6j5kYlUmMY0FdvMgQfM1W7uAX52Vk/O0NF2DHSHVLje/jSCbwR+
DqCCHKeVGRqWZxpPtb4GcbMEtY7xwooPm0SwEGeVcXo9sT9LUght/zJ3Pa6Eet2O
sSo4BVIZvlqDPwSEuiB4SLH0QJDUI8rzrtYBa2bEzstHwimw0reAtAFpT/g/QnI/
t+URgXSvKsMgPMaiOtQmsOG5c9mUKipHQVUdeIMxe4KGcIxCWz1DWXgE1FUqHaB9
1MO6S1SgXwRmWZDToL97PcRr9fqX5A==
=aAGN
-----END PGP SIGNATURE-----

--Il/EvjUmeeGoz4+Y--
