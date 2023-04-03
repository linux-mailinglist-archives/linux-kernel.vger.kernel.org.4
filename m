Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788AC6D3E6E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjDCHw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjDCHwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:52:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DED4497;
        Mon,  3 Apr 2023 00:52:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pqjm63MYxz4x91;
        Mon,  3 Apr 2023 17:52:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680508342;
        bh=gYZb2Jae79Q2X9AMaXBamBMC65TqmsvEJ7/ULlv42u4=;
        h=Date:From:To:Cc:Subject:From;
        b=WghE64ENgNrMe7IJ73bmFvnYK5QfSgEc6RQK3E4pyDzGOrpSoHhGQ+N6BjdG9Wxh3
         1P3M8SLKjcsUNhkD9j5OJfqmsg6Olic1/FCMHx9IAYBlE0i7vZnfYGPBAXv8oQPPqx
         VWEQnVeBMBH02DBUh0GORjpads5VfmgVXfDcyqXsinK61k5tc3GhtR0y21VqG8OtbN
         ivccOviKOd3AyEbR60CywdDeHNiqgR9kH8gUYyKiIHtSvB8mLCLx7GQFVL4BmQrIQ6
         RTxXSgSPAqQYdofNPnBBrh47G6nBf56kHH7Vo7EP0Idj3F39jAYDePMJ6+9fAG78ro
         NA14g9DtEkcoA==
Date:   Mon, 3 Apr 2023 17:52:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mediatek tree
Message-ID: <20230403175220.5b946b60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ORo+bPMd59BzFlyCypou/Cc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ORo+bPMd59BzFlyCypou/Cc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mediatek tree, today's linux-next build (arm64
defconfig) failed like this:

Error: arch/arm64/boot/dts/mediatek/mt6795.dtsi:647.21-22 syntax error
FATAL ERROR: Unable to parse input tree

Maybe caused by commit

  a7c7f1fe2fde ("arm64: dts: mediatek: mt6795: Add MMSYS node for multimedi=
a clocks")

but I don't know how.

I have reverted that commit (and the following 2) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ORo+bPMd59BzFlyCypou/Cc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqhbQACgkQAVBC80lX
0GxvqggAlRfOKhcdZxFOTbZZHW4fslt+m75QsWlUr8RND82j2BuYCTNRBCiiSJZY
d6i1TprLWa21G7rf22+P/rtLyE9bh+SBr65GI9yP5v/pRo5GiSlg4YCUoCCrFqmt
uQ4aMC0FLo10KlMs0RCbh5hNsXkj8kfH5o0v+P07UPFUO9xx1jmszpRk+BjiGpDA
+qix9hgIp0hAvd9XqOjgPh/WxtkmWbjsAqj0Ibr4Z2PvjkF5vvFB4aZDBHmkZy4u
fkeD5xE24MKJIT9sFfPaTw6No08p03YBfsVPyrNX6sQYUyGVz2AfD2yPIOuULOcg
CZcJKKb0N4CvcVMA6zEiehMdqzlWEQ==
=QETh
-----END PGP SIGNATURE-----

--Sig_/ORo+bPMd59BzFlyCypou/Cc--
