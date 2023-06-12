Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC9672CEBA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbjFLSwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjFLSwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:52:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AA7118
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D298661FE8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BCAC433D2;
        Mon, 12 Jun 2023 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686595938;
        bh=pnRmShH3zQPplLb9mvpVVNrWQAOBdcEg/Pe89/g7yo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ndlyxcr8M5ZZZHhtDAKNpxVr7Y7goaKcu4uzsdw30OYeV6XVNvjqwpaJFKB8PymCy
         MQJmgL1rsrHjMdj9FKVLF9zf1TbsYeZm2/RHQNL1CfwhaC7wrdmSpA7DJMAPa952y1
         +AYPUMpXpztFp5l+ECrupKh+RAglfitV4CNENev2W3sPTwS45E5PoHqFcgJ965drjN
         /lTrJSYGFZYwzo930hShNSFJlOo++jz1Kndd1CSgKHixoT+p0UEay360mggpHhCWRm
         b1o6xfs/Zb9KJ3AvH5ryhE7cZNvZy6N834NzMluMoGD8RwfMlOog63P+Zb/pFugTK3
         dwv5gAhbDbHow==
Date:   Mon, 12 Jun 2023 19:52:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YingKun Meng <mengyingkun@loongson.cn>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
Subject: Re: [ PATCH v2 1/3] ASoC: Add support for Loongson I2S controller
Message-ID: <8b069919-664d-4329-9168-ec8f26fef647@sirena.org.uk>
References: <20230612085318.3039485-1-mengyingkun@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7mJvWglGipw14bY8"
Content-Disposition: inline
In-Reply-To: <20230612085318.3039485-1-mengyingkun@loongson.cn>
X-Cookie: If it heals good, say it.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7mJvWglGipw14bY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 04:53:18PM +0800, YingKun Meng wrote:

> Loongson I2S controller is found on 7axxx/2kxxx chips from loongson,
> it is a PCI device with two private DMA controllers, one for playback,
> the other for capture.
>=20
> The driver supports the use of DTS or ACPI to describe device resources.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306060223.9hdivLrx-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202306060320.Sphw0ihy-lkp@i=
ntel.com/

These don't really make sense for a new driver.

> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Loongson-2K I2S master mode driver
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */

Please make the entire comment a C++ one so things look more
intentional.  You might also want to update the copyright year if there
was any substantial work on the driver recently.

> +		/* Enable master mode */
> +		regmap_update_bits(i2s->regmap, LS_I2S_CTRL, I2S_CTRL_MASTER,
> +				   I2S_CTRL_MASTER);
> +		if (i2s->rev_id =3D=3D 1) {
> +			ret =3D regmap_read_poll_timeout_atomic(i2s->regmap,
> +						LS_I2S_CTRL, val,
> +						val & I2S_CTRL_CLK_READY,
> +						10, 2000);
> +			if (ret < 0)
> +				dev_warn(dai->dev, "wait BCLK ready timeout\n");
> +		}

Ideally you'd have a set_dai_fmt() operation and support both clock
provider and consumer mode. =20

> +	if (i2s->rev_id =3D=3D 0) {

> +	} else if (i2s->rev_id =3D=3D 1) {

> +	} else
> +		dev_err(i2s->dev, "I2S revision invalid\n");
> +

This looks like a switch statement.

> +static int loongson_i2s_set_dai_sysclk(struct snd_soc_dai *dai, int clk_=
id,
> +				       unsigned int freq, int dir)
> +{
> +	struct loongson_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> +
> +	i2s->sysclk =3D freq;
> +
> +	return 0;
> +}

Should this be integrated with the clock API rather than just using the
ASoC specific stuff - where does this sysclk come from?  I do note that
the PCI driver appears to have a fixed clock...

> +void loongson_i2s_init(struct loongson_i2s *i2s)
> +{
> +	if (i2s->rev_id =3D=3D 1) {
> +		regmap_write(i2s->regmap, LS_I2S_CTRL, I2S_CTRL_RESET);
> +		udelay(200);
> +	}
> +}

What's this for?  I'd expect initialising the hardware to be handled
internally within the driver but this is semi-exported?

> diff --git a/sound/soc/loongson/loongson_i2s_pci.c b/sound/soc/loongson/l=
oongson_i2s_pci.c
> new file mode 100644
> index 000000000000..f09713b560e9
> --- /dev/null
> +++ b/sound/soc/loongson/loongson_i2s_pci.c
> @@ -0,0 +1,500 @@

Please split the PCI driver into a separate patch to keep the individual
reviews smaller.

> +static int loongson_pcm_trigger(struct snd_soc_component *component,
> +				struct snd_pcm_substream *substream, int cmd)
> +{

> +	switch (cmd) {

> +	default:
> +		ret =3D -EINVAL;
> +	}

Missing break; here.

> +	/* initialize dma descriptor array */
> +	mem_addr =3D runtime->dma_addr;
> +	order_addr =3D prtd->dma_desc_arr_phy;
> +	for (i =3D 0; i < num_periods; i++) {
> +		desc =3D &prtd->dma_desc_arr[i];

We didn't validate that the number of periods fits in the array.

> +	if (num_periods > 0) {
> +		desc =3D &prtd->dma_desc_arr[num_periods - 1];
> +		desc->order =3D lower_32_bits(prtd->dma_desc_arr_phy | BIT(0));
> +		desc->order_hi =3D upper_32_bits(prtd->dma_desc_arr_phy);
> +	}

This is always true, right?

> +       ret =3D request_irq(dma_data->irq, loongson_pcm_dma_irq,
> +                         IRQF_TRIGGER_HIGH, LS_I2S_DRVNAME, substream);

Does it really make sense to request and free the interrupt when the
stream is running?  It's generally better to just request the interrupt
once during probe(), that way we know we've got all the resources we
need.  If we do need to allocate/free all the time a comment explaining
why would be good so people don't go trying to fix this.

> +	ret =3D pci_request_region(pdev, BAR_NUM, LS_I2S_DRVNAME);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request regions failed %d\n", ret);
> +		return ret;
> +	}

pcim_iomap_regions()?  At the minute you'll free the region before devm
frees the regmap which is probably harmless but not ideal.

--7mJvWglGipw14bY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSHaVwACgkQJNaLcl1U
h9DJGAf9Ep6CwNQYredDySttL400B4S/REQ1oaOQqJw+0WmP0KmOF6PXeIQuDzAV
zinJzrHhykdbNGHx6aW41IrCo8wxsctwRLlWQqfwzRcnGO0R8TnknoF1M39bLKWn
A27hmnq0PZfvdWtRC3PhosiYhz+vav/1iU4fNxGyMHKYfTzFpZisJrOTO+xg40DI
x+CKOEzpioj1QQHuOQQLGoGV3P9QXVsdkqRRG8mO2p7WgHsiIJSNpfvc/X0JmpqY
O3YTCbzqbfst2o+QCJF7x06SLIQPg9j19MOFqX239VS+HGfnRITTvRQPTDMjrvL7
FxbV/wCFf1KXQYFxyhrYLK3E3BIufw==
=vj4u
-----END PGP SIGNATURE-----

--7mJvWglGipw14bY8--
