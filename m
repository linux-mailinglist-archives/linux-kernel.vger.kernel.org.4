Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0906A1643
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 06:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBXF1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 00:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXF1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 00:27:47 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F146532B1;
        Thu, 23 Feb 2023 21:27:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PNJLm5P1zz4x5Q;
        Fri, 24 Feb 2023 16:27:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677216464;
        bh=PxcueagSgEjjLRpdvac2UeMZ4iatPHRLu02oOlq9SO0=;
        h=Date:From:To:Cc:Subject:From;
        b=RninC+pwn8bBshAumEElbTopOcjSO/vzlWPjXLwgF2YqrLEb9urF2WOV5QRch43Mc
         9PrWsRBT73tVGot7/7e/VquSNMTdR79dZAeMnBR/vDSf/lZTz06hJKqsVJSqmClXnw
         JQvkmzE3T/76tZ7wyhg4dz/HdT065SlAAA8Zj8GhqlPCRP1D/NrK0jzNMU1c4koSaB
         IlxhmrK2cXHAofu65u1tGydgwjccST7RNT1OmsZf3sycc4mS7zn9Rhu3N/zPwa4T3H
         vN7ev2gdNrzvcjaSnzHu4ekX5OW1vBleJ8PCBt9IZdG0hdN1clygCrN1V85riD+FW9
         ug6894mhgZXcQ==
Date:   Fri, 24 Feb 2023 16:27:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eric Van Hensbergen <ericvh@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the v9fs-ericvh
 tree
Message-ID: <20230224162743.1d570596@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X6nQwL6FA22D3mu_foMBrQu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X6nQwL6FA22D3mu_foMBrQu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  f5e9fae38851 ("9p/rdma: unmap receive dma buffer in rdma_request()/post_r=
ecv()")
  bbe43094b640 ("9p/xen: fix connection sequence")
  cde40939c1f1 ("9p/xen: fix version parsing")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/X6nQwL6FA22D3mu_foMBrQu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP4StAACgkQAVBC80lX
0GyALAf/eVKpTTq79PMGsoy9O1aA73HjpVA4uyPdtZriOGSUwVyQzwnvSse0noFU
WnTRIK0qqZ1CWB4QxjOhIXhiKzGkpYBEjIlEIb/ZyA8gB/j8Bp/xaqPhAbjVGGPi
+W6rbRHpseJJFIV+9HX8PMyLNoVlKLbfLcovIX7HZwWdK9naJnYINIhoQBITuIay
wQ63Z15ENLy0wpbi/ltx7dlTlX99Zbaqb9REyBDSudf83a6402guxHWM+xUyoZZw
SlFnfqo0Iux5io+G8B30a5KtNgTuu23X8JNYqq3MM6iyhl7A4lqgVXkwmDu6ubmU
SNqfLLkaqGVMNA9OWb9nI4MDXfYTDA==
=34SU
-----END PGP SIGNATURE-----

--Sig_/X6nQwL6FA22D3mu_foMBrQu--
