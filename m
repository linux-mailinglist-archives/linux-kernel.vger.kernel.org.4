Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD88465E22A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjAEBGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjAEBF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:05:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC7E2F7B4;
        Wed,  4 Jan 2023 17:05:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnSvk6035z4xyY;
        Thu,  5 Jan 2023 12:05:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672880755;
        bh=2DlQM3PNbWfEbIMdLPJ6D4XabmS9FmziJAsp7+tKym0=;
        h=Date:From:To:Cc:Subject:From;
        b=BJB94/miDJVCAXxDboH8LeueeKSYXmzU+TioGau0u/r7t13VcZ8NKevIkPlo0UMOY
         zKjVOqTQxbjk5vsznJ04cBgcXs0wldxaEqDzSWNUE6mnG7YXK7r+TWTEfephfc3ohg
         /+WofWASuah5CH1yKrgpC+u7jmdttG+3OvWpCYWnIFyLWr6414dp/cQhPXCZVlZMLN
         lsONDXcw0NXi0i2P9mqUAo7zG+Zr3RnSR8ogUAeWx3uJrBzc28qC4Tz011PI6LqQP/
         NKG62U5vwskRErK6zx7XLpx57Y4HZlrzRVy1Z4PQR5J2nHpTFUkkbyKRce9DXdulHy
         /2sWI7VM4OEsA==
Date:   Thu, 5 Jan 2023 12:05:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the drm tree
Message-ID: <20230105120552.77bcaceb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xAv5h+U54DYQAowicK6_TeW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xAv5h+U54DYQAowicK6_TeW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits also exist in other trees in linux-next as different
commits (but the same patch):

  9f1ecfc5dcb4 ("drm/scheduler: Fix lockup in drm_sched_entity_kill()")
  4333472f8d7b ("drm/imx: ipuv3-plane: Fix overlay plane width")

They are also in the drm-misc-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/xAv5h+U54DYQAowicK6_TeW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2InAACgkQAVBC80lX
0GyUowf/SY5F+tn+BCckr3tc4JOkakwv9nLCwyJ2kiF1o8/gYamIvbwdGn+A6mY6
0RqS3AR2PLjRL/hoN2yFdA9VMz6eB9+xgT/IJkAny02TTvBqLueD4kCFeiht4iJQ
LLz7Y5h3Fs6x/c1DoKg4lua555DBluWWccfqm+D9nqbfbXW87yIo+5UK4xiL5jjP
tRa9GtO8X+pNZiq75C19cNso1/ZNto195rz3DM6zHk8bU56qOFxTZJeCYfUjDu7X
Aa0ApGk5tiIlUwnW4x8iTUV3jEYeWPpwNE7BtLE1ck0owgt0UySZg3kHKQWzV+PO
iF/ZP9YJittbWohjrPBOCKR6WrIvKQ==
=9W1S
-----END PGP SIGNATURE-----

--Sig_/xAv5h+U54DYQAowicK6_TeW--
