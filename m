Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5C660BDB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJXWpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiJXWof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:44:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F311CE3ED;
        Mon, 24 Oct 2022 14:07:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mx6Sx3mMCz4xG6;
        Tue, 25 Oct 2022 07:42:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666644145;
        bh=JvArXTXLlCWwbB/iVkguOuQ/s+HWcZybwT36DiuPR7c=;
        h=Date:From:To:Cc:Subject:From;
        b=mfDdVtvBVJ1emMYpavetQLplSCt+qsQaERLVxkotN0Vzz9MDK52hhwbDm1rYfIMbL
         1cfdYdC52doIPj+4GuiwevYvCQi2IIx8HybXk78RbdvlogG1O0Z0N1ja5Fe3wgudRB
         hmt4CQhlUpZukXq9V/B5fB1JTbxeyif2qslihe+Q/uN+RzF9wgjAGKtaGY3WYApwvA
         Vlsv5RCMm9eHRWOqQ7KdVvFyynhX4tZiyP9bi07+lnZOrKgy3YTAr8CRWaDEJKGfPQ
         cBTB8poiW12YuAeddFPQnCiJRn9Xk8MkpuaV3+IYU3mGfY2T4bDzRDAdeC+uzSFgK+
         RrljcPQm53UcA==
Date:   Tue, 25 Oct 2022 07:41:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the slab tree
Message-ID: <20221025074156.19fdd67e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JWSTRo5q6GA5eEN8b2voHVu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JWSTRo5q6GA5eEN8b2voHVu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  5a01d8f8b6a0 ("mm/migrate: make isolate_movable_page() skip slab pages")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/JWSTRo5q6GA5eEN8b2voHVu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNW+JQACgkQAVBC80lX
0GyAuwf+OEOHz/NeDXQZeCeqVpdac78EwE972g5pxslLnLJqmuPBOpjBR308HN+J
5gJFnwz33cN5tfrJcu5eNm3AFagAniJmnRl+26nydelEVPhCik1/FPRS2iCAFArU
SCaHJZB4M31v68qs5OBU/wBVVrhIyLqAcKeTzjr5u61FoPWLwPgPugi/JL2NhI/w
4GEyTGHsxTxYu03IKsuSRLFE9nemLn9kGPQbbb5lnUpomhLkDNngz/mV91kGyo6I
6aXS/qfuIWM6xGjDfG9gLbKWvlfVQlYl41AyxmYKvjywxC+pquVX6vz7XaxbliHv
c2isPDot+rcV8CW37Y+ckkM5aY8pLg==
=OhQo
-----END PGP SIGNATURE-----

--Sig_/JWSTRo5q6GA5eEN8b2voHVu--
