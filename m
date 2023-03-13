Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A03C6B840B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCMVhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCMVhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:37:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733BB898D9;
        Mon, 13 Mar 2023 14:37:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pb9454VpKz4whh;
        Tue, 14 Mar 2023 08:37:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678743461;
        bh=49K12yWWdtmrUou9Tpbx/H8QMp/k/kD118qkD2thWhI=;
        h=Date:From:To:Cc:Subject:From;
        b=f5H3WW1XPLzcG0bTKuo5IB5bmDo7OOmQXr/gDidNqdlQmka3lJpVnYlOa5LFZTx9y
         cpHF1FhRDWjVHkRTWZRIa84v9a/hDzQOH0afz1pimd6s0jv/1lkhPp+JHkjQoqQlpz
         Ze4/LbZPRgVXQv+WvvUygfywAF7so7v4LUCX/+6W30Sqs/bhFB6Ue2bdQWe5ZApJpV
         st3uhehlDy7OIinF9HAhFynq4dYMgMLBmypi7EJsr4rL+vZc3x4hx0C3RTy8W6bmmw
         iicyoUkgtkOPCfkXNCce/taytkEa2n3M36EL58E9W2Bcw8iDNZRHvWjZsDKXE64pyG
         ts4KLa1i1Zl3Q==
Date:   Tue, 14 Mar 2023 08:37:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20230314083740.758e909b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qjPLLPcjp=JZjD6ho15UTsM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qjPLLPcjp=JZjD6ho15UTsM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commits

  2e498f35c385 ("arm64: dts: qcom: sc8280xp-x13s: fix va dmic dai links and=
 routing")
  4def7aa377ba ("arm64: dts: qcom: sc8280xp-x13s: fix dmic sample rate")

Fixes tag

  Fixes: 8c1ea87e80b4 ("arm64: dts: qcom: sc8280xp-x13s: Add soundcard supp=
ort")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: f29077d86652 ("arm64: dts: qcom: sc8280xp-x13s: Add soundcard suppor=
t")

In commits

  e43bd22cb377 ("arm64: dts: qcom: sc8280xp: fix lpass tx macro clocks")
  670b7d6569bf ("arm64: dts: qcom: sc8280xp: fix rx frame shapping info")

Fixes tag

  Fixes: 1749a8ae49a3 ("arm64: dts: qcom: sc8280xp: add SoundWire and LPASS=
")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: c18773d162a6 ("arm64: dts: qcom: sc8280xp: add SoundWire and LPASS")

--=20
Cheers,
Stephen Rothwell

--Sig_/qjPLLPcjp=JZjD6ho15UTsM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQPl6QACgkQAVBC80lX
0Gyt+gf7BmB+lKEk38ogQl6EulcksxNvF/J3cEgOGTC+tr3UfbRVjf3K1eQ8BC+0
L1hq+sSFBCdRc0Y2wMuc0Tv9Byp4LH9kXh644G/ShYTqwZyrmEpUg2S+QdUiMb1F
dtLkxgl5mdHlc8cgIqugtEWLiinI5cFa91kCBTB4ut67JfE9c3sFvLbi9TR/0Q8/
0wpkm/0FG8TXsMujsWrFGKqKgLsoHg9ZO/UlZ3Sg66DtoDUW2HNKCoMRUnT/Y+Kz
PJn0UQsGpL1uFZEtgv8pCIECxaNXhClrDIiDZe/9av1oUnAjqIAHFod7p14+QpGG
xFhVpTqZvYEJbgMXsXzGpqnT1FNk9Q==
=10Xk
-----END PGP SIGNATURE-----

--Sig_/qjPLLPcjp=JZjD6ho15UTsM--
