Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20F85FDE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJMQ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJMQ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:26:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014FC10F897;
        Thu, 13 Oct 2022 09:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8CF7B81E35;
        Thu, 13 Oct 2022 16:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B701C433D7;
        Thu, 13 Oct 2022 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665678368;
        bh=GcvxS+T9lCh42KcPxSTQEFsBAfbdHYtlBGG/GfLCaTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0T93yoTgJ0ZumrsT++ndcfJCHC0bfqiobcTEXcd+R90cXD031Z6wKu1wOfogRWC4
         QTCyuEChf09L8A/RYtG0kFzpeMwcY+k66/8EJCmD650Rva/6hIqq2JMaW0JdN9Ddek
         VO7VUz5EgCeozfbjJ39JCjvN8e0Yd4862oaXZSN7pieVeuFWg5anQ5ejlm3t05UyVh
         INw6eoCFVVt5XGST3PeoZrZ73/K7aXDjYVZOR2B8Zh/UxzawCoFhLtofZ4d3Jm4HR9
         nwHL0Q45Ic4kdM/VotjDpU9H7U43HOXhNDu0RvA7f8S1emlTVrPdTrbVQGWK5MlB5i
         /473Ur1VjCVJA==
Date:   Thu, 13 Oct 2022 17:26:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
Message-ID: <Y0g8HEYHZYHGdwlf@sirena.org.uk>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
 <Y0gLyLbdOCetX5LN@sirena.org.uk>
 <Y0gteD0QYVlYxSZh@zx2c4.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LixpHJ3vZ/nLYQye"
Content-Disposition: inline
In-Reply-To: <Y0gteD0QYVlYxSZh@zx2c4.com>
X-Cookie: Do you like "TENDER VITTLES"?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LixpHJ3vZ/nLYQye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 13, 2022 at 09:23:36AM -0600, Jason A. Donenfeld wrote:
> On Thu, Oct 13, 2022 at 01:59:52PM +0100, Mark Brown wrote:

> > The expected users for old toolchains was always users doing something
> > like building a newer kernel on an old enterprise distro rather than
> > people actually developing anything AIUI.

> The thing is, do we really want to be catering to this? In the first
> place, enterprise users and enterprise kernels are already doing freaky
> things, forked to no end. But moreover, do we actually want to support

My understanding with that use case was that it was precisely people who
were happy enough with a disro userspace but wanted something more
mainline for their kernel for whatever reason but quite often involving
not having all the fun enterprise patching.  One use case I've heard of
is doing semi-embedded stuff where you need kernel support for the
hardware but everything exciting in userspace is locally developed
software.

> people building the kernel with a different compiler than most of us
> develop with? In a basic way, that just seems like a recipe for
> disaster.

Personally I do frequently use my distro compiler FWIW.

> It's also easy, nearly trivial, to download toolchains. Arnd provides a
> bunch with his crosstool. "Must use a toolchain from your distro" is a
> requirement that affects nobody.

I wouldn't be so sure about that if you express the requirement as
"must have control over and reproducability for the build environment"
instead, it's a lot easier to get everything by installing distro
packages than to have to introduce custom steps (having packaged
versions of things even if not provided by the distro themselves helps
here).  It's not that it's impossible for people to get things set up
but it's definitely a barrier - I know there's a bunch of projects I
should look at but don't do anything with precisely because it's too
much work to figure out how to install and keep up to date whatever
shiny new build dependencies they're requiring without messing up any of
the distro provided stuff.  Those do tend to be things other than the
basic C compiler though.

> So I just think we're thinking about this all wrong. It doesn't matter
> what's available on the distros. It matters what the most reasonable
> compiler to develop with is, first of all. And secondly, it matters that
> this compiler is easily available for users to download in a variety of
> settings need-be. And I'm pretty sure this latter part is already the
> case.

There's definitely tarballs for the kernel side stuff which is fine for
development use, I'm not aware of packaged versions.  There are things
like tuxmake which will run the builds in containers which is another
approach to the problem, though again that'd require people to control
both the tool version and the container versions which might not be much
of a win compared to dealing with tarballs.

> Plus, as I mentioned earlier, this is already the model we're going
> toward by virtue of Rust (and to a small extent, Clang) invading.

Yeah, like I say I suspect that the way we handle dependencies for those
might change if people were using those things without actively seeking
them out.  You can flip things around and say that the reason we're
happy to upgrade the base requirement for clang is that people using it
are actively seeking it out already so there's not the demand for
working with older versions.  At least for me it also helps that clang
provides apt repositories for current versions.

Note that I'm not saying we shouldn't upgrade our requirements at all,
just that I'm worrying about going from one extreme to the other in
terms of version requirements - it feels like there's a step change when
you move from things you can get in current release distros people are
likely to be using to things that will require a large proportion of
people to install extra stuff.  At the minute we're more at the other
end where it can be hard to figure out who'd even have the oldest
versions we support without deliberately seeking them out and keeping
them going is noticably making work for people.

--LixpHJ3vZ/nLYQye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNIPBsACgkQJNaLcl1U
h9DbWwf/fb8PDMCmSZVetZYI6a6yo0VcahmqdulNYMkZxpCmaiL6juOlFwPJkhye
Wc5UugSCaEKk4D1AF2J3GQztaZp2RFk7xYuEYQRDSXCrcjmdhpXe6ZNlnLGKQZMJ
Di/0WQQGJQKlx2sRBP2b43C/Pz6gvGutnst0gjTVDae6UxwRvn1YsVF5AQDNnwi1
DihIMHOxZzeamzqjNyifkj2+BggEeD95guJQzIi7TO4trIkLtSuegSYTXNuI+ZXT
M7Qg1dVtgeDgCTPtd94yG/yNhXuX7kM8c8wd3VNtJmNmtKqNzAvfZniQ7dhoswOP
ZkvXaQhemubKEpW+mRU8yhH6k533Nw==
=JF8c
-----END PGP SIGNATURE-----

--LixpHJ3vZ/nLYQye--
