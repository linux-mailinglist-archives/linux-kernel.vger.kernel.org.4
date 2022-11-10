Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B7623AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiKJEMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiKJELS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:11:18 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774BD32BB9;
        Wed,  9 Nov 2022 20:09:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N77ds1D1Bz4xYV;
        Thu, 10 Nov 2022 15:09:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668053393;
        bh=efdeU73S6fdDllLQr16Y33lKGpbCYm21shAP5HlKYos=;
        h=Date:From:To:Cc:Subject:From;
        b=Kh9OqRM5ibVrR/ubeIYF2IoqwvbbRALc1+qLGadDqu5tvT5wufkTsDx0MLieI37QQ
         VGrSTEoAS7hgcl64d0LiHkFpaEu3rPRTqY1WQQvLcgpKcfdLNnPrAmdkt94wqgEBC7
         UCjuD3bT3eGppqvPWR//YTdFMntgsFRiAEkP9VgcH30FKv4cwy4lJXBjKuRbN2mVrB
         ggrB2wlmEtiSIHMVytQbKXY7g2DP4Tg4YxXjcU56viIAmaT2fY0uM6IyfNsC0L341o
         IiYqAU7F/sdyoKdQuf/qN28sYjEvkSkA88JfA/flKD5ZGil1YC5RKL/pshBASVEw9S
         c5WmK/Ef6UKOg==
Date:   Thu, 10 Nov 2022 15:09:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pinctrl tree
Message-ID: <20221110150951.1d9f0079@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AYGngnTW2Nrhv7DdtJhBukX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AYGngnTW2Nrhv7DdtJhBukX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pinctrl tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pinctrl-loongso=
n2.o

Caused by commit

  6b88d921f848 ("pinctrl: pinctrl-loongson2: add pinctrl driver support")

I have used the pinctrl tree from next-20221108 again for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/AYGngnTW2Nrhv7DdtJhBukX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNseY8ACgkQAVBC80lX
0GwS1wf/SCiXDfZiZaT/0Zz09FtUfFrrTofLeCGTD9wn/yh09r1jCGx15PBi71F1
GtApqpYziLbkTNdTgg5Peu4pSf/n+nvcHxwkvMop7aXEDpWJw+4td0xSNIa30mZ5
TR/VH5/RrPWD/Jshdi+C3x0c0UmwJ3vHlcSKRu621kPmKujVF754KxzEjbEGm/Sq
HTFhnDLiR2kfs0f1znXn4TZ4hkngGXMLfh5kEpwed0p2ucxyBnS95It2gmGKg5kU
59N5yajqGYzG40LUjwi5s3AsBnB/Lkddzx6Xh9HMWAOxpyUP7+/m+z8IlgKTfaax
XlVfNYHFlXsyyatIUoJlpDAUbBKiDQ==
=HGfV
-----END PGP SIGNATURE-----

--Sig_/AYGngnTW2Nrhv7DdtJhBukX--
