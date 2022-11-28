Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED2A63A091
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 05:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiK1E0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 23:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK1E0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 23:26:49 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B4BF7F;
        Sun, 27 Nov 2022 20:26:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NLC923Jv8z4x7X;
        Mon, 28 Nov 2022 15:26:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669609607;
        bh=s0ckmJzFb9AoM9lnKvO8dA2qYD/wcA2VBYQQJyZJD28=;
        h=Date:From:To:Cc:Subject:From;
        b=EAun0cKn0ho8UF3CX3MAF0Sc6oWBy9p0MUTr6fqUxL+wSirDADt8nhAhrBmXQr438
         0BlB0DF6Au4f3sAFo0dltkaEktKzdCj/4U63ajY0+3+ZK5JZJfwNtdROcjcwygMxp9
         XR/adSzO4WExThPCkZPIGDHyhPHVHj+DDk+6f+SQGuSEGznmiGrYJB41/oh4FbqwyT
         ldkwgSFcJKxuG7VrZNXWhSbLGHMQ++CgMZwKIaEnMANvnMZij1FE3/3zgBqjzXbJYF
         jdG6CgyPmpuHPQANuuAyff7aFutcdioF57WwUUG69SAwUa6tU3ARr23qEKPZIgnK78
         8TXBfNXIcq8bQ==
Date:   Mon, 28 Nov 2022 15:26:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Lin Ma <linma@zju.edu.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the v4l-dvb-next tree
Message-ID: <20221128152645.245141b6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.5K7g0MVBZKVS=XkzPf5DS/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.5K7g0MVBZKVS=XkzPf5DS/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb-next tree, today's linux-next build (htmldocs)
produced these warnings:

include/media/dvbdev.h:193: warning: Function parameter or member 'ref' not=
 described in 'dvb_device'
include/media/dvbdev.h:207: warning: expecting prototype for dvb_device_get=
(). Prototype was for dvb_device_put() instead

Introduced by commit

  0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")

--=20
Cheers,
Stephen Rothwell

--Sig_/.5K7g0MVBZKVS=XkzPf5DS/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOEOIUACgkQAVBC80lX
0Gz95Af9EMxuJb9Gq/JjwoOVkJc3E2Cj8XtVLxJx7gV+6/r+Kfv80mgF519V4DpU
gNrqZuvo9SzrEdcQs7pq1aRLJ+/zPe8mUklFeLq4dIpGTdMJ7RikLtrIRg1h5RNI
bCguO4bcs02cPukU6/spAk51JS7+t9/WyFZb7vZZhuFvDGWqfU9gipcAD9GsBGoT
TFx8xPISu0MWmx9H4FyUyIZh7R1TiYmnCFkZ5gjsBwqvBVgM0HoItp91Hg6nYGvu
L4NqgrrzIgiSWxmxiWALrPfWCipVgGshqKw80QPXw3zW1kdrWjAMC9CDwQYM6ZgL
Ou5ezc8SuuG1dE/0ZvizsjfOD+SWPQ==
=FSHE
-----END PGP SIGNATURE-----

--Sig_/.5K7g0MVBZKVS=XkzPf5DS/--
