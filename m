Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7992967D89E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjAZWjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjAZWjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:39:07 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2B84EF7;
        Thu, 26 Jan 2023 14:39:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P2wc82gXMz4xwp;
        Fri, 27 Jan 2023 09:39:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674772744;
        bh=nAcG/YYvgYCoLwfwltWnqDMCWXVKQpjGcIiUMSGG6w0=;
        h=Date:From:To:Cc:Subject:From;
        b=hD5aY3Kzkm9INMo1LXVkl0OcHz4/bBV9GwLnOeouAdgLXLhZGX15Bd2hM5QqgkZN2
         Iw7cqzc1OMPZNe1oLoWDf9TjdN7CsOaQQGb6LINsLYybf8XGi0N1vyp+6QHl3+Pqup
         fblaVNTAlFQ/k6kArshO3tdoZScM6un9OSEa/5pwjVLmPOaOFMpRbC/26+2wwNSxrq
         AYZ7mdrmD7ck2XuG17MT53XdgKQj/JzIs8wy62H7UqnR6euagwGoVogG1+gH2LqyHK
         qr1exx3IeEsYyUAu+dZM3aklNUBUnUEY89kSM0JsSY+s6WEsf2T6UUIWoYNgRpKjkb
         wgfQsqXL2DPnw==
Date:   Fri, 27 Jan 2023 09:39:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the hid tree
Message-ID: <20230127093903.1f60ddb8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eC2Nj93nWtQT_kEE.9u_2PW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eC2Nj93nWtQT_kEE.9u_2PW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  82a3e2fb3e96 ("HID: logitech-hidpp: Hard-code HID++ 1.0 fast scroll suppo=
rt")

Fixes tag

  Fixes: 908d325 ("HID: logitech-hidpp: Detect hi-res scrolling support")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/eC2Nj93nWtQT_kEE.9u_2PW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTAQcACgkQAVBC80lX
0GywyQf/WaEHTFdEiVv4BNR5RSQhIJBAu8V5rO1MGvtozQ4G5cynqqvJTyzcIUMi
TTowkDvOM4MkUcrMgiqAAH14oRsL3M+4x6+UqeuR650TCFWo7f3qOdeCV+ue+iN/
ZKoIX4YjF+GK1hxvJqkJOBkK0KlXfW6f2cR7luWS3njHGxBZYDG1N1E2bjnsL1sP
dHteAJWmJJEj4J67eRpOZvXH080dmViGH4Gn0b1kfE63wtthmBAtCYpn0u+TrzSb
19NLwILAVDC6viIycA604zyraHnuBC41YIu4TsrnGCjZrTgttSdzyQ0pBAS15peY
wMYC6PufFBWuiWjZzthsOs/URgUUXg==
=ZNKn
-----END PGP SIGNATURE-----

--Sig_/eC2Nj93nWtQT_kEE.9u_2PW--
