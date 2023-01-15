Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1266B40A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjAOVF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjAOVFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:05:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B715012841;
        Sun, 15 Jan 2023 13:05:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nw7303zYpz4xHV;
        Mon, 16 Jan 2023 08:05:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673816716;
        bh=dkJJhPu6Eq8wnccHsTI9yKUaGqP7Gikme4opFmbVGB4=;
        h=Date:From:To:Cc:Subject:From;
        b=X2A940sycdJUG2FKVSVxCxdMJwcJ2UWG7QmWYqHEiCaLbSoGAhy15OzWypPXtGP3N
         xq1QUiK6irlhP2m8d4rkC6mLpnslaYbvhtqzkSSDq/DQp/+n0zDo4riPgFmxvJQT1S
         OosykDKJL8m9cDYLBO9I2gFaNn51/NkLdntp5C1Dq6yyLlFo9rBDydSa9qXBL8ZIBN
         AwjKOchD1DsNK9k1FnH2ythzg9vrfZJ6ShwP0rRdoILBwFmKpXKURFlAxxLOuiF0Zb
         A7P0/TKU2kDZ5kcKi84hBgNAp1FT79es6tKDHU3Ju+dqAo4AhkFqHsUgFhUhM24+3D
         1nmruIsnkjXfw==
Date:   Mon, 16 Jan 2023 08:05:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the zstd-fixes tree
Message-ID: <20230116080514.34ee3baf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.Bv41YerEpnJfdZ8z1YvSGf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.Bv41YerEpnJfdZ8z1YvSGf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  8cbf4bb547b7 ("lib: zstd: Fix -Wstringop-overflow warning")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/.Bv41YerEpnJfdZ8z1YvSGf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEaooACgkQAVBC80lX
0GwbCwgAhIML8DUxDB+dCJa5Xt4XKpDgttbd1zezAt4by00OvV53GIhGY1WeNPXE
D+pLA88fZDiRGH9S8rrJEEklN8jSMI90eE0LMuuBYfs9biONo4gfsIGL8fwv2eJN
NS5j3aTxoX+/icJK44xLM8O3IDUBEGZG4CdW3a4FsE1T2PAfg0MrVso3+4m1O4wM
2kMPlB53qyOZWd8FnW3q4L8mt4iFNQK6LPVnykp78QLSNHAwRJ49mFXuh9mU8ydj
0WRI2viZB0t9ssAruG4wskIO4ChWtgmDLsDbh9OG8HQn5vFOyIFu+S4Ca0RdH4ed
ASF0wSo18o8WznafyxwSKcRfjTjhYg==
=EtUr
-----END PGP SIGNATURE-----

--Sig_/.Bv41YerEpnJfdZ8z1YvSGf--
