Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F796F0D34
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344270AbjD0Udk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbjD0Udi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968393ABC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B2DA63F99
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 20:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B127C433EF;
        Thu, 27 Apr 2023 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682627616;
        bh=KTbprxbWn3/KMv6+1sSUmWVNFmdM1ZRCv9bkQLvQfk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nAG0QdXGZfixzeLLshwWoYg13S6m5NwnX5PUTxABW4Bd6Cv9F1KbPdQ3kb/iGxneP
         hzyTlK7uSetgEyOIjHODUJUbQbPepPvfuGo++/fUH/qSqnNUUhgH7+3XOHg15ou/rH
         Q6PkaXnmHEVQHkQoIVK1Q4wuZaHh1h5Hx7sr95n2sHt4kuscR2iU5lo5Tnv+4MD6/d
         a1+dbcqc1VU8AKZdoucUV0Z04aRMOE1WAs3oR2weZ5MuQvSPobOfNkb+t+Ef5a7L7w
         IL7+ctow27X/HdoUqFcVm0vTdYYhB5zE7R8Dsv7drq4zZDmVFqqg7oFJFNlZ4zu8e6
         /wbroBwOmowzw==
Date:   Thu, 27 Apr 2023 21:33:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Philippe De Muyter <Philippe.DeMuyter@macq.eu>
Cc:     linux-kernel@vger.kernel.org, Philippe De Muyter <phdm@macqel.be>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] Documentation: regulator/consumer.rst: fix
 'regulator_enable' typo.
Message-ID: <7bda9037-3362-4557-862c-43ce531c90ab@sirena.org.uk>
Mail-Followup-To: Philippe De Muyter <Philippe.DeMuyter@macq.eu>,
        linux-kernel@vger.kernel.org, Philippe De Muyter <phdm@macqel.be>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <1682537582-2314-1-git-send-email-Philippe.DeMuyter@macq.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="piu5JyvxpHSRKUPb"
Content-Disposition: inline
In-Reply-To: <1682537582-2314-1-git-send-email-Philippe.DeMuyter@macq.eu>
X-Cookie: You will inherit millions of dollars.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--piu5JyvxpHSRKUPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 09:33:02PM +0200, Philippe De Muyter wrote:
> From: Philippe De Muyter <phdm@macqel.be>
>=20
> Removing an erroneous 'd' at the end of 'regulator_enable'.
>=20
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--piu5JyvxpHSRKUPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRK3BsACgkQJNaLcl1U
h9CsHgf7B7BrTeZtwycYoVV4jw1tgzNxyAlDsE0YQZYwJ13bZJ0RLs8JsQdgVb3b
V9mVqygirprliw+xDfg4Sr0WeUbowf5xs6hL6hqeSiJfxgw2qxmdoPnZ2roTrEXs
oSXjq+CRD1Kp5rPaxEnkIjWunKrnp/X4UR2YqnfldNIH3xae2grn87BNWNXOcAjo
SCUgtM7gHuYoxFPG19WyWo44zvQgtv+MGuXYIUAjoXwfC0s0IqK3Dg4OiksrmwHf
E97HE2weuxuKNn6zATNlvD5SvbSfxW9yl614VXvRnGAPmr2rsbXvt3aNf3iKaO7l
YF5/io1ThhPe0nP3t/D2yLTZZp3LSw==
=RCPU
-----END PGP SIGNATURE-----

--piu5JyvxpHSRKUPb--
