Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CE75FED0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJNLOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJNLO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:14:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB801C77C1;
        Fri, 14 Oct 2022 04:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E849B82260;
        Fri, 14 Oct 2022 11:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB04C433C1;
        Fri, 14 Oct 2022 11:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665746019;
        bh=NbNjkJk3WWEqHVvhDnG9kCdbSC0pN4vGvLiznRoMfJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RymSTLyxZs/j3SUJqlXcOKahVLY7Cf6B9oMnotZmfq+CM1HU0IVVcK33hkiIIb5jQ
         cDy/f9GSrHM4G9Aewg2C6dMgFElufEuAFzOqpnhJFEQJIfY+0IKeXly6hiNb7bkQN8
         rjbHznBISp0QpXXHnIS5BIlKsEqvUqGR44faikCSVhYnZhNypOjdy/U8NxxzGFz82Y
         2j0w8lHWX5g+R3zog4QaObLHHPIxbfuzaxScKensViBRdFkabmvGUzvErUDfy6D8u3
         UD25EApLFPrqUL0rNFXiFm7apw6Y1kXt714vopwHZDIAT2y+z5n/xHKJ6IAOjUvkz4
         PmKsP6WynGdXg==
Date:   Fri, 14 Oct 2022 12:13:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
Message-ID: <Y0lEXhjcl5MFaFIq@sirena.org.uk>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
 <CAKwvOd=_gfTD24zEh9YpoNuBr_D+xjsefeb8sNXnSaU_UgnVRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="beXBv3HrZ8c1Z5yV"
Content-Disposition: inline
In-Reply-To: <CAKwvOd=_gfTD24zEh9YpoNuBr_D+xjsefeb8sNXnSaU_UgnVRw@mail.gmail.com>
X-Cookie: There's only one everything.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--beXBv3HrZ8c1Z5yV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2022 at 02:08:22PM -0700, Nick Desaulniers wrote:

> Are the defconfigs totally broken with gcc-5 and gcc-6 and no one has not=
iced?
>=20
> I wonder what versions of GCC KernelCI and linux kernel robot are testing=
 with?

KernelCI is using GCC 10 at the minute - it's mainly focused on runtime
testing coverage, we try runtime tests for everything we build so we'd
need to do some work to curtail what runtime test gets run on things
we're mostly doing for build coverage.  IIRC Linaro were supposed to be
doing build coverage of compiler versions at some point but I'm not sure
what the status is or how far back they go if it is running.

--beXBv3HrZ8c1Z5yV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNJRF0ACgkQJNaLcl1U
h9DJYAf/RashXNRmXkE8eAUJOdekyw1hYk678BDbC/OQOdC+HS0pN9/LUJp5dRrV
gqp7oQITQ9Ue5v7YmNgfWtn1mWOeysy/XzhalrQC9TbWqOdvJVoXcXU9HQQWegcg
VhFWIbkj4hnN8kP0VEFXRAKIOblTt9t6QT5R+fcs43CFnlEY4OxauIJ03w+Y0Nrc
UxOx0kU/poZlM34klGZOHMymbeRs+DsOelGpo8NUr7pKaG3Q+ppl4xHrDImdNrng
sv9q1dJDc3FmTviGgcBBFiAPkesHrFsFd0c+WKZ3TtZxcUlBxh/7JRK5rwC6AUpb
O61JJbJ6ZdHxV4RUomHHHlWZYTNyAA==
=VRq9
-----END PGP SIGNATURE-----

--beXBv3HrZ8c1Z5yV--
