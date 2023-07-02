Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC81745315
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 01:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGBXm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 19:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGBXmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 19:42:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AD7E45;
        Sun,  2 Jul 2023 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688341371;
        bh=cT82u9M2a2EePk1o1W+cQtyYlEl7DZ7cY6auLzp8BiU=;
        h=Date:From:To:Cc:Subject:From;
        b=jnXtAPEuwhBteymoLB59+e+j2CMGi77ohfih17QgdpqxKcoI0tudIR8ZwxFt/bDCH
         B/HPNV1+p+NiwlNZGTzLEoTP3AJTO9G5NWux5zV/5ik1aMk2zjnByLxR+nZi7Uw6z/
         x89Hx26FRfBQ4FspE92jd5P392kkS8sdeHcMKs9zb556TYSYzu7LFuCs14fEZ0vZIu
         anBkBlc/+0vE+/+1mnxG/PVJ8YvB/P7pjWwgrFoLV1wX2/8mUDhAyAZmHVVSWH4lnJ
         yji2MSVqJJoogHw2VFBX5zRzYHxqgdJAe8i/RqqgABQWbaXb8MTjW7djVOtqPvGsqo
         XrHqnoNoDjXyw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvQbH39rmz4wqX;
        Mon,  3 Jul 2023 09:42:51 +1000 (AEST)
Date:   Mon, 3 Jul 2023 09:42:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the pidfd tree with Linus' tree
Message-ID: <20230703094250.40be7092@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/op6S6dTDrhgksTysqlmt/.f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/op6S6dTDrhgksTysqlmt/.f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pidfd tree got conflicts in:

  kernel/pid.c
  kernel/pid_namespace.c

between commits:

  b69f0aeb0689 ("pid: Replace struct pid 1-element array with flex-array")
  dd546618ba70 ("pid: use struct_size_t() helper")

from Linus' tree and commit:

  757777eef55b ("pid: Replace struct pid 1-element array with flex-array")

from the pidfd tree.

I fixed it up (I used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/op6S6dTDrhgksTysqlmt/.f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSiC3oACgkQAVBC80lX
0GxDUAgAnlfnyc/gO4w6PQj4KqsscdByned2Sm/xQ1/rpUqNSGlp5KFIXLNeqFdt
3pKNonWPSWSorVLOAozqHSXpd/szawmizGqleZ8LLeYKy3MOxZ8CbDZ81J3RJ051
VTcASdzRIJUkBz8yycaMaJ9xNwpdCMt8KX+OHMG+HNKwQzpw9qDL+Z+G0CyVugrC
yqg+aHxIJy+x4j4pDi3EMc7rNFpKKacxlusD7od5802YuSbcqw41CAmavVvjnQgU
WEUPS90a8pM69vy6Wy/20nPGQmLZWBiukTWn4F2PXIEH1lVLZZm6DOuCzTOXTbAn
DUL/u97T/hSQrA2HnicD+k79Htlheg==
=NmWj
-----END PGP SIGNATURE-----

--Sig_/op6S6dTDrhgksTysqlmt/.f--
