Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433956DEAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjDLEmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLEmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:42:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924112D50;
        Tue, 11 Apr 2023 21:41:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Px96B5wYCz4xDH;
        Wed, 12 Apr 2023 14:41:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681274515;
        bh=WOpYuRsAmoJ1ACqu6zUqXraoZTYHhLr7sNyyBFq5vsw=;
        h=Date:From:To:Cc:Subject:From;
        b=JRXzrsp8hOCd/VpGxs88eDJf08zahFmUEElad83SGyzXfie22iJhiTh0yBff7Kst+
         0+lfmKUSE6B0Y3+qDL2NUOqr7sINvxUUVThTA5picgsm+k48ZUjXKo+WCl4MwACjrD
         x7y3S8wj+mTyVWgFKwcWQgOCJvzBQk9fyZGq80du8abHJpo+r2nMPtTyXBhEUtPkXE
         9BRBFLHX+HAYE14kYnY2Ft3bUQluwj/mdcO4eC54XsCCGH8PrKxQ9OtyvbGXG5jN+m
         v4VBc1yum/Z6mFhMeAkhKzOv7bc2FkElP2C6+8Yb2Vb0avH6RG+HDst6BvmNC5B/ZP
         brnRVGso/MB2A==
Date:   Wed, 12 Apr 2023 14:41:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the amdgpu tree
Message-ID: <20230412144153.4cb2c40b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6nqvJVZKqYTObGCewEJ9BxY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6nqvJVZKqYTObGCewEJ9BxY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced these warnings:

drivers/gpu/drm/amd/display/dc/dc.h:882: warning: Function parameter or mem=
ber 'fpo_vactive_margin_us' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:882: warning: Function parameter or mem=
ber 'disable_fpo_vactive' not described in 'dc_debug_options'

Introduced by commit

  0289e0ed1b9a ("drm/amd/display: Add FPO + VActive support")

--=20
Cheers,
Stephen Rothwell

--Sig_/6nqvJVZKqYTObGCewEJ9BxY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ2NpIACgkQAVBC80lX
0GxyxQf/RSTv9apYAJ368+IYkwZaXnRiqVICinuXQDH2zuJ6EVXw1MLQtHCgirtv
uH7T2k01jV7DeCVpVvoD58FvENH6rObIceglZJBsDiaGZ9v6D6OIH+U0t0v1TKo9
qLI2o3LmvBbL5DSRpLUikfW0ZzTkL1wm7+xVK7X2Zt1fbPDm3v+dxI9enzOw/QQv
jHRUNczpZQ/ozE5zvmncoYJmcsfGKAMFqkp/0rMBM/WV02Q+WKAJBwsBahKtF5Ec
vruA0YlGT2ZTylPlsmDJ0R/QuqQARW5zPpm8UyeyqXVx/ojVLC4u25aJpfxK7kPo
amUATNU1I5BPt6fkuUCzTFX8L39l+Q==
=8NYv
-----END PGP SIGNATURE-----

--Sig_/6nqvJVZKqYTObGCewEJ9BxY--
