Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672A760E138
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiJZMwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiJZMwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:52:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB9732DB8;
        Wed, 26 Oct 2022 05:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09134B8224B;
        Wed, 26 Oct 2022 12:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA4DC433C1;
        Wed, 26 Oct 2022 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666788724;
        bh=g99w7lC5JOwtIdlrGIanVT5rZTPjj0ejDg17RdGr4y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGrvPz9A7HozY2G68tM5Grnyj/W/v02JPqc6yPwN8D62DYj7yB7GNEzNNPIloRuj+
         Jq4b57K3zdtZkO0WGkaiPe5RTJfkRHTzvSYoGdN0Wp1RelJUCd7TuNskhhpvqXPGhX
         WROde92MLQ+H+Mkrv2ufQfx99LOOB4vaQPzuNKOvuwssnkIugtR7joqe7/CNHIQaEu
         odn2/BkbfeIkuidc4/GhOphfPRMT5EJHlO4Ux+COPikDJ2m9SmO4mI2BLunsGM5dNE
         XwECk/h6HUtIcumdLVmwGVBS+2lnhUjgcSdg6Bb4OpMPoErGrSPx1cP49p9yK5Qx36
         R+hzMMpYJRD5w==
Date:   Wed, 26 Oct 2022 13:51:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: meson-spicc: move wait completion in driver to take
 bursts delay in account
Message-ID: <Y1ktb1ZXpLKwjI7L@sirena.org.uk>
References: <20221026-spicc-burst-delay-v1-0-1be5ffb7051a@linaro.org>
 <Y1kql/WwAX+ZV8us@sirena.org.uk>
 <7fb8e635-ef61-0773-eadc-7a5723740df6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="no6NW13eb8/jU+ir"
Content-Disposition: inline
In-Reply-To: <7fb8e635-ef61-0773-eadc-7a5723740df6@linaro.org>
X-Cookie: Prunes give you a run for your money.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--no6NW13eb8/jU+ir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 26, 2022 at 02:48:07PM +0200, Neil Armstrong wrote:

> It's the case, I added a wait_for_completion_timeout() + return 0 in meson_spicc_transfer_one.

Ah, so you did sorry - it was a bit masked in the diff.

--no6NW13eb8/jU+ir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNZLW4ACgkQJNaLcl1U
h9CTgAf/RMC3sDbxS9xaMNlF3JMbSakGFH5vYSNcVar7RsbbwNlybfndPrpu8z67
Kt/n7NQhlghUwMMbJtep+OgxkwjNk2VwfPxGHsBVCmc4ssUwjulu8QEoDtRoQjQc
RMe0SH4Lgp5aIJOxZEIXllapQ2rfkNlefj+5bWzERik+YapauO6wMccIW/8InAIl
YRZRnPqXwFg5idAqhNoV0jt99qHWbcH2z1H5T4g3QsMPuAJKcmViVVzJvfUhAdaR
bwEIEbXjPVM0rvF3mS30lW3OSsdtYdUtUFQOg14hZs+V6cDr0vUGUNvshEsyME55
b146uYjdZu0ru8ygEm55sNrvasqCDg==
=NC8n
-----END PGP SIGNATURE-----

--no6NW13eb8/jU+ir--
