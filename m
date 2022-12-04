Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB04641DFC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 17:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiLDQn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 11:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLDQnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 11:43:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A4815707;
        Sun,  4 Dec 2022 08:43:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C740B80ACA;
        Sun,  4 Dec 2022 16:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719BFC433D6;
        Sun,  4 Dec 2022 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670172201;
        bh=gqymyFsKgInak7fZfK0hJ85X9i/0voKikaTVsDdR+dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GU12FKoaaDigDDtDEnc9weZ1yNQGiAb+0gMBpgPsyzXTvDhYFkygaUYM+6WB1XYpt
         IjJ5Wd+yxlOgS55PiAvOFCnuXkuCIeLqIDbLD5q62CXTF2071yUkbR87xO6YgcjIkI
         UhgjmALKKl9wZGusu8BquXmEtXFTvQVKXHl3OUbbtaV90qqcZKYcTjIJWMOk+2q4Ie
         xLof8fuVF5dChZb/35ZAcUlA2PQzGQ2EWxdllMKmS2q+60r0kq6a+8NT4ZDT/7MrTq
         0dkRxnVQFg23z1tG/GBr4Be7xE/Cjbq2K4BargyHtO+Xj6am+1wSVoNfaEPTGRrxoB
         3BLgKdA/9njSQ==
Date:   Sun, 4 Dec 2022 16:43:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: edt-ft5x06 - always do msleep(300) during
 initialization
Message-ID: <Y4zOKRhE1SY6NeD7@sirena.org.uk>
References: <20221202105800.653982-1-linux@rasmusvillemoes.dk>
 <Y4pCtm4J3HWhYl8/@nixie71>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oH7nLYaKaHj5K9Ew"
Content-Disposition: inline
In-Reply-To: <Y4pCtm4J3HWhYl8/@nixie71>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oH7nLYaKaHj5K9Ew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 02, 2022 at 12:23:50PM -0600, Jeff LaBundy wrote:

> I think the right solution is to introduce a variant of regulator_enable()
> which does not return until a delay passes, where that delay is specified
> in the regulator's child node. Unless something like this exists?

regulator_enable() does not return until the regulator is ready,
if it returns earlier that is a bug in the driver for the
regulator or how it is configured on the board.

--oH7nLYaKaHj5K9Ew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOMziUACgkQJNaLcl1U
h9DBfgf+I3lx2DKSUXu8lTOnmId6zd5lL/YcTthMgwjcx3+ga6Bv8jdTSzBvDqX1
ED8HFf/e6cK2Dh9qs60vSw35qQsjO9cd0PcBVRqTRF9jec5ROznyvWxsHEmOzSQx
frsQGz4udnMGFe12oQT/NVNhL1iJecgSuNDQBzHMOVqfFqwNnT8o9br3hNvjMABc
C3bEDDzeVjaSDtYHA8kK4pxFq3eHylOsmOSpHgpgigegzyUgEF1j+nLwUpWaEthv
Z97p5+33LiFCHqaDPOlfvv0PMbuOueDqytqmIlLD1VoJKLqFwqxdkB+7brHRIr4I
haAFV1hqJmuERoASif1M3rK0qmYkyA==
=3Mqy
-----END PGP SIGNATURE-----

--oH7nLYaKaHj5K9Ew--
