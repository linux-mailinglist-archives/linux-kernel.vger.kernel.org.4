Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6769B675829
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjATPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjATPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:09:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4005BC13CF;
        Fri, 20 Jan 2023 07:09:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6C5AB82865;
        Fri, 20 Jan 2023 15:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01A7C433D2;
        Fri, 20 Jan 2023 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674227373;
        bh=peKWyvA00/J4ADxFPcOLLkQp13SsZuDfZ8mX77eLT9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gaW2nDiCnmEA1IGUr1wprvi2wT55A036DoUI0MAELWfYtF2dX9h9Ax7nxJCjmikLc
         KZfK74bAOXoKxmlR9mYBFxbacm1D8FDiPcAxK4gt6sXoelssHw+gAyRyxMWx3H0H6M
         NrndF1VhgJrvjD+xmGj+zdb3n7W8jbXxq/3y7s5hyIu0neGI+Nkvx3ti7LUEdh7qJH
         Opp/1XplWOZ8trTyrkBL7GfQPsone7dr1zeOS7CERJvm+jYQDSEkjjwUM7vFL48en1
         McNIFvhXpXa7uACR6T2LpKbJ/75HMZGmxU7R9pjzW2hVoJxLYffwr/8KRiVIEviMgi
         myII6B8hchU0A==
Date:   Fri, 20 Jan 2023 15:09:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: document SPI dev
 compatibles
Message-ID: <Y8quqsiRmMbPyyar@sirena.org.uk>
References: <20230120075618.153664-1-krzysztof.kozlowski@linaro.org>
 <20230120075618.153664-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YyLy3D3xhC0HNElW"
Content-Disposition: inline
In-Reply-To: <20230120075618.153664-2-krzysztof.kozlowski@linaro.org>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YyLy3D3xhC0HNElW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 20, 2023 at 08:56:18AM +0100, Krzysztof Kozlowski wrote:
> Document existing SPI dev compatibles.

I'm missing patch 1/2 here - what's the story with dependencies?

--YyLy3D3xhC0HNElW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPKrqkACgkQJNaLcl1U
h9B52Qf/RickB1eqf1M22Btw5a8pAHEiaM16lLisG2SGq78tGur7mTepZQSpLY/L
9Cs6CYuhCToI8aX17xQ1IZeWSVO0SEX0blBYXMX+LzxEUlE41tnkpBQY5V2ssUPf
kSh+EKYEiqsWM0O0w0rbbBK8YN/7NKF2NwW5gti40xIQmZHKPr8x1SEeZlgBj4/p
PfxqtmiO6YWrdLhQCxrzeA7XoIvec8THYKevHVKnacFuW7c80yCn3xb4TiffURL1
BoD7/TwIUXOT8OnhN5ylXLosXkPrW92CxaJqVkc/ocO9oaho7uMAe/s1IZ5s1eUp
iDRVB5pVShnKaawuoumwcQTCj0cNZQ==
=kaoS
-----END PGP SIGNATURE-----

--YyLy3D3xhC0HNElW--
