Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF471FC12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjFBIaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjFBI3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:29:43 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC286E4D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:29:18 -0700 (PDT)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 9410022410B;
        Fri,  2 Jun 2023 10:28:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1685694504;
        bh=yeu1dDYEqxkGt/Kv0SsWWyfWdDRDvxznAptvFgDLt5A=;
        h=Date:From:To:Cc:Subject:From;
        b=BD/oPK940PBxRjlBHsH9/RWNZ0nJvOc44LnHRld/Tgz1GDZyVMTwWtQa25f2tzYIO
         7G0N9KwihSHVcjMWT5D72UAIt9rGL/tKdNYdUe7UnMlW26U64YMSC1Q6CVepUnUf3b
         JKcbalkcen2aeBYaD4E4Z+kuFHZB3skHcjut6mIqsw1imTyIVxk324Jvl7AJGV+QfO
         EFA/pX3rMGn7baQlxk/p6dJEfHihmopBWpy71ScoH8XTUz6od010whvJSB+700vjL+
         Bans7/NYr542F8WU07EVO3Np7i24TnlJLWTyBnghLnllsMU6QhkfB/xuaFgcmcGVkJ
         C+Ea6V6rQUhUA==
Date:   Fri, 2 Jun 2023 10:28:23 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.4-rc4
Message-ID: <ZHmoJ_TIIzruBSIY@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IBycmC2veqYOLJt7"
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


--IBycmC2veqYOLJt7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.4-rc4

for you to fetch changes up to b3fc95709c54ffbe80f16801e0a792a4d2b3d55e:

  iommu/mediatek: Flush IOTLB completely only if domain has been attached (2023-06-01 11:50:13 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.4-rc4

Including:

	- AMD IOMMU fixes:
	  - Fix domain type and size checks
	  - IOTLB flush fix for invalidating ranges
	  - Guest IRQ handling fixes and GALOG overflow fix

	- Rockchip IOMMU:
	  - Error handling fix

	- Mediatek IOMMU:
	  - IOTLB flushing fix

	- Renesas IOMMU:
	  - Fix Kconfig dependencies to avoid build errors on RiscV

----------------------------------------------------------------
Chao Wang (1):
      iommu/rockchip: Fix unwind goto issue

Chen-Yu Tsai (1):
      iommu/mediatek: Flush IOTLB completely only if domain has been attached

Jason Gunthorpe (1):
      iommu/amd: Add missing domain type checks

Jerry Snitselaar (1):
      iommu/amd: Fix up merge conflict resolution

Joao Martins (2):
      iommu/amd: Don't block updates to GATag if guest mode is on
      iommu/amd: Handle GALog overflows

Jon Pan-Doh (1):
      iommu/amd: Fix domain flush size when syncing iotlb

Randy Dunlap (1):
      iommu: Make IPMMU_VMSA dependencies more strict

Vasant Hegde (1):
      iommu/amd/pgtbl_v2: Fix domain max address

 drivers/iommu/Kconfig          |  1 +
 drivers/iommu/amd/amd_iommu.h  |  4 +---
 drivers/iommu/amd/init.c       | 24 ++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c      | 31 +++++++++++++++++++++++++------
 drivers/iommu/mtk_iommu.c      |  3 ++-
 drivers/iommu/rockchip-iommu.c | 14 ++++++++------
 6 files changed, 61 insertions(+), 16 deletions(-)

Please pull.

Thanks,

	Joerg

--IBycmC2veqYOLJt7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmR5qCcACgkQK/BELZcB
GuN7XxAAnl3iTkOVuTW2O/STNNsn0xQJFooNNVrLGSlGdqLRgOVvpfN9wh2QGFwl
0dIFSfM2tpx3LFjDdzPl8paKmnKvoYQxUTICs9rdD1sxetcb8lvvcXcnH8LfqRqr
ZKTJUtho6t0jCOikeFcOEeRwa6VvU8LMnzCk0k0FHhdOwC2b8IHZt9xwckYQirj9
SR5TJIJhHfIH4ANJRTEZd8IQ7ZWsrfzSnLpJ8H2cuoj37OVRiZk7NLVJv3xb+Bzl
BNJsp07/ge3v+RGUSLWLwFKAhyIwFuvzsPrgtLi47JEFPuQyiZVPGEqBcyP7MD2r
KS6FGbhHfcVGKeBg/X34SCsgbX2r2eH1X/DxJMOi3vfF0x49y8Ndueh57md0jQsu
3ZRUdS6G/rK28BpDV0LCKrjE13CM6pNdrAHVjhDtWexN/R5LIoSP5AG1dm7RNpl6
sBJdtC34Nm9VIA0OZeJwhQ0r4xZnK7MDmIrDHDhrXh74Jhz4sG2niBG/zQEjORzG
5ZtkfFo2AfnaFiemT/65mFVW+WuFZx8+4QJFMXsi3s8orCOJXmCXAwdvXMJBDvc2
jlp6D8LZ6WSeFb0Exi+RivLMrgjqFApcJ99EvK4MPvjmJ26CcdwMEdYXWsYQjiY2
7Q8FA+Y76ySq+QtV8496XtLfyfMf9NagA83mCVI8baCC4Tz6DsY=
=S7t2
-----END PGP SIGNATURE-----

--IBycmC2veqYOLJt7--
