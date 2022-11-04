Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB83618F76
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 05:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKDEYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 00:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiKDEYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 00:24:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EA022528;
        Thu,  3 Nov 2022 21:24:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N3SFc4WRMz4xGH;
        Fri,  4 Nov 2022 15:24:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667535877;
        bh=YQBFYt/jUjBwwYzIrXZna1Vjm0wLj7zLZZu7nOA7mJY=;
        h=Date:From:To:Cc:Subject:From;
        b=L0HtTPypDwQ2I/VIqSCIs/yDpL7xk9v7m7CiCJm6cwM7K5tWsaArpT/BmSrai8H1m
         Jk5khN4MS+MGsCuSsEnRp3meG+7bE0ljbrFigNV0YjrgRI3TeNglF057n8wvadJrq2
         72J4EuaGpeH2KRWWAhyH7p7lgTIn2nbgP3Hy7qCbxD6eqG0r0Kz68dUVybAHtnYf3X
         0HbH6FAyaIokk81C7bUKQtKBQp0osrMenrC4XWppT49ewm/D4tuJShdHqMCBEzXRcx
         RoW31miV3m/s8JB+0HiSoSEXnhe+wDkXTp/BFlO77JfiHnxUbsoj0s8zjIUUpBMSaE
         uPo8MTd0xV3ug==
Date:   Fri, 4 Nov 2022 15:24:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20221104152434.7233ed45@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W7UvFxxyQJKQbaUubjRjOcM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W7UvFxxyQJKQbaUubjRjOcM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommufd tree got conflicts in:

  drivers/iommu/iommu.c
  include/linux/iommu.h

between commits from the iommu and iommufd trees.

I don't have time to disentangle this, so I have just dropped the iommufd
tree for today.  Please coordinate.

--=20
Cheers,
Stephen Rothwell

--Sig_/W7UvFxxyQJKQbaUubjRjOcM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNklAMACgkQAVBC80lX
0GydWwgAj/IVy1OFFP06lXjs0myDuUhsmCfM+fIOBCjI494ZA4X+OzuhWE32IM1l
T7xvyuwq1K2L+mVbPApDXKuWETiM8ZD8UHX8dqIP2/NpI1KX/vV1OL5igI8BF3ET
RxVAmZKCzvwoTdSE+E9Ez/uqc8YLtlLjemgoL0IfkEuFBgPft0vix49+ui2odmOr
S8TUjby6VMYerwNSICBHAqY9L8Yrh266RXS/jRdex8QyCVY8ZmRa1jmLGP577LSY
T05pfazTvkB1FQ5++SIZ3FOd2oKRKM+Mf5LyWuJ7cwSWFaPrtLnX79LTWmTzYwuR
lcNVpiqllPaWblF6pDR0SVYjUiUmcg==
=2B9X
-----END PGP SIGNATURE-----

--Sig_/W7UvFxxyQJKQbaUubjRjOcM--
