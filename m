Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC9572A32A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjFITeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFITeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66E330D0;
        Fri,  9 Jun 2023 12:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63DE465B5A;
        Fri,  9 Jun 2023 19:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79B9C433D2;
        Fri,  9 Jun 2023 19:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686339247;
        bh=UOspDcDfDFm6QPopNaAEG0ZWyNsc8e+X/dvLCTYWW0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQhS0eRyklovhz/AoC7U2GE5HgQOiLjzRFTt+o3ZaiC9tr6qYM1CkWJP4Qlm+9q3T
         RU7NiJBJajGB8cdlIO6VDE/oX6e9S0Psnue96fn9fVTt/qm9oYckEGCvjh7fupaWJb
         z5B6WvqusQ2SyRSWlfR/INpEVwIo9Ih/tAm7bAMMapz7rWhm4weStrlmQBdfYBR0b+
         A6VdWdYb/CqXYW+7MhULJgXactJgbkDgDdeGCGzcJC15rZOgeFhyKlcCqSMS6Zz6OU
         DHBLH7R2RphkCQgxo65P81CvZPnd18r6ml2ajIJ50/vxrLThnaYzMLgIyTwYakVJ6k
         3grAPwoG3v1wg==
Date:   Fri, 9 Jun 2023 20:34:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Raymond Hackley <raymondhackley@protonmail.com>,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, jk@codeconstruct.com.au, kuba@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        michael@walle.cc, netdev@vger.kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v2 2/2] NFC: nxp-nci: Add pad supply voltage pvdd-supply
Message-ID: <a3d2dd4f-38ce-40ca-9085-893f808f817b@sirena.org.uk>
References: <20230609154033.3511-1-raymondhackley@protonmail.com>
 <20230609154200.3620-1-raymondhackley@protonmail.com>
 <e2bb439c-9b72-991b-00f6-0b5e7602efd9@linaro.org>
 <20230609173935.84424-1-raymondhackley@protonmail.com>
 <7ad5d027-9b15-f59e-aa76-17e498cb7aba@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fhm/1UM3KQHYSisd"
Content-Disposition: inline
In-Reply-To: <7ad5d027-9b15-f59e-aa76-17e498cb7aba@linaro.org>
X-Cookie: Tom's hungry, time to eat lunch.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fhm/1UM3KQHYSisd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 09:29:51PM +0200, Krzysztof Kozlowski wrote:
> On 09/06/2023 19:40, Raymond Hackley wrote:
> > On Friday, June 9th, 2023 at 3:46 PM, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> > Second condition regulator_is_enabled(pvdd) is to make sure that pvdd is
> > disabled with balance.

> So you have buggy code and to hide the bug you add checks? No, make the
> code correct so the check is not needed.

Specifically your driver should only ever call regulator_disable() to
balance out regulator_enable() calls it made itself and it should know
how many of those it has done.  regulator_is_enabled() should only ever
be used during probe if for some reason it is important to figure out if
the device is already powered for startup, this should be very unusual.
If something else enabled the regualtor then whatever did that needs to
undo those enables, not another driver.

--fhm/1UM3KQHYSisd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSDfqgACgkQJNaLcl1U
h9ABiwf9Hutr2zJvx9D17c4xS1JOiT2t+PozkRvq6t8oWu82/GhSKzCEl4qiJ48j
KG9Dyy6j44XBO2sjM4X0ge6gjX7+3TPcFRd4WC5VtqmqNgyKQviRk8KBPT7g+9Le
tA5btQ5ytvDJRNhvlAqi8FxkwAt3P+6DPVZGosDcJcaDwHa936TM1SAZnx6TP7y4
vc0etFHfMt/+xL9hMRqxlCyL+dPo45wdsNOibWJu9mF15yDfDdJLfWW+d8qbRu9r
V2o7YSG0k0Ukxpj5fgBiBgWfAsYKmYVzg15gTazoop0PHUGtonXk14vZt5bQQGkV
s3SCRrQAOCNB7v0yl5nhK87ypCx31Q==
=365c
-----END PGP SIGNATURE-----

--fhm/1UM3KQHYSisd--
