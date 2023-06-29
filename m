Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9687474301B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjF2WCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjF2WCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:02:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFFE30D1;
        Thu, 29 Jun 2023 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688076149;
        bh=F28ZahlgXjExh+5XAqY7bmPHaUAnSIwr50lEZalnpTY=;
        h=Date:From:To:Cc:Subject:From;
        b=XGqma75sFI5y83ziB3mhzXgBVIuGtnOCwMX0ua0irNag/d2Per2/4mRWD5KPqW3y6
         q38jnpmvxRPoLZWytXXOPtVu5ALThyY8ZB/ZXk/lXJaM96IKKCBtOSmHYeXQdKBDk/
         Fk6NQjTcnzk8oGse/+KfDcc4DFyAmsaAKk6D28o14krIhjFE9+0Hyin8VM5dEK3FV6
         jLANic++8G8uLnAaOlPXeUql77TFoelW+noqHsxvO7JdMOfky2vkoo2iasftUZmLi+
         bJe9m7/2zcqyiHKkIQiVIGWTJlSX2Kk1/5jWjCxYfqn5N2z0MxyguOMc102p1mZ0jI
         gKu+kVDy3KT3A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QsXVs5SClz4w2B;
        Fri, 30 Jun 2023 08:02:29 +1000 (AEST)
Date:   Fri, 30 Jun 2023 08:02:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20230630080229.16ed7427@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v7kpd+GpS/UEEZf_XL+A/Ri";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v7kpd+GpS/UEEZf_XL+A/Ri
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  de33661d31f7 ("fs: Fix bug in gfs2_freeze_func that can cause deadlock")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/v7kpd+GpS/UEEZf_XL+A/Ri
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSd/3UACgkQAVBC80lX
0Gx0pgf+Ix+y3dBr6d6gOwVLj34EQMxa7JJ72Rn9GTLJ4splhlhzRmtb2Qo8mqHK
BjGr7EEcvit/WE37VBS6PfxC1imyG9FI9C5yfVCof0c9heNshU2dKfyLWR6gzY6G
AQ+1topA2vBNugbo2LONB6r+1IAYcQchalu/G4Sd0tx7aX5a3o/p4iY7vY+ZtOqw
WN5l0zgg3H1bM70NZzQH/HAAxXfs+Qt0tk72oNAv4wN9HHY6CbbNqxcnHaUfTBF+
FhW2tA/5typRQmEcxLCZAdnfVsj5aiom1Rb40pB0WGP8AC2ezqvz9x/GyXvVhdQh
eaK6BDgDIhGpCNtQhzYheQXVfzQYyw==
=O6O9
-----END PGP SIGNATURE-----

--Sig_/v7kpd+GpS/UEEZf_XL+A/Ri--
