Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267A26AB583
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCFEOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCFENl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:13:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1022B1707;
        Sun,  5 Mar 2023 20:12:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVQBc0YyBz4wgq;
        Mon,  6 Mar 2023 15:11:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678075912;
        bh=3EhWh7MBk39O4XZFmQgSj7LheLWX9e7QhEyAhqntv1w=;
        h=Date:From:To:Cc:Subject:From;
        b=YYJn4/GhhGPmnUn32TmMtYH5SDMI4ZD9cQMJMqV1iAuhFK3peS0cr28qhAnw7gmt9
         rXhACX8/jK4M1D5fJcItADL/KRAdipm1ey/xqTZ5DbvXwOk/z2996DzQSH5ndyer4Q
         L53EynUO3NJ90Bf9S2lX6o4pMhySTwEThbwjiexJyKSzmQvN5iSS1daLRJZa88eVSY
         4UsakW8XbXlgOCFulOXDsgsIjXW0XBgHfC4KfEOX7yLv6Ij6ANOpBAQmoGRHc0CGw4
         EHXD6YCsLuWIasCKYhTyPnx4DMvqXJ9E0YcHNkFJo7VDZy2hAsjWFV5ZppG5SNykiC
         KkALmXtvlKzxg==
Date:   Mon, 6 Mar 2023 15:11:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: removal of the keys tree
Message-ID: <20230306151151.17752355@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f_EGACMCvgVJ0JYWXs_f//v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f_EGACMCvgVJ0JYWXs_f//v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The keys tree
(git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git#keys-n=
ext)
has not been updated in more than a year, so I am removing it from
linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/f_EGACMCvgVJ0JYWXs_f//v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQFaAcACgkQAVBC80lX
0GyoUggAixOfOG+g8CGXzawxhlHjgD7l9gbb7aTgMyF4EiMKkyPopcAysENOlHqz
GuV+gp5iSOr7paWDzD/Z0U7kVBsKBoOOliwqxXvlm63pAvFYUjFFFiOI8SEiSbz1
984ijnJ2tnaccWnjhyTIp9ISGYusWSFlQsxOJySIj5fOCYWnLuYyvkeLEI0zZHpG
clhcCb4DLohoK/E/yJubMHianykGIw5JLYZjnVvov+N/O3o0u6ZJynTX96tYgce/
fSp90XsUN2y6cZ6OTgFIXgs8Wo/TSqzTjU72L1VJr3DuIBjQY7dQA1FZJ3BEHXz4
sgtnZLfTyLkmNmkQpQbmVMVXpmkPHw==
=7osK
-----END PGP SIGNATURE-----

--Sig_/f_EGACMCvgVJ0JYWXs_f//v--
