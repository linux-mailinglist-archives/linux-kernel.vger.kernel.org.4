Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BE9717867
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjEaHiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjEaHh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:37:58 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7A3C5;
        Wed, 31 May 2023 00:37:56 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685518675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=crOpwvqDjgCv5Iq8u/sJqrtyV1k8VhIgkmZfw96TObI=;
        b=MHE4kD9uYhdo+tdxmqhAEUgebBeDxykmVLMZMpMzMKAU+RSHEtHsdEpyv8WH2nOfRbROJr
        Y4D0LRK6hgoph8i/s6COIQiPi9BJZnBikCP7W5/Z3YzLxkZ72N6SEo89gJ5UoVke215o4F
        X10/u/gr7XzzpzAMUaurHTFaYs+9d7guyErtIcig2Yw56lh42sZmsveZQbELzfbN4JtwUT
        GxK7Y6gzs+OsXhKLTjd5MhkXA1REa3dPnxNk9Oio55QARHSrAFJ+VGJrLIHuSsr1CaXsqT
        pv5qPw2364H8JKMvP07nzgesCjsZwf+KpmwQubOnFaWmr+e2LIifmQmTpQ48kA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88D6DFF808;
        Wed, 31 May 2023 07:37:52 +0000 (UTC)
Date:   Wed, 31 May 2023 09:37:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        arnd@arndb.de, daniel.lezcano@linaro.org,
        neil.armstrong@linaro.org, f.fainelli@gmail.com,
        christophe.kerello@foss.st.com, liang.yang@amlogic.com,
        jdelvare@suse.de, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: rawnand: marvell: add support for AC5 SoC
Message-ID: <20230531093752.17fbeb1b@xps-13>
In-Reply-To: <20230531025847.1284862-3-chris.packham@alliedtelesis.co.nz>
References: <20230531025847.1284862-1-chris.packham@alliedtelesis.co.nz>
        <20230531025847.1284862-3-chris.packham@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

chris.packham@alliedtelesis.co.nz wrote on Wed, 31 May 2023 14:58:47
+1200:

> Add support for the AC5/AC5X SoC from Marvell. The NFC on this SoC only
> supports SDR modes up to 3.

Strange!

But alright, I'm okay with the series.

I'll put it aside waiting for all binding changes to be acked (yaml
conversion series + this one) and then I'll apply everything.

> Marvell's SDK includes some predefined values for the ndtr registers.
> These haven't been incorporated as the existing code seems to get good
> values based on measurements taken with an oscilloscope.

Good :)

By the way did you sort the timings question on 8k?

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/mtd/nand/raw/Kconfig        |  2 +-
>  drivers/mtd/nand/raw/marvell_nand.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index b523354dfb00..0f4cbb497010 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -160,7 +160,7 @@ config MTD_NAND_MARVELL
>  	  including:
>  	  - PXA3xx processors (NFCv1)
>  	  - 32-bit Armada platforms (XP, 37x, 38x, 39x) (NFCv2)
> -	  - 64-bit Aramda platforms (7k, 8k) (NFCv2)
> +	  - 64-bit Aramda platforms (7k, 8k, ac5) (NFCv2)
> =20
>  config MTD_NAND_SLC_LPC32XX
>  	tristate "NXP LPC32xx SLC NAND controller"
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
> index 30c15e4e1cc0..b9a8dd324211 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -375,6 +375,7 @@ static inline struct marvell_nand_chip_sel *to_nand_s=
el(struct marvell_nand_chip
>   *			BCH error detection and correction algorithm,
>   *			NDCB3 register has been added
>   * @use_dma:		Use dma for data transfers
> + * @max_mode_number:	Maximum timing mode supported by the controller
>   */
>  struct marvell_nfc_caps {
>  	unsigned int max_cs_nb;
> @@ -383,6 +384,7 @@ struct marvell_nfc_caps {
>  	bool legacy_of_bindings;
>  	bool is_nfcv2;
>  	bool use_dma;
> +	unsigned int max_mode_number;
>  };
> =20
>  /**
> @@ -2376,6 +2378,9 @@ static int marvell_nfc_setup_interface(struct nand_=
chip *chip, int chipnr,
>  	if (IS_ERR(sdr))
>  		return PTR_ERR(sdr);
> =20
> +	if (nfc->caps->max_mode_number && nfc->caps->max_mode_number < conf->ti=
mings.mode)
> +		return -EOPNOTSUPP;
> +
>  	/*
>  	 * SDR timings are given in pico-seconds while NFC timings must be
>  	 * expressed in NAND controller clock cycles, which is half of the
> @@ -3073,6 +3078,13 @@ static const struct marvell_nfc_caps marvell_armad=
a_8k_nfc_caps =3D {
>  	.is_nfcv2 =3D true,
>  };
> =20
> +static const struct marvell_nfc_caps marvell_ac5_caps =3D {
> +	.max_cs_nb =3D 2,
> +	.max_rb_nb =3D 1,
> +	.is_nfcv2 =3D true,
> +	.max_mode_number =3D 3,
> +};
> +
>  static const struct marvell_nfc_caps marvell_armada370_nfc_caps =3D {
>  	.max_cs_nb =3D 4,
>  	.max_rb_nb =3D 2,
> @@ -3121,6 +3133,10 @@ static const struct of_device_id marvell_nfc_of_id=
s[] =3D {
>  		.compatible =3D "marvell,armada-8k-nand-controller",
>  		.data =3D &marvell_armada_8k_nfc_caps,
>  	},
> +	{
> +		.compatible =3D "marvell,ac5-nand-controller",
> +		.data =3D &marvell_ac5_caps,
> +	},
>  	{
>  		.compatible =3D "marvell,armada370-nand-controller",
>  		.data =3D &marvell_armada370_nfc_caps,


Thanks,
Miqu=C3=A8l
