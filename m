Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783CB5FEDF8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJNMXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJNMX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:23:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5051CCCDF;
        Fri, 14 Oct 2022 05:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 196D461B0A;
        Fri, 14 Oct 2022 12:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723E5C433C1;
        Fri, 14 Oct 2022 12:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665750206;
        bh=opCSM6SmwEXXy81XxgCiHIRAX7jERw0sRlnq6ZysCP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjJ+enQbW9TnWdjb3oJaHBD6RoX7wLURWXKXxLiCa/MZxEX1r5jBtlkY2ORXb8a2X
         ITjqtYQZ7WdEtjVY8s//vXlmwvFYGsiGRbFhf4hEyldBCpUtjYm6YwpIVTE+aMmkmR
         l+lTZ72fDMDH2K3edklSJI+kU1wGae4aMQDs2jpmiLNzXFPO+qf2XmnfT9ifrWxlDQ
         MDGbq97IwwuGztP80lX1/Y2mmhbeMpyvquW6xxbyo7DvJ8iAbDsgTf8sHuv3RtScZa
         r4sdIvzFblIjmKXJG55S47K3HbDL6dt1yJ8znKt4dvUyZm29F7LEDhpbrDH26fSGyz
         Rw55wNMAsPN7g==
Date:   Fri, 14 Oct 2022 13:23:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 4/6] ASoC: samsung: fsd: Add FSD soundcard driver
Message-ID: <Y0lUuK0V8qVnr+LW@sirena.org.uk>
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
 <CGME20221014104904epcas5p4f458182cc9ac9c223d9a25566f3dd300@epcas5p4.samsung.com>
 <20221014102151.108539-5-p.rajanbabu@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Co4Q+wAEW5EdCUvd"
Content-Disposition: inline
In-Reply-To: <20221014102151.108539-5-p.rajanbabu@samsung.com>
X-Cookie: There's only one everything.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Co4Q+wAEW5EdCUvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 14, 2022 at 03:51:49PM +0530, Padmanabhan Rajanbabu wrote:

> +++ b/sound/soc/samsung/fsd-card.c
> @@ -0,0 +1,349 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ALSA SoC Audio Layer - FSD Soundcard driver
> + *
> + * Copyright (c) 2022 Samsung Electronics Co. Ltd.
> + *	Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>

Please make the entire comment a C++ one so things look more
intentional.

> +	if (link->dai_fmt & SND_SOC_DAIFMT_CBC_CFC) {
> +		cdclk_dir = SND_SOC_CLOCK_OUT;
> +	} else if (link->dai_fmt & SND_SOC_DAIFMT_CBP_CFP) {
> +		cdclk_dir = SND_SOC_CLOCK_IN;
> +	} else {
> +		dev_err(card->dev, "Missing Clock Master information\n");
> +		goto err;
> +	}

We're trying to modernise the langauge around clock providers, please
use that term rather than the outdated terminology here.

> +	if (priv->tdm_slots) {
> +		ret = snd_soc_dai_set_tdm_slot(cpu_dai, false, false,
> +				priv->tdm_slots, priv->tdm_slot_width);
> +		if (ret < 0) {
> +			dev_err(card->dev,
> +				"Failed to configure in TDM mode:%d\n", ret);
> +			goto err;
> +		}
> +	}

Just set things once on probe if they don't depend on the configuration,
it's neater and marginally faster if nothing else.

> +	if (of_property_read_bool(dev->of_node, "widgets")) {
> +		ret = snd_soc_of_parse_audio_simple_widgets(card, "widgets");
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	/* Add DAPM routes to the card */
> +	if (of_property_read_bool(node, "audio-routing")) {
> +		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}

Just fix the library functions to handle missing properties gracefully,
every card is going to need the same code here.

--Co4Q+wAEW5EdCUvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNJVLcACgkQJNaLcl1U
h9CvIgf/SAQ8DRxcD5wyuIRH7gQqZTjvWFCF4H6llSklkqzQZj83G/C8GylQqjhN
jrtgCtomymyJdlg83NY44CxMxDH4VQAVAp54N88D2AZFaxYruFasSR3MgnpdfWrX
of1VocuEnjeFu1wyBl2GZVh/yfc3ITDMtaSd3ogwwtMGCi8IOBD1fkVd/lgc9gs/
eOFEAlIsBA5jcD5PFPXjCDAHerOLxJxAnYuv5WQ1G6mnRcos8Lrb2A6hhoSn/Qed
yb9A6MoZ7oagUm2AHQd/XL9UDbmmWz+te2WGLltWPz4WkxWMtu5ySrjiE/uhD9TU
IriKVezxcSSpWV2/YbvZ5NFYwtLCvQ==
=NM3V
-----END PGP SIGNATURE-----

--Co4Q+wAEW5EdCUvd--
