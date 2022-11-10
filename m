Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8049F623CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiKJHga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiKJHg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:36:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B93FE081;
        Wed,  9 Nov 2022 23:36:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N7DDB74wdz4xYD;
        Thu, 10 Nov 2022 18:36:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668065787;
        bh=qx9k6n6kP12zH9txQP8+1Sse8k6uwgZ+ZDiaxpV4gzU=;
        h=Date:From:To:Cc:Subject:From;
        b=e+vmPlv9JPuYKCh9WfloVEAml3KeBoSJhCrCQybVrcZV/9GCPiG62F6C2EfkOW4yB
         g+nKxKEvybVE38g6PoGs/NRkU9F7ldqxlf1ruoLOBTw8eev1kaOKC+yZ5qV2Ouvw+5
         0s7xNPlkHMsqZLyYcf3U9x6rdZHu8GunBj4YcOdeIrx6tJSce14gy2/1Js5Fao3CDc
         6o0aqX1s2nrBxIVpQPfV2UNh1HfXJ+86SSCfEjCXsYrP2XYPV9v2eJ1WU2YGSvELPj
         oeJuUSsfCZOPJgUcv5PNByT6jODwwj9eBH2qlspZBg/SHRyz7d4te6bRJqVHiBkHBo
         SUDXYX3HTU3Aw==
Date:   Thu, 10 Nov 2022 18:36:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20221110183625.63d54576@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KLDsslfk.jnzbjHrjTOgAS1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KLDsslfk.jnzbjHrjTOgAS1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/mm.h:1214: warning: cannot understand function prototype: 'ty=
pedef union '

Introduced by commit

  4a3df046c983 ("mm: teach release_pages() to take an array of encoded page=
 pointers too")

--=20
Cheers,
Stephen Rothwell

--Sig_/KLDsslfk.jnzbjHrjTOgAS1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNsqfkACgkQAVBC80lX
0GwPqwgAhwxVlXo20gWIYfLhLf6ydRypBcVCsDgDdvIp4MgxikPJOcFlQSvfAxa1
PY4SJm1AE7wAHXz6dFegwLnQBcOAUH6eN+ShOI5XHj7RmGef4Ma8LpGWHVOb4wNt
TYbFSO8ZTSVSPboUl3ZT9mixbdcCuxYj5mY3reHQBCAMqBhnjs0gmxoekcdYeTnx
b6AHgxrnn6v//BdaXjP7Nf/bK4cR3bqGV3e411OlBNww9NpZjw2qGPX56VR7dgC4
+NZKlvdfdb7xpQWhEb/Tr1AxcoLshX5k+aImeKIrAPHrC0wUX7qn6CW1WaFc/2og
Vh9xaZ0HsqQPqmd3i6GOegbNyYY3Qg==
=w+TJ
-----END PGP SIGNATURE-----

--Sig_/KLDsslfk.jnzbjHrjTOgAS1--
