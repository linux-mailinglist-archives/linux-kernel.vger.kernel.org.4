Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D646D30E2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDANC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDANC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 09:02:58 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CD6494
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 06:02:56 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id C2F01245407;
        Sat,  1 Apr 2023 15:02:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1680354174;
        bh=ivLCR7G42mOBHbyzSVSeaGBW1vJ1pQzIUjyUrNLx6HU=;
        h=Date:From:To:Cc:Subject:From;
        b=bc4WRjtn7yMT7g/GeeY+l0pgDBKsWK8a5n7Dz/KkY3D4ZEyqtOkplNdh4KUmHa2jx
         U3U+aCr+eIXVT4WIVIlZvXMuUbTX18DW+7lK/i4pH8Glx1jAsibof0nfdO7Kr2PjCV
         yGcwuzHYcC4wTCmXUoKCL7av8QkPgDX8t/mCZIfvXNvJLf1yr8TmLoKJi9Rkb7wvvq
         2UndONTiz8k9WDhZaVVJGIMPfoaw4SB2w8Tb+uIzoiIJd5zAcyeYC/WQrm1mUchXHL
         LiHtKtLdbRwNvL/Arci+ZrWFHeh3S8Cv2tXZ7c5KtMT8QjJsT4feUhzBqOJPYKet7j
         hIQPNTCenw+9g==
Date:   Sat, 1 Apr 2023 15:02:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.3-rc4
Message-ID: <ZCgrfX7DoO9puGmY@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+gelX+8wR+xGJNeO"
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+gelX+8wR+xGJNeO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-6.3-rc4

for you to fetch changes up to 16812c96550c30a8d5743167ef4e462d6fbe7472:

  iommu/vt-d: Fix an IOMMU perfmon warning when CPU hotplug (2023-03-31 10:06:16 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.3-rc4

Including:

	- Maintainer update for S390 IOMMU driver

	- A fix for the set_platform_dma_ops() call-back in the
	  Exynos IOMMU driver

	- Intel VT-d fixes from Lu Baolu:
	  - Fix a lockdep splat
	  - Fix a supplement of the specification
	  - Fix a warning in perfmon code

----------------------------------------------------------------
Kan Liang (1):
      iommu/vt-d: Fix an IOMMU perfmon warning when CPU hotplug

Lu Baolu (2):
      iommu/vt-d: Remove unnecessary locking in intel_irq_remapping_alloc()
      iommu/vt-d: Allow zero SAGAW if second-stage not supported

Marek Szyprowski (1):
      iommu/exynos: Fix set_platform_dma_ops() callback

Niklas Schnelle (1):
      MAINTAINERS: Update s390-iommu driver maintainer information

 MAINTAINERS                         |  3 +-
 drivers/iommu/exynos-iommu.c        | 17 ++++++----
 drivers/iommu/intel/dmar.c          |  3 +-
 drivers/iommu/intel/iommu.h         |  2 ++
 drivers/iommu/intel/irq_remapping.c |  6 ----
 drivers/iommu/intel/perfmon.c       | 68 ++++++++++++++++++++++++-------------
 include/linux/cpuhotplug.h          |  1 -
 7 files changed, 60 insertions(+), 40 deletions(-)

Please pull.

Thanks,

	Joerg

--+gelX+8wR+xGJNeO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmQoK30ACgkQK/BELZcB
GuP7vhAAsS/pWWeNqE+/kqgFDuwUo4dvATUse5hCfHnLf7KNVYfsCXFte6kC2EyN
YeQiKXRDGz5QLm8XmmqeZSqdjc73OtYXvxPhbd7+9UQjutri+SAj+3ntJPP4LXcO
iFE5nHuTA02Ir/oGE4E2LOTeK75i8HJdR4vaQpbpcrvvF7i32p0MrYpl424dq7BV
icXsJ0Cy8iVLaIyTCOyWkFFMcd0L/pBMFZelHc/MJeZuFgULcp1jFhRdvflT4ctR
vNtl9qZtplWE6Vs9lJOSGHUrkdfnY1Uy1JoTUr+F0lS6QVQ6JyIYPPfz65x24XiK
2WajiHTP53r4RCZSXSXvfA2kfIr4AvferaUC1KUv3mP2A5dQH2uPVBiNmnzW2DwO
MgOThEzJcegyRz2ZTPraQEl/cqUqrILaLUdVnz5pR/2I8V3iB4PlH0X1j7vdgWhu
5t0u6FWtISWiWu7mPQLqwIrSsh3jEpEc/mceLqey1N/ms7lMZiuU2biMM7rdep16
ZiXIxM7ojGzWGPQ6o63nvRQ8VFc30/aR8NEhN0SKCPM+lVMgoVUY+Nt4/he8e21U
HpB+yxUuPA2qo38iIjKZn5GZvWl6VyAJNXLAN4HYIQVk6fAXlClGObc+Pkj03+0T
6/odNocDJ0NeLSVWTmuduw5IETe84Hx6CeyRG+Wog+ngi+BzXYg=
=KIvi
-----END PGP SIGNATURE-----

--+gelX+8wR+xGJNeO--
