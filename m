Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DF7674C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjATF2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjATF21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:28:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A646B76AC;
        Thu, 19 Jan 2023 21:23:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59DD4B826AA;
        Thu, 19 Jan 2023 17:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C02DC433D2;
        Thu, 19 Jan 2023 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674149789;
        bh=EQ1fSGGlGH77kXooVwbjybwU1LhFwJogktLoTx8jPAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mz7rCjR/A33xwAO7ZrvKUN7jh8KtBbd7CBPKGiVSdyLBLmM+cwcl38xhjCKqv8ey6
         i9TkTBrT538e04b5/quBdE7b4XeTRQUEVPJ7EG09A5Y0FBRp7UYIlqin9YP7zj6CxP
         RM+FC0eKo8W6L8jB0pFZr2ZjOeWRxNy7M5srSVRBIyMIwSLpppt4+ZfM784Vk21gUs
         RsPxKj0NgF3FjMhNdhoW2YbOe4HsqpH3IorX9l22WD5lUDEqYvMPgGPx3Kn/987zuH
         1Zm4hvm/A9fKsJC5eo5yY64TPTfJ8oI7B68xbMpWixcnm5ObJENOhSBJDFI5DHjJvn
         RcMZ43COLKsjA==
Date:   Thu, 19 Jan 2023 17:36:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: spidev: add new mediatek support
Message-ID: <Y8l/mQjjgKJiE1/F@sirena.org.uk>
References: <20230118-mt8365-spi-support-v2-0-be3ac97a28c6@baylibre.com>
 <20230118-mt8365-spi-support-v2-2-be3ac97a28c6@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Jz0aOHbv75kB/Hqi"
Content-Disposition: inline
In-Reply-To: <20230118-mt8365-spi-support-v2-2-be3ac97a28c6@baylibre.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Jz0aOHbv75kB/Hqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 19, 2023 at 06:28:20PM +0100, Alexandre Mergnat wrote:
> Add the "mediatek,genio" compatible string to support Mediatek
> SPI controller on the genio boards.

All my previous review comments stand, please don't ignore review
feedback.

--Jz0aOHbv75kB/Hqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPJf5gACgkQJNaLcl1U
h9C0BAf+Jl+1E0pCscUWyq547PeayYiVt04DMkk+4q1qCXREpiJP/zLOicoEZCWz
2xIkBo1hIB1RAJXIZWkrMO/kN5SbqsLQ+ySgMVaWK/Lp3aL0M8YyPF34pmEhLojN
ly/WNvpWVwmdO6n6NGGsK1tgp7IE4pyEj9M08YmBcRbWzMddKO71u1YMgY+mmOcN
NDEc2E1vmp4aWd22lsMmgtFlJgpRPAw0+/T6nA+XLdP4u3EvGo+Au3LOa3ij1xOA
tWw3+wlro3nIC9+h0Iwy5rWLBzuaxMccUhM2ZEYAbj1a8Nq8yq8Of+7vlxOhiee/
NdWsOYPhtLy6IuWthaMnaMi7vzliew==
=uuJE
-----END PGP SIGNATURE-----

--Jz0aOHbv75kB/Hqi--
