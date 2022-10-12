Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2305FCCBC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJLVFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiJLVFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:05:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0C61ADB8;
        Wed, 12 Oct 2022 14:04:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MnlXP0752z4x1G;
        Thu, 13 Oct 2022 08:04:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665608693;
        bh=EJJS9FjesJU7J8a3BxU2JXR13tD1ROBRuN06W4YTZ+Q=;
        h=Date:From:To:Cc:Subject:From;
        b=sfydKeycADu9MwB1Wjq1wp2PFh68r4sZzTYgM8foaxjUyeFA+BbvVTfR4egR9zQLC
         4vOBMpzNVVR1ZgPOpZl5XPrijgqOsZ6N+s3BKQL4hy9pBaf21KZY1t6VMCJhtG29N6
         9sQWiaLCfUFqxtYMj3jOEu96QrWfYXf9S+klbYhQnHU01BBQk59KzLeZhwL6MuNxQW
         9VO0nJtPqe828yDyLP9Q9Drd6UEePLIVrsEEY7HQULM8CLkTevpyxNXCEBdYtuPXJI
         3Q3rBGHQ22OoH+IHcuazsv/qdq5w4C+XFo+G2hereDe4SVSTsrg/4OtRKt6W2UBZnU
         fq7b7//kKwRXA==
Date:   Thu, 13 Oct 2022 08:04:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the fuse tree
Message-ID: <20221013080437.4924f2ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HAeT6v1TBsW6/26nhGBNTQH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HAeT6v1TBsW6/26nhGBNTQH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  aabee0953ad4 ("fs/fuse: Replace kmap() with kmap_local_page()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/HAeT6v1TBsW6/26nhGBNTQH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNHK+UACgkQAVBC80lX
0GyWhgf+MaUE9SsDJF9er1ObWdchlV+xz7TN2OpEurMpTSZc7xgEDWjYWFQfMov3
Y/Ryl2wFzY+vuzPtJPOfCVIljMdpGZHwT3hhboqMPhRr2Po101ycbOr9K34WmX6X
pSPbEFDY+WZbRZ1vs3wsFg5YT8aVQ5KIqx8FlFsz75KW1dPRq20cs6AsURJJjnPF
HgvAsBE14io5V1NZxdgHBHMg5jQhg0rMCaTNebseJCPu6HHfmcd9UvKoOpu+espr
80JBqWCrlvjk4U8eO1IrqbvKbs8/eZ4C8mes8qtG8nfqA2A//CfxB6imKDML62CD
Oznhq3QpIIhAH/nmYjHDFBgrOtvMGA==
=dD7H
-----END PGP SIGNATURE-----

--Sig_/HAeT6v1TBsW6/26nhGBNTQH--
