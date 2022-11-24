Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EBD638061
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKXU5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKXU5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:57:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B775712D14;
        Thu, 24 Nov 2022 12:57:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NJ9LM3JBxz4x1T;
        Fri, 25 Nov 2022 07:57:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669323467;
        bh=T+Ekp7moZrH2H5ic7xKHfW9FmjhdZ8QvwOokl5/e4Yg=;
        h=Date:From:To:Cc:Subject:From;
        b=VDrzHWTkr1Zb9PJ6gxGKWhXzS2FLRkwdo0ynzn1li8ZPJNNuSjUrU8OZA5zKFOuFx
         +6O9os0QCyEC6IXNLt3AZINrfPFv/smsvqNuDAVMMtap3yixe0Osk27YXzcOQKKFCC
         Ybq+g1wxLTdb83RMEeKS0YoLZz/sVlvMuM/jCSN3jC/n1Dnv6P5kK2amnNP1cvS34q
         uyQ/7xfRCYDBmDAeF/ilPHTBMqIeKDPC0ojssb3tTsk5QpdRjO3brAe3k+1zbnupLr
         +k3BicjyIGVvI3pVIiqH9h6RaARwgDRh97UC8gS4o3qjctHRV775thxfSSgbSRmnFP
         rbfUTUEYSUPvw==
Date:   Fri, 25 Nov 2022 07:57:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the perf tree
Message-ID: <20221125075729.24214bd3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fl+DvJXPTaJ6XT=bsfPQCzN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fl+DvJXPTaJ6XT=bsfPQCzN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  be3392b65f2b ("perf list: List callback support for libpfm")

Fixes tag

  Fixes: e42b0ee61282a2f9 ("perf list: Add JSON output option")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 6ed249441a7d ("perf list: Add JSON output option")

--=20
Cheers,
Stephen Rothwell

--Sig_/fl+DvJXPTaJ6XT=bsfPQCzN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN/2rkACgkQAVBC80lX
0GwiQQgAkCoWR9TR85BrhzxFCguBAUdjJlvwzJlsTBk6slK40pkSvkjvqKG5n5gB
VRmTsAKo1TVmJs39d5QDVdLd11rFt49j+qyms1sJCcsYluwY3fR+gpRc+fMpHGCH
swqHyDh44QBnxll1ZOBxazLe6IrBZbq2KNvMMgfdIhUvbRW/S3NUPU2W0LnQcLBn
El245LVRfu68a10rr6/XAY3cEbc6NKy+w+gXdhNOVC+eojiqEd5tM8TbdQSChOpP
I6C6cQc1SVkO4TYgAFQA+uqlsYr/cdsF5LhkhEvLIsMESCcURhcS0dQs6wTJ9GxT
R6oBBXvL8Rb1uSaa9Py9+R7FhGtYjA==
=kreZ
-----END PGP SIGNATURE-----

--Sig_/fl+DvJXPTaJ6XT=bsfPQCzN--
