Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5004B633BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiKVL4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiKVL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:56:45 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B3126AD4;
        Tue, 22 Nov 2022 03:56:43 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 24B071C09DB; Tue, 22 Nov 2022 12:56:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1669118202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=bLu/KvzJPCTB/Xa7S7YY3MbbLXv7uV0njFU8uvir2CM=;
        b=EDHX+WnCmFMJzNVMipcOujGTEfG4y2dPEqZGEmYyyTFEzrhRwKwVpL+cN/UP3CC5OUPF97
        qKfjzGpjBNGhmY4NmP8tNeoM6DwV2ah3XjObU60xPt4g3p1wSct8jluvAB5O3M+rMzWnJe
        w9jN9XGLem7jr/QogEzlCixGhfV0H+U=
Date:   Tue, 22 Nov 2022 12:56:41 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: nbd: please don't spawn 16 threads when nbd is not even in use
Message-ID: <Y3y4+QqOlF00X9ET@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xPdvxnZFnwXOEoiz"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xPdvxnZFnwXOEoiz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I see this... and it looks like there are 16 workqueues before nbd is
even used. Surely there are better ways to do that?

Best regards,
								Pavel

    257 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd0=
-recv                                             =20
    260 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd1=
-recv                                             =20
    263 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd2=
-recv                                             =20
    266 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd3=
-recv                                             =20
    269 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd4=
-recv                                             =20
    272 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd5=
-recv                                             =20
    275 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd6=
-recv                                             =20
    278 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd7=
-recv                                             =20
    281 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd8=
-recv                                             =20
    284 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd9=
-recv                                             =20
    287 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd1=
0-recv                                            =20
    290 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd1=
1-recv                                            =20
    293 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd1=
2-recv                                            =20
    296 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd1=
3-recv                                            =20
    299 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd1=
4-recv                                            =20
    302 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 nbd1=
5-recv                                            =20


--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--xPdvxnZFnwXOEoiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY3y4+QAKCRAw5/Bqldv6
8hPjAKCzzoppkzpcMQzHpbLeYPjW5+/pfgCgn+QgASwdXiGIGIJSvP7peIs5mLo=
=5DEI
-----END PGP SIGNATURE-----

--xPdvxnZFnwXOEoiz--
