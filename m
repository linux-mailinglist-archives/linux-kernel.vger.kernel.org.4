Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A35630F58
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiKSQNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKSQNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:13:15 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C2E92C66A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:13:14 -0800 (PST)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id C51512A029B;
        Sat, 19 Nov 2022 17:13:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1668874393;
        bh=pKZSOrFJ0a9jKmN1CuPpLnJ+pFpga/JV8WusiyY0ZG4=;
        h=Date:From:To:Cc:Subject:From;
        b=OdDddaqTizQN6ByY/OGzcqozhLZHehAgZblXoSs/3vbEsx2bB2Pa4NuX5tRswAI7n
         R1IUDkxmHf5Vvpuuo+nDwAq9wo5aWTTTSkcKLtcJdS5togtwF9JqiVOV+KAW9rdtk9
         sx/IjjjfM3dPEB8uqBHj7FUWz76Rn89zdAOHZFbvp/qo3ZS3YQJg+L8xxF7xBKvP3R
         5MRU7dgcdMNHZkta1rM4q2ywmCcwm+09XzhWtq56ZnVohtZMMAO9JkLpQH7XqVLP3D
         aWBPwyTNGj5AM7FS2crJgSPdMqHQWCbi/KMF9l4M+LeLf/W5nruB182faWl9Mg3J+o
         kukseuJ4a++jQ==
Date:   Sat, 19 Nov 2022 17:13:11 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.1-rc5
Message-ID: <Y3kAl1vpndkuviqt@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zSTt2Xp8a783qA4a"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zSTt2Xp8a783qA4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc5

for you to fetch changes up to 7fc961cf7ffcb130c4e93ee9a5628134f9de700a:

  iommu/vt-d: Set SRE bit only when hardware has SRS cap (2022-11-19 10:46:52 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.1-rc5

Including:

	- Fix presetting accessed bits in Intel VT-d page-directory
	  entries to avoid hardware error

	- Set supervisor bit only when Intel IOMMU has the SRS
	  capability

----------------------------------------------------------------
Tina Zhang (2):
      iommu/vt-d: Preset Access bit for IOVA in FL non-leaf paging entries
      iommu/vt-d: Set SRE bit only when hardware has SRS cap

 drivers/iommu/intel/iommu.c | 8 +++-----
 drivers/iommu/intel/pasid.c | 5 +++--
 2 files changed, 6 insertions(+), 7 deletions(-)

Please pull.

Thanks,

	Joerg

--zSTt2Xp8a783qA4a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmN5AJcACgkQK/BELZcB
GuPtBQ/+Kxv2obtuPUS79X+4hxloB0znNhTBEkcD4k67lOEiH/8zMUI6Ykc16KQu
SIIB0WCc4i2GTCKs8xJc3U7F1QMZSsPl1/89GrTvQgZJ6NBW4t6xlvCLQhyU16LM
0onnlx+UOwg0l8na2FR15urj67Mc3PQOZeKEgwF5eIbNfDhgJgdz8Mh/TEmKxDxE
59H8HanwWE9Q2JwpAvQpymS6XGPW7obhuPeQRD+7N5FNkC78TIIboNmiZ8S7r7e2
CZ45iv3i4u60T2OiWSxp4F19O35AuL6J50ZmOTYI/Xq5qLreCtcqq4EYb50qpGgv
rVXC4D4nY4+YJMyBWS9mh8QX8cJXxMbhsE4I2CV50u5WPs+bORf5T9ds/o+glr2I
IAzrWeeA02QBfD9FQKLUH/cV0QrDPxDJfIy6bq57ws8nRl3z1+m87NmXWFTn/Ht2
fcOktVKFxE45fOiQv98cv2Jf1tv4gnS/ggntaDNuA1zdxlkJyZHrc+mdSJ8QyQ3O
afkeQTStzat6SiaDW9SMEG0LybnJWC0St1gQH5Wkd8oexNkiGtko2wDu6NCZB8SB
C4Q4LZLj/qVU3/pL2938QhwMIQtJkrHohtcpt0FErd7Ltaj8TOZFpxpNQ4tNjYho
Lo6pPm2vmz+MKSRnv43N669Zehj1lUIA6TBI+aSysn/V67sdeN4=
=9988
-----END PGP SIGNATURE-----

--zSTt2Xp8a783qA4a--
