Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADC65BC502
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiISJJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiISJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:09:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FF22DDC;
        Mon, 19 Sep 2022 02:09:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MWJln4vpKz4xD1;
        Mon, 19 Sep 2022 19:09:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663578581;
        bh=hToJl6MYbUVsAp3AfAZbgEG6Dva/oSxS4elHy1hck8Q=;
        h=Date:From:To:Cc:Subject:From;
        b=CMgX2HNL1P0FHu7eWFXKRl2eBwW34wsDTi1Xt0rC5G1D3CjP5mig1G5jzXuXY/ATP
         r0hUINndWFmL/G+P72L8EhL+T7BhdEo0fAUC7n3je/EfmG1iZfkwO9R3mljR6EKnwl
         YEqHGx6X4NGAEz8ZFqfYITcRTpkU58t3A9bMYugYzBbparHPu4wu6/a+PcwTm/lCS3
         HyiU4RhW4+fjDniTnRwCiRjPyEpGEZK/FHaKVPrtwkKl7BbyFVbakmYVyE9Ck5r2+U
         TiSSFSikn5kQaney0OTqfYRaOau+d1+TXLuh5UY5XM6JjCVB8q6w+0FC8MNcMu7qHF
         RwI8Znr4wofJA==
Date:   Mon, 19 Sep 2022 19:09:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20220919190938.0948bd0e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2ShRTJQp.ZA==wy0kPfgwht";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2ShRTJQp.ZA==wy0kPfgwht
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/gfp.h:1: warning: no structured comments found

Introduced by commit

  4f57293dcaaa ("mm/page_alloc: remove obsolete gfpflags_normal_context()")

--=20
Cheers,
Stephen Rothwell

--Sig_/2ShRTJQp.ZA==wy0kPfgwht
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMoMdIACgkQAVBC80lX
0GxGUAf7BxSWQg58/XZv9KgpQwQd9A/hwCMfS+XuApMRGRWpy3T98XZYuD8I4aEF
E9HiUtcpZc2H2JFSCo4pBfWfWT5xwA8NZC2NV2DDhgkFQWvBva68gBkxzACPB1IJ
SdnNy8CW3QdKRLsvEH1HM6sZgP6cN4+gD8wP6bFJ+/pS0Lk/ksxpHzbh1p0JzTfG
5a8GMHuATVhd4PLU25zOxauRDHjFdRhZNdkL3CioDc5+v4DcMrK09aj/P0Rl1547
1TNKST4KZitb3C4fVuOoWq/K7d6aBEaebtZ6yRHN39LMx5O/Z/ANViJyslwl3B7X
b5qIeZAmON8LXcao3JoMvmBWb4bFvQ==
=v2Ap
-----END PGP SIGNATURE-----

--Sig_/2ShRTJQp.ZA==wy0kPfgwht--
