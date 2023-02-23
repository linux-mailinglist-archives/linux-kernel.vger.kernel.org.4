Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E990369FFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjBWANt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:13:47 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81EA24109;
        Wed, 22 Feb 2023 16:13:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PMYQt6zc5z4x4n;
        Thu, 23 Feb 2023 11:13:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677111224;
        bh=rHOQEcCUbLerBSAXShl1mdrbfj1msY+pPXnEyEd1HJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QAn6JR03eA2ghJS4i9SOe4U3zUfoIoCyTMKnxfcqPM/40oD/NN01oadwXeK/hx3jf
         C/DmkDaHlbhXIfalxAIK4Ca9MFdmxCMIGU2D/UEavsM//hjG0p5DDM/JmewH8X8pSo
         x+AQlXjZR8GoCYKZiKQ+a3Xs5vai8oMCIPUNuQqaa6PZSo0L3W3bpTYswGjzJR7Vw7
         h6rhzfjXYQnCjcKOjMcsIsYh3kP8iy7FXioup4+jeHTYMaHKF8spLPiA01FXjTsO6m
         XvVYM6uE0zTtQatSixu7vGdN3NYEDyJT/MXPMJl2cSA/bylTDA6/PAQkqkNPFL3Cb6
         w+HxaAl15Kcgg==
Date:   Thu, 23 Feb 2023 11:13:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        William Qiu <william.qiu@starfivetech.com>
Subject: Re: linux-next: manual merge of the pinctrl tree with the mmc tree
Message-ID: <20230223111342.7177513b@canb.auug.org.au>
In-Reply-To: <20230216124004.2be84a01@canb.auug.org.au>
References: <20230216124004.2be84a01@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_9=sdbnY1po0KZ9=MCz8NlM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_9=sdbnY1po0KZ9=MCz8NlM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 16 Feb 2023 12:40:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the pinctrl tree got a conflict in:
>=20
>   MAINTAINERS
>=20
> between commit:
>=20
>   9e622229bbf4 ("mmc: starfive: Add sdio/emmc driver support")
>=20
> from the mmc tree and commit:
>=20
>   d6e0a660097d ("dt-bindings: pinctrl: Add StarFive JH7110 sys pinctrl")
>=20
> from the pinctrl tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc MAINTAINERS
> index 1208b0380fa5,8a851eb053ca..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -19914,19 -19890,15 +19914,21 @@@ F:	Documentation/devicetree/binding=
s/cl
>   F:	drivers/clk/starfive/clk-starfive-jh7100*
>   F:	include/dt-bindings/clock/starfive-jh7100*.h
>  =20
>  +STARFIVE JH7110 MMC/SD/SDIO DRIVER
>  +M:	William Qiu <william.qiu@starfivetech.com>
>  +S:	Supported
>  +F:	Documentation/devicetree/bindings/mmc/starfive*
>  +F:	drivers/mmc/host/dw_mmc-starfive.c
>  +
> - STARFIVE JH7100 PINCTRL DRIVER
> + STARFIVE JH71X0 PINCTRL DRIVERS
>   M:	Emil Renner Berthing <kernel@esmil.dk>
> + M:	Jianlong Huang <jianlong.huang@starfivetech.com>
>   L:	linux-gpio@vger.kernel.org
>   S:	Maintained
> - F:	Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.ya=
ml
> - F:	drivers/pinctrl/starfive/
> + F:	Documentation/devicetree/bindings/pinctrl/starfive,jh71*.yaml
> + F:	drivers/pinctrl/starfive/pinctrl-starfive-jh71*
>   F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
> + F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
>  =20
>   STARFIVE JH7100 RESET CONTROLLER DRIVER
>   M:	Emil Renner Berthing <kernel@esmil.dk>

This is now a conflict between the mmc tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/_9=sdbnY1po0KZ9=MCz8NlM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP2r7YACgkQAVBC80lX
0Gw58Qf/aL6sDMlZhTKxlEKQfAFa7xFCJJ3ol8+Ax+U31sRQ5GIMjgS5MHmyhwK3
0ElS1IewbjdtXInsg1g+JfMKEHb33qjsY+WTrtp5CXgaXWmGCfuBG2UTaHJqxkVc
QJ/dupzye+qqeauNnorPi1qdKn6EajhKSC/Mfspo2gbNYxT/Huy94Wi1BHCMOV2I
Caznw7EY9nztB40JHIsM+iKDsLZHCOH0dAEP79OL1dRblWnmXoSklafTJrYg8kbX
ih7uBKBskwGYLk/RmETrFhJW+OCVa9RMUMEcWTXZb4vQgL1sj3J1uWFYnKRqUCaR
fNa+wDKf8F40zKHlATVOlm++yXB8sg==
=QN80
-----END PGP SIGNATURE-----

--Sig_/_9=sdbnY1po0KZ9=MCz8NlM--
