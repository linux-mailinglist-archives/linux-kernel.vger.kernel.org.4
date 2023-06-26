Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421E873D6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 06:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjFZELO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 00:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFZELM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 00:11:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0BDD1;
        Sun, 25 Jun 2023 21:11:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqDt12dsbz4wZv;
        Mon, 26 Jun 2023 14:11:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687752666;
        bh=DgXWd7rCTm7X5hwjHdCWcplbDtrDixFpRuzbvTCxIHg=;
        h=Date:From:To:Cc:Subject:From;
        b=O1X061WiyF5H5DMrCAX7s8u0cjmch8JyTS3f5BlRe7raAMnXd1vTQs6Y515h/aJGZ
         85epaHPYcFQYA0rt3Uy1yG8SwHlWOLDURnyQiDyKXfHGDty9adMAifcIDJDtoEWXlR
         xaFwnj7ODaLrwQ5RjrBOv7HW4tsDrVLJkxodhp7DS9IVhIFyT78+cLQvf5yr3f7JLv
         hReS1JMjSUE36OhawcWzeKhe62RrHQko5A4VTIz0I66+l71mIslh1hijhKONTRB974
         vGe1zVB7D7QTQcilPg6HVcacS4a44rIOnbh1F+t7ppZBV4CTtNhKljYWtXDq6GZjas
         6BQWQxuu3BGUQ==
Date:   Mon, 26 Jun 2023 14:11:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the workqueues tree with Linus' tree
Message-ID: <20230626141103.4ad0eac9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vrxg0VrsNjU5t/ZTOs2ePkW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vrxg0VrsNjU5t/ZTOs2ePkW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the workqueues tree got a conflict in:

  include/linux/workqueue.h

between commit:

  afa4bb778e48 ("workqueue: clean up WORK_* constant types, clarify masking=
")

from Linus' tree and commit:

  525ff9c29657 ("workqueue: fix enum type for gcc-13")

from the workqueues tree.

I fixed it up (I just used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Vrxg0VrsNjU5t/ZTOs2ePkW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSZD9cACgkQAVBC80lX
0GwAIgf/c7X2O9Zck5wnRuUlrcWI1u0bGDBq8U4sJLz8PhjiVgF2s+swn2ete+o0
nxt7kA9PnEvz6PooKQyjQ1i9aFqRiW4NojS3ii7qCiQ5sHgBu7S8XMLw9dlhN6Xy
5aq7UEqgjWcwTeVxj+cEouFhnnh0uDAKJITYOAEMBNun8RzflEOQ6HxGA4d8AeY5
wQVyzaj6LIBmkct3X7mPwOtavJ6M1VvXUypD5CSN15kufsVzzGRD72jyDkKCX5x/
XEQDJsTOZUr4ytyKIeRfVyRh/I6uEo8VlxY4HpiaxDE7V6lYFbhN9IiUPrbDL9as
GfbYU6NFP8329xQ8NZ7SXwp88Ie+Dg==
=l6AI
-----END PGP SIGNATURE-----

--Sig_/Vrxg0VrsNjU5t/ZTOs2ePkW--
