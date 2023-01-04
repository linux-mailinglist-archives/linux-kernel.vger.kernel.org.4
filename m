Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F401165DF4A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbjADVsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbjADVsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:48:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015D033D56;
        Wed,  4 Jan 2023 13:48:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnNWV2Bb7z4xMy;
        Thu,  5 Jan 2023 08:48:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672868887;
        bh=ppDAWVHpCKhnzv5Hmoe6tCuegfSNsAHt8u9zQlXSB6M=;
        h=Date:From:To:Cc:Subject:From;
        b=F0l7sRL8VMBJpGjCxUusXqfpbygOmQAQdGGDKLwT1DuWaeFQHd05dXQ4E7Neib3YK
         W3FUYX/wNloHO1WhtMDhpJGeF7UYvHy++ZGsQqvRSQMi21st537AytHOvaQ6IL2q1W
         obxAYqZg0p/vfdKFQLa7WXznQD4Azze79LFssFzoV0aGre8MBYbcxYv8nsYxUXP/eP
         ++d8Wcq/HmQnq40tLG97PY3ajh22zghbDMYyGjTla6eQIl7WUdw+h3MxHs217jiRMA
         1CwffwJE7r3U+PPu7CRo0tmnRVnd5tgCbDOxyicyDPPiRkS74HZN+GCgcxWXF6taPF
         21MTQHLD87jnA==
Date:   Thu, 5 Jan 2023 08:48:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the drm-intel tree
Message-ID: <20230105084804.5db80fe0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZQoynXGs4CD5.84jRf9uSoB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZQoynXGs4CD5.84jRf9uSoB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits already exist in Linus Torvald's tree as different
commits (but the same patches):

  50490ce05b7a ("drm/i915: Remove __maybe_unused from mtl_info")
  f087cfe6fcff ("drm/i915/dsi: add support for ICL+ native MIPI GPIO sequen=
ce")
  a561933c5717 ("drm/i915/dsi: fix MIPI_BKLT_EN_1 native GPIO index")

--=20
Cheers,
Stephen Rothwell

--Sig_/ZQoynXGs4CD5.84jRf9uSoB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO19BUACgkQAVBC80lX
0GyONwgAh/1YLxnu8kxqaK4pN3u993umujBtH4LbBM8WQUtat3sjSMX9bs8BX6sk
/QtDlh4GOwxOGYgZhjquQQFrzuFr0n/POjTwWLbxrziIEtyqGOn6eW1ogD9p7n4s
OzdvWoibImvBhCoo022fvncnDk41VE+wFFfjXg+OcXegA5DUqGw6P+OZM2GAbwnN
u+epG2sYT8uq0VYDolSbpamY7qObZFRJ+2sQubQ0pzhIu7q4mviRLA3lBewBsg5I
MCapYoQv8irjJQBblhBWVVib1UzwPNGyGInWnu43Gny4OeRGPhlAbIrvWF7D8jIQ
UjvW3hURXxJw5It5fc6l2UAFDz1EhQ==
=TfdY
-----END PGP SIGNATURE-----

--Sig_/ZQoynXGs4CD5.84jRf9uSoB--
