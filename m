Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32766FFCF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbjEKXHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEKXHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:07:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDAE2D4A;
        Thu, 11 May 2023 16:07:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QHSGQ5Wb8z4wgq;
        Fri, 12 May 2023 09:07:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683846446;
        bh=7aOBU3S6gZdjMqA8FSQtrSA3oKTpWMBQzWJVOHffsQw=;
        h=Date:From:To:Cc:Subject:From;
        b=TTG1/VtPjnlQ29bAnmeWMAW/5bKUS2gBKAmbAohCGu+Hv747h4lhyS8mwaeSrdjF8
         5kNGAq9o6mYix6aMVYEof2vP6ssKnL7Y79b6PS3c2whTekvto7MYQSOpgC8tWKH+LA
         3+++bGfoVftEkxhHNqrcTYMASc55b/3FZZIYlX8KmSRbQZPozqukDrLDpDl5g9MN5n
         uHYa4y9RN+PRqsTJo9JJxdzMVT3DWwM7FbdEn7OmSoCoT5EsO1e33FVqyJwfLxUYi3
         loCqo5KalZqAzQQbCgGw8qcOvAFnoALQT4ilwd1f8E8+mu0EfT0CByy71x6QUqKq3K
         2VzYfN2YoCszA==
Date:   Fri, 12 May 2023 09:07:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the v4l-dvb-fixes tree
Message-ID: <20230512090712.175dd8ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=Cb6DjRX/Zt8nZP/LGcJKzS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=Cb6DjRX/Zt8nZP/LGcJKzS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  6b854bb90d23 ("media: platform: mtk-mdp3: work around unused-variable war=
ning")
  814fb7f94d70 ("media: nxp: ignore unused suspend operations")
  97e814237417 ("media: rcar-vin: Select correct interrupt mode for V4L2_FI=
ELD_ALTERNATE")
  07ea2bc2f320 ("media: rcar-vin: Fix NV12 size alignment")
  60ddb2e1a331 ("media: rcar-vin: Gen3 can not scale NV12")

These are commits

  ae3c253f595b ("media: platform: mtk-mdp3: work around unused-variable war=
ning")
  55e2a6e36be6 ("media: nxp: ignore unused suspend operations")
  e10707d5865c ("media: rcar-vin: Select correct interrupt mode for V4L2_FI=
ELD_ALTERNATE")
  cb88d8289fc2 ("media: rcar-vin: Fix NV12 size alignment")
  879c5a458e53 ("media: rcar-vin: Gen3 can not scale NV12")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/=Cb6DjRX/Zt8nZP/LGcJKzS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRddSAACgkQAVBC80lX
0GyT1wgAi7H4RSVm4mjIYNyO/OUbhTVWNrPRnMngZXMAu9eEJPJFtOEAo4IIa45W
jlBXUtLTWdhWXTP7wg0kIETDjzpIgNkToXXoQkct9aQqs7Kpi9gXWUA/O4Nxy2BV
aGtX3flBWlfnGKs9JeUtBrLnX7otQc1V32hKs6Izc3q4ZHRRuvQ3jbZ5sEe+tOEE
4m6Gq3AuoPlXmVrizdqt94NKvw4Xf34J5dyqp82Mymh04YKk21qA5dyXb0oQmwf4
MzLxlp6E31XeTPKOP/t28wH0zqBJ7Nq+bR9YjrMuBr4Vtz+Yhb8xEPXXj8DDdVyW
N8E61iwr7wBK6CY/lxdUkSJHZWDiWQ==
=3bkx
-----END PGP SIGNATURE-----

--Sig_/=Cb6DjRX/Zt8nZP/LGcJKzS--
