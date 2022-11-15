Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9243D629112
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 05:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbiKOEDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 23:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiKOEDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 23:03:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B562B114C;
        Mon, 14 Nov 2022 20:03:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NBCG26b0kz4x1D;
        Tue, 15 Nov 2022 15:03:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668485003;
        bh=3FVi7YR5ydMbW8FZhQb19D7y209wMWIMPKpHppb9+S8=;
        h=Date:From:To:Cc:Subject:From;
        b=OvLNzHhtXSr21lJ5jGo5CuLgN4rofim9Bk5e7qKQZ6pIlyTK9kRpJ7idSRcytODH7
         Q8IGmkR24dIIIxr5vpaSdiaLnPXVugvAsrBr7fiHxHWHRY/BOb9LEbkQH4wG7lD+Ui
         Om547fI1jh2o47r/UkrGWEN0C9KdI1kVxU0waL+XUIN5Fa1OxzSrFGVxIH0+hEEgpu
         qUC7JAWQA2xdd16F0Luzp8+/bpQxxBVAJ3qY32M7n7+uW5t3yxpWZ1z7nupwdfbJwz
         jFOmuFtRc04RLruwigXrjYmC0sjgcpLpR2a5WXkGkjdQWO9DT3zeRzGcaSMa6PBsu2
         EuGCMki0i/oiw==
Date:   Tue, 15 Nov 2022 15:03:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pinctrl tree
Message-ID: <20221115150318.7547f53f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/on_I8nhaqq9UomVqUhgO+xg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/on_I8nhaqq9UomVqUhgO+xg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pinctrl tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "debounce_time_mt6765" [drivers/pinctrl/mediatek/pinctrl-mt=
6765.ko] undefined!
ERROR: modpost: "debounce_time_mt2701" [drivers/pinctrl/mediatek/pinctrl-mt=
6779.ko] undefined!

Caused by commit

  e1ff91f9d230 ("pinctrl: mediatek: Fix EINT pins input debounce time confi=
guration")

I have used the pinctrl tree from next-20221114 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/on_I8nhaqq9UomVqUhgO+xg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNzD4YACgkQAVBC80lX
0GwjWwf9HmLJ75oSOaYLiTODmBAUVim29fpTK7jJmN8M0XSt8mt6UJs3iopXB54L
K4hrehztykHtwJ2jhdO2fCja0jjxi1RlVE9uhwsEw7eKbdZemVLzK1ItNVcgnmqg
FcFSD2J9XgiIYjmolTz/3R9/lgO4/jrWO1Pei1NGlKD9e75if7zqOrnOJlgtkP75
KGCuHr7P+PKa1VcuU/B0hAlGwWSlkU9Pm96A4WVfG5myx9DADtdzidmO9h5cvBVL
5PMCp++b7Ylba/rlK6YYn8zWCDGpB+nrfSiGg6N4kh9dJLN04RAs5mX4LYziYuV1
XtiWG8x7zYjWxMuLzj+nSCc1IWvLLA==
=sdD5
-----END PGP SIGNATURE-----

--Sig_/on_I8nhaqq9UomVqUhgO+xg--
