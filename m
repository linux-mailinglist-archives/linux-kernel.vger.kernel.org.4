Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0FD67124B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjAREKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAREKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:10:32 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A6053F91;
        Tue, 17 Jan 2023 20:10:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NxXNj2LQVz4xN1;
        Wed, 18 Jan 2023 15:10:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674015029;
        bh=u6vMH/fNh5tDTyWkHrjyEqVd/qKhfxttm6Rbx/mW+sA=;
        h=Date:From:To:Cc:Subject:From;
        b=D63sEux0pTsqJD7vO0i57PZMjAvWSwXGvj5OfIKcxxUddaNYYBnMRcSl8zwyzsgM1
         G/WLJPJjjiY0RLi+00pykS8o3wEZMyok/tcsygsoNrROkFLhO+aJSp94XIareuoGOa
         nMOwIyrxZUp8g/4lxk0SzDsO/SNr3s8HG7/jdZ04WMI1wRFZQrpmKv01eIE8XIjtbz
         WcjqcSTmHPDgpyTBMd9CQ1vRC2lcOe5D5Um0aPgJeigVkawynExGDJ5wnsn7CCFBkD
         99CKhWAMLjFznicuIWCm+HfMlkui7cT2/3dYXcyzWwQ2L2PMmv/2BnWqrjTXF8Qocd
         Y9cuqaey+Behw==
Date:   Wed, 18 Jan 2023 15:10:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the risc-v tree
Message-ID: <20230118151028.1602fb47@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_gOJlxZcVGqlPCr6yW46Fz+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_gOJlxZcVGqlPCr6yW46Fz+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  632a9d999162 ("RISC-V: fix incorrect type of ARCH_CANAAN_K210_DTB_SOURCE")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/_gOJlxZcVGqlPCr6yW46Fz+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPHcTQACgkQAVBC80lX
0GwboQf/W24+rDD4efYy4rqwYIqieQS614ixYTE6HA0AyRDgr2HAyIc30PX6ahfu
jiy0QZvRnQjBKRb+0tv6yMkrHxngsYmHaF0qH9p56R4T9tV31KX2wDQms70qbtzJ
nWJ8SW0SQSdefgYeJ3MOsGf5q4wXTfT46e4rJY5Y8V4+TsZaNDDeM9oXVusjRsbG
+PTvqhndRgQYnZxXGRu32fo9oz0x2kNqNdSRTxQUtMjJiudcCX63UJ53NP2cI85S
ZcZWdQq15nVDxX3GC8QHcwoNuE7zapwZe8fgCKgYwp/cAW3WAqOhnWHlgheb2sbe
UkJiqsXo35G9V+eCBQZi4egESLJMFA==
=J7cU
-----END PGP SIGNATURE-----

--Sig_/_gOJlxZcVGqlPCr6yW46Fz+--
