Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B000A65F6D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjAEWc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbjAEWcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:32:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC10DF0;
        Thu,  5 Jan 2023 14:32:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Np1Sh6sQTz4xwy;
        Fri,  6 Jan 2023 09:32:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672957973;
        bh=Cvd6DoNzRdTLa/kgU2bq9vznfp/vCxDw0FcHNRFdYDY=;
        h=Date:From:To:Cc:Subject:From;
        b=dtWoPhprS9UJTJIGguaU98R4EOEE9kb19fKOc9Q4ijqjDAR1p6PyoVfvrbwMONQbR
         hnrffmw09YhHS9I9ymfVo0jpip7CG0pDDg8xLCVR1tIbvVFBY4PWR2D+Qtj0alfMk9
         tSPcC2kh6jUIMjwpCMG5b9AGcXwEMMXChQNn0nrKbIGoEodAdMNAukjiWOyG8YsGkv
         99V24FY9SMjiAKnqErWFtJMutfM+9Bf/r5Uyl5gHzbs7Jqjrr/Ga5gaHSNKEmlqXZs
         J5MXih6T5GAXhTYvFHB8r40i2M9kqjGGJL9H3OJjQuGT4+ISCipWdiFZYxQ8+qgelc
         1OFjM0ovjQ9hg==
Date:   Fri, 6 Jan 2023 09:32:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the spi-fixes tree
Message-ID: <20230106093252.333e715c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aCOG5T=yLrKKq5DoRRXHb_H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aCOG5T=yLrKKq5DoRRXHb_H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the sound-asoc-fixes tree as a different
commit (but the same patch):

  b24cded8c065 ("spi: mediatek: Enable irq before the spi registration")

--=20
Cheers,
Stephen Rothwell

--Sig_/aCOG5T=yLrKKq5DoRRXHb_H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO3UBQACgkQAVBC80lX
0GxctAf/eYvW8s8hAdp4hTs0Y1czH6gGgmvuuMVYb0RGSffn3MscQpj1c0JjsXA0
PHHvkZzLFDZOmH5HxoAsUhGEcvQZrjxOu8OBjyEmJNkFT9TBdJPRz1nDe1+cY+lz
OyNp+xWpAbanblO684vRYvqk4VfJd5qRVtSEpxCNn0c7ph8T2MjG9LXwZMlkUFe1
mgg2ZgNL2xb1ipvE/VlV8NSBOhC/yYl3Q5Uq59lk5k+aYKVuqkBF+2MDs15lAMVN
70zlYkb3gyGJDe4WLX3or/vArrjzrCuh/RXw6tqlWazYO7ZsX+GvDu3vRxE0A4CN
/+R+6UrSFUur3YyVru6cEA4vrky63Q==
=zb1m
-----END PGP SIGNATURE-----

--Sig_/aCOG5T=yLrKKq5DoRRXHb_H--
