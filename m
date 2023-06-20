Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71642737794
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFTWoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjFTWoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:44:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839A410F1;
        Tue, 20 Jun 2023 15:44:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qm1s60M7Vz4wjD;
        Wed, 21 Jun 2023 08:44:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687301050;
        bh=8MLzFgiZMqNPwZbnm6qtkPaARcc8RTEAjJoFn1BS6XA=;
        h=Date:From:To:Cc:Subject:From;
        b=mfc2DHqUh+oraUKnfuTT2N8G012QEWJIuSWOYT8Qc5pw4ymJw+rHtmHI2kx4JDBWJ
         PoCBQMoSOY4S5lstsNk/DZDHMwsulyXFem7kg0UFoSzbeu6gQ/u4QjkwlHNwEZDj14
         7LrsV2NSjT732K/A7/skMxxy6iubtokFJxsPK4L/tavMA/HJ3fPg0u9TNra/aEmYek
         b/AOicd5liSfy71EB8QgNBA2h9+8n/4XbHv4yFv+fMTfPPRaQ2B9d+aS1SrDdlJtis
         mfp/rVPaXFZUMJfQCgsUF7xTATIUf2XVtEJ8qHRN+jxw6loXHyYUrJ6clVxAYJjfc8
         9azTZ7oRJcGqQ==
Date:   Wed, 21 Jun 2023 08:43:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the loongarch tree
Message-ID: <20230621084355.13df7a8c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Bjceb8tXi_taZ5FJgBXOb56";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Bjceb8tXi_taZ5FJgBXOb56
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c976fff79c12 ("LoongArch: Add kernel address sanitizer support")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Bjceb8tXi_taZ5FJgBXOb56
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSSK6sACgkQAVBC80lX
0GxNnQf+PbzXUogN5w6L739TuZ39mxy4mUmeMadufhTNEAcxpjsuMPI/3Gi32fuA
/f4PB9CrMxssgEPw5nX4Zp5Y1etvVIp0I+hcsnbKipIjhNYQApRQuATBx48K4wCg
NJDDxgiwANjYwKKNh+6dUR//1uLfYZQBigxUqwBm3YTbvy9D6Rd5UehVC88u1GnY
eO+Akk3vY9//fgShwnvg38Q+QClJ2alLBaZDVbrhF/vm2Fmk35JdsNaqdS9LHDxJ
rKVKlRwp+ff/TFsgevqmmt3DmK7qM4T6csjdZxHvCLiRyv6lEeQsGTR6w3/VQSnJ
T1eaECwICeNig3QCf+oO+jss/kDGNQ==
=gJbK
-----END PGP SIGNATURE-----

--Sig_/Bjceb8tXi_taZ5FJgBXOb56--
