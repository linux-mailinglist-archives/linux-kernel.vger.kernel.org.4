Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A50374D437
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGJLGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGJLF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:05:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ACE199B;
        Mon, 10 Jul 2023 04:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4BF860FC0;
        Mon, 10 Jul 2023 11:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D578C433C7;
        Mon, 10 Jul 2023 11:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688987084;
        bh=TwtuDKEbyYTJYwb5YfWy40545UzZJ3eX6HtXjCq2/DY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1hoO4AmByvX1+/WmpbkKZwew5eudKc1FQfa/lRAOOwiXQ8zRshL+Oq9bFoJQeu7s
         LcEcu9oephfIQANzA4/3cifEEgUeal19PEixt2fvddV8g2XCmGK0fFh3Uc4W+J5uOn
         XEO983Rlb7MGqbsEKGjwJjCaRtJ44jxPCT5CF+Iau9ZSof+GY2neKJt0KjAvaY/9jd
         RBqd+kDX18tFNSlYceBbrvR3r37PvxSvj3S5DjVmlQqBMkOMXeP2JrMR5z6F5rg6jE
         qp2ogGv8JQb+t32ZmOV4oiKG0GwgxT5l0kEjeNVOqRmXVjkyf2EUtnmSnqitny5s3z
         HoqJaUtvZLO7w==
Date:   Mon, 10 Jul 2023 12:04:35 +0100
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
Message-ID: <1ffd5603-4140-4bf6-bfed-af70a6759bda@sirena.org.uk>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
 <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kWZTJCyyxQE+byGQ"
Content-Disposition: inline
In-Reply-To: <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
X-Cookie: Do you have lysdexia?
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kWZTJCyyxQE+byGQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 01:27:47PM +0300, Andy Shevchenko wrote:

> Convert the users to SPI_CONTROLLER_NO_?X and SPI_CONTROLLER_MUST_.X
> and kill the not used anymore definitions.

The above is not what this change does:

> -	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> +	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;

--kWZTJCyyxQE+byGQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSr5cIACgkQJNaLcl1U
h9Ah2wf+KmkGI9qlUKgHUSNXh1DbqoLxbTpYFnFP5xpasapdwBa05UYP3eghOigF
R9RLm+Z+cOhxpxkEijdYqYKOu94px87YE9vU9+e00ZWaz+X+R8C17kt4hk+9x5pI
n6ln7unk1TDzZww8TWx81WkEqR6E4uMcYhMfsfjKKDcC6ZOxJu6+h3wWjhkj8q35
k8NbtIo8bz2TzLqTuNjWsA64H1AxpRqwoT1fLLiZRPrng7Zc4wIP68cX17WSWwqj
+Tn8sO3EBbpYl4vuJircRmezY6Roo1TuLU4M7iIGhGoUrt+jdmoqIDsjQVU4IKIv
kRGC3WQT0+LuWsoU8vUp0PFt+ntu4w==
=03Nv
-----END PGP SIGNATURE-----

--kWZTJCyyxQE+byGQ--
