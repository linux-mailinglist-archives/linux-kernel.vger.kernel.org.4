Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888AB69C3B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 01:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBTAmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 19:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBTAmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 19:42:05 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CE1CC12;
        Sun, 19 Feb 2023 16:42:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKkBy5bsNz4x7y;
        Mon, 20 Feb 2023 11:42:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676853723;
        bh=eIBTlVl284ifam3km3sq7RV+DiKESnsqJTSjZ6hqdnA=;
        h=Date:From:To:Cc:Subject:From;
        b=aYDTv/Ry525U9IsT/M+TC+EdsSCf4r7ELaV+9qXi6mssWk7an07w95YTDDowek3pO
         T67ttRm5FZJy35UcuASiTgPaFXidEXbnI/6b1IOGwz5/wHZkWOsdff5ssLLA75vJHr
         fRfNOVq8bIWLXhGOHmdhSvrGNgLrbXB6GWz0n16F2livEmHAWeJ7p8LrKos++20IcL
         F7jsp/xU4IRXhlTA8ArylsaiWBzdLKH4Ts9qGi7ascMhvLEBOcS5Uic/UQebbK6vBl
         v2Em3BUNTzldIq5dQB3P5KKdIZ5m8t4mUvLTQsLrr9uDONx/0GRlqSDfrRTl96BFj6
         iITGktKuBGGzg==
Date:   Mon, 20 Feb 2023 11:42:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the block tree with the cifs tree
Message-ID: <20230220114201.11659a37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xHMQmWwL4wHa/2wPSa3HU8c";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xHMQmWwL4wHa/2wPSa3HU8c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got conflicts in:

  fs/cifs/fscache.c

between commit:

  8378eea2e41f ("cifs: Change the I/O paths to use an iterator rather than =
a page list")

from the cifs tree and commit:

  220ae4a5c2ba ("cifs: use bvec_set_page to initialize bvecs")

from the block tree.

I fixed it up (the former removed the code updated by the latter in
fscache_fallback_write_pages(), so I did that) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/xHMQmWwL4wHa/2wPSa3HU8c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPywdoACgkQAVBC80lX
0GxRFAf9HdXOa0oZ0GhmiTYFLy+fF7d6k5H77OxRI5+/HgXdRqKdyW9a3sL9mmPg
79DaoH5dxfL20POFKwGUqxeJu0rfDVSFZcWVKom3E5y0eM2U6qNtiR3yJZuNRPpO
SIbK2gFWpmDRSrqsvH8zldDxdjwFPf9E1OQcFd3b1ehIoijg/CnCZoWXb9r7PcXR
/NoCoRz8UuX6STwz7dBzIBoG7yq0XIc26DtZxeDvm07VCvOzS/1GGiWj16WxhQvl
Z6k8hxXps6urJuhd1y9YY6UY08woKMLejkmB8Xa37/QA9TVtBq1vN8XI/Dr/sJ+u
eY1zOCLf4qxNTdiJgV0CP7t0rtUBbA==
=OUIP
-----END PGP SIGNATURE-----

--Sig_/xHMQmWwL4wHa/2wPSa3HU8c--
