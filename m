Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEFA70CFD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjEWAsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjEWArq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:47:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEABC4C21;
        Mon, 22 May 2023 17:36:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QQFkV3Gv5z4x4X;
        Tue, 23 May 2023 10:36:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684802211;
        bh=C4nGr9EQgURQKOQa9g2l+S3dF21O7wGPd7WXFEN1Xdg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XLUh321ScnIWn/Dcnq8uvD1I+st1WvoqwV60ZP1ZBJdc2rrRQ92N6BdboOst0eVIs
         DAiVdfjj4c5ESw8NkbNut4h9A8mTynyuk4iB4f8dJd+005dzqYbOrjo6hNxuN68AGb
         3XiqLtQ182wp65El1ug02LVbOPbgVZEbDeXtDsHw9jAS3sjj9I+hfJkQmq9ji30T4v
         DV7ay0GhMGx9RpmBOI/14Ttv6a11TwDtSwX+g7w91OrwsRSEUNmTlbrM0RxgASeKrl
         ie95mZHTuQoSWZpWawot/lvrXR3kYBuDYK4x4FD3sGtU02KGf1eQKTbpyDjQKAa8cA
         A7WDaVZI/OrBA==
Date:   Tue, 23 May 2023 10:36:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Huan Feng <huan.feng@starfivetech.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20230523103637.20175fbc@canb.auug.org.au>
In-Reply-To: <ZGr6aB9uJVnyfJQ9@gondor.apana.org.au>
References: <20230522105257.562cb1ec@canb.auug.org.au>
        <ZGr6aB9uJVnyfJQ9@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8prTCi.GI047Yt2qEAvJrF.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8prTCi.GI047Yt2qEAvJrF.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On Mon, 22 May 2023 13:15:20 +0800 Herbert Xu <herbert@gondor.apana.org.au>=
 wrote:
>
> On Mon, May 22, 2023 at 10:52:57AM +1000, Stephen Rothwell wrote:
> >=20
> > After merging the crypto tree, today's linux-next build (x86_64
> > allmodconfig) failed like this: =20
>=20
> Sorry, a fix is pending and will be pushed out soon.

That did not fix it :-(

My fix up patch is now:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 23 May 2023 10:31:28 +1000
Subject: [PATCH] fixup for "crypto: starfive - Add crypto engine support"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/crypto/starfive/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kcon=
fig
index 908c162ba79a..2a15d51534b9 100644
--- a/drivers/crypto/starfive/Kconfig
+++ b/drivers/crypto/starfive/Kconfig
@@ -4,7 +4,7 @@
=20
 config CRYPTO_DEV_JH7110
 	tristate "StarFive JH7110 cryptographic engine driver"
-	depends on (SOC_STARFIVE || COMPILE_TEST) && DMADEVICES
+	depends on SOC_STARFIVE && DMADEVICES
 	select CRYPTO_ENGINE
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/8prTCi.GI047Yt2qEAvJrF.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRsCpYACgkQAVBC80lX
0Gz0Swf/emvGMFeJkGQBY2CxLqqfdhXLSCqa8G3Kes33FT+wP+VuAHJpnh/04aBU
4rlAxMiJWAtIYG5QWz4VCanT/vIPj+ZvlNJJBq4+UiQf5r9lLeXHrARZIHEKs6ss
mdSkybWyLYnMFL1A70HFTQDbUFJ/gMFya6v0A7haVbe+UfsQCkUPxGvrmpFlrjXt
e9SRqYiLbxF/rY2wZbdBkVCLTtMYr9ZCsIoCZLSlBKHQL+mWC7cDmsUSID287y3G
PmQ9qATUKkQTnfSDCfA4Ko4CN/GnuaJRWuymoZKOXwzOOvhVG12jESELkvKyyNTk
H9ADh/enexrR9CCS/XgjF4g29sdYCg==
=KH/1
-----END PGP SIGNATURE-----

--Sig_/8prTCi.GI047Yt2qEAvJrF.--
