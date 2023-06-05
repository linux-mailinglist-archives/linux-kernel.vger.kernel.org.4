Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CA1721D1B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjFEEWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjFEEWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:22:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65DF9F;
        Sun,  4 Jun 2023 21:22:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZL6w4Lpcz4x3g;
        Mon,  5 Jun 2023 14:22:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685938953;
        bh=+ZuFdlS6x5KF2QIO7Gf0zcMmK4BRUsPR8BuCCtKSwH0=;
        h=Date:From:To:Cc:Subject:From;
        b=Pz6Iqnv0YSksAKBy3Bdnmiku8pCM2xw6vS7YIDKhGgxD08McfoE1tQ5vsUuXMN0f+
         zSQMaI2akg5wbe6Is+L5C1mKeubF63ZHYgjWCz7QqKTp98vKCj9uF2uFujhWv/RBUz
         +uj5q2IL2vfVKKi1zSnagjEJFS4zqnSuHcwk9evWpYOoeyMfgsFY/E64uDWQvgyuK0
         eBZMN9EYAtwGjo2zHjR6VlFmdzBq0DKkr9Ppxaxi/BVwr5hUvYdsIw82WOPQUvBIui
         Ip7K+f2DlRo7mHm/BWpiysjQmqKo0p6Dc/Quha0A4Z8P3imy4nehdj74jneRvY6XOX
         9O0ovEbHdGmKw==
Date:   Mon, 5 Jun 2023 14:22:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        David Chinner <david@fromorbit.com>,
        <linux-xfs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the xfs tree
Message-ID: <20230605142230.2ee1f616@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/alEh9dSHJcc3IA+UnGThjlK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/alEh9dSHJcc3IA+UnGThjlK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6a458bebafe7 ("xfs: fix broken logic when detecting mergeable bmap record=
s")

Fixes tag

  Fixes: 6bc6c99a944c ("xfs: alert the user about data/attr fork mappings t=
hat could be merged")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 336642f79283 ("xfs: alert the user about data/attr fork mappings tha=
t could be merged")

--=20
Cheers,
Stephen Rothwell

--Sig_/alEh9dSHJcc3IA+UnGThjlK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR9YwYACgkQAVBC80lX
0Gz9Bgf8DmgUwPYnYI3w+pSuGv0eZvElYQPSDgapQ9NSk+hujQ/2lrAFG+ZgPI5U
D4L5Wq66a0HM+j/7+8Ub58+nDrpvikEYulc36AVsm+R9vYBpJ13hZ6fskXahtA1a
e+sFKLgN0V308fDc7/+nNOSHT9nvdl/ztG0VzjYB/qGVBZbbinKE1qv6LRXzGRtp
HHCUuSmje29DDEvNz98MHH9N0a/U1tLRt9CG/Fs8X8nVvHJNjbwCas4LS74Pn1bH
BwKzeCx1poD11zgAAHLZX7cWYLIpTvhkTaOLyN8F1C8gWe3SkBwmEAUCB/R/upQa
c9dpNrwx/r0n0vUWkXfv5nIs2uLAYw==
=q3b+
-----END PGP SIGNATURE-----

--Sig_/alEh9dSHJcc3IA+UnGThjlK--
