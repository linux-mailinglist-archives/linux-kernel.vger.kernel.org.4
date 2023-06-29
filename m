Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F86743019
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjF2WA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjF2WAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:00:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6077912F;
        Thu, 29 Jun 2023 15:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688076016;
        bh=yiZNuBJVKq+5GNf0+M0hxIexJbn8EMOKzOteUcxiiCU=;
        h=Date:From:To:Cc:Subject:From;
        b=Xbor/dkCMzOa8yG/4qhf/n3xQFfH/j7CXz9h5T6zT/BJtURLgO56xpNFoN99lcqZa
         DkWjHvB3hZbM4hcn7O1ou8sf++4DSkzT9qOBaKxvRxwPlCyBoicmfLUmrNUA0JdLg6
         Ifr4QksVb2hyct7ankxtJproqj6y8ifl0/M7XQD1BNr56TFOV383Q44serobBQBFNo
         1s6afb1KGlSGgBw+AyMhFE/pJf5c22Y4caJ/CJjnDw6wrKlRkzqIZInlSddzDOz9hP
         ZizGj9Q7hKtxRUbhRZxLW943URdfJCLyxnj57RfBpmIuv0POP2BCXB6NSrC5Pijn6+
         svGZkPbTw1JPQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QsXSJ1Mcqz4wbP;
        Fri, 30 Jun 2023 08:00:16 +1000 (AEST)
Date:   Fri, 30 Jun 2023 08:00:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Matthias Reichl <hias@horus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the sound-asoc-fixes tree
Message-ID: <20230630080003.69d7493b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lO6+8.uhbL5uKyvhg5SybO8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lO6+8.uhbL5uKyvhg5SybO8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  7b5162080174 ("ASoC: hdmi-codec: fix channel info for compressed formats")

This is commit

  4e0871333661 ("ASoC: hdmi-codec: fix channel info for compressed formats")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/lO6+8.uhbL5uKyvhg5SybO8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSd/uQACgkQAVBC80lX
0GzeQAf7BmgWMuO7gW+uL+rCoWGCB80OEor9/bETB5Kx0QcJMkU78JP31IcYqag6
RXU+gPv4T7Wt9+zRpMUtRd4QUPxOlqTLGqT7EotLPp4WCySxhjMHyOzK/clm2d6S
ozq6bIJWlvt2rfC1KHmrUJCieXXdF2wOLe1DdvCrAPperNNlLqBN5SdTZdB7Jrqf
eExd+pLEfjs/4rMUC80LUGZrj5VwTw6MVs25hvKo/3iOloaFkE1Zgv6iPUdNocJI
B71tMVOmD4lWeTlPyNdDl8fQYEwqDOIcsn62ndbMWWFkIfe9oXrXEBIgBKe22NDY
Uo1xyAeWhmMZGkOXsHG5uwldDyA/vg==
=GFxt
-----END PGP SIGNATURE-----

--Sig_/lO6+8.uhbL5uKyvhg5SybO8--
