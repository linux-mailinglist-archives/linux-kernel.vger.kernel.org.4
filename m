Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD366656B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjAKVRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjAKVRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:17:19 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E3619C1F;
        Wed, 11 Jan 2023 13:16:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NsgTh34gMz4wgq;
        Thu, 12 Jan 2023 08:16:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673471784;
        bh=TVrLDAJDtGlb3Vpkjqq7DnY4TM1Q8BDSADpfcGYo/mA=;
        h=Date:From:To:Cc:Subject:From;
        b=WHUakgGaPXCajLuLmM5R2vsrj8bbXPUieA7TZd/iPRxR7BeWVaP4gNTc+yL4FLX67
         MndPtd4a4FFh7bJXQTfvzsB7XxsQwr0rGfF8ENh6LkihijVux782+vAAzPBJqBoWX9
         xXBJ6O8QWeYz4QP8AokWCXQqXxFoK6bflV3MxigMLcpw+w4s3sRyNw6z25su9Fc64L
         65i2LIHSTXOgJG/jpE7SW2p/PgRGOwJyJbSIxxtXN7z1y65JFg5i5M3XVxer7r11lk
         L3aCvdEeXXynsH2lZKd/1s31CoF7cGFSKzMeq4hLX+BsjezH4+RYfPfCPnVtsyP4PA
         +VmOzv7F8jtcw==
Date:   Thu, 12 Jan 2023 08:16:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Perry Yuan <perry.yuan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the pm tree
Message-ID: <20230112081623.4537b43c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3_cE79EG7N0o=28mNAqS3yg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3_cE79EG7N0o=28mNAqS3yg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4f3085f87b51 ("cpufreq: amd-pstate: fix kernel hang issue while amd-pstat=
e unregistering")

Fixes tag

  Fixes: 1d215f0319 ("cpufreq: amd-pstate: Add fast switch function for AMD=
 P-State")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/3_cE79EG7N0o=28mNAqS3yg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO/JycACgkQAVBC80lX
0Gx1fQgAis4DCNf6BhWt4fBIT4LVUNVdCjODXvdWvaxShJfdxTWyf+uepAVbr3Jo
lDv48R9BMkY8rVRPtS/yL+ogT1vGuEErehveO18vme0UsmgQfMh4zIcfStD/dQcP
k1p7dT4ip1rDCOiuOauf8NebiaFWRygeaTLGaeElbbewecMJZmckIdK/CZypKmOG
vIygwn12daC+jWFBf6WV72OKw99ix70eB/hpdnTX2x4DhP/nKqN/ltf+A3O3nNQk
51R5Xh/+ythyaSz5lU64a2Y5xOXhGlyR2saoUrz/pyKKd/MVGdCOF/bNnxVpAM7I
WYhAT5uWvUJrFjm6+mE2q5vMnkrO6A==
=JTnq
-----END PGP SIGNATURE-----

--Sig_/3_cE79EG7N0o=28mNAqS3yg--
