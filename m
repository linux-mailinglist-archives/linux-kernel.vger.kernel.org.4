Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7103864EC14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiLPN1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLPN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:27:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB92233C15;
        Fri, 16 Dec 2022 05:27:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42E18620FA;
        Fri, 16 Dec 2022 13:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DC3C433D2;
        Fri, 16 Dec 2022 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671197268;
        bh=CI5psMfl9OJ/zNyCUIvQEPoWmsXwNysWNI8BVnhMZns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbgmR4T9fVG5mdnayztMxfoqIu+4XygSd7Af1PdO2TInpHlDRePoVWrFEcmuJ5NRv
         hOKIW3bQhMnyDYswCYLCBWk3eFYILkjU3B6gLYB6uAdCe4U+ZivIpNMKoo1oR3Pl8v
         Xl73Jf2QrAVblv7Z9iR52Hk0aNfeCcOeiGFGO95d1227ONVPZ+uaRcY5/grLiSphti
         XQLwj1XA4m708GdSfbuEVcMquF/dudIjZK30rPjCujowQauSE2A1VqRK/DWUqbxYEE
         T42VPpixPS2I/av9+H0upj/8uBQjKNVFbjiGRN8wesshhSclDHTLwpJR6XI8KflJGz
         A/piN5z4Boi6w==
Date:   Fri, 16 Dec 2022 13:27:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@rothwell.id.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: taking a break
Message-ID: <Y5xyULcw4rlr3kpa@sirena.org.uk>
References: <20221216124626.0dd8cb83@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EPaXEuohUYqzpXK9"
Content-Disposition: inline
In-Reply-To: <20221216124626.0dd8cb83@oak.ozlabs.ibm.com>
X-Cookie: No passing.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EPaXEuohUYqzpXK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 16, 2022 at 12:46:26PM +1100, Stephen Rothwell wrote:

> Mark: Thanks you for your help during the year, but I don't think you
> need to bother this time - I assume you would like a break as well :-)

Yeah, I might actualy still be working a bit later than you so I *might*
do some runs but definitely only a few days in there if I do anything at
all so nobody should hold their breath.  OTOH having my build machine
running full pelt sure does help keep the place warm!

--EPaXEuohUYqzpXK9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOcck8ACgkQJNaLcl1U
h9Bqvgf/UB6PW8R4ZauWFywrlEIZEzyQXMgJxni4ergVRu8K3GNaeo7/XLYdaO0f
17EE6PtoLF46U8A9ZXRThcbSEjvKILKf1XVgoGIUu6zTfvZkcO1/meo/apJFf2TL
NpMekYItuvkpr2OXs3Z0vWyJm+mss2zhGTjEaWmyes+nZXKtwZyOikMG4OFwBfnv
Gc6Pgg3m0ib3VCZnm5Ug7G6e0klivUaT2fWaL7NhiUNRfP2dy9aaDLu+EKvdl2Hr
C7NODHPfA/SOyZ6bdAfmqwdKCZsCveJVUzkvK22t08QS1bMUqNghjB+7CFoOx6L2
V0HX7IuN/235uZAU+roCXqo9z6vgsw==
=hzCE
-----END PGP SIGNATURE-----

--EPaXEuohUYqzpXK9--
