Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB026D6FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbjDDWHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbjDDWHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:07:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A5C421F;
        Tue,  4 Apr 2023 15:07:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Prhh33YgJz4x1f;
        Wed,  5 Apr 2023 08:07:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680646035;
        bh=Zz8HZziAkSzcMIk54EB5EBlh/kY12hV/o3RbEpgBV1I=;
        h=Date:From:To:Cc:Subject:From;
        b=LhJWmZEElGPmDCVYJxeKSyrCttZB8vHfoGGyPd4JdrBS/yeZ+Uqx5UqPGdn2qiV2j
         Txtcxm2/gQjp5nix/scHqdCeWeUJHSQ1MKcc4eDWEC6wUI8jUiqUINJmgpUoWwPW0B
         k70633p5s6dYzJJkznryz5SGmShVpHgMUyuoJmSnCx8EJIFE+gyStKbkzE9aUGZ3mB
         m5s+ef/dhzyqGwW7rWvLJ+jTpLOKo3TupRwIXn5agZ4qRZ5Tx1mXOiVZP/tVKEamLK
         7RbhatXmCdGKOTDr6ENs1HtzAUSCr1X3FrAFcM2l9KZc93K48guqVj3cyQF5/I+95N
         cX58WCIKgKHMQ==
Date:   Wed, 5 Apr 2023 08:07:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mmc-fixes tree
Message-ID: <20230405080714.72a9bf9e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/niCsm6pUOHDrUCRCSKye8yN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/niCsm6pUOHDrUCRCSKye8yN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6459a9bf7e46 ("memstick: fix memory leak if card device is never register=
ed")

Fixes tag

  Fixes: 0252c3b4f018 ("memstick: struct device - replace bus_id with dev_n=
ame(),

has these problem(s):

  - Subject has leading but no trailing quotes

--=20
Cheers,
Stephen Rothwell

--Sig_/niCsm6pUOHDrUCRCSKye8yN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQsn5IACgkQAVBC80lX
0Gx/NggAh8wlYxFoNW7hJEArHohPJ7bBdlU3JM0IWnnWUIBrqsOaPQY7uYn1Ykqr
nAvSAK/gkxSW+xKKEM/uIgXgr2SVDu20AtH1OuAy+HH7p20XWdoxEUrTlSgAEk39
wpzHyy1WTQoI1Qa7Ck9AhMpWR57wdYGGC3cNmNl5E2jNkaVK8a02lFxXaV1lhe9v
XDarDTK0H2CdJsP6cygyDRqMMFRJmzwhvBf/8a/NGgBGzjDQEW+LZYziQYhU1NCl
4qzC5JlXRc7ajTscq0U9rR92LaoDfZQJES289aSqHnhMytkmKl7vLsHetuQWP2Ka
huwKtPMh5swvUhHtWdb6ca4YkT7YQA==
=b0Pk
-----END PGP SIGNATURE-----

--Sig_/niCsm6pUOHDrUCRCSKye8yN--
