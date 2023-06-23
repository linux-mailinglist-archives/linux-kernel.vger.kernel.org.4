Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD9373B8C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjFWN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjFWN2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:28:14 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A1492683
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:28:13 -0700 (PDT)
Received: from 8bytes.org (p549ad14e.dip0.t-ipconnect.de [84.154.209.78])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 20345227ABF;
        Fri, 23 Jun 2023 15:28:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1687526892;
        bh=4YXDigxgMsWL5sBX3onfN4vWolhY0RcWjbjbXVZW2ao=;
        h=Date:From:To:Cc:Subject:From;
        b=sY6qK5ct+weBbyiXQnPOIt2PlM30wwuYlDrPoBdATj6OwHO+cdu8muyyhkkUH9D1C
         puG2DAKyjPtRhClJ4Mu8pQEq4cItmfFNokMDnKTq+FB0KTbtGPINjRIBhk5t+9GahT
         IKCEs+yI+dO7zPttOw/atSbzp+wgX1K6YyXi5qL38uZan4be/VVsbk8bAeNRLCWKPz
         hMVdgLT/3DGR5QL7mfjP1/DUueynl9NwpDXJ4O5YpQWvHX2Utm3J27WHtjm9ieGKR3
         hbPvjeqiayTvqa0ywGpRurrCkCh1wIpOYRjCjv75c8hHpDWvta3wc9Esda5eRARdsi
         SHap2zQTEx1xg==
Date:   Fri, 23 Jun 2023 15:28:10 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.4-rc7
Message-ID: <ZJWd6uejO9mO65IX@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n6Lqx8/O9gUBDJ0C"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n6Lqx8/O9gUBDJ0C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.4-rc7

for you to fetch changes up to 5b00369fcf6d1ff9050b94800dc596925ff3623f:

  iommu/amd: Fix possible memory leak of 'domain' (2023-06-16 16:36:45 +0200)

----------------------------------------------------------------
IOMMU fix for Linux v6.4-rc7:

	- AMD IOMMU: Fix potential memory leak in domain allocation path

----------------------------------------------------------------
Su Hui (1):
      iommu/amd: Fix possible memory leak of 'domain'

 drivers/iommu/amd/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg

--n6Lqx8/O9gUBDJ0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmSVneoACgkQK/BELZcB
GuOvng//TpxDteTc2PUTgRAPR3tDMtLKUhuZmIIBvf3aMheRXOsZLkuiJ8S21Ymk
Y3wZhncwNEM6tmxiZ7vuuoan5UCUIyk7ozsBnBV7AmPj3tf2De50q47QEtV5Mldz
RcNvBYwjOHOLHNhiZMYRl2z8f7QBUJz29B+gEWhIPAzR7QaieQaCDZrmtDvXUWlQ
4s11m1XXGmz8w1g4OTmIHk6b1GuinEmevkYWYispwfDvfU4uHABbDPugDH5X1QKd
RVFPY0vFhihuJ4kWbvIVrD5L+Bwg8xmOj6KicQLkeeQCUUMSQDtDm2P5gvqTmRga
pnFXRlXxXswPLKUzwYpU0lP5LyWxeU+GjWttlwLYIKkv2deHL4WlIxZiChUHxCi5
AK/U6fi3Ef4MBnuzHlNhmWY6mAYvftXgyIsCmWHs3hChOnxZER4TZxjGN9eUojMB
Vbhl8Cg5zdlj2MKA89zOpJDOKlzM3rdoGGLKNr3uhRgEkoSShflch6ebidFFG+m0
vOw9mo4Bc5EiOATYdgndSffVBN7K39X4T5tawDa0Kc7jqmBKRAn3yrI+B79M3oD4
JcPtmFI7sO/uoKN105CHjEIH1mBZ8ui2EH5hTlGOD4E1WloApmEt5m9T6SROGnVw
qLAR0fqZZsboC/3py5haCMPOccG1ORA4nMsoKS8t+PZ6MigoCEU=
=qB+y
-----END PGP SIGNATURE-----

--n6Lqx8/O9gUBDJ0C--
