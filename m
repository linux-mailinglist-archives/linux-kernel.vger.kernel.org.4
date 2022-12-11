Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD3064948B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLKNv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKNvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:51:55 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99E79AE5F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 05:51:52 -0800 (PST)
Received: from 8bytes.org (p200300c27733500086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7733:5000:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id BAE092200B0;
        Sun, 11 Dec 2022 14:51:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1670766710;
        bh=5iE76IbZ6z7bALyFl54hXKSWuDsr7IdaN0MxDo2mowY=;
        h=Date:From:To:Cc:Subject:From;
        b=Hs1eTOpvC3MavS4ip9duTF+vE3F/AMZ38Us8NWSx8mpbqOBERqbK/JvgNVI+VSm7S
         oz+Osz2wpiJbuPx9aL1R/3S2TRSRgE0eEkHUEniRkMPgSSLw53HCJO2uDRMk4wk7Qv
         7/fOTzedRwNfUp2dl8PZU0GAw/Vkxu5Yd5JXwnk5+cWhJLS0TxiDlG2XKGgq/mctIh
         raZlJwctb9KAGIkLf4VAgsyI6pXrV2uJWBpPrCS/wSd2PWezjNJG1IvK1Cj1dW12sP
         E/M4SLCT+g1xAPvum+UNK5/CKo3LDqiC5x5NJUT+juO7sP+6tCtDQr/YbyvQgbd8fn
         vrRD1dJ+7GV1w==
Date:   Sun, 11 Dec 2022 14:51:48 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.1-rc8
Message-ID: <Y5XgdLWLDDRac92s@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="niHSYq8Tkq/eLwko"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--niHSYq8Tkq/eLwko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Sorry for the very late fix, I was traveling this week and didn't get to
send the request earlier. With that said, please consider:

The following changes since commit 76dcd734eca23168cb008912c0f69ff408905235:

  Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.1-rc8

for you to fetch changes up to 81c95fbaebfa5990c3c786c8c3e87426a33106fe:

  iommu/vt-d: Fix buggy QAT device mask (2022-12-05 14:27:03 +0100)

----------------------------------------------------------------
IOMMU Fix for Linux v6.1-rc8

Including:

	- Fix device mask to catch all affected devices in the recently added
	  quirk for QAT devices in the Intel VT-d driver.

----------------------------------------------------------------
Jacob Pan (1):
      iommu/vt-d: Fix buggy QAT device mask

 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg

--niHSYq8Tkq/eLwko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmOV4HQACgkQK/BELZcB
GuNiWQ//c2QE9v8ZbvdDfHW18ulLoGShNv/MU+KzMYuMadMbBgG9Vx2xAx0H+M1S
sngwlQ1HXz2O8F850DJxI7JFgObSwcqgSkLot2An4C3SfZFqyziYIQ7R1EaGYDcq
s6SiWqxkyPfFFgjQPPAHTKkymbVN0fhOTl0jSHOrb+05AmBliD74ioB9WMJMbT7b
HF6aTfGqvt6YhNSnXAHr9Fyc8RMqmjnBuiL27WxljVw/918puHwzlbYo+ow5ieRy
cl8QSKarNdm4Y/+nCPMcMrLew09yp+5OLM5RtThG0GHwapsHyIWiLoRbE/x7Mzfs
kTiEmmNUgiXZoGLv/WXkxqjXa47qrf0oadoxhqChg6ccn79o00Bq49SIEgkkXRoT
v1wxAVh6WdTVWYl01Zdr2oREG8ianhj56NKhwXFbapuRcHbh3Wc04/s1bGu+Sak7
w0OMw7heEytzy1+Z7miT76GPlHmLit9pcr/FUjavNBH9IIHVrsfd4X2GggSB7p3E
OqvR/AOy9Ez+drdoXWIx9Wt1NNjAPBUCgGB2HI1oe4U4Jp+NKlchE2MSkIiJdllu
rHc18YNWRXBcfBWkhL/Pwi1i6EnvPKTdNnzMRBJX6yyWh9d4cIbjImAM/yg6RvFw
BOm6aX8LnrPIq8CPmfFvKvODeonvO91B9jyy9a/UCBxgR+DwNpw=
=4fHo
-----END PGP SIGNATURE-----

--niHSYq8Tkq/eLwko--
