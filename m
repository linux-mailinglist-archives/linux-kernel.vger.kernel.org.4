Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ED6674BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjATFEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjATFEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:04:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5166DA10A;
        Thu, 19 Jan 2023 20:51:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 413ECB82622;
        Thu, 19 Jan 2023 16:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72650C433EF;
        Thu, 19 Jan 2023 16:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674146366;
        bh=3bJjdB+nWWOEDo4Kr2GKl2c8L2HL7kShd//vBhxQxIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAmesnlcLr4gXydaCxspVBHJl//Pg48EEE9Ac1TuOp9VDD22lqzx2tTzjv8ElSimU
         pWOk7Tpp0yXR8fj7azquosDK8AHJhlQDRpdzhmLD0lfvBPvDM1bklUh/uEA76afBPg
         gC/3E9MSVR5mRb3tWpVgRll+UrxNn6HRXTmG/DSYEtdLdxj9MgElxOuaJhm8BojqV5
         6lc+OAZIpb4B/ZJpqUfKQFuMWQH55IZjFqgfbDtvV96U9AGQn9gGT06dMbsEZqp2wh
         A5lS99N0Zg4L8gWvXMMr9qlhpA5dZN8pmF3UDJDBX/MFCXdZP8j6mnVo+Jz9JRA5sM
         BN2z4OU8HN0KA==
Date:   Thu, 19 Jan 2023 16:39:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] spi: spidev: add new mediatek support
Message-ID: <Y8lyORTrfmwIzEEO@sirena.org.uk>
References: <20230118-mt8365-spi-support-v1-0-842a21e50494@baylibre.com>
 <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fQ/9xqKBaGbAnkd8"
Content-Disposition: inline
In-Reply-To: <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fQ/9xqKBaGbAnkd8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 19, 2023 at 05:28:50PM +0100, Alexandre Mergnat wrote:
> Add the "mediatek,genio" compatible string to support Mediatek
> SPI controller on the genio boards.

>  	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
>  	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
> +	{ .compatible = "mediatek,genio", .data = &spidev_of_check },

We need a matching update to the binding document.

This does also seem like a terribly generic name - Google
suggests that this is actually a series of numbered products (eg,
Genio 700), perhaps we should be using the specific numbers here?
I guess users would care which they're talking to.  It really
parses as being "generic I/O" which would be an end run around
describing the actual product though it's not actually that.

--fQ/9xqKBaGbAnkd8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPJcjgACgkQJNaLcl1U
h9CRKgf/aE9L/bycOwLdBtT6N4nGdMCTKRv3Lik1C75xILzdQEoMeSY6hbiIprsK
akyYOAkVATInpreBpDdxVLBv2WRoF1gjCOyS658l/ZDWgPSYZ2oIe8cR2Ve4TYYX
OiK6PPIcF/PiQ4/MMrHDd4V3GOQ9JUBukMUM88cbBsqMbHXiITvP83Omb04MPXV2
xyAtq50UCaRGJnlwS1/ahDJ4wSL42RUKgu+6WJNeMckv3L3tM4hhs4qKcZVOfWPV
yDflRvfSWw0mgd6x9C4CoRslSC9FRLEpniU8fRtwbkvP2CnBzJnx7o+mQ3KtFnor
opcBdJ4aSzsX9xPuTU+M97GKibnXeg==
=IObu
-----END PGP SIGNATURE-----

--fQ/9xqKBaGbAnkd8--
