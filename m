Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8C607A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJUPZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJUPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:25:33 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E23A510F8AF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:25:31 -0700 (PDT)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 6A3DE2427DF;
        Fri, 21 Oct 2022 17:25:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1666365930;
        bh=UbaaFnYo+HTXmhcj8WOVnQZ9fo/iLoY+tAwf/skw/Wk=;
        h=Date:From:To:Cc:Subject:From;
        b=Gd057/c9r1s2m22unQTK1xRSfS1qFHyz5czbGSlDccMlZ2MBZ2SkBdWN85MXp3GY3
         luLV5YH94RbQaUjE7rprdMV+/ILw9/xmXYo5hQ+PzUBBvcuk1mYvcv5By+0N3lf2vz
         L7OZpj6qmBeMZJSW/RFRbsfT+rA3d3Yr1kaPg4mk2GBzJkrLn6KfZjCv5r4gNFh9Ts
         XuPjLp9zcR89tuGBp9fh3gK3bN9xVHhptfbALLEc1va7Jkce+xAozF/vszpIbrvsyv
         W6MavO1fTTycyArVTweRn5QKJwL4zScKoekc4gj7ITBlT1d91yfwgsLQhPhbLZY/N+
         AGM4pKghjyQ5g==
Date:   Fri, 21 Oct 2022 17:25:29 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.1-rc1
Message-ID: <Y1K56ThNRTpLRA2X@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oKHxqs63Pe8+DD1/"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oKHxqs63Pe8+DD1/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc1

for you to fetch changes up to 620bf9f981365c18cc2766c53d92bf8131c63f32:

  iommu/vt-d: Clean up si_domain in the init_dmars() error path (2022-10-21 10:49:35 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.1-rc1:

Including:

	- Intel VT-d fixes from Lu Baolu:
	  - Fix a lockdep splat issue in intel_iommu_init().
	  - Allow NVS regions to pass RMRR check.
	  - Domain cleanup in error path.

----------------------------------------------------------------
Charlotte Tan (1):
      iommu/vt-d: Allow NVS regions in arch_rmrr_sanity_check()

Jerry Snitselaar (1):
      iommu/vt-d: Clean up si_domain in the init_dmars() error path

Lu Baolu (2):
      iommu: Add gfp parameter to iommu_alloc_resv_region
      iommu/vt-d: Use rcu_lock in get_resv_regions

 arch/x86/include/asm/iommu.h                |  4 +++-
 drivers/acpi/arm64/iort.c                   |  3 ++-
 drivers/iommu/amd/iommu.c                   |  7 ++++---
 drivers/iommu/apple-dart.c                  |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
 drivers/iommu/intel/iommu.c                 | 17 ++++++++++++-----
 drivers/iommu/iommu.c                       |  7 ++++---
 drivers/iommu/mtk_iommu.c                   |  3 ++-
 drivers/iommu/virtio-iommu.c                |  9 ++++++---
 include/linux/iommu.h                       |  2 +-
 11 files changed, 37 insertions(+), 21 deletions(-)

Please pull.

Thanks,

	Joerg

--oKHxqs63Pe8+DD1/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmNSuekACgkQK/BELZcB
GuNtQA/8CgW461/OeYTerU80IZVLVJPUHVcUTCCzQ5QVY8AH2rvAn0CJyTrc4MI2
golyz3hv4WWRmjW8djSiS+OKC+ffgDPhugIQXiVQTKTAVK7BakhysGEMFwOSY/y9
7+JZt+CDSA1DyOnL09f6g85E4b41+FIsCj6DkP5iYjHr7eX0qz2HXYL4Swpej7Pr
sNsMR/jfLJEXTqDWywkbguHyRJa5R7gd40FtzEyxWxRT+gs988lpMtvzigyWz8hq
FrpO27T0qkkuKL1vUZqCTV6Xilxc+uOQOJdEZCMZsMMXAXTxKFiZfAKfX6yPtZD4
NWRqpG64joeBYj2ALY4XYlE8fEBreR/rJrgH0rpGIykiTo2edMbhN5ZVUygqhNiy
PBnUxcWxhYxiJgrlCDshHzlZrPXryyD4NsIYteg0P6gUddtyC/cNrHZ4GkpwmPaj
+roYzUFUNHTXjDdF/r201iE19rjEe4BhfKe/6dMNvQ8wUCzEDLyMPFn4NqleyAPS
jilw+oIL57KkiWaYOlCdAdXnM4iTspCcWcTUr8D5tWuJibWuptp2c0cl6n1+oixo
5yBg+pMw68Y48vQObpLG6frOIuasm3nl0hvr611vVrWPjIYu77vJ2zdesYNBzmCC
JWGcoPUKuoGcTZ0z7Thfi8Ey94OjyDEKMDtHvo1EOYAY78RHt3E=
=5DZQ
-----END PGP SIGNATURE-----

--oKHxqs63Pe8+DD1/--
