Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A016068FA62
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBHWp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 17:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjBHWp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:45:57 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9631A94B;
        Wed,  8 Feb 2023 14:45:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PBw7x2Db7z4xyF;
        Thu,  9 Feb 2023 09:45:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675896351;
        bh=Hh2ibYljk7zsLnLjiDF9KL2TAdzmwiAjDyNsMT+2eNU=;
        h=Date:From:To:Cc:Subject:From;
        b=BggeNlfWO3OUWpqnjJQLxfaU5NWm9bV0tAMc+WGzyBAZR02mdTg5U1yN4i1bi5lzg
         QjworVHZ1OP58w8OlytwHWxCIb9Gtz92amDaxIPOm8Bnn8ZBMWwtzQ9dZayfMCfDlM
         0NWP5FXjR453n0mBk5jSbUeRjJVvvuqSS2gOIabCGhgGK2KeyKA2VCvw8O2Rv6eewN
         BuVQmzTYuJ0d/xXJ/89uJgwAZ/NMcwLVbVnz92REBq8XT9WNUx4HYfIUtnPdqXKwZe
         r7J4ZOhFgK+2n4llh7VjpTUCdMrQ30/eatVPyyGfTTMnraOUY+XpsqKVsGG0ejdfnM
         ughQVT/26efTA==
Date:   Thu, 9 Feb 2023 09:45:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: linux-next: manual merge of the v4l-dvb-next tree with the arm-soc
 tree
Message-ID: <20230209094548.44b29fd5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t5K/X.0WF10MQk7xE/21q6F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t5K/X.0WF10MQk7xE/21q6F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the v4l-dvb-next tree got conflicts in:

  drivers/media/platform/ti/davinci/vpbe_display.c
  drivers/media/platform/ti/davinci/vpbe_osd.c
  drivers/media/platform/ti/davinci/vpbe_venc.c

between commit:

  eeee69739353 ("media: davinci: remove vpbe support")

from the arm-soc tree and commits:

  eb78ca6a0496 ("media: ti/davinci: vpbe_osd: Drop empty platform remove fu=
nction")
  5204a5dce04b ("media: ti/davinci: vpbe_venc: Drop empty platform remove f=
unction")
  0d3732fb1b20 ("media: ti: davinci: vpbe_display.c: return 0 instead of 'r=
et'.")

from the v4l-dvb-next tree.

I fixed it up (I removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/t5K/X.0WF10MQk7xE/21q6F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPkJhwACgkQAVBC80lX
0Gy4/Qf/W1xH5oBVbSBPiQBDZEFJWMal6Brami1+SjmrHAUkz+67uuwBxWfxvYXZ
4IfeppwZ7i9YI9n1ZHeaC3TH1RIt9jQ8NXjPSR7bWXVxsuQqiDBcPdNvAWitcyDH
SkLhxJ5BIj8cKXUquwlZbIwv0PmtoHurgofst18SesqoEOff7SKGzIygFGwceWSb
jwsMtvKJ2OiReuIbVezfgRn+zQyP6/TkaGX+kTJdhCISmHvUWZmJZjKgIX3sq4OA
KDOMMbEmks7bi7QCAkhQM7iDdujgG92RdCCJqxwkDe/0syFe9NeMySpFN+eYUunl
RIjQkfK10hyVLH1j7YZT7FzYDTKTjw==
=BxCG
-----END PGP SIGNATURE-----

--Sig_/t5K/X.0WF10MQk7xE/21q6F--
