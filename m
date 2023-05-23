Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C604970E8A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbjEWWMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbjEWWML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:12:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF06119;
        Tue, 23 May 2023 15:12:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QQpSx5klWz4x3q;
        Wed, 24 May 2023 08:12:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684879921;
        bh=vTAgYcBcJh4NpevjZHZf2EnICFjL/G5gYybK7PYAf0U=;
        h=Date:From:To:Cc:Subject:From;
        b=AdLRxI9WCPd4L8OV9SOb42lluZu69XI5v6dAFrkKL6cSRqH7ns1vKTQojJA2bQT2p
         9IyryK8uGZJue3q+t3fZSkViAB5YJ8UEXibeosyxFXx06Nch4aBlHgTVzemtONp518
         Xe8uxobbo2yztpzvKrysWspzoBvaQFccXdvMms0mFf48AusT29f3Njq5FW8EzlN2/4
         BdkKmr1ov2ctVSnM/pSycDizsYdicWqAWDvz99eHmW/WmeO2fa9cLmYJGeWKmjoGRu
         Lz0/UDgmCp5uvg9nEOo5Ze1HiAavd4ninK6EjV2BbeRj5KJurKoSdBrwDSyp1riesZ
         cvM3a50U2UUdg==
Date:   Wed, 24 May 2023 08:12:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the input-current tree
Message-ID: <20230524081200.1badf8cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s2PelWIa13j4jj.bKvPqWK=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s2PelWIa13j4jj.bKvPqWK=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  feee70f45686 ("Input: xpad - delete a Razer DeathAdder mouse VID/PID entr=
y")

Fixes tag

  Fixes: f554f619b70 ("Input: xpad - sync device IDs with xboxdrv")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/s2PelWIa13j4jj.bKvPqWK=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRtOjEACgkQAVBC80lX
0Gynkgf/eL1ZQyR23nUTqQUKjoJ9FzayHje4mEgZQFfClzLlN1vc/1CakP9fGX8n
MdVj7S1RLLLUlxuC2e04HrEYOvBG80YVnKg6ua3l3ZgtJJC2bMahr2AxRqY4dASl
3jeB+8uBNtm/fsgrPESIVICwbX7xD6pBr65OpJCmcYnVcFjXqIR74zH05i9qXK8x
+zOAhfW1O5kRi2mXwnQH72Qs4LrNxpyt+19LFqvuNmBuc9Wc+hamq0rLf3kjVcx2
yQLNZwmQfeHq/vaMjHowYIfZJH5zl03f0ygLj2vmx2RLAbo/IUa5dPQhkgkHvTJ1
w2N4TRnN8USHHlyRlQoKhFbTLT/oMg==
=QfYq
-----END PGP SIGNATURE-----

--Sig_/s2PelWIa13j4jj.bKvPqWK=--
