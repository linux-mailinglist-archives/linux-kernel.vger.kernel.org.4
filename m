Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1CF74D761
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjGJNVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGJNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:21:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E38C103;
        Mon, 10 Jul 2023 06:21:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D581960FC6;
        Mon, 10 Jul 2023 13:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94191C433C7;
        Mon, 10 Jul 2023 13:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688995274;
        bh=ruJlO0wimIrsDY1JgPUqCqS7prBe1pSopi+dM4yYAWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCUvqCttiPcwuUH6oQaeDTVlt/jVMTKddukpB3Rq2NTAjbzgaXhOs+IbQKiqA2zFS
         A9RwOziobHTKo8xtAoLCbw9/G5XP7z93lwwcMiVxafq8PiTNYdyOWz2ZmNVbJqaRu3
         p+o7GErUG6dN3D+2vdmSUok/vpvLEP/d4e2/6uVM8lFbtbK1g1KhHRcJ+YzSNSc8aV
         vzC9RTasZiyt6DNQvmgXjaDeqvMTkrDbkZFHHHz5OJ3MwZifaBQsXsj96SFX7XFS5/
         2yl7VTCIzPWHRNx1uEfr8lQDSlw+D72llgC2cC8KCiu81fGygjzL2Umg2d4uKSVdv1
         5QaNEib99pP6w==
Date:   Mon, 10 Jul 2023 14:21:05 +0100
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
Message-ID: <7aff8759-cfca-47b5-b995-5260e5082c45@sirena.org.uk>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
 <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
 <1ffd5603-4140-4bf6-bfed-af70a6759bda@sirena.org.uk>
 <ZKvmkAP5ZuT6lGLN@smile.fi.intel.com>
 <ZKvnPXl9H+cQR8Ok@smile.fi.intel.com>
 <353027bf-6d2a-40de-9e18-8553864b343c@sirena.org.uk>
 <ZKv7p96D2B9vYd0J@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bc8mzeK4BJwaYeTa"
Content-Disposition: inline
In-Reply-To: <ZKv7p96D2B9vYd0J@smile.fi.intel.com>
X-Cookie: Do you have lysdexia?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bc8mzeK4BJwaYeTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 03:37:59PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 10, 2023 at 12:22:59PM +0100, Mark Brown wrote:
> > On Mon, Jul 10, 2023 at 02:10:53PM +0300, Andy Shevchenko wrote:

> > > > > > Convert the users to SPI_CONTROLLER_NO_?X and SPI_CONTROLLER_MUST_.X
> > > > > > and kill the not used anymore definitions.

...

> > > > > > -	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> > > > > > +	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;

> > What part of the above change is replacing _NO_ with _MUST_?

> None, that's why assuming the split by name should be fine.

That's what the above changelog sounds like it's trying to do (I'm not
sure the change itself makes sense but the first thing I ran into when
reviewing the patch), AFIACT you're missing a "from" in the changelog?

--Bc8mzeK4BJwaYeTa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsBcAACgkQJNaLcl1U
h9BDYgf/Sarsl9t6SagewIDl2ctlFPl7f++zP6SLId0C0LErq2lPLxZKf8tzzV5x
7mUMpK3rPcygDeYAqOKLncxnrZp/i7yix/98fZtls9IesvOQa29aRYKVSvhKnB6y
dHoZoMBdYj1Rbo/olUcS1xjzzZ0o1VUHkLsp9rjoMW4lcz6Hu3o8GSOq1pbc9lRd
qlCYAjMqjR9K3te5I6FICKKGnIrXm2uxuzSPZl1G7LaN0THUZGZJvcBHjhR2PcJs
K9i9m0gJ9xsQXDOQgLTcXrm8hdSF7yQoRI3TBZ7RXzdWeO3mjNjeHGbVDRr3DMZy
Oici+Ga3mBLzIlFlF51Tg71+BGqcoQ==
=NWL6
-----END PGP SIGNATURE-----

--Bc8mzeK4BJwaYeTa--
