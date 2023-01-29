Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF44680213
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjA2WAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjA2WAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:00:03 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4571BD5;
        Sun, 29 Jan 2023 14:00:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4lbg6PhRz4x1f;
        Mon, 30 Jan 2023 08:59:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675029600;
        bh=d5Tq29eOT7oe2mO1gr97KxsLGBhd8cp+joWyi5EBnjU=;
        h=Date:From:To:Cc:Subject:From;
        b=JyfsEGZj6kAQ4nT7pY7uP0BvCOt9fpSZQzDGSWGbRm9kCj9R0Xi6cyT1vLP617dEG
         /du8Yj4OA4IjFcWssE122YSrjKY2UyG/4NykH81MuOGk5w9dmumRb6fCB6++lapo/R
         TYcy2BHhcrb6VxV2I4pbKaWQzbMjE6/znsm/Q3F9FGG8j6czPlIn263aLZOx4Y7dan
         fxnsNgiyza9HS7raevNq355y5rGJjrSqV01SwxuZARNXSCHMMIU8+lwlNDXbTl+37u
         ZpPtI+NSoYf2HoGq7O640STIE6oAtwToDmBIewbSjsbAJaaFoYMis0gSt3pep9ShSs
         upQSjT3yRxovA==
Date:   Mon, 30 Jan 2023 08:59:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the amlogic tree
Message-ID: <20230130085958.4ada9cd9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kCDCwNwJI+aTcQMrbDz9siN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kCDCwNwJI+aTcQMrbDz9siN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  43b0fcdef2e3 ("TEST: arm64: dts: amlogic: Make mmc host controller interr=
upts level-sensitive")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/kCDCwNwJI+aTcQMrbDz9siN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPW7F4ACgkQAVBC80lX
0Gxl7Qf+MPWdRt6y9ATyVVle7G9qofrV2YGZnoMSFjI8DxQawqjsEghx1qb3lFz+
0DvJRVYFvW0qvzmdsYnABqrpd/Jl9Xp1UsOqbVqlt9wFEqyHhNVPrz3era6W+i7u
qLyJBICYUwR977wVy990Ph/pGyBQkOvnHhmQ5yqsz4EhhsUcbqBVkSyrWOXiaMh9
1e6wUSZ5qi6Xi9M8obgLnKJmOqIEyngeE9vUV+3iVZZKIt4Q3G7B4LbppD7rhszA
13sd4ljktb+43zxy7cx/UpYC0Fy5S5XJsqDG93yf4315fujkJGKWFKzml1trlp8K
psHCdQ3ie+ivH6IZt4oaDhq8cJN0uQ==
=xPil
-----END PGP SIGNATURE-----

--Sig_/kCDCwNwJI+aTcQMrbDz9siN--
