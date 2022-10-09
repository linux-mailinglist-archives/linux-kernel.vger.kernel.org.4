Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B825F8A26
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 10:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJIIg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 04:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJIIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 04:36:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A465B7FE;
        Sun,  9 Oct 2022 01:36:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mlb484LwYz4xFv;
        Sun,  9 Oct 2022 19:36:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665304584;
        bh=MEmT/+poAzMaRtzK+Xv881yqIORw5x3tVbKd47OTzgY=;
        h=Date:From:To:Cc:Subject:From;
        b=gS7qv+D21PYec4M1CvJ58syU+bHyQ4AAMzbJ0MsiWDr6pb4/uUI1L7xjufoeIt4Nr
         7OG+1dG4wnutlAVFwmw3DiBcvgmgoN3ZeXeivT6xYygul/H2sbRCEdcdwkflAAvt3Q
         9ALouZqd06ydRTgm5DeWXhcUMkm00U4yfyPTeVtJ/HvcBYqoDjbIoTaIzj8gIdHTwg
         kpGt0p5SBVJM+PX5jNrvajom3RyZEzwZPS0sbj+OQdYju4puD3zLM9/gRL7tNPbawy
         MbMl39ZV4sdHL+eDV2KqPauqGSevRK1opPJbmtONWPwZokIYPv4qImKK5HDAWbV9SV
         77et2wSWaEIgQ==
Date:   Sun, 9 Oct 2022 19:36:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm-stable tree
Message-ID: <20221009193619.70d6c073@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IxYE_jNptQM/EspFuSbzmpc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IxYE_jNptQM/EspFuSbzmpc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ecfbd733878d ("hugetlb: take hugetlb vma_lock when clearing vma_lock->vma=
 pointer")

Fixes tag

  Fixes: "hugetlb: use new vma_lock for pmd sharing synchronization"

has these problem(s):

  - No SHA1 recognised

Maybe you meant

Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchroniza=
tion")

--=20
Cheers,
Stephen Rothwell

--Sig_/IxYE_jNptQM/EspFuSbzmpc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNCiAMACgkQAVBC80lX
0GwoEAf/XjQsbWoCQ+3FQJeeny7xH6GX/5PUPbbanTkbbuZhTS1UPFNXoSe2oTwc
VsVUqW+8DioCx+iPYPRrdk78pGfDMCfYN3rrvSUWSJH1bX0dWMQvrJtzkJN3MRLp
AVQ3HXUCiPF/vLZURdE4HLm+/yrvwaXf7COm97ODxCG89hQ2SgLA7k0bgqB6yORk
aLby9hi6ij0rx0HNZ3oA5/Eypxk46egOZ4W9mQ4Mz3DiXZcXZhXqzZmBYo5KKgcP
wxIsHJ63epNkk/d10gmmLC7fUYzKDSmivcHOcpvVclleQ+R+it7nkNwPuP8NMJAA
BN01EGQhlKOSdzrQmgwMo0UwQlFSrw==
=9uMy
-----END PGP SIGNATURE-----

--Sig_/IxYE_jNptQM/EspFuSbzmpc--
