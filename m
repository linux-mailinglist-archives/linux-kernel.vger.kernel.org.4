Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8DA668587
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjALVf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjALVew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:34:52 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD40D225;
        Thu, 12 Jan 2023 13:24:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtHch2zhnz4wgv;
        Fri, 13 Jan 2023 08:24:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673558676;
        bh=n5GNq2ce4h8YRPkEhSWhIQJSm6F6SdYTneymXVLkVmA=;
        h=Date:From:To:Cc:Subject:From;
        b=nyYJqy6LK/TLD+cKlMIbfWRqI4pcq/S8/+JOYIR0hLpqtSxGO+6a+KshYM6nhrHaO
         gzVfAJNkpro3btlTI09G60LU4cTKe6//Z364OZ7Q/kkGooTs76CrIRQFgCo/FgBjT3
         z+W2vNSh9pgs2WpSEtSFJdkb4oxM8TsvspX/p+l9qX/IcmGUrqWmCw5KxjEjI3ILfr
         ZBAxn0XJ1alcQ2cCXIcCYjcJzzmUM+dUix9XHQrFViXPQogQ2Bp5cD7xkp+ngRduxq
         UoLT4vxiSoWkWm62SbTAGgQEs5CCzikNzfruH7TJTnIQPl6zKvEjkikaqdTrF2PXss
         JME1xK15se3Vw==
Date:   Fri, 13 Jan 2023 08:24:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the spi-fixes tree
Message-ID: <20230113082433.08cf19a0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5FK32QBlQ7Y3V.L7XyOMiK6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5FK32QBlQ7Y3V.L7XyOMiK6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  1f4d2dd45b6e ("spi: spidev: fix a race condition when accessing spidev->s=
pi")
  50028988403a ("spi: spidev: remove debug messages that access spidev->spi=
 without locking")

--=20
Cheers,
Stephen Rothwell

--Sig_/5FK32QBlQ7Y3V.L7XyOMiK6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPAepEACgkQAVBC80lX
0GyeAAgAioi1aJvC3FZI5rjqT3u692eCxv+2mO9rRg/HoYxs+UwJq2EtA8/5uTGc
J4XlZBGVl60c/x41hPV0MKHrgM3vlA/EZIEyxfsw0piDzpZopGpDioKJfRmLpHOi
2lQ1YCFIIPR4CIkLdpPM9N2azzwQewtrVAmm7uklTgbu14t98cv2+Ugy2lxxAIPH
OpA1Y2KUlhCRLutCAcKiOY/KY3WMZpmPljJzbQcNE9t22wbosFzl9XNzhGPsWTSN
TZRUsDlVOwfmwpv3i0TZ8pNowvqo3UxoWVxA6lXUhJZYmVzzykveB9Vpb3bpgTaE
lUV3jM0MBRM/kVGxKk0Cd0ztJ6YUhw==
=mFXZ
-----END PGP SIGNATURE-----

--Sig_/5FK32QBlQ7Y3V.L7XyOMiK6--
