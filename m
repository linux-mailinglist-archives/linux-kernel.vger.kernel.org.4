Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D4C6F9D24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 02:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjEHA62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 20:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHA6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 20:58:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D554100C1;
        Sun,  7 May 2023 17:58:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QF2wD5ctnz4x1N;
        Mon,  8 May 2023 10:58:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683507500;
        bh=NyZMO6wSDEOunlXN0bVz9uBaulPGt7cIN5ERoh4KmR8=;
        h=Date:From:To:Cc:Subject:From;
        b=HSMCgj/cs5e0RNskMLkyaCRA+JIQ7UGk6hni/U0/zXqeP82QISRx7rDqtfT2OslcU
         WORkdcbcLlFq618P9oU79TwOvx1vrq89BtU8SevNjjVbyezcPSTwZltsmagKoDpsdC
         Fe9F0p8NlRzZDEgsWYxCxt5Jt/F2NpYovgVYK3v2RLJ49O9r9JVTnKXvYAPvCrhgHL
         +iElDZt5Hzr/aWKLNZFGGIbPDCsdjxb7nj0/oSvFycqXXHRV7gvNueqJCj9E6IDOZw
         702900pMrwZR8XqoLi2zTjZGpK/c/KSCYs1V1t9xFatTwDABi6NenDAb+Qu3RIVN2U
         xwKAKzpFjrRaw==
Date:   Mon, 8 May 2023 10:58:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the clockevents tree
Message-ID: <20230508105819.3bb63c3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yhd0z44v/5q2pFUVYWwNetE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yhd0z44v/5q2pFUVYWwNetE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  01216c745bfd ("clocksource/drivers/exynos_mct: Explicitly return 0 for sh=
ared timer")
  12fdc0360660 ("clocksource/drivers/timer-tegra186: Convert to platform re=
move callback returning void")
  155713e86bb6 ("clocksource/drivers/timer-imx-gpt: Remove non-DT function")
  1685579e3b31 ("clocksource/drivers/davinci: Fix memory leak in davinci_ti=
mer_register when init fails")
  29574a9acebd ("clocksource/drivers/timer-ti-dm: Convert to platform remov=
e callback returning void")
  2f8358e46cea ("clocksource/drivers/timer-stm32-lp: Mark driver as non-rem=
ovable")
  61ff2668d3ad ("clocksource/drivers/ti: Use of_property_read_bool() for bo=
olean properties")
  62a9488edfd7 ("dt-bindings: timer: rockchip: Add rk3588 compatible")
  67e7a94afa75 ("clocksource/drivers/sh_mtu2: Mark driver as non-removable")
  6bc2e2a00f46 ("clocksource/drivers/stm32-lp: Drop of_match_ptr for ID tab=
le")
  b0856d6884bf ("clocksource/drivers/timer-ti-dm: Improve error message in =
.remove")
  b1ba12d97c75 ("dt-bindings: timer: rockchip: Drop superfluous rk3288 comp=
atible")
  b6999fa1c847 ("clocksource/drivers/timer-ti-dm: Use of_address_to_resourc=
e()")
  ca394a540eb0 ("clocksource/drivers/timer-mediatek: Split out CPUXGPT time=
rs")
  e8fb525fe931 ("clocksource/drivers/timer-ti-dm: Fix finding alwon timer")

--=20
Cheers,
Stephen Rothwell

--Sig_/yhd0z44v/5q2pFUVYWwNetE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRYSSsACgkQAVBC80lX
0GyZ/gf/d3eqItC9fRqNDFBDI1njn4Qqau4ZFlLQQ47qXQFASglCvWh5umfaAWzH
r7yds2kxtftv7f8xXIFKtcc1zW8YXxjoQ+2Xh92v9jQzZgDpUzHrlo508weljwa/
UaGVWMDKZA2YNvQS6TFkciN8DNhcChDvQnITWGImpPR8aezmNQZo+K8HYHysqdtW
Q5isANqvSEFPUNkVBwtHBVveTT+xhQlr8LRRUlbUcu/auswLjG8Xwtu/uTYeY/E4
hvLmD9RlHH48ALIM243VgGDiBt3JoiTnSWSLXwxxs7H66C6eAi876yJSlepZrUw1
9GzHow7bw3ZfXwZGdZYcotuNMYIupQ==
=8lCI
-----END PGP SIGNATURE-----

--Sig_/yhd0z44v/5q2pFUVYWwNetE--
