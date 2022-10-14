Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539905FE94C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJNHPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJNHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:15:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AEDC510C;
        Fri, 14 Oct 2022 00:15:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a25so5039732ljk.0;
        Fri, 14 Oct 2022 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGyxzte2IKH3Md6Ogu2BfJvxcJ1+fvLq/yJsfWOfr70=;
        b=pqwCFkn2YfX8+dy9tEFmmFX254tPZhy8XC/gXHWLPWFBChGhNjq3ISmacP2zxKbyFc
         DZrD/71buQpS8mz6Jk3J4P/Gseqg8DQ9OsFKn0GeflaZzq2mBbQ4pgOyFFjN3Uya/t7r
         wqlx4VXoWYSp0c9QUis7psazVfZgJOXVie6kCk/CRbSxI/8BDkw6crllLe8SfciZzw1r
         GHmhItW9sYvjzYsve0MyIVF783NG11UHp+pkLiT7lVgQ93jA/qX5qgpE86BEnvd5UChX
         3cDMo7Z3R6/qEwZSRJv9y4z5qgk1OWNPDgbzkLvoHHddloHqKpAqwzYXrV7tFLf4SbF3
         41Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGyxzte2IKH3Md6Ogu2BfJvxcJ1+fvLq/yJsfWOfr70=;
        b=pyRbCnYn2gckFVJDfl2Fabu3e7nN9riBsbYFrviMdnp4epl6u1hQQyPt23pSlgOpz2
         7fnOnNNHq5weyc+f1bApBpZfi/EHqdil7XyNYkazAsfbvYO1hdiN3FSlua9Scre68L+4
         e4IoiqzjaS1nE3814HNZj11c6o1fS9FlJwmIbmrptH1JsG150Ie7p6cxHmXsXzvyOWQ5
         5tCMUvNEUKuVLliThZKVHuFV2Zo8+iYXXCKvG1ef4NPjABNrFgstRxzO14z9Seq7PzHz
         OhEAXOp2S984i6Yk88wmbIN2rRtUYxrhOL3613ioORevmsgHNW7GZXZsB7KKADyo/Nxm
         RmxQ==
X-Gm-Message-State: ACrzQf1V7RqMRrVF+nKKvIuqQMZLLf+B+1TCuVDGvfp+4hJ0vjRpHRSI
        3JsdXiZRgSw8/d7KXyMOCI71qqF288k=
X-Google-Smtp-Source: AMsMyM6nxpTjYdLb97LQzpum5UqrHvPtyw9mv3uPfpi7o1Md6mpYRYfd3QXz4o77WMOfwYnUASYfNg==
X-Received: by 2002:a05:651c:b23:b0:26f:db39:9544 with SMTP id b35-20020a05651c0b2300b0026fdb399544mr443383ljr.116.1665731738793;
        Fri, 14 Oct 2022 00:15:38 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05651c231300b00261b4df9ec4sm240535ljb.138.2022.10.14.00.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 00:15:37 -0700 (PDT)
Date:   Fri, 14 Oct 2022 10:15:19 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] =?iso-8859-1?Q?=A7tools?= =?iso-8859-1?Q?=3A?= iio:
 iio_generic_buffer: Fix read size
Message-ID: <Y0kMh0t5qUXJw3nQ@dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mOhZbFKr2wlI1FAt"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mOhZbFKr2wlI1FAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When noevents is true and small buffer is used the allocated memory for
holding the data may be smaller than the hard-coded 64 bytes. This can
cause the iio_generic_buffer to crash.

Following was recorded on beagle bone black with v6.0 kernel and the
digit fix patch:
https://lore.kernel.org/all/Y0f+tKCz+ZAIoroQ@dc75zzyyyyyyyyyyyyycy-3.rev.dn=
ainternet.fi/
using valgrind;

=3D=3D339=3D=3D Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyrig=
ht info
=3D=3D339=3D=3D Command: /iio_generic_buffer -n kx022-accel -T0 -e -l 10 -a=
 -w 2000000
=3D=3D339=3D=3D Parent PID: 307
=3D=3D339=3D=3D
=3D=3D339=3D=3D Syscall param read(buf) points to unaddressable byte(s)
=3D=3D339=3D=3D    at 0x496BFA4: read (read.c:26)
=3D=3D339=3D=3D    by 0x11699: main (iio_generic_buffer.c:724)
=3D=3D339=3D=3D  Address 0x4ab3518 is 0 bytes after a block of size 160 all=
oc'd
=3D=3D339=3D=3D    at 0x4864B70: malloc (vg_replace_malloc.c:381)
=3D=3D339=3D=3D    by 0x115BB: main (iio_generic_buffer.c:677)

Fix this by always using the same size for reading as was used for
data storage allocation.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

This patch has been only tested with my kx022a sensor driver. Driver may
have some culprits(s) and my understanding regarding IIO and these tools
is limited so perhaps the hard-coded size of 64 bytes has perfectly
legitimate reason - in which case I would appreciate to hear the
reasoning so I could seek the problem from my driver. Also, I didn't add
the fixes-tag as I don't really know which commit has caused the problem
- as I am not 100% sure what the problem actually is and if I am just
fixing a symptom here.
---
 tools/iio/iio_generic_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 2491c54a5e4f..f8deae4e26a1 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -715,12 +715,12 @@ int main(int argc, char **argv)
 				continue;
 			}
=20
-			toread =3D buf_len;
 		} else {
 			usleep(timedelay);
-			toread =3D 64;
 		}
=20
+		toread =3D buf_len;
+
 		read_size =3D read(buf_fd, data, toread * scan_size);
 		if (read_size < 0) {
 			if (errno =3D=3D EAGAIN) {

base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
--=20
2.37.3


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

--mOhZbFKr2wlI1FAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNJDIIACgkQeFA3/03a
ocVehQf/XIQ0ICkmrTi+n5aEjFmdKGhSs62dWbL4jsnhmp5k9znUWu5FbggGrIS1
Zjhh2srQ9oec+88NUdEcIkupXIuHBW3rsoQTtlA3/Egi5D1sQeLjmikAvq5ps6AS
pVSohBswNh8QgKElzubyoKDN8bUKibbD3xj0oFeONKrN7q0wGlEHRb+e6qAY/HCq
5pVunzYHjzTvymqh6OFu7BYzF5P9+lUb5x/2WyKPR3RiCSdS71MYFV8+YjDCzpLA
K3Mv1/r5NNQh5mBw+6ydBDsO75Kl/uJBjS8sseGSxK8lBqp6YKA638Cy4IXLl6pg
pTOLgxnpUN3vlIw3OCJIEsm3i5OOpw==
=IFzV
-----END PGP SIGNATURE-----

--mOhZbFKr2wlI1FAt--
