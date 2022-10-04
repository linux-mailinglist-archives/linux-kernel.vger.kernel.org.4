Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77A15F3CC8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJDGeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJDGd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:33:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452048E94;
        Mon,  3 Oct 2022 23:33:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhSb82LP9z4xDn;
        Tue,  4 Oct 2022 17:33:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664865236;
        bh=b8nxpO5hLVQWdUZY49AZ7JzIRI0LCnM4GIc4792Lhpk=;
        h=Date:From:To:Cc:Subject:From;
        b=gDTYPQz7YQkeJnIPNrire64OzzKSbxBuAibtFoPWCuDMgnFdAP/F0A+G4v3eh1yU5
         yZgjwtAt7rrAtYcsdlHn2HL5/cMBU2FzU7oK7dSRfq52A+F4ZK7+MRrsBbVW5ZvMYt
         SPJuQXvGtbRSnj76c5y4Jda1rfYHvlf0YZAPlGlbA4h4sX3+GiOKaZByLNsunNlWiO
         dcH60N0UplyYUQtysqx3hnOFzkrDdXbSfHvGBFDDARNrpYYxSDAb8w6jOyD2hzuEkS
         FbgswjDVM2S0TgUXvOm61laadNk9yPDV2eVTJVq9wwUX1gpwHdMeWoPMDFWEPV3oGW
         1CZWz9510g+0Q==
Date:   Tue, 4 Oct 2022 17:33:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?UTF-8?B?SsOk?= =?UTF-8?B?cnZpbmVu?= 
        <ilpo.jarvinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the staging tree with the tty tree
Message-ID: <20221004173354.141e1a5b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qiA9o1QSv=AsjgA6o.C1/5f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qiA9o1QSv=AsjgA6o.C1/5f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/fwserial/fwserial.c

between commit:

  a8c11c152034 ("tty: Make ->set_termios() old ktermios const")

from the tty tree and commit:

  db65becab2a3 ("staging: fwserial: delete the driver.")

from the staging tree.

I fixed it up (I deleted the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/qiA9o1QSv=AsjgA6o.C1/5f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM709MACgkQAVBC80lX
0GyI0Qf+PHw2IO7Ml8DG734fQb2uA6AwNPuSrwtOn//R+tSR2s/Dte3O6mp7VmZB
j7hu56R3edxmjydfiCHHmeLUYhXG5iHCS1FPGjgSB++UKEEzFeea31w8Ne+f8oGh
nPe/Tvwv58FU/ydlrihP5+I0T2pV2Y6MThjLOtnSsRmhqiV1G1c0VrrcMX4KqmqA
SED+WSPri6Zg2OqHr/EsURL70YV3E1vzKWRGZjVCtHyQxzO92MXF3EO3QJxmtao0
eh2vkQemlec6WdX6Gst1V5dt7YYsKeOTERZIFqnin6j6mWN+8OUad5pvQmrKv8wX
g+SvdNC/tjh8DBtiXGW9rPWT7EKHOQ==
=S41f
-----END PGP SIGNATURE-----

--Sig_/qiA9o1QSv=AsjgA6o.C1/5f--
