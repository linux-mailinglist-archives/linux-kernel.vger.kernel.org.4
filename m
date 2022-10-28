Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E339611761
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiJ1QSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJ1QSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:18:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115EC17E03;
        Fri, 28 Oct 2022 09:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA636B82B07;
        Fri, 28 Oct 2022 16:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5BBC433C1;
        Fri, 28 Oct 2022 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666973867;
        bh=MPN/lPTpCXpy+0PRxdY8GXPpytF3KfULUfkRjnBwUpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4jN1aqrPtVpL4VSh4NG5IKIR0V5D/7XGlmxImplMYfIF2nvv4TCI3FNBmihmGZEx
         V9fP0Zer515uPmI0ZDdCMLln/GOWnTRqQLKZua/VEzttslPumufiygnfvpQkIRwWcN
         TFV8I7d6Xb1VlRUUJUGFLovN1ITdLhP++IPi3/9/Kzb4u/eEdSZhq4pEuihKYZtYWY
         oSwO3C8T7BU3xoCKInl61SsWHX7yvHNbaSMiProzM44CvwTnhalM6/ts6sIf7QvvPU
         nFmLKoj7eJeHyGNZJqrQcw5BQOiUVpp/hiTtP1rzYhOLWD7zppUH9YgIc8Xpo08WMx
         HBiUwucVzAr2A==
Date:   Fri, 28 Oct 2022 17:17:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v1 2/2] ASoC: mediatek: mt8186-rt5682: Modify machine
 driver for two DMICs case
Message-ID: <Y1wApOeV7OoQzkt5@sirena.org.uk>
References: <20221028160733.1390230-1-ajye_huang@compal.corp-partner.google.com>
 <20221028160733.1390230-3-ajye_huang@compal.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cw3lWstGeVw1b8Ns"
Content-Disposition: inline
In-Reply-To: <20221028160733.1390230-3-ajye_huang@compal.corp-partner.google.com>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cw3lWstGeVw1b8Ns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 29, 2022 at 12:07:33AM +0800, Ajye Huang wrote:

> +static const char * const dmic_mux_text[] = {
> +	"FrontMic",
> +	"RearMic",
> +};

> +	ret = snd_soc_dapm_new_controls(&card->dapm, dmic_widgets,
> +					ARRAY_SIZE(dmic_widgets));
> +	if (ret) {
> +		dev_err(card->dev, "DMic widget addition failed: %d\n", ret);
> +		/* Don't need to add routes if widget addition failed */
> +		return ret;
> +	}

> +       if (of_property_read_bool(pdev->dev.of_node, "dmic-gpios")) {
> +               mach_priv->dmic_sel = devm_gpiod_get_optional(&pdev->dev,
> +                                                       "dmic", GPIOD_OUT_LOW);

My prior comments about it being nicer to make the addition of the
control depend on the property being there and the description of the
options configurable do stand (I appreciate that the other driver might
not have done this which was probably an oversight).

Also do we really need the of_property_read_bool() there?  I'd have
expected that devm_gpiod_get_optional() would be handling that for us.

--Cw3lWstGeVw1b8Ns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNcAKQACgkQJNaLcl1U
h9Dszgf/VXVqdAt6y4Tux5PXD9zW+9i23ZFaCs1y/E0zse4AyVDDvo+BtL+IrkcL
z9i6r9EqrQuX6SBUCup87nUu3s4aIwtlCvH3Li2znhZWKfY1PEN7xWA7IB6eZDrp
nWBO4wPITY3ftUoLGTEpv2ZgQ3QIFm4B/rQpNEkfxbwF91kv/JPK2VzAL2Q0zbck
ahvvraHhPGI+2MkDjcufrlzqUke/MteuKH+zKgZjDLYDicXFaj0gHhS/0n7s46Nw
Uq2pcLsOFtU8yBm9LVBeC2CDk134qJH4h81Pen/yF/v2+7Pyz5uJD1X2PqXqVRDF
Et13wKZD5oDLUdFdlZhs82B5gcdQ4g==
=Qv/e
-----END PGP SIGNATURE-----

--Cw3lWstGeVw1b8Ns--
