Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEBE677287
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjAVVFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjAVVFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:05:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AB81F930;
        Sun, 22 Jan 2023 13:05:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P0QjN2YVlz4xwy;
        Mon, 23 Jan 2023 08:04:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674421496;
        bh=9gaOh9pMWdwkleuMIhpxZwO/9JjJzXWVz91e40nCBcw=;
        h=Date:From:To:Cc:Subject:From;
        b=KBaf/sT+XkX4jvEHJggFuBVb90pkwFamJAp2D7suatpplYF1fYJw37QFsJQ1cv0le
         EO2gJAiwE5R15DOfAA4fPu7SyAqhxTkaq9SgaO5PP5gOTI15OfcUI9ZXhFZ7KkOma7
         djiW8ffMdWoVYm+7GSg6+zfkPtC1BvFVdY8TRNYolLWjs9AjA4DsqtGyJGyR2zBhaV
         ZRz+j7FdQZt8GjsBgJAXLBL7Y3zqVWdVRVl5iKN7dsm+UEOl3XuOo6kE0yEPNBilKX
         4fXAMEsrfRmZ0SfMeqQD1Cv+N9S1eGWDONYW0sUl/qBNzO5a0rw98OgLgUjp3gXJAJ
         Ny6hkDY0hLOpQ==
Date:   Mon, 23 Jan 2023 08:04:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the amdgpu tree
Message-ID: <20230123080455.6c4d9832@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j8h+=bAoGj2V9x59nTdUzB1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j8h+=bAoGj2V9x59nTdUzB1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  0feeb4fd4c93 ("drm/amd/display: fix issues with driver unload")
  1427a7202739 ("drm/amdgpu: fix amdgpu_job_free_resources v2")
  1def6539028c ("drm/amd/display: Fix COLOR_SPACE_YCBCR2020_TYPE matrix")
  25959dd67dde ("drm/amdgpu: allow multipipe policy on ASICs with one MEC")
  29c472b28ba2 ("drm/amdgpu: Correct the power calcultion for Renior/Cezann=
e.")
  3c6d1aeb4342 ("drm/amd/display: Fix set scaling doesn's work")
  3cc67fe1b3aa ("drm/amd/display: disable S/G display on DCN 3.1.5")
  4d3d5e6c078f ("drm/amdgpu: fix cleaning up reserved VMID on release")
  766f17923863 ("drm/amd/display: Calculate output_color_space after pixel =
encoding adjustment")
  99761aaa1ce8 ("drm/amdgpu: correct MEC number for gfx11 APUs")
  9aa153708192 ("drm/amd/display: disable S/G display on DCN 3.1.4")

--=20
Cheers,
Stephen Rothwell

--Sig_/j8h+=bAoGj2V9x59nTdUzB1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPNpPcACgkQAVBC80lX
0GxlDgf+KVFx+fTYO9zMzQABoD5E9h4U74boLuKnGkJGKWFqydjb9W/3Zi1PG2Vx
xNpyLWHG9ajgqtj0dJ1ppUJ2aj9KpfWOaTRKiuw2K1YnlHB52aib5wLZIqk18JcD
j/iuctwJ5aMrE+ODWHNEwOQBJde8a48GoIJo/0hfQAtAl/+1dKTmqU9VXvZGQwY8
xaJVK8eskiAuCiEvZEqY+n2an+otd+WOETRYLNvFVfc50xmsvZAvd3Ayebblez52
c8DYhdI+YHDINIKPCIXtS+mHWN1XjcNS0UiCfVhk5DJNRPmhaMK3WlXEgt8Ughkv
tLyZEhf7m8P147DMIlMH8prt+rTHnA==
=UGXk
-----END PGP SIGNATURE-----

--Sig_/j8h+=bAoGj2V9x59nTdUzB1--
