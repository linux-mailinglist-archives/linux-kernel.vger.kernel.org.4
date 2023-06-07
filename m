Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EAD725469
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjFGGh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjFGGhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:37:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94EF10C3;
        Tue,  6 Jun 2023 23:37:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qbd2217Skz4wgv;
        Wed,  7 Jun 2023 16:37:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686119866;
        bh=ZUyUX8hoKxQ8IX9AXzCttqc3N8++oeZ0LmZx0MumW2U=;
        h=Date:From:To:Cc:Subject:From;
        b=Un4yUpwr+iCyQ6ok48X7cyIf1apwF5FQrXyKxpNa3WWk71GbQhEcl1fPYc75SLfVz
         rEqwqFYBASxu6O7frEZgpRpHTDn2gccMamasx6C5BJjnueJ+un4udn6xmLFix6mEyw
         qUmmhTslKImRU8KvU/YEbxF2Wlq16RblFR3EGj2zCZw77btBrH3oyF9b6ZylUQi6Ud
         yo0cA3zvzC1WbBFkxuwnImDSDA2FQGzIJsO52QIkt54Gbl5AnhM6phKCa4TG+w1yMr
         nqqw2nmc1WXxw5y3bWoyJN36j2cLpPwN/y7zjC8iig7SQuiZ1n5oYOmfs+RV1nLoIf
         zl2XadPG3zgmw==
Date:   Wed, 7 Jun 2023 16:37:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the regulator tree
Message-ID: <20230607163743.1c266a7f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NwpFl.U/DxkQYj43Onpc6y7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NwpFl.U/DxkQYj43Onpc6y7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mfd tree as a different commit
(but the same patch):

  75c8cb2f4cb2 ("mfd: axp20x: Add support for AXP313a PMIC")

This is commit

  2f518d914bd3 ("mfd: axp20x: Add support for AXP313a PMIC")

in the mfd tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/NwpFl.U/DxkQYj43Onpc6y7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSAJbcACgkQAVBC80lX
0Gyw9Qf6A7JQ69EEBiR9Ax4KnS3R1EBScgUvsapC2AEK8KVqe9uz7/dtDvuOZHBS
gcjt+GQayoqNheC1OJ6RALq1YytEBCVlWUDMZkW2pLe00e0j9s3LHdTe+JDlVoKy
h6auM0kuZUejetR8aUVCmb7xiY2lBYsruROQsXo+YMaijFma3qqX900krsNRsvJR
NapwkWJruhfsosOVbFLbLitW3M7DsKVpUnS7JGLMfQ/9OGEBm7v35UDBY0bHzKXm
LolcHmmOuy/thkS8CHwr0zVjLcykb1VBYyzNhmwlLjm0esLPWa1qFXWP5vlkykv+
YFpAIPASOEPcP6476t/eaw1dn/sTRA==
=WtgY
-----END PGP SIGNATURE-----

--Sig_/NwpFl.U/DxkQYj43Onpc6y7--
