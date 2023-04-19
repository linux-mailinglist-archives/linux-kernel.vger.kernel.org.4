Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A396E7ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjDSPsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjDSPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:48:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D1A5CD;
        Wed, 19 Apr 2023 08:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D2FC63CB5;
        Wed, 19 Apr 2023 15:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5E8C433EF;
        Wed, 19 Apr 2023 15:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681919221;
        bh=wr7CnKmrpEbT4OAdlGdrtt1dX2ep3MIz5NvcC74tElk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJAd3I0DLoZLoH1POP9v7XG5IlW2WgDl6mSe1m69HJTOd59MF9OJu8OrzUqDbmN4j
         w/4GSfr55HUUap7woocdXuAZZsRfhzRmZIXcG/zaqU168is0zE4H8npE7oZ0S//w7d
         RngzbEvxCcr1rDnTVp05+xvAKuq3aeqmf4EE43F4aYkSNwO5imiFC0x/JsCX3JCdjy
         wUOsEvoAvq/zFE0ZxogTfphX+7ddXKXhHtlQAA1LlL5Anok68/hvyLl1SPU8oNqhze
         QarlSV9ioerltHUA4Bw6B77czgyvgZmvfHkzKXXV+p+AHCu3fdmb+n0jIwC/IaPLxr
         xXmjEEQf0Rbdg==
Date:   Wed, 19 Apr 2023 17:46:57 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH v2 1/4] spi: s3c64xx: changed to PIO mode if there is no
 DMA
Message-ID: <20230419154657.h2kp7ouddy6m7l4r@intel.intel>
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
 <CGME20230419062755epcas2p1370c1ca60d88d6b114a7c7c1de3f15c0@epcas2p1.samsung.com>
 <20230419060639.38853-2-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cckin4xh754itsjt"
Content-Disposition: inline
In-Reply-To: <20230419060639.38853-2-jaewon02.kim@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cckin4xh754itsjt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jaewon,

On Wed, Apr 19, 2023 at 03:06:36PM +0900, Jaewon Kim wrote:
> Polling mode supported with qurik if there was no DMA in the SOC.

I think you want to say here that "Through quirks we choose to
use polling mode whenever there is no DMA in the SoC".

> However, there are cased where we cannot or do not want to use DMA.

/cased/cases/

> To support this case, if DMA is not set, it is switched to polling mode.

You haven't really described what you are doing here... you could
just write something like: "Use DTS properties to select wether
to use polling or DMA mode."

Side note, please use the imperative form when you want to
describe what you have done to fix the issue.

> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c                 | 8 ++++++--
>  include/linux/platform_data/spi-s3c64xx.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 71d324ec9a70..273aa02322d9 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -19,7 +19,6 @@
>  #include <linux/platform_data/spi-s3c64xx.h>
> =20
>  #define MAX_SPI_PORTS		12
> -#define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
>  #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
>  #define AUTOSUSPEND_TIMEOUT	2000
> =20
> @@ -116,7 +115,7 @@
>  #define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
> =20
>  #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
> -#define is_polling(x)	(x->port_conf->quirks & S3C64XX_SPI_QUIRK_POLL)
> +#define is_polling(x)	(x->cntrlr_info->polling)
> =20
>  #define RXBUSY    (1<<2)
>  #define TXBUSY    (1<<3)
> @@ -1067,6 +1066,11 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_=
dt(struct device *dev)
>  		sci->num_cs =3D temp;
>  	}
> =20
> +	if (!of_find_property(dev->of_node, "dmas", NULL)) {
> +		dev_warn(dev, "cannot find DMA, changed to PIO mode\n");
> +		sci->polling =3D 1;

	sci->polling =3D true;

But it could be even better:

	sci->polling =3D !of_find_property(dev->of_node, "dmas", NULL));

and you get rid of the dev_warn() that is not required.

Andi

--cckin4xh754itsjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQScDfrjQa34uOld1VLaeAVmJtMtbgUCZEAM8AAKCRDaeAVmJtMt
brz+AP9FdshhlbJoiOlwJlMu/QXvgAitd0xQA1alj6GOQtyK7gD/XNPMbYrf1gEO
fI5feLcKerXaFWVZVDkntoCe8eGsLA0=
=UwH6
-----END PGP SIGNATURE-----

--cckin4xh754itsjt--
