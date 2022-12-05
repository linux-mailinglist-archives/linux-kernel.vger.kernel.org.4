Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AEF642166
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 03:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiLECME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 21:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLECMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 21:12:02 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF2112A8C;
        Sun,  4 Dec 2022 18:12:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQRr94Cr0z4x1H;
        Mon,  5 Dec 2022 13:11:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670206314;
        bh=47fI970nCbAtDsVXIob2q/VXxrdUuAylhwDVGCzCJM8=;
        h=Date:From:To:Cc:Subject:From;
        b=vK8QkZxlv+4bm4vDWZZFdAP5IXIzW9KBbaLAJLNapw45QMex3o516+LiJALTCJp28
         /5ohp4QqDFLYAQNqQck4FnyBLyW5SuMvdISpJ60FrFWJyRH5ivHF3FSHlTX+JVYiEh
         wz4nqedfacufm1LQugzExST4Ey4oq8ZBpVB42Y398hnfNzdKKbEz/urcwVjQTrNDW7
         kQqBQ6dSYRdfR2gL9+JPDf2rno1gyX7G/RH9Nr/NRJr0eOFHZWH2xTCIsre8s3dC2T
         9KrvTjx4vnNzabFFvZtPjScZTNUKFe3V5U+8+JSM0IaDyicuKj6JMplbibe0P9Wtz8
         EQY/1cRTIOMWQ==
Date:   Mon, 5 Dec 2022 13:11:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the driver-core tree with the block
 tree
Message-ID: <20221205131152.26c49399@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dkNr_BLgZrxgb1OvV7weeVh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dkNr_BLgZrxgb1OvV7weeVh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  include/linux/blkdev.h
  drivers/block/pktcdvd.c

between commits:

  f40eb99897af ("pktcdvd: remove driver.")
  85d6ce58e493 ("block: remove devnode callback from struct block_device_op=
erations")

from the block tree and commit:

  be7e8b917ead ("blkdev: make struct block_device_operations.devnode() take=
 a const *")

from the driver-core tree.

I fixed it up (I removed pktcdvd.c and used blkdev.h from the former tree)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/dkNr_BLgZrxgb1OvV7weeVh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmONU2gACgkQAVBC80lX
0GxwmggAmtiB+NOQ5K+ORB2SsdyoSDOqqb4saMnpJIb0KnmLbGUcQJMWfnNRKrlq
l0gLZdZ/98Tvr1rudnOozLNOtbgznp40rvXMoyAT1lhhwB29MnEAjjxgoGJePDfG
iA/OsHRDOx4LkFDpe2+SlmrZjzeQYBNb1YXzy1K0bZGmv5h8SP6R3BlbV8aMMLmp
pScAUPqflcGprqYUjXuHwn4nxNr0E0mRNFSLZSN8OXn+asA+NnDFm4IBHBVkPS1b
jqGG9IOc4/rfm6LfeFzgYmWbaw4/ZPx67uID4yd6UfVkudraQs2V/vQSzJGLnaHc
yvihy+mIwB/fmF4dq1UdvROOH02q/g==
=+DPK
-----END PGP SIGNATURE-----

--Sig_/dkNr_BLgZrxgb1OvV7weeVh--
