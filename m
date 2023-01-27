Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3D67DCFC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 05:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjA0E6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 23:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjA0E56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 23:57:58 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF4B4B4B0;
        Thu, 26 Jan 2023 20:57:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P351G4qV3z4xGq;
        Fri, 27 Jan 2023 15:57:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674795475;
        bh=T59zovVc/L/Pqhwo8VBdTh1qaafyBuJv8zsylji2zdM=;
        h=Date:From:To:Cc:Subject:From;
        b=hKZ5XbjHPGJityH3RL3RrnfiUM209ldHLEGwlQsVc8Y8lBPRL9vDEfFi3gfmaUBUR
         8loPvz4jurRDJJncL+x0/vY1Vwr47pxOEOTW/5JvqvRJXisBO2YZvAumJAlzgo1L+i
         kl3IedKRpEkdkwhT6f940qzRPOI6UlIMeeU2hsO0yMKpLB9yAFITMeGODhMUblke7J
         XXSqD74cCNrfd0lxijqvDqW7NP4RVzZrd2/gaRJsHiW1tZSD3COJh6f8eh5ykkYDyf
         brLgupkaWR+HKQYSs2wIUPOz8ieI/fv1X8iH0YHe8XQcr6rf+zsW222/+fEE30a7/u
         c/oUIwnJh68hw==
Date:   Fri, 27 Jan 2023 15:57:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>, Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kspp tree with the tty tree
Message-ID: <20230127155753.1f9b9517@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HUtStHaeoacsaSL72FoLP0x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HUtStHaeoacsaSL72FoLP0x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  drivers/tty/vt/vt.c

between commit:

  feb36abbedea ("tty: vt: remove struct uni_screen")

from the tty tree and commit:

  19c30ead3938 ("vt: Replace 0-length array with flexible array")

from the kspp tree.

I fixed it up (the former removed the line changed by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/HUtStHaeoacsaSL72FoLP0x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTWdEACgkQAVBC80lX
0Gwf3Af/eQ6Izg/Ips8kDFgm2J68+wgUppZsjzN//sApnOR5Eu5PU9t1F5MERqRe
L7kLlwi2IfOa4IM1g9x4L7BitwUC1QNsb+g/Tg2/jm63hqtr1tgweLe4HXKY1w7Q
/gRJk8VU+xMIabSfSqSezaeX1izK+rrUYRS2XCARY4DOHoALy0cEantVTVl513fn
9rNPHZumN2EIvgGFcpQBoVj5+omxK41y3Tu0YTxWuOnx+QJa5Eu47CQevSn9LQ3Z
72ShWlUNXzrWkPtXPv6fqeUVU+Tb/e96lJHdu3NpGCckgUbvExTFMxpxic/+ZmKx
0abMNlO+dEQ/bAjKpjcNJaV9m0YuXg==
=kcFX
-----END PGP SIGNATURE-----

--Sig_/HUtStHaeoacsaSL72FoLP0x--
