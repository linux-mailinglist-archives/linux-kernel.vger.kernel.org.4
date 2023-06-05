Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0962472337E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjFEXEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFEXEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:04:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA00698;
        Mon,  5 Jun 2023 16:04:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZq1H5hMyz4x2c;
        Tue,  6 Jun 2023 09:04:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686006260;
        bh=mClXEyFuxKVLSCZ/OifK6dDdln+IGWMW5o9ilw3yoAA=;
        h=Date:From:To:Cc:Subject:From;
        b=l6W0aw07ia8Lsu2ZH05mCOCE4ljZ1S7YRjzw/qHW3oAjHDw4UJAfRLpExNyJH0QE7
         2HG7T/1kyPw3oWGSbYLTJDxc+O2ElB2YF3gXUMVUUF5u1Fae602MEOlZX/H9F2deu9
         Qvl6rn6QZFzHvoK3GX5ehteXtulaGoYJ1P5UD9gOVtm0t4jr2asRmVLwi5WUNuteVn
         tyvDs2AAvQFwexYhfrtOgjCmk2XwYWLJqzp1hFhTpI0R26HB97HehmRyiJaboEv6aH
         2UO42LR/9n6cCWVazBE12VzjUoqzwrGQvl8k4pmxdRvVLaqKos+TKwrft3KMwS4U3i
         2IQabp77BlrNw==
Date:   Tue, 6 Jun 2023 09:04:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the landlock tree
Message-ID: <20230606090417.1ac74a69@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y+qDfrB_1leVi_AryG.bJo=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y+qDfrB_1leVi_AryG.bJo=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  33ccf2aa6175 ("landlock: Document Landlock's network support")
  9de310e28b9d ("samples/landlock: Add network demo")
  23351443960e ("selftests/landlock: Add 11 new test suites dedicated to ne=
twork")
  b949a75491a3 ("selftests/landlock: Share enforce_ruleset()")
  6d0bfdb25ce6 ("landlock: Add network rules and TCP hooks support")
  e832565406eb ("landlock: Refactor landlock_add_rule() syscall")
  36afcd997ab5 ("landlock: Move and rename layer helpers")
  7b45d662f4fa ("landlock: Refactor merge/inherit_ruleset functions")
  2e7ccbdea0c0 ("landlock: Make ruleset's access masks more generic")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Y+qDfrB_1leVi_AryG.bJo=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR+afEACgkQAVBC80lX
0Gxk3gf9Gj+j2hCatwWZraJswkddB3q6lP1FiptmaQJWogztaOpc+TD6xZ0SFAD/
XR20iOF7OKzCkzLqPDE28kA4GjGsbAEUXj9i8U4srCXjICgTmooIIuzYYxvOqoxR
6wJrTcTKhmHLf1IqCYBPhTuN32OcKLSOPl/ijpMSZ67qzPH71lthNr+h3gdHOfCM
7U0hNKdqnNB1QblK9+DXHvvnUOfvM409csdXIO5c5xA4pqRtRn5VzHiyfR4M2bCo
ZIqwVKzNw0hs1OnYIakY2KDx1zQHU3j6q9315UMEXvfe4vX9rwSyTCMgw/xio8UJ
H01+2UZWJVU57CP+Bd8mIk5YZVTjNg==
=6nf+
-----END PGP SIGNATURE-----

--Sig_/Y+qDfrB_1leVi_AryG.bJo=--
