Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E12609933
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJXEh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJXEh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:37:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE9F7961A;
        Sun, 23 Oct 2022 21:37:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mwj3Q3sBWz4x1H;
        Mon, 24 Oct 2022 15:37:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666586242;
        bh=XeBbu51ONb9JAfg1h17zoPOKHfDkBz9Y1B+LeOgUEVI=;
        h=Date:From:To:Cc:Subject:From;
        b=uqM2YAUvqYVzNJ6rKOACoVlCWVDezvOeE8RwcEnUpqVbC3MGg5Kmi2eW18LuFd6MB
         nNIxWysxliyDB/Tde9z57LPmIGsb6YQkFzxh2etfDZQib9pFULaSXMKf9UXj35u1Pc
         bZNHrrbuiat9uYkyGvdkKsUqIy0BLYZ+eCskf+tH2ZtJY90nbCjLKOJs0XDL6fGMYe
         YV4HgtzOMuXY2VnYxuMCTUy2KUDsj3NUVMn0YVyGtkOB38+Hqx0wwUrwojEFQ83d8v
         vWX48s1Ojig0iUbY/0ZWmYGq1L15R81inxSes0slEQz3CSQK02/Vn3/N9DPS3vXn3V
         xuZpqiUH/yBIQ==
Date:   Mon, 24 Oct 2022 15:37:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20221024153720.5e387e34@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1unH=l9f0fRgJjnPU44mXN/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1unH=l9f0fRgJjnPU44mXN/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c9545754e9a7 ("arm64: dts: verdin-imx8mp: fix ctrl_sleep_moci")

Fixes tag

  Fixes: 1d8df9c74bff ("arm64: dts: freescale: add initial support for verd=
in imx8m plus")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: a39ed23bdf6e ("arm64: dts: freescale: add initial support for verdin=
 imx8m plus")

--=20
Cheers,
Stephen Rothwell

--Sig_/1unH=l9f0fRgJjnPU44mXN/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNWFoAACgkQAVBC80lX
0GzwnQgAovb301iZeT5H+2g5ApfWYVrWTsIfpMME2Xawfj4a7DfPJoYzRp6P65cL
7QkzxWGk14ttHKjWDPWJ7X26/NuFc4MAo59lxHm3PxLnoqAschDDXxgwWteffLKY
bFKQrIBVWVxseMt7BWRxfUKKv1+p465qDvex8ZxwHT9QBpxDqJnv54m/kaZhqFhS
89J2Cz9mCxAgMlJ3jp3J2IQmilliH+eAcoxlQj/o9AESgdLiy0LiED629v4cbFub
KSFFrfrBi6MGiUpPBQwoacUsyNdXCtyYEhLU0z7TnqUHXf127BfJh4jkfsP/rQXN
CjTttpR4fD6sfpEGziYYyxmnYK3h1A==
=17CZ
-----END PGP SIGNATURE-----

--Sig_/1unH=l9f0fRgJjnPU44mXN/--
