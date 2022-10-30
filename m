Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C9B612CD5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 21:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJ3UpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3UpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 16:45:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED479A1B3;
        Sun, 30 Oct 2022 13:45:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N0pFC4Kw5z4x1H;
        Mon, 31 Oct 2022 07:45:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667162703;
        bh=M9kvrOOdAsEyzPMOCvnKZFWiFDbnN7O+NBDcqfL0LDc=;
        h=Date:From:To:Cc:Subject:From;
        b=anV1RiAgEW6gBlwzfeUDs2tfaerJtc8/kfXWH3Vuz7JM4YJ7AaP8M6RdO+ptWUgMV
         XgnP5/Dfis90pBMijNK95M9aoc8tEzTDxjQ+N/rmv+prQ3eHUgsWAOBTByj4f4v3Lt
         DMD+DsONgEqjqUlI37eDeeniTYQCL7skxv2IkYlmLtvkHOO4CDAPUISkR+fC3OBZ68
         G9UMKhsUxLP0BXHWzucQHpupmGTHLC0UoOwZ6NKPkp1yWg+Vl2KePas/tSqHpbu5dk
         DkVwtTwgMUYTLTUd4w98XfAsmcL2GrywctIlp0ZbBKea6vCJfnCx/19PBwgHyyMMS5
         a7189iPlbIV/A==
Date:   Mon, 31 Oct 2022 07:45:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the perf tree
Message-ID: <20221031074502.56b2f73c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NiLphbAk0ytxDkGdnUneowe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NiLphbAk0ytxDkGdnUneowe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  a2879339be71 ("perf bpf: No need to include headers just use forward decl=
arations")

is missing a Signed-off-by from its author and committer.

Just a misspelt "Signed-off-by".

--=20
Cheers,
Stephen Rothwell

--Sig_/NiLphbAk0ytxDkGdnUneowe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNe4k4ACgkQAVBC80lX
0GweMQf/SZiLUpdwTOkXxthMKH7jZ1Grl56OYE8v/f6zGUwGs7JGyD+pt1WE1hZL
VDrYVVRFBf3g+hMqeq5iK2PNmwC8BEYMmtPkFGNcIg536eutsMbSjzyTnBS51y4J
EC2JyKDD7Umu2hkkqG/u0G1ykK0tIuYnHp0unS/2pXWS9o2m/GJGjIgtUmhjQEim
3XJ4lAk2h8xSOKF4Y5s1IWgPaItfz0Z1KyjwGHVS/LycNF8ak4spEn40nExpMxyv
/pzOBshW0kV/h+gAS77BKdVVM7c3lIzDGx2WrE56Lpd0rX2/vY35fShBpuFLHOOK
nIM1jxWGEDb2fkhC/kSpWK87OL21jw==
=uXUi
-----END PGP SIGNATURE-----

--Sig_/NiLphbAk0ytxDkGdnUneowe--
