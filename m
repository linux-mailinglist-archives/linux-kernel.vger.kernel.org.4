Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55F873AE6E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 03:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjFWBpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 21:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFWBpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9124E2113;
        Thu, 22 Jun 2023 18:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27B8361939;
        Fri, 23 Jun 2023 01:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7B5C433C8;
        Fri, 23 Jun 2023 01:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687484741;
        bh=et2RyEAtrTCPeg7D75ZI8ND75zNE3OwXD5CZqqPNfHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qu60KtgRlkwuexNOqn8m1uRQipIaD9P9c/rUCu0x2VagvCAyeirwQfHMPj8o/Jlpg
         Cl+5TCDELwrHaTKr0FnVb5p4JpPdGJzLCRAI027EdBKHpf3sOQ9CT+tpZmhx13hPa8
         vsDtRHA4IphjJnGKxy9lGDqGMMC6gGhLHuhL6VG2D07bqKVUj1c2igU8kF4BXTHDrq
         AwA8rEe+4fYyPHdGPGtZNXuqTTS/R7Pb1HS+M/TCLYUvDemvKZz0icQtGnF0Sumnss
         Pivwc3I18u3EBxQf7G47lHuvvCk4hmhOV8Q/R+kYR4PyexJ3RDC4x7Nu3IpKNlvpUa
         Ya7z5f4lhKlAg==
Date:   Fri, 23 Jun 2023 02:45:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-doc@vger.kernel.org,
        tech-board-discuss@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Tech-board-discuss] [PATCH] Documentation: Linux Contribution
 Maturity Model and the wider community
Message-ID: <ZJT5QYBxmGWneAOo@finisterre.sirena.org.uk>
References: <20230620212502.GI286961@mit.edu>
 <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org>
 <2023062144-hefty-why-305d@gregkh>
 <04cd7204-cdee-c333-8815-57acbab82721@linux-m68k.org>
 <20230622173913.GA34229@mit.edu>
 <f54e2fc8-0aba-3b62-7870-023f25e11e8f@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ttfLmHNA3y5JxN5d"
Content-Disposition: inline
In-Reply-To: <f54e2fc8-0aba-3b62-7870-023f25e11e8f@linux-m68k.org>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ttfLmHNA3y5JxN5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 10:52:08AM +1000, Finn Thain wrote:
> On Thu, 22 Jun 2023, Theodore Ts'o wrote:

> > As far as getting upset if the latest release doesn't run on "suitable=
=20
> > hardware", if they are upset they can submit a bug report, or better=20
> > yet, submit a patch to address the situation.=20

> I think you've missed my point, which was that some maintainers require=
=20
> that released code is executed promptly otherwise it should be deleted.=
=20
> Please see also,=20
> https://lore.kernel.org/all/7c2a6687-9c4e-efed-5e25-774b582e9a27@linux-m6=
8k.org/

Looking at that thread I'm not sure that's an entirely accurate reading
of what was being suggested.

> > And of course, if remove a driver because it is unmaintained and is for=
=20
> > obsolete hardware, if someone shows up saying (a) they care about that=
=20
> > driver, and (b) they are willing to volunteer to maintain the driver, o=
r=20
> > are willing to pay someone to maintain the driver, and they have=20
> > contracted with XYZ developer working for ABC company, then it's super=
=20
> > simple to revert the driver removal.  It is, after all, only a "git=20
> > revert" away.

> > I do have to concur with Greg that relying on this as way to get new=20
> > people to be work on Linux kernel is a *terrible* idea.  The number of=
=20
> > people who are interested in retro-computing is quite small, in my=20
> > experience.

> Given that products like mobile phones etc. often get made obsolete withi=
n=20
> a few years from launch, my guess is that billions of users are now=20
> interested in retro-computing.

The whole situation with embedded devices and their lifespans is a bit
different to that for a lot of more PC style hardware, and TBH if anyone
is actually interested in the hardware it's much more likely that the
support will be actively maintained and the issue just won't arise.  The
pushback with obsolete devices is more about a lack of anyone paying
attention to them and them causing trouble as a result of that than it
is about cases where someone is actively looking at them.

--ttfLmHNA3y5JxN5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSU+UAACgkQJNaLcl1U
h9CTHgf+OcU+naqmbbXtP/d8J9P3CsjwJdhGhUdhNkPQ1xJ1oE07KTsgRSqY7Icr
4u+7wr+rj8LRmNdJ0B3e3q3SMo2L6gE1pIrQI1uKpXGuqcf9arIrk92WFNjqHgoe
opsxNBefbNFl/t4cqHPj3chs0qEA/sOQAUWc1L7tfe9ut7GQKbn7zOoGTDrKuF7X
hn8DK4ahrJYA7qLnU4WQJGk6//dEjnGWu5Axcu+ZWp0OiyDhi221NDrF3j3FsYxP
t3epKPsR2ZNL3Py0/warvpwuJiF5uDUwxCRyxVjlUKzlnHr/t6xZ1EoDW8Tgylvk
9zdGhPhWKWPrXreN39GaR/rK7yEo5A==
=t4oi
-----END PGP SIGNATURE-----

--ttfLmHNA3y5JxN5d--
