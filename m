Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723437430B8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjF2Wrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjF2Wra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:47:30 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2E22728;
        Thu, 29 Jun 2023 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688078848;
        bh=H//WAPBzPwlc0jjRgnUzqlnUgQCn5XHSNkfIzMBetXc=;
        h=Date:From:To:Cc:Subject:From;
        b=uLsdyp9kStwS5wq+MvRXNSRmSOxkqRJCo0MOF955BlI1Ks3wpIvFZiE2bcDT9quRJ
         mPLPQbBU1V18rljCeMfQE55fv5izBaBmDUQbBqp5FA7+qpeTRkUwpBcmz2OqrBg0eE
         dtFiC2PEE9D7YpRGjRYc84A+0x4dt6R3fir+spOpdNBsrfDJDZQut6aviRHmidm6mu
         ZpnhGAsNQ95teszkl5UlwV7WsWiSEcR2oHGXcJK28CPU59bJSdjBfccXChExUYUntC
         0Mrbci8qIct/ZoZ9AusgSAz0ZRYTgbJQkhjsHy0s8CwX2wWAqO3W1tN7bk77vWSQWH
         qElC8de28DmcQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QsYVl2hySz4wZt;
        Fri, 30 Jun 2023 08:47:27 +1000 (AEST)
Date:   Fri, 30 Jun 2023 08:47:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the tegra tree
Message-ID: <20230630084726.3d3e47a4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i.Z+J5y=_PMlYtFoHcLFqnh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i.Z+J5y=_PMlYtFoHcLFqnh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  0cfe33924cd1 ("dt-bindings: tegra: Document Jetson Orin Nano Developer Ki=
t")
  9928d6789ac8 ("dt-bindings: gpio: Remove FSI domain ports on Tegra234")
  f13fe44fff40 ("dt-bindings: tegra: Document Jetson Orin Nano")

--=20
Cheers,
Stephen Rothwell

--Sig_/i.Z+J5y=_PMlYtFoHcLFqnh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSeCf4ACgkQAVBC80lX
0Gzf5Af/UnYfV5QiGmjDiJ+FI3SJRvtTvKdQTkRKBPYpfDSAuVsfpjOuiIxUqZaQ
IP5VRK9FgqIL3hwDCcQLiSS7asc/7PaOulKXvSbPGvynWq/Unt4kQnat38ccnASL
8saGOL3Xe6wHi/DjqfklDBDqv60h25GoxDYNaM9Ak7U09uh+MTaKCfTNqGf6KM8e
jYedDHQpdcBGDW9I5n8nqQplYU53SyvSTIhe9Bqt4mpaNqGKSKSWSDNBMlr7NINm
Iw/tmLjciku3zhhh80dNZaI8KpHo2UdUiM9U0aLIjxLRgT33EzyhLJPyF5Odvh6O
wptkBFkrIJ4HpIJgBUX3kjfI4Uwwaw==
=9dU6
-----END PGP SIGNATURE-----

--Sig_/i.Z+J5y=_PMlYtFoHcLFqnh--
