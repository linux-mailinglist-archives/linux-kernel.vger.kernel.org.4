Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCE55FDEC2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJMRQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJMRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:16:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9259ECC834;
        Thu, 13 Oct 2022 10:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4909CB81FCD;
        Thu, 13 Oct 2022 17:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E974FC433C1;
        Thu, 13 Oct 2022 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665681385;
        bh=7AH+ah8oQBin4B8tNbYAsKta8NwJf7sQZ7geLz5uCWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ni32Vx7+SQTcRLJZaf4WsPbdizUjs68S32ijOJ03NHSCn7wgAFEZJOyfbCtBQ9J9K
         JJF8+i9fiS49x5ggaaMQe/HUypR6dZFakjnFdg+HpwbcLIq4Y4WIXXj61AV6jQkupg
         tAkSZp4LJPm7z/vNV1Sk0RxWr5/hrPSpDMNAOL+Rz4bv32myX27qskqAQEh4wyxaQm
         9uvqrG+GFBhZnmK7ujP5L9qXNeRXBaaxrUdLXatBWwJgkCKOqpH1j8JQI57py2NQb1
         qXsmBcHYCc+D+rXX2rf9PL+UK60J4eCjqhOzYbAYUsHzr6dmv0DpOchK/hj51iwUrd
         Fwdx0DqvgU41Q==
Date:   Thu, 13 Oct 2022 18:16:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
Message-ID: <Y0hH5NelZ03yfQuU@sirena.org.uk>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
 <Y0gLyLbdOCetX5LN@sirena.org.uk>
 <Y0gteD0QYVlYxSZh@zx2c4.com>
 <Y0g8HEYHZYHGdwlf@sirena.org.uk>
 <Y0g+wTTJmlaFVLzr@zx2c4.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pqLuB+nOEHF//jVE"
Content-Disposition: inline
In-Reply-To: <Y0g+wTTJmlaFVLzr@zx2c4.com>
X-Cookie: The Killer Ducks are coming!!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pqLuB+nOEHF//jVE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2022 at 10:37:21AM -0600, Jason A. Donenfeld wrote:

> Regarding "one extreme to the other", I suspect that in spite of my
> arguments, which would seem to justify an extreme, the actual thing I
> suggested is a bit more moderate: let's support the latest 2 or 3 gccs
> at the time of kernel release. If we choose 3, that's roughly 3 years of
> gccs, right? 3 years seems like a fairly long amount of time.

I was looking at your suggestion there - as a Debian user that feels a
touch enthusiastic (though practically probably not actually a problem)
since it's not too far off the release cadence, current Debian is at GCC
10 and we're not due for another release till sometime next year which
will be right on the three years.  There does also seem to be a
contingent of people running enterprise distros managed by an IT
department or whatever who may take a while to get round to pushing out
new versions so for example might still for example be running Ubuntu
20.04 rather than 22.04 (never mind the people I know are sitting on
18.04 but that's another thing). =20

If we went for three years extreme would probably be an overstatment but
it's definitely an active push.

--pqLuB+nOEHF//jVE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNIR+AACgkQJNaLcl1U
h9C67Af3ex+OLALFHxPiKkDvZ5VhBRDSpLHhVdbNIML/j/Q87TNYkucnxamW78gE
YkhmUYkN7rlXWHOtilPK+C5h3T3FsAR+toDsE9aNzAutDIBD7eIIUQ0QqqOjwzUt
vJhJ0YQtiZy+UonWfHoD1KIYB4G4C6w7hH571Cb/EvRauXjwtWPUlv0k2RMXnekT
MOrg0f62nYzBHP8pPwplCWOKGOaD0EzIPdAAGJGeILRMxnQnL0PqOgQ51RIz0Ynq
eDN5HjnDm0CqsrSvLNvlu/qVtyZiNr+rKX0vxJsbDzIGI5LOZB30diGpziRYiWlB
FcL31j1g3zwCUuIszROz1nSzvTKN
=OKll
-----END PGP SIGNATURE-----

--pqLuB+nOEHF//jVE--
