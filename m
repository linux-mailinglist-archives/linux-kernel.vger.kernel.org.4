Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848F95B639A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiILWVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiILWVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:21:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953B71C920;
        Mon, 12 Sep 2022 15:20:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MRLdz2B1Jz4x1L;
        Tue, 13 Sep 2022 08:20:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663021256;
        bh=vkdRLKYkEn8WLx02FgGlPy0UPC9XOFXdJRyMmbMpLLo=;
        h=Date:From:To:Cc:Subject:From;
        b=hkan2IpvYHqSHc0C95e/gk9UFSXnRYWfG10RF3WdjsNsSBYneIbUdof7i9IIyKiv8
         QSoyjsgbhP+0yI20ZD3SbBnoqx2PlnxkTIwCqBcJrmGYaluRjfdNCEVRvp9qZ1eAST
         BRz3tMzqhHeX+RgmDQ/myOdTBWSD71Uh3NzMiNY8L4i/jpMjVnDNwVwkIwtjEzpuNm
         uc/P9O4DteQh9VG44TOud0kh8ojBuXHidKLbiSUsK80AAVSdOURwvncskiAvs4ZLkh
         kRF7U1lNXLq1HANsVKdSO14Jxm14e1NqrbPyo6mvqinNn3uXJfRiOOfs5LQWlH9zzP
         Ay9y2kjt0WJXw==
Date:   Tue, 13 Sep 2022 07:04:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Liu Shixin <liushixin2@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mm-hotfixes
 tree
Message-ID: <20220913070410.7468b763@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Awg9MQbL.adzXq8Abi83IZN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Awg9MQbL.adzXq8Abi83IZN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c3bc4e30a601 ("frontswap: don't call ->init if no ops are registered")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/Awg9MQbL.adzXq8Abi83IZN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMfnsoACgkQAVBC80lX
0Gw7ywgAo4agynJcH4Jp1s8+EmjVvP6eCDO6AFAqdpr7ucUJ4T87nD9z7v+Ma+fb
5fusdN2hxy+LbYeabGLtkJ5vaAtHpghrXLgOiNiX4owk2oEQdGtUTOPgGq/kKMiq
gOcZIQutyYmyqZGJzCVzPwghai1so93pi6r1ivH6B93ZpzFfhFjfwxwwkHPaFAN5
YaOUfKAhbHRGFx8mzDSgdxV0hOTYlO8YPiubf91LWvbStJqgHzDUi4EGMn+xTCmz
vPf3p/OTvRcKCmKCs1tPxAd37rbaeYmAwtYDHXQpIHSdbobpGsw9cwZeI/sND/DT
F3ym/RZZ+Cr6wDNMUwNV/gN+R3Ig5A==
=TF8E
-----END PGP SIGNATURE-----

--Sig_/Awg9MQbL.adzXq8Abi83IZN--
