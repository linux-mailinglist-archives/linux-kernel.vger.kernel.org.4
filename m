Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AF0611031
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJ1L6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJ1L6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526C31D2F62;
        Fri, 28 Oct 2022 04:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4F1062804;
        Fri, 28 Oct 2022 11:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEA9C433C1;
        Fri, 28 Oct 2022 11:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666958285;
        bh=8RLwq8ki1h1dxKk0NdgzIrd5GZ/cNm4zsawgcittnDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BWh7/JiVpgOVYE3svGcPrILvMKVCQg3xZW8Dx1t5Vnlwo5bRVQtPS1IVydoks8WcW
         lpYJnV4vm2/NMmsqzlOMWtPyPPxKpGxM7G8hVBa8V639B3ajbTprSCDH+J7eU4lDeS
         jGB1XWSy8JHRPMH+DsizQeG5clgASCJzCwLXH1TaM3uOH3slehxOchh6B8zS9A6u67
         GNZYlLS7Dusr/UKFlc6lvWQP97aFIY1bsG24nsICYL9H0Hrc35nc4Q5Mcpvuk/ibbo
         yMvKFqTB06ed2OZpzYw7u3Ze/1yHHwOOHhw2xZlhHwUXQxiflZEGfoplCkwvTuaQ7H
         3BkQfVHPVhF1Q==
Date:   Fri, 28 Oct 2022 12:57:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, robh@kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        angelogioacchino.delregno@collabora.corp-partner.google.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v1 2/2] ASoC: dmic: Add optional dmic selection
Message-ID: <Y1vDxtdNGURAT850@sirena.org.uk>
References: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
 <20221028102450.1161382-3-ajye_huang@compal.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GFVHecDBq3J8AQvA"
Content-Disposition: inline
In-Reply-To: <20221028102450.1161382-3-ajye_huang@compal.corp-partner.google.com>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GFVHecDBq3J8AQvA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 06:24:50PM +0800, Ajye Huang wrote:

> +	dmic->dmic_sel =3D devm_gpiod_get_optional(component->dev,
> +						"dmic_sel", GPIOD_OUT_LOW);
> +	if (IS_ERR(dmic->dmic_sel))
> +		return PTR_ERR(dmic->dmic_sel);
> +
>  	snd_soc_component_set_drvdata(component, dmic);
> =20
>  	return 0;
> @@ -125,10 +172,15 @@ static const struct snd_soc_dapm_widget dmic_dapm_w=
idgets[] =3D {
>  			       SND_SOC_NOPM, 0, 0, dmic_aif_event,
>  			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
>  	SND_SOC_DAPM_INPUT("DMic"),
> +	SND_SOC_DAPM_MIC("DMIC", NULL),
> +	SND_SOC_DAPM_MUX("Dmic Mux", SND_SOC_NOPM, 0, 0, &dmic_mux_control),

If we are doing this then adding the mux needs to be conditional on
having the GPIO, without the GPIO the control is at best confusing to
users.

--GFVHecDBq3J8AQvA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNbw8YACgkQJNaLcl1U
h9CYCgf+MWaEyyoOOBqvu/7ws9X2k2O/7vrpIy4ywmtMQiwtox/kaUZhHBVGeOpA
mLhySDFOd/cfzRbOQoGr0UU3//+cBLhPNiIIynPX9yuPJELkezuH9r4ncjOEfilv
97kU9XGGND6BGzLYmn99vmc2x7CAtVQKQsY8tEhMWD9SMaWnBk0ynqHZ9BpiKjhy
yw8XAkIz+VDE0SbTzRxk/YH5Z/CeQfVrM+CAjUaubhQ1615qZgWL20/dlq/SzX3Y
CQs/QkiA+U00mcNy/n99wWCxclIh0v8FHWhvqkIMxzNmoEhcemnG5UMUTa8O68WC
69KDHTwoPpaO/X7k/S7WmN73wEPV+w==
=iidS
-----END PGP SIGNATURE-----

--GFVHecDBq3J8AQvA--
