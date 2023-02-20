Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD5669C3BB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 01:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBTAvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 19:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBTAvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 19:51:00 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1218BDEC;
        Sun, 19 Feb 2023 16:50:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKkPF5mWRz4x7j;
        Mon, 20 Feb 2023 11:50:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676854258;
        bh=FT4HmflXkNRJsCIexIFENG2HM0fP4ER5q6khNnErFwA=;
        h=Date:From:To:Cc:Subject:From;
        b=YC20eCPmuI2GYmxG7zrl+Q+Nbaz1fN4kW6Dh02fjAUm55LJm9UZD15I0qjgxw7aza
         4HDLTBkrDPcZpN1rTyuTxZFgWiHf1xddZNr5hugxAEG0vubKcjZk4cuxGmBBfBdEoY
         D6j3o3sY6qxPpBwC5LZhMfAPUXr+0/y7d+vGnGzuDXFT6fHr07NOgeILM/ml7Zs6Sq
         GNmI2nJ9ZaMGoF8v5emgyoD4wBxYXisZAyIN8BCXnlvvf+avfIb3Mxv3BF9f6GPbhb
         +tIlb6pFPRpbfyaxeZGPi0d4enVyGODlFSTYf1ecxF+Dk+pEq4RAunIsJNcL7qhEt0
         hrP1vGQCFefYg==
Date:   Mon, 20 Feb 2023 11:50:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the block tree with the cifs tree
Message-ID: <20230220115056.22751cf6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.pnJTFBH=.MHEZKa1YOF8LE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.pnJTFBH=.MHEZKa1YOF8LE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/cifs/smb2ops.c

between commit:

  8378eea2e41f ("cifs: Change the I/O paths to use an iterator rather than =
a page list")

from the cifs tree and commit:

  220ae4a5c2ba ("cifs: use bvec_set_page to initialize bvecs")

from the block tree.

I fixed it up (the former removed the code updated by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/.pnJTFBH=.MHEZKa1YOF8LE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPyw/EACgkQAVBC80lX
0GzA4gf/ezrbWjNJmt0MuSYZNGCQ6RbWYoB2gSDqn4MqMla5Mh0Oi0MRxY0c+Oat
S/AYZXxICXcUJcleCmFgdUczrSCdiqW/YUpthvAhMF60jYpWCr8TINLM2eMatLL9
qGztP1NrJIrike32F8qQC3WfmKTysREHZF6TuPnm3zjfHDCRi4mgEY+CdYnrTu3O
dMQrCI1nrtrmb4rS2g3fIhWaPEgVCnUTY0/iegXOeYIDZRJqHPbKlbrFM4edE8vw
sE49iC2tlyfKcExZmcJa3JXhvSDf0j3BpyO4f0Kx8nedoiKwp4qh5FFjDWH8ziI5
WTUYTYkGv/ZOv3mYn2fe0AuJBi4xVg==
=AmTV
-----END PGP SIGNATURE-----

--Sig_/.pnJTFBH=.MHEZKa1YOF8LE--
