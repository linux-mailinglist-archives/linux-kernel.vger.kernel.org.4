Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCEB62B54F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiKPIdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiKPIdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:33:38 -0500
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E544DE31
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:33:36 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id x21so20858249ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKlOC+omeE7Fbq3sEW7T1SZBevKbc2ofi3hDZZa2pfk=;
        b=mpw6Q413Yi4X65VWu+UbiJXiCg78Mj7R3h0QyEx1FdneT/deiGn9+ylHYPUjqtPN3d
         LC4HPH3hIK5uzSDDtww/qRTCrp29r1NEGvHAeloM2VRPQPykfj6njWtv3PvGpm+d80yw
         +FXLk66k9Y0jTM4jx6CquKiNavkv7C+1RactX440xl5L3BLJZs+8E++ZWQdaYF2Zqghx
         Fd5n/2deFP6I4RicnaSxgwL0tFfEh/jmp8hxIQwnY/4f9yhRhFpbee0Fuym5YmWzZrj/
         VWfEVnb8cU+ZDqcftiMKO3oW47+ie26ksa6UuC5fESGsy+KW5xDvN5jyfhSsp8CiizP1
         VpYA==
X-Gm-Message-State: ANoB5pl59hfCB0bmejrhzSTpH1II94R7gJ8bUaNvoSGTxZjKhl/3fMBw
        LPqLVR73ag2DyQ4+q5LZF1s=
X-Google-Smtp-Source: AA0mqf6SE77eBndDoLF4RFu17/e3c4fPtP6W3PQJiKheVp+BmKOheBJr+IXOwJrgVP5irbyc8KTK4g==
X-Received: by 2002:a05:651c:88f:b0:26f:c160:6dde with SMTP id d15-20020a05651c088f00b0026fc1606ddemr6990991ljq.20.1668587615176;
        Wed, 16 Nov 2022 00:33:35 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::7])
        by smtp.gmail.com with ESMTPSA id y14-20020ac2420e000000b004a9b9ccfbe6sm2503115lfh.51.2022.11.16.00.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 00:33:34 -0800 (PST)
Date:   Wed, 16 Nov 2022 10:33:25 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Prashant Laddha <prladdha@cisco.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] fixp-arith: do not require users to include bug.h
Message-ID: <Y3SgVdVey9legtX+@dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GS8yxXAiYW45aPhR"
Content-Disposition: inline
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GS8yxXAiYW45aPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The fixp_sin32_rad()() contains a call to BUG_ON(). If users of
fixp-arith.h have not included the bug.h prior including the fixp-arith.h
the compiler will not find the BUG_ON. Thus every user of fixp-arith.h
must also include bug.h (or roll own variant of BUG_ON()).

Include bug.h from fixp-arith.h so every user of fixp-arith.h does not
need to include the bug.h prior inclusion of fixp-arith.h

Fixes: 559addc25b00 ("[media] fixp-arith: replace sin/cos table by a better=
 precision one")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Another forgotten patch I encountered while cleaning up my local git.
Seems like this has fell through the cracks.

 include/linux/fixp-arith.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fixp-arith.h b/include/linux/fixp-arith.h
index 281cb4f83dbe..e485fb0c1201 100644
--- a/include/linux/fixp-arith.h
+++ b/include/linux/fixp-arith.h
@@ -2,6 +2,7 @@
 #ifndef _FIXP_ARITH_H
 #define _FIXP_ARITH_H
=20
+#include <linux/bug.h>
 #include <linux/math64.h>
=20
 /*

base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
--=20
2.38.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--GS8yxXAiYW45aPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmN0oD8ACgkQeFA3/03a
ocV2+Qf9HvZLfrZRdoKiCqyVHwRqTvI2GyScR/J1uuxQktJOG5+qTFFINQZkasI+
y4SzW3QdXpSoOGBjrXicGHtYmcqXcJ2L3degaQAWAUqSNb6WpOH4urnXUVya5m6d
VzIughhGC+hX/R3C9kM7OqbVnVyHsiO/qh3I/z/zhFGQtZzazcFxYa9HdKFLB4kl
26szvWxQ6KAYM00rHuuRQS326BDNUQU3xFjIGm1zKVvOTrfTdvTV1WY25JeGGttt
BRx2yG0CP+RweilIPoi9uhV0TaZQZdmeQqmnGKlSDoC7t1jhmUYa1DEMwiENCxfe
jcvf9JeuzglfzxTnCzqRYJG7n7Bj7w==
=3eFE
-----END PGP SIGNATURE-----

--GS8yxXAiYW45aPhR--
