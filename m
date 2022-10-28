Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6541611017
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJ1L40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJ1L4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B96F1C8D48;
        Fri, 28 Oct 2022 04:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 351F86268C;
        Fri, 28 Oct 2022 11:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB70CC433C1;
        Fri, 28 Oct 2022 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666958182;
        bh=GajkIQuzrXIIDnBsaZvhN+ecuRXsqOWV5zsQ+wIwrZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AE0J/FU24uj2MBHn9UKB06iauoLTCYWYWPC81msDpshmPXPB1LYtdXl7XVj+je7Yq
         DP27Q6rkf7r2lxMHPbGNAIMajkevaZ8CCXnVsYDBri2b0fKA4SRJpaNzwYoESzV0KP
         6nntRtx11lz4UmsbkZP7v11aLyKiCzKvzNgmuYcf6Gkt2QULmMor4SwKdS72vmSUpG
         +IxnnVOR1glgwyjZ1kyD/RVVRMDrsCzSwQxCfEcuc00fgMQGCW2jWpN1fZEVq5WnE0
         waVTUbiny3BfTG59K91selF+MDJPuov8GFSFskn2PCd+OUJvLWucAc/6vXv9E1efk7
         BW8uFfueYPmwQ==
Date:   Fri, 28 Oct 2022 12:56:16 +0100
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
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: Document dmic_sel-gpios
 optional prop for two DMICs case
Message-ID: <Y1vDYNOwZNOco1hq@sirena.org.uk>
References: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
 <20221028102450.1161382-2-ajye_huang@compal.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M+JJnzUDip9rx8JE"
Content-Disposition: inline
In-Reply-To: <20221028102450.1161382-2-ajye_huang@compal.corp-partner.google.com>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M+JJnzUDip9rx8JE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2022 at 06:24:49PM +0800, Ajye Huang wrote:
> Document dmic_sel-gpios optional prop for switching between two DMICs.
> Ex, the GPIO can control a MUX to select Front or Rear dmic.

> +  dmic_sel-gpios:
> +    maxItems: 1
> +    description: GPIO for switching between DMICs, ex Front/Rear dmic
> +

If we're going to do this we should also allow the bindings to label the
mics appropriately so that the control presented can reflect the actual
hardware.  It does feel like it might fit better to do this separately
to the DMIC driver as a mux between the DMIC and the DAI it's connected
to but equally with the way things are at the minute that feels like
it's probably disproportionate effort.

--M+JJnzUDip9rx8JE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNbw18ACgkQJNaLcl1U
h9A7JQf+MkRMavqrw/+lt93KD/xfx0zvIziXhJJ3+MlsSpvWpJmxEX1nDEEu2I2g
C3wW4SWf4Um/Y1k/eHZYy/KpGJe0ceGE3pmMdrZynpXT2CIWFnGAyLkZAtlRajY9
3wn7V68sQ/A+py5pQOPY1/uDrOkQH2NwHjR9lLvUE8uT/yF1fKmDSMfQTPqHXIVJ
osuU/f+QuIC6JRvu1KcLLk4k0e+Urkm8Y6rck9P3qmbSFM2JqvTm7ZGIIFnmIakd
U4r5I/ex9DN8Qnc002dKHTVM+1Q3AmE6TCnrtnh6F009WvQV7XFLiFQck1b7P5HQ
CIoF98dhQQ/K07h+K2mhTr9xu1ScjQ==
=QJF2
-----END PGP SIGNATURE-----

--M+JJnzUDip9rx8JE--
