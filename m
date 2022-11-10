Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA07623CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiKJHd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiKJHdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:33:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC8513CC3;
        Wed,  9 Nov 2022 23:33:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N7D9F2tyGz4xGR;
        Thu, 10 Nov 2022 18:33:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668065633;
        bh=1BivK9y+HHLQFMqmHhkHxBUQnn4r1I9dtpGjtLJ1jXQ=;
        h=Date:From:To:Cc:Subject:From;
        b=VRyJcHX+9Am3FgMOC4yMu2qao0SJLxN+iOrdS6hbR24Z8yWTnqnhI2BY/vp5n7+bY
         HMYzYZg37+vA0BL7+nCssF9sjK/SnPjK85vPHqJ2w98WCbwmqja0UBUt0UyH7hVGjg
         Vc0yP3aLql/q7HLdvR3Kdc8ejzp7vcRO7gk6tRwc+khoTReH4IAIgPSb8Kqs5K5vCF
         4I+ef37jkcU6ZFQ9qLlvgsZ7ySnzGFRNvdGD2z67mSxeHqgk05fa0l4tY6+oWh53H9
         71E4UsK1TBD2GzxabzL70LTZ4fPE9I7SqHy/dXZqVVizxnlvRPrLm+nyqNDAzuIjyH
         Q5hLh7cbLC97A==
Date:   Thu, 10 Nov 2022 18:33:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20221110183352.08cc2303@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7K1n.GHSQD2HSGwa=Gqy7=F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7K1n.GHSQD2HSGwa=Gqy7=F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/mm_types.h:268: error: Cannot parse struct or union!

Introduced by commit

  ff02b16f96f5 ("mm: introduce 'encoded' page pointers with embedded extra =
bits")

--=20
Cheers,
Stephen Rothwell

--Sig_/7K1n.GHSQD2HSGwa=Gqy7=F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNsqWAACgkQAVBC80lX
0GwJ+Af/QqNRiH2z+9AxMVGhJyfYBFwymJm+D5BOLI3x9KCxfZsUljioigMU66FR
Msfiod79VKDed8YGhYgFNcnjg3YgHq44/EgOgdJmrODP7CMxfGtdn9ZZiQLZHHYM
YNBz2XRSKE2F5EyKIbqvVWUG5qozw2P6GF6xjpaJ5qy8HMHcq1Fmlw50+f7ZYhkB
YOrI9D/pVyu10yaEqe5Y/Udf4YVFW/uxpRiMdLYW7pnbRKg4Ed92q6Qg7h31UFyq
uF1CyA6whONJkwHKgJxGLHHMzVQnZYoSmSWk3g3g86l+VNGj2xCfySL0kw562sna
Gg4T3jz5dBKHktlCh0G091XcVeihVg==
=UFPo
-----END PGP SIGNATURE-----

--Sig_/7K1n.GHSQD2HSGwa=Gqy7=F--
