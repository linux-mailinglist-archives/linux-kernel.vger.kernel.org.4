Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100D4677290
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjAVVIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAVVIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:08:34 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91417CC0C;
        Sun, 22 Jan 2023 13:08:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P0QnW5fpxz4xyY;
        Mon, 23 Jan 2023 08:08:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674421711;
        bh=IEGxqnXkpH04iTDA94Taa55eYtJhtHzA0Yj9mdjXy0M=;
        h=Date:From:To:Cc:Subject:From;
        b=RoifJO3HjHlYJiygO0CrZQZPWvc5npcsLMsobtcIRqivJId/ZBBy6ScF2wzGRGv8j
         EwvQ1dwRLIPqqaR2HsCnM7GlFXIPNvQs6GXptoa8FpRwqYLlx+fUf+ZcZXRBpYDzeH
         CK4aRnoFZcf4bfZ00fa0OLfZrZtBcXlZV5yQcTLBdJhVKHuIFL9CpmKz3IUGBJ7Xds
         opVOpVLZcaDj4QuN0lRAJQVdoWWe+NgXjfG9OSBjzFRuAb6mL1XVUPC/NlmyG3JoSg
         NuMJaFZPAEkyUrrFWQurTE0+2MT0YrPVi7zOpa8McvSOQg2D30Dfeb0UJ/ykJkllFZ
         WchP1hRQNCPFA==
Date:   Mon, 23 Jan 2023 08:08:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the block tree
Message-ID: <20230123080830.7d50fccd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O7P7qgyIWb3.CowoQ8D+Ahp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O7P7qgyIWb3.CowoQ8D+Ahp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  24337ddf1ff4 ("io_uring: Enable KASAN for request cache")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/O7P7qgyIWb3.CowoQ8D+Ahp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPNpc4ACgkQAVBC80lX
0GzjeQf/bU+h6jlw0Oas7j1U8HiycQJuKCQvuCKwMF/VTwVWiIpTtS8HGDU4Pb57
nfmmPqvRVL2ITjr0fsQqj6GOOovDoi1TqjCY5toZZuGO6KJsdhLZu6NrrhKcr8Zl
PTF/Hto0fe+hgBemSX/fZDROvM/jd/aJ4mDeHTGXnYOxAiBqLe4QH+HNpnYRcOe+
03WRn9YLmE82BrsqazYvw69QBGOGTa9w9vrHQuWijLou04vFv/I1iLVIPw19GEHM
J+tlVchG5wa85kRv1IzeyGkrobWv7nA815LiY8qKRWRAzXCjSMvv9SUCZIt7Lcjq
uEb2qWBOqmHLpQzX+zaXGkPPs5+MeA==
=JV0t
-----END PGP SIGNATURE-----

--Sig_/O7P7qgyIWb3.CowoQ8D+Ahp--
