Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E1F6DE749
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDKWaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKW36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:29:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A16C46B3;
        Tue, 11 Apr 2023 15:29:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Px0ry5jjzz4xFd;
        Wed, 12 Apr 2023 08:29:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681252194;
        bh=f/bZfbo+Z9vAxuPDGAcCUT7CZdGBFDB4HU3XSZ43QBE=;
        h=Date:From:To:Cc:Subject:From;
        b=Kt8VTP24mvpphZtK57LI5/CR4eLdHo5hu3Zj3T+dW/rm8l7GOwCFUP1SW2Z7YK+ek
         vIPE2FoN/zclMUBv46edqnQnL4EN+G0QzlDbDS5AgyGN2SJn9F1ila2ibEhWikZKH8
         efQ/SOPR6SySjEPZPDgQWmDT8mIgn+grdZlZCwdA5aPCfNwVgnGBqtieP1sKWQT5io
         lnnw/0gkQWarUWDPRKZ/8qM83+THdFu2iZjnie3GI9WXiHrB3xErmJekxpupbpHtTt
         vRM+yvXrlhrYbWU13mCeCVZVg4/N9Vu/c1DJGvQvcpnmKB0AZKOu6LcNposP4heh45
         PgplyVm0NTLRA==
Date:   Wed, 12 Apr 2023 08:29:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the erofs tree
Message-ID: <20230412082953.64ac8828@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9Mp.FFw54e8Q=kxDMqC5=YZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9Mp.FFw54e8Q=kxDMqC5=YZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  95ff51070f35 ("erofs: handle long xattr name prefixes properly")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/9Mp.FFw54e8Q=kxDMqC5=YZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ132IACgkQAVBC80lX
0GzS3Qf/RtLV3WOgunHHsabCLHVu1SlfsnGNpHB2PdDcLdf+quejmfkn7PFF6Kuu
jets+OIuBHtSyj7KTHceLlN/W/bt9IX2xjZ2YwViwLbKDeG+t6xZqTycHgZi3yab
JlsK87EdhuEKq3HGNmShKIeUGilky3IatKJJ65uWGM9TUX8+xB9wpQq+pa6uCafx
uvLGx92JoZdooTUnsb9RIx/576g0rU+yD7j3jqyeOgYYoWeCSyly+QCF0rXe6v0V
6N3QSheaWEoruMldMVhwTMvFDoq511s+GNcwvwAZxvUxo8ZQu2NrQZT2n99M/XtT
UXAzHpxA7s7YC/KMk6zEPxxpUTRZAA==
=fLJU
-----END PGP SIGNATURE-----

--Sig_/9Mp.FFw54e8Q=kxDMqC5=YZ--
