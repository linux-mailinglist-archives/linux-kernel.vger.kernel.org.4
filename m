Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D9969A2D8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjBQALH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBQALF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:11:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AF8360B5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:11:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1E1CB824B7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC60EC433D2;
        Fri, 17 Feb 2023 00:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676592662;
        bh=WSgwqtzcOunbPHiwKxcPqx3pkrkQMBCpjk6IB0bGudo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z1bkKyKq0JKsZIghnMmYA3yfX9wqFhY3Y3Af+7F2laA6iUR1OxpbS0/cDweXPi2ph
         hL1Tn3gjg+KhZj5OcUXIeGpAiEcqg3pWuV944vNv/lbJRX9BzrFyyZB3XH6p4naONS
         9BdjQychn3zsXzMml8IYMUoQOHfjyKz0e8CBpxWMGVHHtyx0IqXkmAw7OQgjhIfojk
         jvyTZuAt25g1alg8RRevXn6EdsfhnVuz0UHB63IVljURiDJram0uAh8LrgOFwg3c2N
         gDuCBlx7d3p6FrT309vQtZrQjfVheba6gtwEi7fXZognf9aSboajl2zSiKi6m1bfd+
         j5ogVqHfJB6VQ==
Date:   Fri, 17 Feb 2023 00:10:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Joseph Hunkeler <jhunkeler@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc:amd:yp:Add OMEN by HP Gaming Laptop 16z-n000 to
 quirks
Message-ID: <Y+7GEp06snoDjrH8@sirena.org.uk>
References: <20230216155007.26143-1-jhunkeler@gmail.com>
 <Y+5Ym5rUWLK4TOAf@sirena.org.uk>
 <224b230c5c8d3037b650602b5743bbf217369ecb.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mGJ+2Kg6cbWRtwcg"
Content-Disposition: inline
In-Reply-To: <224b230c5c8d3037b650602b5743bbf217369ecb.camel@gmail.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mGJ+2Kg6cbWRtwcg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 04:25:45PM -0500, Joseph Hunkeler wrote:
> On Thu, 2023-02-16 at 16:23 +0000, Mark Brown wrote:

> > There's no need to resubmit to fix this alone.

> submissions. Are you suggesting I change the email subject from:
>=20
> "[PATCH] ASoC: amd: yc: Add OMEN by HP Gaming Laptop 16z-n000 to quirks t=
able"?

Yes, exactly.

> If so, do I edit my original message as new, amend=A0the subject,=A0and=
=A0resend
> as-is? Or do I reply to the original message with the amended subject alo=
ng=A0
> with the full contents of the patch body? I know you said there is no need
> to resubmit to fix this, but it's is not=A0clear to me how to do it witho=
ut
> resubmitting.

You'd need to resend to fix it but I'm saying there's no need for
you to bother, I fixed it up locally.  Please just bear this in
mind for future patches.

--mGJ+2Kg6cbWRtwcg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPuxhEACgkQJNaLcl1U
h9AYXgf9FrBlba9D5DIzONucAJ6z978YedlssPxQluPcoVw0qQBdKByjfw+f9lE4
DX6+ho2v5q1gHPahe44dnq6uUsGSTT2pl1koALpOu+ligEg0crtvjdJFvmh9fnVh
Z2ejfaIMvSOe/6JTcDkyWggXM+p6kHsxqVKKLCO0/kHpwuR0DoKm40iquXZ3OtPf
m45nmYEbp334+mw+mYzviaDeb6sFOwl2/bl1Fpw+J7eH/+xP6snCM6wNWplqqj4z
e4drw5vDIJwAyVY85zLYcmFqBgzyU5DZe7sv5N9mnWiQnSeiKYkMmNNKr4l/UPAe
Wsg/ETiwaWVd6e4PDreOnBg4DpkvyA==
=IyJK
-----END PGP SIGNATURE-----

--mGJ+2Kg6cbWRtwcg--
