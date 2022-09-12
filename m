Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7255B53A3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiILFpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiILFpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:45:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E2E1C927;
        Sun, 11 Sep 2022 22:45:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MQwYm4RRXz4xD3;
        Mon, 12 Sep 2022 15:45:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662961549;
        bh=n/hA2E7aR9QGQvEWX6tBkvbVW1SthaixTiBLJX749ds=;
        h=Date:From:To:Cc:Subject:From;
        b=Ah6H09wYxJLV2ETBfHEcqxolGlXgsU11Q//YM46XtONc2BBfbd71DFHE5ADhXenWR
         2Iz3E0dsj4TFLwwVYjDbPdlxnWKZtbLtADD3e+0yu/Q+WMGton8+tf/xPKaEZ94IhX
         9kbonRQid4sL88b30STml+j294OPnx3HhAkL2gGAcLQ7mIPR13hwYkR0/kV255tDzI
         xgPow4Q5QE0WgV5FkyOVzDN8loKO6Sb5WU2+wqd7yzFMn566qgFDJEWmSCRLO5P+qX
         NUbLLxy7bMKyZN2Ez1vuZih9n1RLGKbJuebcQoT9OsEKauvK15VOrxqCvoNAuoio4M
         AoQP51cAonP+A==
Date:   Mon, 12 Sep 2022 15:45:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Haiyue Wang <haiyue.wang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm-stable tree
Message-ID: <20220912154547.312165c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1.VlejSvJ1dIkcTIRgHlk+2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1.VlejSvJ1dIkcTIRgHlk+2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  831568214883 ("mm: migration: fix the FOLL_GET failure on following huge =
page")

Fixes tag

  Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array rac=
ing with memory offline")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/1.VlejSvJ1dIkcTIRgHlk+2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMex4sACgkQAVBC80lX
0GzuEwf/RnZ7cz9MFC2hSjt6Emz8MefnwBFvkKFL2VijgSIs3b3G8/5tF7Zx0Zvr
wmrP2IDESFtS0rbh/qiOuMhTvquq4fDejQoFdAm7j+XdHoFdks68R/HnskjCVYEI
D7r/7Nf3BgCP66evvnqtYTRDlttMlWarfNdd4dhKep3W6aIpVW3NuZoxmMpcluI9
vsrAw4GwrOX+5qKTup7Ex+sZYq1+cZykK9jEHujEf0UcLZTO00F2pRfyReE5uGEh
0GlBuV5msnWDTZ/p5aTW56p5JSiPPa6ADOwnVs5Gurm/vG+nyBK+LjPHaEsuIpYJ
mqvpZhXVnzuo1gFJ/D5/uoITqVsC7g==
=pv6l
-----END PGP SIGNATURE-----

--Sig_/1.VlejSvJ1dIkcTIRgHlk+2--
