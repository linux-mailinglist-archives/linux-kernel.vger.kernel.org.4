Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D269724980
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbjFFQrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjFFQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ED9E6B;
        Tue,  6 Jun 2023 09:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84737630C1;
        Tue,  6 Jun 2023 16:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E033FC433D2;
        Tue,  6 Jun 2023 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686070065;
        bh=h5qXADfp5iiHf5MldklfzUICOJ9UUo9FqnfqQoU50+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ravdK7JRjrbpZQJXRxpzY2TO5yOug/TyvCUu/I5jnTGVcKdN159z0lEfOVSmP67uJ
         41MtN0iYA+OJE89RvAmHGPEo6F5Q8cr9TFu8WkRbXvRwSWM/2zATy3U2NlZx+tmuRD
         RQzLcBpsd5vYbT22DcCu/IzfcP2W5Y5tWKAuoL28M4wdILnD10zkA561w9chFyEscf
         1fo/fgcx1uqc1cdPxvhSgXatNaQ5YskiSMeFmFz8mL6SuUgY+2Q4M3RVCEYxbQXujU
         27TX3Rs3gFv/WqZxEFrL8T1zsPSAQyfRfsmgNYrJubWncrxvJ2VQsi0xZdktPrtufd
         jIxgNsLT4iY4Q==
Date:   Tue, 6 Jun 2023 17:47:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abe Kohandel <abe.kohandel@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/2] spi: dw: Add compatible for Intel Mount Evans SoC
Message-ID: <7696b01e-c388-45f2-9694-e427dde84b2b@sirena.org.uk>
References: <20230606145402.474866-1-abe.kohandel@intel.com>
 <168606867693.49694.16483038401822255147.b4-ty@kernel.org>
 <20230606164040.s3ozznrkcclozugx@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ishfBgfXgGNSCq9"
Content-Disposition: inline
In-Reply-To: <20230606164040.s3ozznrkcclozugx@mobilestation>
X-Cookie: Keep out of the sunlight.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5ishfBgfXgGNSCq9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 06, 2023 at 07:40:40PM +0300, Serge Semin wrote:

> Mark, next time please wait at least for a few days before applying.
> Give me a chance to review.)

It's a trivial quirk for a platform, it seemed more hassle to wait TBH.

> * In this case I have had a question regarding the in-code comment
> which may have been needed to be fixed a bit.

That can always be fixed incrementally if there's issues.

--5ishfBgfXgGNSCq9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR/YysACgkQJNaLcl1U
h9CxQAf/VtujR3HvlFC6goCYk8294SlUDYFVXzT6M6n11QIlRbX9IAfYBveFXPo4
6LGOn1rTPQIpI3iw51jahj6D2MF9YAqz2hilaCrvdq7JQm03GT20eAeJ1aUZEtxO
4xhoujdH2dv8bpXsZhJVPKcGOCPCxXySXKMtbv8OszgYEzLG2unYxC7PixB6BsNp
jkTEbCSxtQGu02Rjyl2Z+I2XbUScs0L55TUc8U5etEub9yYkoWf2voaTkHU5XXnU
V1HZMwTLCrcxFoJaV8+W4hC96NVUTf3Go/FDr5KWmaIxl4J6OVk8jXrIdcU71uUw
4+/fLXQW2lSxoX3lCVeCIJvOfopvFQ==
=Q3jY
-----END PGP SIGNATURE-----

--5ishfBgfXgGNSCq9--
