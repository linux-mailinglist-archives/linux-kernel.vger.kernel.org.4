Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193AE5EB4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIZWkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIZWj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:39:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2886E1EEC8;
        Mon, 26 Sep 2022 15:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2EA2B815A2;
        Mon, 26 Sep 2022 22:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCEBC433D7;
        Mon, 26 Sep 2022 22:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664231995;
        bh=Z5wnR/iO+6eqE2b+akQ3tVxGbit/SIgqvm30VUmQ3u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwurO2TmcBUfW69VH7nzv1u5qdAKnYupn33jWDtzxx7gKkqVHrbhkA4NS2/vXUfXv
         bydlqcCiC2NMdsvQWGjwxRqpNkefMQfkGtDaFo3TvKj6t/j9RtRpRQTQq1JczTT+eB
         8dV8OPOuVQYbgM2aH0uZxHwhSsDlwtrcAADnGSBhfXTKkFLkZqXD1lmG7IBVPCxUWO
         BkedOe0/dul8i3VbEHCEOCAOjRLpuaFPjn7MWVSAVaqLfUU2/kV0WA1kgTzTh8CwGB
         PCRKHfM0Y2FS2uO6JZpPrmUNCTGGxAnVWVdA5WItTNIj21bUQK87BaBT16mvcIiW5N
         LQtDnC4W+ZcbQ==
Date:   Mon, 26 Sep 2022 23:39:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: control.h: Replace zero-length array
 with DECLARE_FLEX_ARRAY() helper
Message-ID: <YzIqNqhTIuaWZrOl@sirena.org.uk>
References: <YzIcZ11k8RiQtS2T@work>
 <YzIj6tdtDe9YrX+I@sirena.org.uk>
 <81af0106-a732-ce45-bb1c-c45db9e1aeb9@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bo6iFE6H5R63k7d1"
Content-Disposition: inline
In-Reply-To: <81af0106-a732-ce45-bb1c-c45db9e1aeb9@embeddedor.com>
X-Cookie: You may be recognized soon.  Hide.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bo6iFE6H5R63k7d1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 05:27:41PM -0500, Gustavo A. R. Silva wrote:
> On 9/26/22 17:12, Mark Brown wrote:
> > On Mon, Sep 26, 2022 at 04:40:55PM -0500, Gustavo A. R. Silva wrote:

> > As documented in submitting-patches.rst please send patches to the
> > maintainers for the code you would like to change.  The normal kernel
> > workflow is that people apply patches from their inboxes, if they aren't
> > copied they are likely to not see the patch at all and it is much more
> > difficult to apply patches.

> That's exactly what I intended to do:

> $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback include=
/sound/sof/control.h
>=20
> Jaroslav Kysela <perex@perex.cz> (maintainer:SOUND)
>=20
> Takashi Iwai <tiwai@suse.com> (maintainer:SOUND)
>=20
> alsa-devel@alsa-project.org (moderated list:SOUND)
>=20
> linux-kernel@vger.kernel.org (open list)
>=20
> Did you see anything wrong with this or something...?

Yes, you should've also included me and the SOF maintainers.  It looks
like the MAINTAINERS patterns aren't entirely up to date there
unfortunately.  Though that said given that you'd picked up on the
subject line I'd have expected the signoffs on the commits to also be
pointing at the right tree as well.

--bo6iFE6H5R63k7d1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMyKjUACgkQJNaLcl1U
h9BBnAf/TPF9R6N8StyDAkuK97mbw3QppdICYdpg3hc30FGONCG1l7j4OKCzcaYu
BnZtgEPFlDS9KiczSbE44u2+VmUbFET3fho5hHTh5hakya3I+Q4DwOCiYVafzCYC
cnVXwBTWYfN87/yZ8zzQ2wgqK8UNWDtFPRofbEb5Xit3EHpMKj1Zf6gmwywWoabk
OtkwMF3s6KnAWepveZmGgpMtiAGzfaPXzB1SiK6SVH1nTU0fnq7mjTTBiJ5ycM4p
JkCHGqZ1sVFzA04aVZODw7hPpeO4SIWxleHDJGeZZcYx/pV7EJhn781WBDIQQ9mI
0nztCD2ZquEvp+ceVljaVTs5BehCVw==
=+Su8
-----END PGP SIGNATURE-----

--bo6iFE6H5R63k7d1--
