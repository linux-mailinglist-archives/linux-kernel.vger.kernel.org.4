Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8967118A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjARDKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjARDKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:10:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FB34FCFD;
        Tue, 17 Jan 2023 19:10:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NxW3C1FQbz4xMx;
        Wed, 18 Jan 2023 14:10:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674011415;
        bh=lWBiSX+T0gL68sI5reEUW7ei1wmZME2hPWkNXUd4p1c=;
        h=Date:From:To:Cc:Subject:From;
        b=FdVsQeWcCNW0QVZC3qPfM91QYQBxT4iXWi4CCIBJGetIAjIBuqdKi+YwKQN9W+lse
         PrOGpkwj82JMZCd9KJXl6bGL+K426TpDEVpmUKZZmLKgxC0qHGpS5+PQfhSfCqNhOm
         CF7TW7PSk7PptLJELh1rkNx90A2JhFrxt0p9qzdkBOsrUD0QJIp5sb78uyC2kDK5VJ
         /tRU3fmLCIU0Sk0p/a+DyctET07Bk81uJ2HE4bDs3o8xoTa6X9HNpZP9MmJOWNjr2l
         hYlT/1kLupf2jOXjSyFAU7KElccRbPy3NTu76oMcYsgvG03H1DzWE78tnY+yhx3urM
         bc2Vm7fDV533A==
Date:   Wed, 18 Jan 2023 14:10:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20230118141013.26289956@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cKzDZtc+=yEGZkph.7CWCd4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cKzDZtc+=yEGZkph.7CWCd4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/block/ublk.rst:157: WARNING: Enumerated list ends without a b=
lank line; unexpected unindent.
Documentation/block/ublk.rst:169: WARNING: Enumerated list ends without a b=
lank line; unexpected unindent.

Introduced by commit

  56f5160bc1b8 ("ublk_drv: add mechanism for supporting unprivileged ublk d=
evice")

--=20
Cheers,
Stephen Rothwell

--Sig_/cKzDZtc+=yEGZkph.7CWCd4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPHYxYACgkQAVBC80lX
0GzRIAf+MXL42d8KJ0lAvz3qLpi+p3nox3PlSfbBPmD8cmc7gmRDERSTYhnJYSIj
gOAXFfmhN7ubDB9cn6SM8njOr8R64vdUvw6dRRc6NCICbgWSCWR9ufZxrGtxC+Zc
eFyArSjLmMHvoF1E0hPxch4RuOBmQO3D9LJZn1QmDERgRVS+NqNXQ122487btWMp
0PLuN9QyanhG9KnQw7pX+h+f845RBFFQ4gA10W5HufdFU/dbrsgXrB45DzN6ZQbP
hsWs+603Xm6mYrKJEeZt0LM2Mv7T/7Fg/ROJYx681WXE2d7u5P4tz6iyPO2hi12R
vbGETteLuRlvFk24vOTqA0IqauilHw==
=LBnu
-----END PGP SIGNATURE-----

--Sig_/cKzDZtc+=yEGZkph.7CWCd4--
