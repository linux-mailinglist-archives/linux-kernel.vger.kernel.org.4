Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F148F5E5FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiIVKUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiIVKUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:20:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E80B2D8C;
        Thu, 22 Sep 2022 03:20:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYBBL0pPCz4xG5;
        Thu, 22 Sep 2022 20:20:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663842042;
        bh=isWspzlR4F4+tBY1FRpoKraSXHtPSMkwmApxBzjChiU=;
        h=Date:From:To:Cc:Subject:From;
        b=Zvj6xOgnRrw2gm7zi78LqxK4VcpFtH7rSEVW7RpxK1GyO6zFr4XjbYiAErDFTRwcJ
         Kh12uM2OFi4FQll0FopFKApCDLjC+ybML1rrQfaehnM2lizXFFa0FPAH/Uvc7dtkDI
         g3NJoL74F+BdiDzlvEDvCJ55sS9q8g4JXK7nfXx5KPuIka7fLYBff6dwjEMeiqxnSY
         dZxq68LqLEiEf++RDMf6z48Zlp7Q0fmnwX3WMo3fBB48Q+UpTmeNjL7ECpp6IWgiRw
         JPI7uSma6Dvj6iudMo+ugM6DW5rdGxSZfhtJ4V+ABhbrRFuW1A04BfaaXA3cwaoRCB
         Rl9ShCT4yAa/w==
Date:   Thu, 22 Sep 2022 20:20:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Eliav Farber <farbere@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the hwmon-staging tree
Message-ID: <20220922202039.211372a6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GVc9ufpE6PA.IYfdVf6oaJt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GVc9ufpE6PA.IYfdVf6oaJt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  103974b11176 ("hwmon: (mr75203) fix undefined reference to `__divdi3'")

Fixes tag

  Fixes: 381a86c545f1 ("hwmon: (mr75203) modify the temperature equation ac=
cording to series 5 datasheet")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant:

Fixes: 94c025b6f735 ("hwmon: (mr75203) modify the temperature equation acco=
rding to series 5 datasheet")

--=20
Cheers,
Stephen Rothwell

--Sig_/GVc9ufpE6PA.IYfdVf6oaJt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMsNvcACgkQAVBC80lX
0GwlLgf/ZzjY2cMzz41Tzi/P1cJiWZYpV9/hc3uitQr9gpOcjbK7Ya0peV/RJnKJ
r2KRL5wBRQaCTF6WRn82pmrY6E70sYf91c34+roN/wWS433tsFtLMTcdGzSiTrbM
Nre/17UyrDCfaep8LFKAKSUi6KnlC3ujw+xpu0TgWDFfKwo7Dy+1sWlTsMk1pLCs
5xxI3T6wud0UUgsf+pxTy4WG1ksyl9ZmEGouWpIH8SlsXtr87cqBf23q2qeoN/7O
pxgt7XQGAosqV5amvo+FPyBq8hd58rXbcC4ZOtboRIKDrvf9bEzEKOMNEiqpUTzo
C1dCoka2TzZw9PQ8qjLzwgk3LyJ2bg==
=R+7Y
-----END PGP SIGNATURE-----

--Sig_/GVc9ufpE6PA.IYfdVf6oaJt--
