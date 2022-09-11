Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9225B51C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 01:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIKXCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 19:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIKXCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 19:02:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0ED22BDD;
        Sun, 11 Sep 2022 16:02:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MQlcW1zDSz4x7X;
        Mon, 12 Sep 2022 09:02:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662937356;
        bh=XcD02g+2VLrIcmv2y3xbpr4sIDsh8ybI5yjoIVEUoZU=;
        h=Date:From:To:Cc:Subject:From;
        b=XT2XZrip8S7PxrVN2h93XW2eMwYI8le7JNAzNQJO0dUbDXAcv6/SLtzrCb/3+4YG8
         sCpEUnGaouB4p0CTvBlTnTxo4g0f99u6owEYuVKqywzGEgyItJ3ZzWd5mIjDA+Cq1w
         JDEup/M4OIOqJmVKEekRNq14uXQzYxNAJBOWV6+BxpwxIsnW7bczVnLc/NE7qi1AzV
         dHT5jSFmbDySHBFr5ojOLoAduwZtbGQLKaojyCraaAfIEZCLsZTs0eyUoCKlZc3i13
         TUrpVvXIobMLG7EdEAO1QiQvBuyNjOkrbVdPN/JDdnSY3XUYgUZkdl53Cwdi9/U70f
         ZwIvjaRaGmIAA==
Date:   Mon, 12 Sep 2022 08:54:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Melissa Wen <mwen@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drm tree
Message-ID: <20220912085206.569a3360@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yoIvGX76KBPMiG01tM=YNPt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yoIvGX76KBPMiG01tM=YNPt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  89b03aeaef16 ("drm/vkms: fix 32bit compilation error by replacing macros")

Fixes tag

  Fixes: a19c2ac9858 ("drm: vkms: Add support to the RGB565 format")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 396369d67549 ("drm: vkms: Add support to the RGB565 format")

--=20
Cheers,
Stephen Rothwell

--Sig_/yoIvGX76KBPMiG01tM=YNPt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMeZy8ACgkQAVBC80lX
0Gw1/gf+LNKi7N7Ozr/Igt5ji+dhmr8YCSahNPRK4gEJEG6dukc6famYWQN+EFud
Fr6nOViWfH9zOfv+qWg7yiW6F8zcuP7KUiK7V3sM8bgyv+zjj5UOtBZQJ8HjY7Ao
Q2KtTNM4fkha8aMwRE5AdP4ry7VwTehDgC0eDVXffT4DydHsebQYQJF6ft0ZaUZ+
3Eup5WDUARFPQoco2IDrAmwjLUwVpz95oIsyPDgiKFRndDoYmhbuCNcemJrBFdTq
MfNBMl2kca62brCUvxMK+FsevzqDDnretJY71xUcDMwUOeqDsIsisLUmlAYdXyqv
8SAGxHBuzVHKpJAqw8nWUtOr7sfzhQ==
=oaAm
-----END PGP SIGNATURE-----

--Sig_/yoIvGX76KBPMiG01tM=YNPt--
