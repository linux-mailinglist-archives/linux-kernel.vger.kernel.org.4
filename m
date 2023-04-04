Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518C6D701C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbjDDWZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbjDDWZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:25:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2267C2708;
        Tue,  4 Apr 2023 15:25:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Prj5M1Wj6z4wj7;
        Wed,  5 Apr 2023 08:25:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680647143;
        bh=QS/zx8Q6YPZktl3pS0hPotNVXStqNKZAcKfe3a3X+s8=;
        h=Date:From:To:Cc:Subject:From;
        b=S0ZlKs5Te+mzYgAIYOVUZYgrXrz5nRQnUEVn8HfdzJhDul8dhmIpM719WGcWXC/3E
         OutSmjPpTuLFR4/SCcCyhyRWYmmjYLd0y3ofJHREqhkLm9JJOWTT5b9UUvF9J65mR3
         5yfQnfmYhl6+q+e/m3F8eGuVrGmZ/0ObR/9vIFaSoeyMjChdf++bsp+ImjeJt7ICIn
         dzB5f7RqHZDX7xDG/xETQCFTMdj7Ssfwx+T05614A0G6fRG2qFfQ38QuBvWxp0GEw2
         lTM86Z9VZOVDVbosu/NhsbfaO9zNEyjjAafVc3BaOWLPz+uZ4d8fWxR1fztI/6jyBi
         NtCd8VB4ltOyA==
Date:   Wed, 5 Apr 2023 08:25:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the nfsd tree
Message-ID: <20230405082539.3e8d1ab9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XQJ=kbgfKHfJ=J6Mr5lfXVq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XQJ=kbgfKHfJ=J6Mr5lfXVq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  a98c27281895 ("sunrpc: only free unix grouplist after RCU settles")
  691a90426c2f ("NFS: Remove "select RPCSEC_GSS_KRB5")
  64208e19495c ("NFSD: callback request does not use correct credential for=
 AUTH_SYS")

these are commits

  5085e41f9e83 ("sunrpc: only free unix grouplist after RCU settles")
  8be8f170e838 ("NFS: Remove "select RPCSEC_GSS_KRB5")
  7de82c2f36fb ("NFSD: callback request does not use correct credential for=
 AUTH_SYS")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/XQJ=kbgfKHfJ=J6Mr5lfXVq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQso+MACgkQAVBC80lX
0GzpHgf/X5JxKGAbjVIVWU9TVgMBachURr9y9rxK8Ez46WuvB420EJW1RX9ruJA4
NXpfeE8oJqB1+b8gFbadJMVbzLXzadXccXrLJxzepSFcpe/g00cbr6taHQx+D9RT
NShjNKt2M/ExPuAtxMj+hBFL6uR7Fec9JGKhZjmqOiGXy0pozXi08Wg1WQX7b/WW
IlBKT1er4HgLK24zRZ4qb3Nhw92hQu5xH8hK5PDccnAVMUTrxDPVk8FRYHgFJtjE
vUH3X9Kp0PuODMhZIe5hc0kAZO4iLNWVWo4TjG4s90EK+q9vdyKuNO6VtjMa4/YI
yY/E5ysRQm12IMPdso1cdhrn3QIzOA==
=JxY5
-----END PGP SIGNATURE-----

--Sig_/XQJ=kbgfKHfJ=J6Mr5lfXVq--
