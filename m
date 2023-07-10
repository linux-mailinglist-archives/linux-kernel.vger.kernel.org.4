Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D894E74D47B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjGJLXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjGJLXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3FBE1;
        Mon, 10 Jul 2023 04:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21B6460F4B;
        Mon, 10 Jul 2023 11:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F29C433C7;
        Mon, 10 Jul 2023 11:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688988188;
        bh=rVbOiKgyxND9mKZk3rAKjAS4exnyG60MuJg/qoml1Vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmQJc/tPCMy3i5v1VlHdRroye/CciPC/ZvFOKcppf3TZf0qRJ3dgdRYwmDVOMOmqP
         VHTHnUz3SjT2CkGo2po+jFLM51kzErpdYTDzbIh1ssyixtC39WoS5AEx1AHhOh2rUT
         oGH0Cj/eImkEiRwQY+a6G/4uTBojRaP1c3PpTvWdlPa8OmIjqYJiqIt27qBeoOyByD
         uIezS9sRdsa2l0+EXR9NmvWwdDucaVOT+HG9neus16SKNTI7aq5f6UxW++970eT5gb
         zfoX4LNe9GA9UuIFwotHUiqYP63tgZEO9J8trRSJc2+FmmGG2Hl/AKVEk1ykYfoY0k
         6E9c0qXH0JqVA==
Date:   Mon, 10 Jul 2023 12:22:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>, Kris Bahnsen <kris@embeddedts.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 4/8] spi: Get rid of old SPI_MASTER_NO_.X and
 SPI_MASTER_MUST_.X
Message-ID: <353027bf-6d2a-40de-9e18-8553864b343c@sirena.org.uk>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
 <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
 <1ffd5603-4140-4bf6-bfed-af70a6759bda@sirena.org.uk>
 <ZKvmkAP5ZuT6lGLN@smile.fi.intel.com>
 <ZKvnPXl9H+cQR8Ok@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SoPr26CyLWhD+5za"
Content-Disposition: inline
In-Reply-To: <ZKvnPXl9H+cQR8Ok@smile.fi.intel.com>
X-Cookie: Do you have lysdexia?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SoPr26CyLWhD+5za
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 02:10:53PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 10, 2023 at 02:08:00PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 10, 2023 at 12:04:35PM +0100, Mark Brown wrote:
> > > On Mon, Jul 10, 2023 at 01:27:47PM +0300, Andy Shevchenko wrote:

> > > > Convert the users to SPI_CONTROLLER_NO_?X and SPI_CONTROLLER_MUST_.X
> > > > and kill the not used anymore definitions.

> > > The above is not what this change does:

> > How to improve it? I was sure that the form of "converting to something and
> > something" is clear...

> A wild guess, maybe you meant to split to two changes, one per each macro group?

No, doing TX and RX in one commit is fine.

> > > > -	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> > > > +	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;

What part of the above change is replacing _NO_ with _MUST_?

--SoPr26CyLWhD+5za
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSr6hIACgkQJNaLcl1U
h9AMOgf+KMPcMsJntwEWI8UJ7/re0uGZ3D9fX1qeb76OfxTqQ5bt1PsIzRULHkqL
pEOuOVnEu3HTSuNnMgEyy0ms1PA7+yFFiMWSdYlZy02GpNeD8FY/VFwOM9dR4pte
UWnlYD6vJK8wffaEnxtKF5F2gOah96lH3Yws15T1IN8/YbK5wzCnJ2R5XWgm5Ka6
zIFhD0cZ077/Z1hO9SJrqAKPpTLLr1KtyC7ZHsvN2YE5+bzvELKFqPSyt3HPy61r
v+QdG7vRj8/tNW2Hn4lpLR8g9tz5JSMFLhxcyg9TRz67jSiOxM/utfw2IY+Q8DB8
YvmjuYpF+tbhIo7G3bYNULQS39HNSQ==
=ZD6G
-----END PGP SIGNATURE-----

--SoPr26CyLWhD+5za--
