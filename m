Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9625866B41C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjAOVRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjAOVRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:17:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96C71448C;
        Sun, 15 Jan 2023 13:17:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nw7Jl3yylz4wgq;
        Mon, 16 Jan 2023 08:17:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673817431;
        bh=Np8kNhbrGPM6N2nh77Hc88jD9JeBw4Oihpkd6V9ffpY=;
        h=Date:From:To:Cc:Subject:From;
        b=hLoxkyFtrOdxUMAmpzV2DVdHAQa2Lgmux+G6gwV4lCi68H9oPvOq5g6sAPQKmQrkr
         alj9z7XZNr44Pf5HudPxEv0z9QV+SxaORPIZiqple9rWFntd/sHsZhIEMgBEkqT2Ei
         z3B/Z57AFGJaRo7ZNMU5tf4asulg9j//97p3npgfFcb9Yu5HFY8IFbTXL2JsCuXhHg
         jndPiphuZKQx+hoeZ5bubLS5ppf00RGu5r/kf3h8TdTeoGXPL1FSEugwUqk7jt0b3T
         hQ2lcusr/gyeggR5Y5SmLP+5tujD04AqExFk5BSneoXJTmpz6s3j5KikjTsiIgxLsX
         tcv+I7XmgjvsA==
Date:   Mon, 16 Jan 2023 08:17:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the amdgpu tree
Message-ID: <20230116081710.7800a5c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/86Ua=.MDY6UmE3VJfphzANj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/86Ua=.MDY6UmE3VJfphzANj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  08e60fac1d8c ("drm/amdgpu: Fix potential NULL dereference")
  3693c1aea9b7 ("drm/amd/pm: add the missing mapping for PPT feature on SMU=
13.0.0 and 13.0.7")
  40794dfd20e0 ("drm/amdgpu: Fixed bug on error when unloading amdgpu")
  45bf79719f1f ("drm/amd/pm/smu13: BACO is supported when it's in BACO stat=
e")
  7f347e3f8217 ("drm/amdkfd: Fix NULL pointer error for GC 11.0.1 on mGPU")
  8ce1d255147a ("drm/amdkfd: Add sync after creating vram bo")
  b7cdb41e7d25 ("drm/amd: Delay removal of the firmware framebuffer")
  c595637f8a7c ("drm/amd/pm: correct the reference clock for fan speed(rpm)=
 calculation")

--=20
Cheers,
Stephen Rothwell

--Sig_/86Ua=.MDY6UmE3VJfphzANj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEbVYACgkQAVBC80lX
0Gz0fwf+M9o38fhV8UPgxlbLqjd1bXljeh2RpUwfZsH1sOvjyjB0VhSIN162d5AA
46PZX2xj7+PS/NYWXI8ALcmb1o/WdvxXq3FpmMXxM0hIDUSmisGce5PhEE95sWI8
Pla6lF+nwFE4GLrSR5p1AGbEqG54MZzdhy9rBAugV7ULwtrfgpF1w1zkjEnQB0bg
tKTX6TLkGu5Bpp8IOQxDVpW+MgnmzNadnm77XzcpUQBOvEhm5IcNoQW0POTMvIYQ
u81mZ/RGp2QRGXDv43S3+wc9EYjzyljWa9npPnToEyX0FmDBMsSjlAJKiv3n7ota
2RKkRy2yUkQiKP6/ElRuq/E0f7Y2Hw==
=up08
-----END PGP SIGNATURE-----

--Sig_/86Ua=.MDY6UmE3VJfphzANj--
