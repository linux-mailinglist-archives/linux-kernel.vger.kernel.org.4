Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D16D697547
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBOEPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjBOEOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:14:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F24934C34;
        Tue, 14 Feb 2023 20:13:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGl7C12Csz4x87;
        Wed, 15 Feb 2023 15:13:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676434407;
        bh=6NpP2stHfFOpAqwIjJFPHzN5E64XNjxtbY4r5Tv5aSM=;
        h=Date:From:To:Cc:Subject:From;
        b=czpPUyx2hHxHNiIxS2uKJwccTRZ0h2JRqNMqfD6CMaWeqwgKGv07aQB+mxvEpdejU
         X/lQ11ijNwhfIUCOZjvgndc5vnaZ35C0ZIng8DzZiT+RQ8xDTDMOUoAyTPC5aBO7RI
         hDXrLP3LA3Io9+m+r3GeSPeQeWEpw1XtoAJ4lGrcM0CSIF54P4TQ5JF6TzM19Y7Rd0
         NoNG+Lx3mVOcWZqp/wG0BAxINANjBiInZefO0l+CE9DeNNYKk1qk7fB3/UCScD0Gho
         A3FCboL7ylMocjoznUFK4P6fO2guAa3ve8/jm9NR/bGhDgpETLpFrScNgQAFXAFdce
         M/01aEZqKcYbQ==
Date:   Wed, 15 Feb 2023 15:13:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Wenjing Liu <wenjing.liu@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20230215151326.576dad62@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BzMFIsSJh.zpnfNaHmh8_Io";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BzMFIsSJh.zpnfNaHmh8_Io
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/dc.h:877: warning: Function parameter or mem=
ber 'temp_mst_deallocation_sequence' not described in 'dc_debug_options'

Introduced by commit

  3d8fcc6740c9 ("drm/amd/display: Extract temp drm mst deallocation wa into=
 its own function")

--=20
Cheers,
Stephen Rothwell

--Sig_/BzMFIsSJh.zpnfNaHmh8_Io
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPsW+YACgkQAVBC80lX
0GzBfQf/eZCTsAFKOVMlfvTfPIdiYzTfAlSyfyeu9+Jde9d7GCBEHiRdLkXoY5Gp
G9iWAZR5Pmuna7IXa0Be0XUk/CiOl/mMxbFzk1PDaRYZE55qzTBYM8BIy27vyEdT
csTg8YJyAJ7gQiCZnKxr24Uda/Rig1TKsTb2irlqyGbJLhs7ay8CCJ+gHC8MteXY
8/WAqI+2vsmqigBsrHXo47NqCMvS7Ij4hyYZJg1yMV8To17B1q/CzRofUPVC4qrW
o0ba/8uWd6S8u7sdHr3xfXYTyn15UJAySRDn1hBxYJiIKz1KmIwDsJrfhSos9LaC
a5blmlNHGl/014wsR9tdSsXa5bwbuA==
=bVds
-----END PGP SIGNATURE-----

--Sig_/BzMFIsSJh.zpnfNaHmh8_Io--
