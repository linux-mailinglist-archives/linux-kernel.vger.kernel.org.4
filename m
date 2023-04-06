Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792F36D8E72
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 06:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjDFEnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 00:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjDFEnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 00:43:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A006EB8;
        Wed,  5 Apr 2023 21:43:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsTR92J6nz4x1f;
        Thu,  6 Apr 2023 14:43:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680756229;
        bh=+Ko2OIlzwdRoql+rtYQMKZeomnKowo61cyjuefUuDa0=;
        h=Date:From:To:Cc:Subject:From;
        b=P4ZzMFocVpGCAbn27eSqHFJVajfvQF1kET6U6UHotaiFLib83Q7pvq/YtUre0/Xcj
         oVSEPielB/Jpg5CcK8bgL2or3AS6zWFOGYtMmv63ST/UeFOVgHHVexfpKEIc2RAgEr
         AL2kLkTINW6lbgnYUZp8q5gXIMRVg3j8uNYzE3K3AXeNPwpjgroIEyetFKHuehwV+x
         sGoe4C1B+yts9ATtw3kN/ueSC0RRODTagBD06eE9iFA1ycsGEAbz3Y+Jc4igE8F2CG
         K3VXo+jB0TlH1bNT+VcioyCX/NTZ5cVjwGo78eGeAhOy9WbSHvKc9HzAAgjj9dh9Lg
         BiznxH4HFVQGw==
Date:   Thu, 6 Apr 2023 14:43:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the rcu tree
Message-ID: <20230406144346.514455d4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a450L8mY_u27og465C3=MmK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a450L8mY_u27og465C3=MmK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (htmldocs) produced
this warning:

kernel/rcu/tree.c:2808: warning: Function parameter or member 'head_free_gp=
_snap' not described in 'kfree_rcu_cpu_work'

Introduced by commit

  07030d20c8ec ("rcu/kvfree: Add debug check for GP complete for kfree_rcu_=
cpu list")

--=20
Cheers,
Stephen Rothwell

--Sig_/a450L8mY_u27og465C3=MmK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQuTgIACgkQAVBC80lX
0Gxktwf9FLv3dDI160G/BE2HxUCWinMOIyGHz1A44WczLCDCEfA5IrOAjvcPxnga
5oL8s2GI2PQgMWlCrgO2azgCpaLIHuS/aVkne7nvO8YMPL4ru8Lqcrj4lryMq7gF
dxzjUX3eav3pw6xI1EtWc/S8VjBiNQdhWPCrnFesHHRWOld6t5LDPwaBCo60ivze
IDINHDiY0JtpWcAzwBq4jNWwzuXbJcesswyC9yLpWe8JxIyRLsL/wOuFzigD7aWW
s7VW/P9t1bhVgllQEreHkLeApN5bVAK2Gv9LV6Mx5ORdBbJaQP07xyTv0R/y1nZ2
AU0JbJzYNZbZ3iRokSBfl6yEE7/NSQ==
=h5q7
-----END PGP SIGNATURE-----

--Sig_/a450L8mY_u27og465C3=MmK--
