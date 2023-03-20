Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDE56C078B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 01:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjCTA7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 20:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCTA6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:58:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED81E1F9;
        Sun, 19 Mar 2023 17:55:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pfx8R4x99z4xFM;
        Mon, 20 Mar 2023 11:54:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679273672;
        bh=jCYWUFqeEcq/iKk9UVbJulf34mhqjekmp+jzoMspAKE=;
        h=Date:From:To:Cc:Subject:From;
        b=Jql0g2mioz1pb4aUO97w+SldgnyDL5hiBtRO9P+uK69BiFH2jnbjIAawp+Eii1TJV
         /N52S3PdzBDUvu0R1xEphOgZMSXhBVRdD1mJ/JyKJWmyXeqAvphvDjGcR79/fMI4yX
         Sjk6OI6OVaaerkXtBhDETRgEGmSPEN369c2rkKePUGu2+R7mlc1DOLewGTgyx4p0+H
         hnl2jid74xgfXhD0zuAU1a2skSJKRoZ3gKxuCdgCUOzrIDfUwmUMe6HJ4Zoz0wokil
         2B5T/J7xUpXnJOSaFGczoS9e0GblrGR6C1Xd9ZBCht4hfk7WNHDKZOhW68hIXbwk1k
         bQjgLfN1Itybw==
Date:   Mon, 20 Mar 2023 11:54:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?UTF-8?B?SsOk?= =?UTF-8?B?cnZpbmVu?= 
        <ilpo.jarvinen@linux.intel.com>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the char-misc tree with the driver-core
 and tty trees
Message-ID: <20230320115430.06f26c33@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u9oc98YIT5GZz45tPttyH3e";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u9oc98YIT5GZz45tPttyH3e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got conflicts in:

  drivers/char/pcmcia/cm4000_cs.c
  drivers/char/pcmcia/cm4040_cs.c
  drivers/char/pcmcia/scr24x_cs.c
  drivers/char/pcmcia/synclink_cs.c

between commits:

  1aaba11da9aa ("driver core: class: remove module * from class_create()")
  035173c91c6b ("tty: Convert hw_stopped in tty_struct to bool")

from the driver-core, tty trees and commit:

  9b12f050c76f ("char: pcmcia: remove all the drivers")

from the char-misc tree.

I fixed it up (I removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/u9oc98YIT5GZz45tPttyH3e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQXrsYACgkQAVBC80lX
0GxFTQf+J9cw/QqUJh0Fasg5+N1H8N3DrdK4/jiSwlQw5WyHRrJ/najgsLvx3m0q
hiXv7kaOBXPuKGEi8xyGrxR+jcoGvncJicuE7gFfR/L7Jchj6BwceOWInQM1zLpi
ceIDljHU3IECvLjnRdgZESzFdMjSgoM756YKCFfA5rbZ5+YHU7Jf0HQ7idiLgJJj
gyXA9OM4v9RTIFFtbQ2/kAch8QVhyUv/TjrBL9fprCa1LusXkod33zUa26qWBbfC
v0bLIp0yBJOSKubkXDinqPA2fu6RGDh9h8F2UmNAUrvKaMDSPxuFRKqPCu9QftaX
fAdwgQsDA5lyBVF9dFUowM63XOpc5Q==
=Gx97
-----END PGP SIGNATURE-----

--Sig_/u9oc98YIT5GZz45tPttyH3e--
