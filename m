Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5C1702110
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbjEOBTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEOBS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:18:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040ED1707;
        Sun, 14 May 2023 18:18:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKM2h2h8Pz4x1f;
        Mon, 15 May 2023 11:18:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684113532;
        bh=RuG1ySZ7s0gri5igZ17AAKvrQJ9VYS5+SrhO6HTfQ/M=;
        h=Date:From:To:Cc:Subject:From;
        b=ctyvs543o42/L/rHIu3u974XNWuO2tg128n0RTkXr+NJWOoFIoKmgJ5oOrJTA/Sfe
         4MemJlc6mDjf1a2TlFinSOcAid9NppZI9ma2T06aoF61aa8c+g+uKfsGfsseQcxLle
         6vWlvMqQwYW9de+VZVoZ0/708gtVNYoOeBA07UJhC3WkHbTs9xghCjgNKsn90mcred
         4XXyBRRqrH3ZdxkbpcK8zn8pt83VqgGt4Jn3WjiCCI5usOFQROvbxtcBCBx9l6ORGG
         2TixEkrnGse2uYYUXG8NLDabxp1zIu6GBDBMrLMCzjF065n3u3bh7T4x9CUpaqux7O
         LirF8NGtM/K0g==
Date:   Mon, 15 May 2023 11:18:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Iswara Nagulendran <Iswara.Nagulendran@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with the drm-misc tree
Message-ID: <20230515111851.73e4eda3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K0iJ.Q_1CtC+BJVPXt_5_.q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K0iJ.Q_1CtC+BJVPXt_5_.q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  include/drm/display/drm_dp.h

between commit:

  55b24786b748 ("drm/display: Add missing OLED Vesa brightnesses definition=
s")

from the drm-misc tree and commit:

  4d5f872dbc75 ("drm/amd/display: Adding support for VESA SCR")

from the amdgpu tree.

I fixed it up (the changes in the latter included the changes in the
former (apart from whitespace differences)) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/K0iJ.Q_1CtC+BJVPXt_5_.q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRhiHsACgkQAVBC80lX
0GwtLQf6A8UkFy13kPQIn2zb39PDbr4MTZunzmujY886d1j3qJ4lFeshMsKFKVdR
xwwOQRTu9pDB0BoJEECRRqhC4FB32oX1o7IfiHJJMnIs68JoEIfZlOWMFrBtRcm7
y8r0tRW940UnaJE8TYSTd+LHcgGZDPxktbncI52N0ikJC2oaa4GXOmICYcXLm6rT
dBZrO1tAKVLFX4kXupw+HaR6FuUFlUUquXcyRonsTjOVDM2AzmwUe5cxLoTQGp+B
rzN3qvjJBpx2GgVTyvCxVZd3zTVkWu6qSYoUzmgA2eRHojeSImjT+cJNcEwoi6u5
6WGhwd4smxnHVmwEXhuIW2phHSpDMQ==
=LYSm
-----END PGP SIGNATURE-----

--Sig_/K0iJ.Q_1CtC+BJVPXt_5_.q--
