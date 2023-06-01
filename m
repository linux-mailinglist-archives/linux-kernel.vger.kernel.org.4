Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1812071908B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjFACbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjFACbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:31:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03B3197;
        Wed, 31 May 2023 19:30:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWqr221PPz4x3s;
        Thu,  1 Jun 2023 12:30:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685586658;
        bh=GFe8zkdRLZWDtES6yWTJ++i+b4QFRKUczpTWQL/EGMQ=;
        h=Date:From:To:Cc:Subject:From;
        b=i4WXPofPWs9leY7NnzMS4htEp6JGjAS+iAr+SpHwrkN8LzrNcJ7ASaM9MXLXX5nq1
         NDuUL9tFoI0g0C2Wn9Lt85RzXxtDnHoKTv5mNVKIhiogjCIknxD5GR0B+i9Ui1/JkF
         1z3q11EUamR4QEw92Wdr18PmoJSRsYwUGI4P22lfRzSvf4Ds61KQXcg9tBF0PF42j5
         /kocf1jvWg3CsXrEPk8V1pjb++vgNIUWxss8weQsGApViUP00mLPgFzEZhFyJ2zaUx
         cHTwhAK1VYE8zj2Skefghal5AuzyiGyTeur3nDGDw3x7UyAdTaN0O4DywKAQm5zHt2
         HVIImUlkRb/Zg==
Date:   Thu, 1 Jun 2023 12:30:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kspp tree
Message-ID: <20230601123056.59b281c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bQJxF7bxd3T5NtWgiQ3Q7gU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bQJxF7bxd3T5NtWgiQ3Q7gU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm-hotfixes tree as a different commit
(but the same patch):

  f7223ccc138b ("string: use __builtin_memcpy() in strlcpy/strlcat")

This is commit

  0af9b29c6efd ("string: use __builtin_memcpy() in strlcpy/strlcat")

in the mm-hotfixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/bQJxF7bxd3T5NtWgiQ3Q7gU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR4AuEACgkQAVBC80lX
0GxBvgf9EBtbBUEqFo9ScDuMn1WrsrAzx5Q82w7oGnw+ggB5zDnbD437jDut4RNw
FKn/EwQbenTPacIfb+ONblZMe9O3OuQXTwE/L04ZKJ1pNOGUFd1zLdbPjdlhJZvB
FA0jY0e9y7RGsn+DyLZuoUQJtabS2vSl+EACJTA5iDx+yFdY/BT06Yk9P52Y6w1x
gdyarDOpn2cjnMQwBKNC+wJ1BxS6pg66IR/gY5vafIQmbgQk3tFCNE0V/dRMX71G
gQI3dgbwK+ItLTBDDm7278RLqhF0mhGKB4PSNJG/MuN1M5NWsMvBP1PfE3QsXsBU
VZzcAZ1IJ7FFIFFT544g1bKtjW0iXQ==
=/7bM
-----END PGP SIGNATURE-----

--Sig_/bQJxF7bxd3T5NtWgiQ3Q7gU--
