Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A255FE339
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJMUY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJMUYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:24:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154D918F276;
        Thu, 13 Oct 2022 13:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43085B82079;
        Thu, 13 Oct 2022 20:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E21C433D7;
        Thu, 13 Oct 2022 20:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665692643;
        bh=I45PmGN6r3QU1UPGDQ2Icpn/q90F4aBf4xGvMScmOrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSGvG/xsCfNMe4yflpDDOLOQg5iE8PACLoOxjBdjgcddu5qOqFoAdj1tFGISNwVw5
         j5hHECGVJwXupe19madVXl0ycgQNdhAj1yOFirx3EIi7v147OqtEZfOEb1G5D1C5zD
         hzwS98rXy5IsVAVWzJadV5GGtgZxMJlsvtKsMhQkpI6KrMRdCz0whEE41Epx6wOQNb
         ccu6hiZ1aRgn1mXDHttjfXegdgZ23wuW9jGDFV+DnqaEWb+MGl5/tM0/RoQ/p6afEZ
         u5URhA9yDsu+qsZTsgrr/K+lTVkJTVcZIoeWWtyMyjDXi5IdLYpHoGr2mDsYTnFeUS
         tgQnyFJnA8RPQ==
Date:   Thu, 13 Oct 2022 21:23:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
Message-ID: <Y0hz3u8ZNO2yFU2f@sirena.org.uk>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
 <Y0gLyLbdOCetX5LN@sirena.org.uk>
 <Y0gteD0QYVlYxSZh@zx2c4.com>
 <Y0g8HEYHZYHGdwlf@sirena.org.uk>
 <Y0g+wTTJmlaFVLzr@zx2c4.com>
 <Y0hH5NelZ03yfQuU@sirena.org.uk>
 <87o7ufwovp.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6IonEliHNUxFdwLj"
Content-Disposition: inline
In-Reply-To: <87o7ufwovp.fsf@oldenburg.str.redhat.com>
X-Cookie: The Killer Ducks are coming!!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6IonEliHNUxFdwLj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 13, 2022 at 08:38:02PM +0200, Florian Weimer wrote:
> * Mark Brown:
> > On Thu, Oct 13, 2022 at 10:37:21AM -0600, Jason A. Donenfeld wrote:

> > I was looking at your suggestion there - as a Debian user that feels a
> > touch enthusiastic (though practically probably not actually a problem)
> > since it's not too far off the release cadence, current Debian is at GCC
> > 10 and we're not due for another release till sometime next year which
> > will be right on the three years.

> Debian also has Clang 13, presumably for building Rust and Firefox.

Ah, so it does - nice!

> > There does also seem to be a contingent of people running enterprise
> > distros managed by an IT department or whatever who may take a while
> > to get round to pushing out new versions so for example might still
> > for example be running Ubuntu 20.04 rather than 22.04 (never mind the
> > people I know are sitting on 18.04 but that's another thing).

> The enterprise distributions have toolchain modules or toolsets that you
> can install, all nicely integrated.  You'd probably consider those
> versions too new. 8-/   I expect it's mostly an education issue, raising
> awareness of what's available from vendors.   (glibc versions are a
> different matter, but I don't think dropping support for historic
> versions on build hosts is on the table, so that should be relevant.)

Yeah, I found the ones for SLES easily enough but not the ones for RHEL
or Ubuntu.  Perfectly prepared to believe they're there though, it does
seem like sometihng users might want.

--6IonEliHNUxFdwLj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNIc90ACgkQJNaLcl1U
h9Cwkwf8Dh7ytjTum9r3EZ+ZYk83cfb/Lw/fDn71e+8wI/WyZ6zuBtw/NUsDnOY6
eGPhSsCMq6Y2saNAyyBOxDwUW8BIBYpO6cdWHWxWJTB9Ez+9qc5h8jjDTZigc2Bk
6wIY7L5R3bgwdnOq75FivnlxYR/wjT4lq3O2WyirKWBQ1Lwh5z52RdLVsuOcBNvN
p1ZN6eZ9D/3oz5CLiJ4+Nt/9AdTpED5eEtUNqq9D6a3/9JECj7gT99s29Yeoei3p
47qMth3j+g3oJDXJbwur+ETFOaKf5NEI1DlunTSlGO7uF0jdn8en62X2vudstzzc
zF9/1EYcMtESGEcnC2MHZ5O1H/wgcw==
=i5/S
-----END PGP SIGNATURE-----

--6IonEliHNUxFdwLj--
