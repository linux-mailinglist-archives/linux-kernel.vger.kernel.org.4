Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9B368021C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbjA2WCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjA2WCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:02:37 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E2B211F;
        Sun, 29 Jan 2023 14:02:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4lff337Pz4x1T;
        Mon, 30 Jan 2023 09:02:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675029754;
        bh=zCu9putZCOmDox5f+SfJrESoNX5BceeobEQ5dz8Xhpo=;
        h=Date:From:To:Cc:Subject:From;
        b=jhZPZtd4F6Snfko6CkoFT/OeUCP+mq/kzFBYmLpwhfEMGdnA9NrzpiEqXS9TwfCOi
         JdcvK/5cpUMKHsYmJwU3PPoFfG1j0nZnzC2aRUX1qKw0/WA+kcD35LK0/9o4q1ov6T
         y7eFwSmtlYHMW0qpRAkYzWkezcc9zKJFEKshiKq6RquwOO+3CcEfIB+zPD4kEAqYlG
         o1XWkITAvIpe4lFccIUDk1uqYqRPERFmuGk4xPNRV2oEa5oyp9j69skliV1ibzluv4
         ySXz9/tpbAo5mNEWY8JAsrbIEUA+uW2YKl8xl2MCg/lzjwh8exx3bFeB7se0VLXDIP
         Uab/kOj9zCb1A==
Date:   Mon, 30 Jan 2023 09:02:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Dan Johansen <strit@manjaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the rockchip tree
Message-ID: <20230130090233.67f2c5f1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uXvIyiQ=byoW8INb9.XIBcI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uXvIyiQ=byoW8INb9.XIBcI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  96e908b46e65 ("arm64: dts: rockchip: set sdmmc0 speed to sd-uhs-sdr50 on =
rock-3a")

Fixes tag

  Fixes: 22a442e6 ("arm64: dts: rockchip: add basic dts for the radxa rock3=
 model a")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/uXvIyiQ=byoW8INb9.XIBcI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPW7PkACgkQAVBC80lX
0GyPAAgAoA1o2E3pqKD0vBiq8sk3NiNBzgIC03sLTjDiD1/1sY3ie5w/vrvuUyuT
TBy6Sihi1wTXgXBv0+VkoA8huPDErAuRNj+U3A6fkcMqE+Psgt/EDc83KWbkyNXY
6u56nWey54TjwOw5EN5suLKjHckxJEjA1v+uUmYwJ5dcwzdSdtFUP5TU2qmpTagW
DvP8LTPgx8wQK1OvuV8rLyGl+SwH7AtPWL50pWKyc4GqH0fSEAwJiXGhmJ+ut13C
AnVeAqrvownibCiCplZhrgZv/QJRs3xRxAJ9NdPSAkx2xfVkZ4eSg7+W5ABBw4n2
tBFgpylXmVwOzxssPsPUpb+GO1zYeQ==
=7/nO
-----END PGP SIGNATURE-----

--Sig_/uXvIyiQ=byoW8INb9.XIBcI--
