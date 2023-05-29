Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD19071511E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 23:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjE2Vty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 17:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE2Vtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 17:49:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56F6C1;
        Mon, 29 May 2023 14:49:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVThT65bcz4whk;
        Tue, 30 May 2023 07:49:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685396986;
        bh=M+yVj+vLQfNG4ud8zB4xhuy4EkeoZBz0Mfxes0Tz530=;
        h=Date:From:To:Cc:Subject:From;
        b=PPgH3cfvnLHtyjNYkeM9ChDF8cZTzOnzE3sgb3S/fLifC74pKujI1Y32DdrIO9i/g
         64jj9n68JWDLBKFrYTyO9huVtiKDicLBdr+pu8RGJ4svWXu0h+H2a/KNj0k4W4ECWC
         aSMXLjP+XxKxi28kqgc0Bg7LE+FI/Kl189n6P3ieQxEOa/eWraKgqZtLOKH+KwXba1
         4DrqUGH4rpms1RMcYwUqBTNfdwrckyu5Fhdx1mqEmP9PeOvUDxsyffhjf7NOQyTSkj
         JcuNJIvygrgIAjfR5xkPjZxfF0bpIJ90P78/UYakX2flQeXh4MmmYfXUao4U7Uqr0W
         HEGi0IQyh280Q==
Date:   Tue, 30 May 2023 07:49:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20230530074943.5b196424@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MVHY6JUTwfHcGA/a91X/tyy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MVHY6JUTwfHcGA/a91X/tyy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8b9ca2f3ea45 ("ARM: dts: qcom-apq8060: Fix regulator node names")

Fixes tag

  Fixes: 04715461abf7 ("ARM: dts: qcom-msm8660: align RPM regulators node n=
ame with bindings")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 85055a1eecc1 ("ARM: dts: qcom-msm8660: align RPM regulators node nam=
e with bindings")

--=20
Cheers,
Stephen Rothwell

--Sig_/MVHY6JUTwfHcGA/a91X/tyy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1HfgACgkQAVBC80lX
0GwphggAljxaWaVve4L0ZNePxtepnw/nvwKK/zg3uFZn+cekNuc8CcWtH2KYgNEx
JmY3lOxM2McPlJ67pK7pWlsizKt1RV/T8Cva4qcCcy/23luqVzHG5Dy1/XcdKevh
yuxtbsgv+8yRHGJuLf0klUepXxL4xjd176oAhoxtVVptRiAbDbjSazVeLH/g2RZY
CNccbU0At/LpfqgbhSrFs/zvEE4ysRvLA6faZv30/E5PQWrPUQveC4NltJXE+NPE
ztZFPVcoMCKV9Jua+Bd7N1nzPDGORMCD20fFB8Re77Kzl0rj6MoW5iAyEx8QyhVi
zXvQmg7mm68kZT7aNDGnS+k2UNeAiw==
=ji6r
-----END PGP SIGNATURE-----

--Sig_/MVHY6JUTwfHcGA/a91X/tyy--
