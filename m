Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583385BC063
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 00:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIRWVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 18:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIRWVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 18:21:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E9F63F0;
        Sun, 18 Sep 2022 15:21:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MW2MR2Y0kz4x1K;
        Mon, 19 Sep 2022 08:21:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663539667;
        bh=GUjelDUNuF5JmYEBOEh92wQAU7AdehKpMo1OUDlswUs=;
        h=Date:From:To:Cc:Subject:From;
        b=dYb8Hfz+DNMnBLD88RslJBUKOo3+qo/paDOuX4NkJdV8BN4grmxppNZqCaabLMl7o
         w+pAqXoeQciABMZv7Rb+081IJ8UXv00VNzLeBulh7gsoCm0W97AJfs499GMOPt/Tdl
         mgrpbWxUus/zDmCgQGfiIcTaXrk7J1jX/MfzuRYgoNaKl7EMgcDFiOLCk+E/r0fVdh
         5iPD5XBoqf3rHn6Qfq3+Lu8o0k3a069xNjdDmWUxd+Bp8wu+URR/X57M87NcIa2FAK
         boKraRtTRZ2OLfAqXM+nj/NGdUqMdpdJ8XbGBMbVWizIlOIZn4nMw2MfzMQYLg6wF6
         +unxaeBOFyA5w==
Date:   Mon, 19 Sep 2022 08:21:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zach O'Keefe <zokeefe@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20220919082105.73c0e270@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B3/7P8vGP3vpqtf0UTgI5kx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B3/7P8vGP3vpqtf0UTgI5kx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  3a41f36f7083 ("selftests/vm: fix "add thp collapse file and tmpfs testing=
" for tmpfs")

Fixes tag

  Fixes: 64b9fb1fa904 ("selftests/vm: add thp collapse file and tmpfs testi=
ng")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

So

Fixes: 64b9fb1fa904 ("selftests/vm: add thp collapse shmem testing")

or maybe

Fixes: 465c955b7343 ("selftests/vm: add thp collapse file and tmpfs testing=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/B3/7P8vGP3vpqtf0UTgI5kx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMnmdEACgkQAVBC80lX
0Gw9Ygf7B1g9UAqfFef5dZZ3DGefEkCK2IvWM12SmmAF5psGMQE3q4Ny7NYZq314
zWs/IRWZ0H4Gfb9qGbdRBB4N+FOlXxK0ML2QBBgYIjjJo/uIg5NiOR9r6OlFvsyX
NgXfL9ghT+RfpEHyX3XJDBIsWGxLLtjgJfQNbL/1HAzn3g6DRnsXJPLL6SPTwyL8
8ZtReWVKtLhYzhJ1S4cAD1iCrwj6qunz6JT2y0l1cXFypcQSwZ+cIozFLgNjL0oD
kWwwEofs8zStfLMlPaNltt07KGFLUKVHhipAbTdK1sFrrNfYXLc11yhlCymFrl+w
/9kjeTh3l5iY9zdWf71d8+jzjqCKcw==
=VISl
-----END PGP SIGNATURE-----

--Sig_/B3/7P8vGP3vpqtf0UTgI5kx--
