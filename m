Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363B4693A24
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 22:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBLVG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 16:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBLVG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 16:06:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BD61AB;
        Sun, 12 Feb 2023 13:06:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFKlL2q6Dz4x7s;
        Mon, 13 Feb 2023 08:06:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676235982;
        bh=UGHELbkmj2TedD0l0ozq3b32EAteMMZe4ol73jksV8g=;
        h=Date:From:To:Cc:Subject:From;
        b=eKmzO+jrWaHplKTBElksxI2XqsMEXfUV6u7MXor0sQ4+Zlu7FfnYa51pRbvDz283+
         RR8HI9LzsJcLUEyvhus7oYFqwk+kYCeSHDLymZYEkrUDDZc0+B3DKECLz2Oz0aBZQN
         pvrtZhiXsVlIgah2dM7rD7XQj2/wYhQM0gwxxu7nNsMHLDp3/i3JzjfKdxakdldqxw
         cydQ8JWpqRCjpqVKgWqvL4BV+SYDk3A8qwNba5aEAlDoJXrHdpie5eI3ZpvrpoiXX0
         J02BdyZ9zEsvklVCqzm9S3dqyGcAnUpPFw3RHv6MpF5uDyEER0TE4K13J7UAtLDE7E
         /y4zdcaZPxxhQ==
Date:   Mon, 13 Feb 2023 08:06:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the pinctrl-intel-fixes tree
Message-ID: <20230213080620.62f7eeb6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D/5WpCISzF0ORtwpy==lbha";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D/5WpCISzF0ORtwpy==lbha
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  a13bbd841bf8 ("pinctrl: intel: Restore the pins that used to be in Direct=
 IRQ mode")

This is commit

  a8520be3ffef ("pinctrl: intel: Restore the pins that used to be in Direct=
 IRQ mode")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/D/5WpCISzF0ORtwpy==lbha
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPpVM0ACgkQAVBC80lX
0GyIGwgApmtffI+nlnGQ876NU3uqbLLX7mIHEbK7i+gQDFV9Xkv24B9dzBF5ZU74
EZtv8/8uRxwoT/C4rApYfmio7O+uF7wwGLzTRi1FUzHZlk8UMzUjqGmdfpQ5BV3c
eJPD0/1f11Id8Sz5IyKHbp8FlDlbFEMiDR325bvcvsbQrTSUyvhcx+u+8MxbxOhU
tBAoi3Ip25gxvk7cI71PUd9NZrDTzT2KWbn1T7xBy7i/cnCwv/4grLBufM4CPDTF
FAw/2Zn/4TalFQ+jqFRauJr1rwZlH43hjLMeFS/QcvQgG5V8OnR+Oj1U4lX9jtST
UTXXRoUvZYnF4eVtY2i7zCcrKAeXgA==
=SjUV
-----END PGP SIGNATURE-----

--Sig_/D/5WpCISzF0ORtwpy==lbha--
