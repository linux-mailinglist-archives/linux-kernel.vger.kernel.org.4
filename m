Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0C62EDE2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbiKRGrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiKRGrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:47:39 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EBD3896;
        Thu, 17 Nov 2022 22:47:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ND6m70pHQz4x1V;
        Fri, 18 Nov 2022 17:47:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668754055;
        bh=A6cu1z9mBy/jPVa56NxpA6ipqfhlgU6vQZycRkyQ2ew=;
        h=Date:From:To:Cc:Subject:From;
        b=kkDsji85mKhagS4mFtQf8OwXZggwz29bJE7E/IuQjX+sKLvPV+OMe7+WzgzLMFJV2
         bHDBtYMiR2ADK3kh9I4wko3x+76ezm9hn1UBl4Q00gGyrFJnZc7duxwyY3V0o7onHA
         PB+gKWwRtePfExOjnhg3Ohb9xKCiFe9L9jWDu+DYrMh9L5xBXRpvHwFKUkiWR/Wdb9
         ImSeZ5726n7mb6T2grAV59tGXJFCKfouu/xAYkyDf3N7UyS+AkkVFEayHp5jcEXrz2
         F4AX34y5meXeJH7NE71awyRJi/ENXBxAxcSbDlkbgKSB7eub9OB8uuF2BY3+MjT50F
         ZREYK4eXsr0zg==
Date:   Fri, 18 Nov 2022 17:47:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20221118174733.78a98e1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_yBrTmq3XiEIq+LHX2Pymte";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_yBrTmq3XiEIq+LHX2Pymte
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

Error: Cannot open file /home/sfr/next/next/drivers/gpu/drm/amd/amdgpu/amdg=
pu_mn
.c

Introduced by commit

  d9483ecd327b ("drm/amdgpu: rename the files for HMM handling")

This file is mentioned in Documentation/gpu/amdgpu/driver-core.rst

--=20
Cheers,
Stephen Rothwell

--Sig_/_yBrTmq3XiEIq+LHX2Pymte
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN3KoUACgkQAVBC80lX
0GwVSQgAnsumUz9J9v9vYfBW/hlw+RHnzKO7UZhJQJzVBxywrf2ZGYe0ki3Niubt
MqfJONjvMPw68M1zB9PW4wYNXMC276yVpR8NKYPFcEwDh+R0MJ33gAAlpEe6XcMY
bhhJ8voZrstsmCAniQNXPkQVhx+2fdk00JgovEri4wjZAC1HP6nnZf/+2+V/Ud/a
8y1spKZsYmE1Ofi8Xz+6sn4jh63XZWXlWNxb3PoOMFSizzuPmborFyN0ah/yB1QO
ISe6AqO4Uuc+M43oM3oDnbWuVPhpih1FA0us13BzJPygZvxXjIgd9oVgwPIZkzzA
yKJnLFXhY6vELDNQbHNax+Lpg/8aig==
=4Tfc
-----END PGP SIGNATURE-----

--Sig_/_yBrTmq3XiEIq+LHX2Pymte--
