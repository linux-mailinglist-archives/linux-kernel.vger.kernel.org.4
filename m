Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CD9673038
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjASE2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjASEMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:12:36 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B06B9B5;
        Wed, 18 Jan 2023 20:06:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny81z3DXFz4xG5;
        Thu, 19 Jan 2023 14:56:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674100584;
        bh=R7E7pDWr8ZqRYg1DBLLo+wNeGS9D5BUam7iOp+Gsbf4=;
        h=Date:From:To:Cc:Subject:From;
        b=Z83nvI5SUnP/biknsjxIIjEvgdmVZlVafrZ2eq2Xhzs5c4G4SPHT5/bKCRihEE2r/
         HgPtOJXxGsqGWjM00BC8JbLbMQJvPboSQdE2ouNkp4+yaA9yR5uUjGEuaXPnjX4hN4
         f4NSaurRFL6mnX4MU2sOoqNYzmsRYYf1duK93DUhUY1HelJt1QcSMCv2poA4U4zwgv
         DQocyNgqp5Vnj80F8xsYup8aA1bDDJc2AWtHzE9Wkz0pKehWkPhTMrv7xcfex0pRS7
         2mq5MOLRH2QyDa3mbjdL5Vve3rq7lpqzZPfaMsQM/gBKhsOfbvQOn8oDFf5e2jGVqX
         9nVsu58RaZWgw==
Date:   Thu, 19 Jan 2023 14:56:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: linux-next: manual merge of the staging tree with the
 staging.current tree
Message-ID: <20230119145622.1e8e0d37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0FWHcgijglPvHQlhu13Lrcr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0FWHcgijglPvHQlhu13Lrcr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h

between commit:

  7d83299351fe ("staging: vchiq_arm: fix enum vchiq_status return types")

from the staging.current tree and commit:

  3ba317227aa4 ("staging: vc04_services: Replace vchiq_status return type t=
o int")

from the staging tree.

Thanks for the heads up.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/0FWHcgijglPvHQlhu13Lrcr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIv2YACgkQAVBC80lX
0GwdVwf/aQ8bbPSRYSvN3UjiXX0/0AgxuQVA6CQAtwv1oHV0V276yuzO6hWS202x
H/k1BDJ+Z2RrBazeq+BKHw8IQxXpS2eetGkO3JG9geJWem6R7mXclPgn1haRvxwR
/TRaEV3cFkz+lErxK6j1JZR1jFtq0SspVwNSqqrpOHXw9JhePAcn4kVehowvG7Oy
MMl13Qes2rhHHFkWooNErRLEeHVL2dux8xdBplSj3/kIZjErxTmglOB4Xsj4LRL0
l71WjZELzmAbtoqeeIchRuDnHUHVUOAMMDA39VcnPYzbWnQeUyPIz+xYqKHBrzeO
Gqdhwc70wfF+KgoxESbELiU5KBEUBQ==
=KQ4q
-----END PGP SIGNATURE-----

--Sig_/0FWHcgijglPvHQlhu13Lrcr--
