Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C496FE7E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjEJXFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjEJXFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:05:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4333065AA;
        Wed, 10 May 2023 16:04:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGrFm3QXbz4x3g;
        Thu, 11 May 2023 09:04:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683759885;
        bh=tTpG+ABzn2ZUqISn9XxbfeodhS9FYuzOIfhGYTqJVc8=;
        h=Date:From:To:Cc:Subject:From;
        b=KidURmCfHk3g93+VCNjrXg1pyeKO8TbkfxPITrpChw6RqXoxp+Mw0AA4bcmtr3vIO
         kzuEyWCWztMe/Gm1YAj//CRKsAa45WUPX3UWp5l9xydWeWO7/tK2t7GfROTsQtoOpg
         jsnfeLRU89ES4wmLXAYGY/I/lzV5B28LraBohqiSJvNVnPX3mv6BrBiLb9mbORJR92
         gNyxUqkLeGSX19F9IVFz44XLNJY7aXyTlEJxo1UYgJSUo+NO6YS7Y433SbP2RlUkYw
         V55H7y4FaXmbuR9+okOYxcYnj4ZM8466FniLu+HD149ym3mALGdX7Jw0Cy49NJEWiH
         5OoeCxMIscpvw==
Date:   Thu, 11 May 2023 09:04:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the leds-lj tree
Message-ID: <20230511090443.359b120b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hARB360zHctH=7F=L4ssbde";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hARB360zHctH=7F=L4ssbde
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a `different
commit (but the same patch):

  fea27b037127 ("leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED dri=
ver")

This is commit

  8325642d2757 ("leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED dri=
ver")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/hARB360zHctH=7F=L4ssbde
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRcIwsACgkQAVBC80lX
0GxLTQf/UzW/BVSiljzyguuX9tYXP/Iu5dz/QuI/E/pwDuDzuirV8Bm6ly1+pFWd
jCXEG9NV3ROyclEo3KoJQWLYmyj/Lh0VffigaXPxBXElG2GCZATqEGmVL9e81+xz
/xFf5y5lolNm/LhlgOt5jQ0p0TC2fzCDOWcsGNJFoa0P3BNFAhc6cvEpwcWF0U7z
48SSEHVN2hxMskoibmnC8cWUk96HhLHiZdkHYksWAf8nK9g/FRiIzILlPOws03wn
mSVm1hDaoUJix/XbUSgUM+L/10HtYpP4C/eA5eUwWohMRjt9+AB1/jdgwmBCm8lu
WqxbO4iubs1lDrC0HP5jUr3LQHcvkg==
=S+yO
-----END PGP SIGNATURE-----

--Sig_/hARB360zHctH=7F=L4ssbde--
