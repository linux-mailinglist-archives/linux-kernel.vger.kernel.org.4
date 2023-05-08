Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F556F9EBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjEHEjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHEjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:39:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD8B1569E;
        Sun,  7 May 2023 21:39:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QF7qY2l04z4x1N;
        Mon,  8 May 2023 14:39:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683520777;
        bh=zgzJlroUDsGes0yfn6kZQ73jk7EHbJLKDPZZ9gGWDe8=;
        h=Date:From:To:Cc:Subject:From;
        b=GcbSb2MUjM3PbSCQ2r3/du9fsKTZIAfHNTFNLJyWlmDJDoSbFUmbm98XGrbJPWJ9a
         ETzp/ZnX7RrYkjldBDS0NokLxUsqVZcjvOwUtOJzPQiuBAhyUZMyCGDCDo/Y5/bjXv
         yw77NKAzKk4zN50lBno8LD6taqvgciml3NH1Qpd1HtjBD9jUnY7Zy9tDil5c1pP+V0
         JeJ1lk/ArCw7crC4m99XpK5KzI/kkJHuCCjnZvqtrFUYEljHuDxDmuVH7WhI/ISIck
         e0hNMb5OwMjl2MoAe7K2DmGbv2F+KHQT+y9zdS8MKFAOG69M7rDdN1zO0P10fzFt9x
         Gcq9Bt6vW/BKA==
Date:   Mon, 8 May 2023 14:39:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Saeed Mahameed <saeedm@nvidia.com>
Cc:     Maher Sanalla <msanalla@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the origin tree
Message-ID: <20230508143935.2cc24467@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bWBJh_gKUGB2HSJ6Ec8Gs6T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bWBJh_gKUGB2HSJ6Ec8Gs6T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

While building Linus' tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst:=
287: ERROR: Unexpected indentation.
Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst:=
288: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst:=
290: ERROR: Unexpected indentation.

Introduced by commit

  cf14af140a5a ("net/mlx5e: Add vnic devlink health reporter to representor=
s")

--=20
Cheers,
Stephen Rothwell

--Sig_/bWBJh_gKUGB2HSJ6Ec8Gs6T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRYfQcACgkQAVBC80lX
0GxfMAf9EYRvs5UGdW4OH9Lax9QnwDkwMLr2A4t7eJNHa3kDoSHFsvqN0Zu2QFV0
hGfHc3XCDkEomVys3bq2RfD7aBkBiEbQBrYCP5u/EQrNWSv6u9ix8vuJ4e0Z4yq3
sacN1svvy4iH4Ify5UkVe78Xey8WaZChKAxrFpCqq0WZm0JpZorHJ7ovKYHX93k8
GZ5SJrDm4c03jtAa+xCoZyjr184mcdR2V7xBkTKgljyECjjxDQ9rTuCzVWrCzrpz
OMNPNOMYgSR35Jxbe7E2nwDFk67nCLqiqXbtwqpi3USGlA80+YoUxT+nDCpGlgmY
P3qJKdiII08FSF3JurdUrOWAfHygpg==
=zUp3
-----END PGP SIGNATURE-----

--Sig_/bWBJh_gKUGB2HSJ6Ec8Gs6T--
