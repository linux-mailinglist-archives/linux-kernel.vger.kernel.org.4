Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8547E6C76AA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 05:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCXEth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 00:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXEte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:49:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C014F273F;
        Thu, 23 Mar 2023 21:49:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PjV9k13hWz4xDn;
        Fri, 24 Mar 2023 15:49:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679633370;
        bh=Un0NLEAqws+lV6/jT34sYKHAY6MqDqmkd6tXZOA0z84=;
        h=Date:From:To:Cc:Subject:From;
        b=SHENG+tXiZlI6BNUjEm6I7fSQekeVtR66JCs9DZq9M/KAEuWvNISBSFc0VC1leF2N
         J4eXCOBUkEGMh1lqatLhEkpfoKd7sZym+Bajl0TY4Lw5npz2I6LamoSS68xovdWj+7
         I7gSoyc38mC1LZmYhwDBSiuZYcl/vIm7lxidxjNnFrZcTJx5k8aiuDfqLppAqMzh+Q
         pxtofnEtYBUnkz9mpXKQ+ijkgEPsw8zUSNwQfBSHqR5GVga20NsIT9nmskld5NqEGC
         V2ttrxdtgEdeAVBhGkB9iUiDiY9YaUmtPHEVWzmblVl+LY7lnCVTfGBLP0ZThwf+JH
         cBdgO3oDCmuQQ==
Date:   Fri, 24 Mar 2023 15:49:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the qcom tree
Message-ID: <20230324154929.32d232c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qDrCELs6XUofV5kco.i6Lr1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qDrCELs6XUofV5kco.i6Lr1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the qcom tree, today's linux-next build (arm64 defconfig)
produced these warnings:

arch/arm64/configs/defconfig:989:warning: override: reassigning to symbol T=
YPEC_UCSI
arch/arm64/configs/defconfig:1232:warning: override: reassigning to symbol =
QCOM_PMIC_GLINK

Introduced by commit

  4ffd0b001956 ("arm64: defconfig: add PMIC GLINK modules")

--=20
Cheers,
Stephen Rothwell

--Sig_/qDrCELs6XUofV5kco.i6Lr1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQdK9kACgkQAVBC80lX
0GybZwf6AwA3mQcTagKjKuV3/3d+IPzz+jc8BIY4Ty+oR8Ra5dfPZ+i+ZflwMbEu
zaDRda8jfsSEC9F/JJ2nCiiWgULHJiuw7E0rzR0dYoXlenIQEbOtxbFxEWMvh3mn
P94V/hbmfxxHNe8oWLzf/3db0R4Wy3POR5U1LPvLVZZwYWFIDHycQwujhEIJLX5e
ZEWauCv+rD53F+KPjLwGRLWXmhC/z77Hu/SsGWd85//k18TMqtkVFyeiAND9Uagi
FOn3vWyfBht4W4w7MBHA4G6Basmhd+VK+X9FSf0dqNA2jVJchIjYwIvXWGoPbOcW
Tg10xOiNE4DGZ83rd14S3rKaDKkqzA==
=bv0r
-----END PGP SIGNATURE-----

--Sig_/qDrCELs6XUofV5kco.i6Lr1--
