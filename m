Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251596E2927
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDNRTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDNRTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:19:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EABE3A9C;
        Fri, 14 Apr 2023 10:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3CD464960;
        Fri, 14 Apr 2023 17:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752ACC433EF;
        Fri, 14 Apr 2023 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681492775;
        bh=WPtkUT7O1f55KPb6oOybgN9Tg6E75bDydYtfxWgTN/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glJ277C+LuPAikNUJQuYBszIJGakPuY6wVnTigqVgnUZZLx8jgsOqsunB16jvAwVw
         xCQbPMtk3eozq0F6Syg82E3D3pYCNS+SAsN+9327/no12x7RMVvuOthJ+DWuzoURF8
         XFMbNiMyJpoxcPZdb5Tzoyw8WAz0C0UAXQAY0986CnthcXwkukAK6PA2gNpTGHWyrG
         s6BPKPsWED0kzCuGAsx69VjMKSbl1uExIxZSkG8U6bDRR7kYXmMGPzTkW86sgVo0d6
         ljQQCqQjpODCC5LpbL2FnDdM0y/vJR7xCdSkX9BmQLBqsM3nuGEnKeq7K9lnlmHyUC
         if+ZcIzmgCStg==
Date:   Fri, 14 Apr 2023 18:19:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
Subject: Re: [PATCH 1/9] ASoC: Add Chameleon v3 audio
Message-ID: <e64b438e-1205-4e54-b8c0-1b9a5d074752@sirena.org.uk>
References: <20230414140203.707729-1-pan@semihalf.com>
 <20230414140203.707729-2-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jeKa2KZqsPnAadPJ"
Content-Disposition: inline
In-Reply-To: <20230414140203.707729-2-pan@semihalf.com>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jeKa2KZqsPnAadPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 04:01:55PM +0200, Pawe=C5=82 Anikiel wrote:

> ---
>  .../boot/dts/socfpga_arria10_chameleonv3.dts  |  28 ++

Updates to the DT should be in a separate patch.

>  sound/soc/chameleonv3/chv3-audio.c            | 111 ++++++
>  sound/soc/chameleonv3/chv3-i2s.c              | 347 ++++++++++++++++++
>  sound/soc/chameleonv3/chv3-it68051.c          |  41 +++

The machine driver and board drivers (if needed) should also be separate
patches - one patch per driver.

> +config SND_SOC_CHV3
> +       tristate "SoC Audio support for Chameleon v3"
> +       select SND_SOC_SSM2602
> +       select SND_SOC_SSM2602_I2C
> +       help
> +         Say Y if you want to add audio support for the Chameleon v3.

It woudl be better to have a separate selectable symbol for each drier.

> +static int chv3_ssm2603_hw_params(struct snd_pcm_substream *substream,
> +			  struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *dai =3D asoc_rtd_to_codec(rtd, 0);
> +
> +	return snd_soc_dai_set_sysclk(dai, 0, 22579200, SND_SOC_CLOCK_IN);
> +}

This could be done once at init, though in general I can't tell why this
isn't audio-graph-card.

> + * Because of the two pointer design, the ring buffer can never be full.=
 With
> + * capture this isn't a problem, because the hardware being the producer
> + * will wait for the consumer index to move out of the way.  With playba=
ck,
> + * however, this is problematic, because ALSA wants to fill up the buffer
> + * completely when waiting for hardware. In the .ack callback, the driver
> + * would have to wait for the consumer index to move out of the way by
> + * busy-waiting, which would keep stalling the kernel for quite a long t=
ime.
> + *
> + * The workaround to this problem is to "lie" to ALSA that the hw_pointer
> + * is one period behind what it actually is (see chv3_dma_pointer). This
> + * way, ALSA will not try to fill up the entire buffer, and all callbacks
> + * are wait-free.

Would it not be better to just lag by one (or some small number of)
sample instead?

> +static irqreturn_t chv3_i2s_isr(int irq, void *data)
> +{
> +	struct chv3_i2s_dev *i2s =3D data;
> +	u32 reg;
> +
> +	reg =3D readl(i2s->iobase_irq + I2S_IRQ_CLR);
> +	if (!reg)
> +		return IRQ_NONE;
> +
> +	if (reg & I2S_IRQ_RX_BIT)
> +		snd_pcm_period_elapsed(i2s->rx_substream);
> +
> +	if (reg & I2S_IRQ_TX_BIT) {
> +		if (i2s->tx_ready)
> +			snd_pcm_period_elapsed(i2s->tx_substream);
> +		i2s->tx_ready =3D 1;
> +	}
> +
> +	writel(reg, i2s->iobase_irq + I2S_IRQ_CLR);
> +
> +	return IRQ_HANDLED;
> +}

Really we should only ack things that were handled here and report
appropriately, that's defensive against bugs causing interrupts to
scream and shared interrupts.

> +	dev_info(&pdev->dev, "probed\n");

This is just noise, remove it.

> +++ b/sound/soc/chameleonv3/chv3-it68051.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/module.h>
> +#include <sound/soc.h>
> +
> +static struct snd_soc_dai_driver it68051_dai =3D {
> +	.name =3D "it68051-hifi",
> +	.capture =3D {
> +		.stream_name =3D "Capture",
> +		.channels_min =3D 8,
> +		.channels_max =3D 8,
> +		.rates =3D SNDRV_PCM_RATE_CONTINUOUS,
> +		.formats =3D SNDRV_PCM_FMTBIT_S32_LE,
> +	},
> +};
> +
> +static const struct snd_soc_component_driver soc_component_dev_it68051 =
=3D {
> +};

This looks awfully like it's a generic CODEC driver for a device with no
control available, why is it not being added as a CODEC?

--jeKa2KZqsPnAadPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ5iyAACgkQJNaLcl1U
h9CRYwf/eql00ml/jymz2c8qytH+GabFGfmGxl54E6dEJDIlm1F7zjcjN3wBFv0f
SlcAt0eEc638oW3fTS6H9ptaC5QOPuldeDPDDH2XNizJ0NrCghPv41FANC3qG+GS
7z21BGGnz92BI1a4TdHfgLLw3ux7kOjrdPL07eRMWyh0A2aeyfkeIlb/rVMlxt9j
20oLEnVHJBVlarEcSmTl4ibfYE9zKajlYCHuM5mzjvIHCc/bFqWSxKF55Q2IkVtr
SEbtZKU3W7/SOnKAuwEKMWwkXhbyrsxVQMjmGvXsSDu1w/ew6N28/Pksav90v06K
j2zejPnplf0eCJBmxfvktdY0p1JQUQ==
=aTr6
-----END PGP SIGNATURE-----

--jeKa2KZqsPnAadPJ--
