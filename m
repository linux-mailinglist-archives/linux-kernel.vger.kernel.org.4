Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBCC64FC55
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 21:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLQU7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 15:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQU7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 15:59:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD2BF595;
        Sat, 17 Dec 2022 12:59:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NZJHM6FBSz4xGP;
        Sun, 18 Dec 2022 07:59:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671310752;
        bh=hfpr6ha0ve3fPSbTzLbi6ybNJQdG+Bfz1rQ3JWX9OdU=;
        h=Date:From:To:Cc:Subject:From;
        b=PhHMNWGDtBbAjvUmx5fsILjEkgeZkjJNvIp5TwrLhHhmRNMTfzZRD2LGumFmrcR0X
         UOvtF+cAd1fRBTCso8dR5JeZWsdC4EwJWQ6UQlMcmScoCT+AXTiO75+/AnEjicUc7k
         CuXdnQM66sss2bJKjiErfU3WspcTU9Xe/fEgMTlGHVnU9CKt4tNTsdt53epBajLmrW
         Pu/BeqUQOP/5Ps3um2L70rEHoFQa98vOj61eR9wbXWjFEGr1RPJg08xon6JODfKImu
         G2LqrWFgsaQQhmAPYBtdzOJ89rN9yhC8dTgH9K0M+EwvOIsapUTxms3/ZzMIagLZ9x
         gHlg45X3Kw2uw==
Date:   Sun, 18 Dec 2022 07:59:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mm tree
Message-ID: <20221218075909.1b12cf07@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D1MlWLRr1XVL/+.dvLHssNN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D1MlWLRr1XVL/+.dvLHssNN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f8bc956f6ea6 ("mm: memcontrol: deprecate charge moving")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/D1MlWLRr1XVL/+.dvLHssNN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOeLZ0ACgkQAVBC80lX
0GzRlQf/SXJBCxTemxXn8a1+jVDMXaQIm3dWIG3lCG2eggqJj46Q+4I5LBVBSrvC
s1SwxYrQ/1tr6cyfSn2UEQQFTe7pOtudhl6y8iXxOPPlXz6USv0K4yvCfJY0LmcD
7ZJeekSL8c/9QWa0/8TOwTgx7w7ZEK49wxFRcmSosDp4gFusXGNrm2N5FCEO+ND/
UY/g0ORgkN6zzrypNVGOsF1zkIv8b1dnHN8DucK3r1+keAWDplFCwW8HHKJ/5Lrt
ECgFC36Drv1nVP5kYqfzaSzoemZTLOatrEXDYyYv8RbS9BE3ruKd29Tlwku3ngP2
J1kpIomD8fv/Sf3GSfbROysGgbzNcw==
=VtSf
-----END PGP SIGNATURE-----

--Sig_/D1MlWLRr1XVL/+.dvLHssNN--
