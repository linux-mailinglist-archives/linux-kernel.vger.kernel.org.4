Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9506D6A92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbjDDR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbjDDR2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A92B10EB;
        Tue,  4 Apr 2023 10:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D00A62F5C;
        Tue,  4 Apr 2023 17:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE88FC433EF;
        Tue,  4 Apr 2023 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680629111;
        bh=slVivGIPAp/ISTzCGMjyFQwgRJZixl9vpfdLn8FPSl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXK4JtoHBB5ocKC9PKLe3VapkJ+Q+NQpxO4NSJWQ3UmKxVn1wPmKPLngGM8JzIoK/
         AMo7rInimmGM2ytkqFstVUsDQbajx8BqC3iqw3duozxV6YZTsTI4Uu0Bu4cuY4omy9
         rzQj8ParM++EK9CMSGqHGWDMJ319eIqygV0Uld9ajiFPgH+E74m/Dm6g36aab9+VTd
         6ZaEs0Nfv1kQjxe/gTAvKuGFclmHvVjiB4ZEFALKObPqqNtIBWhaBozzPrPUlP2JWJ
         YOf0WiVzqts0IF7Nqxl5uWQl7F5icVYeYe7ckiFibA/92Am/i8aJRLePxfGt0Vrrra
         YiEc8aeRRLH9A==
Date:   Tue, 4 Apr 2023 18:25:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Introducing bugbot
Message-ID: <bb77b0aa-6595-4745-b9c8-4ee95cef610d@sirena.org.uk>
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
 <022e2ef8-2a94-3109-ab90-9ee980915887@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/KtUU4qPKQfqDm+O"
Content-Disposition: inline
In-Reply-To: <022e2ef8-2a94-3109-ab90-9ee980915887@gmx.com>
X-Cookie: Being ugly isn't illegal.  Yet.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/KtUU4qPKQfqDm+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2023 at 04:16:08PM +0000, Artem S. Tashkinov wrote:

> Let's have a bot which polls open bug reports every 3-6 months with this
> question:

> "Is this still an issue in the current kernel? Please leave a comment or
> this bug report will be closed due to inactivity".

> By doing this we could make the bugzilla a whole more relevant and effective
> tool instead of having a ton of bug reports no one cares about or can even
> confirm.

> I would only exclude the bug reports of type "Enhancement".

An explicit flag to disable would also be useful if this is done at all,
these bots exceptionally frustrating with trivially reproducible issues
that don't require special hardware or anything.

--/KtUU4qPKQfqDm+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQsXXIACgkQJNaLcl1U
h9ARjAf9HgWGe+u1mX4c6VTfb4cAGrBM0UIDnhAFJobwESusbB1cmrmpIHRzJlo0
ZOmbEj+nO6nmMUwpUOAmAibSJIwX+9/Dgz91XKcW5sxP5hiuVRzktBa0tnifWz38
OHkXzaTlH0q+eul5Yr+yhHk/yACBnUuZg1FDbhiXP6RYKsBf+TmyTK061nlTWX+R
A8fEbGBrFsrhrAk4CLJCwXbLiETZRiVyisGikH37DSNmb6a9Ca30U8UyBN9Q+bGF
T7kIrXtK3+YMtNls7aU7EvRcbLXlH6LdVpjK7ZLvmovawOTCQuMakRdreHZXclbK
f7wQy5bSw+iB+sfJJKd64yxrU76FgQ==
=HYXd
-----END PGP SIGNATURE-----

--/KtUU4qPKQfqDm+O--
