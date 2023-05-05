Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEB76F83F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjEEN12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjEEN1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E694A5CE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCCE863E2B
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC54C433D2;
        Fri,  5 May 2023 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683293232;
        bh=RPMkakcsgGg/pEMX/kFbjCNm3Vpjc9Hgy/zjJOCFcqM=;
        h=Date:From:To:Cc:Subject:From;
        b=rMVtuDb5bKIPa9WIwI/JINrOiAYV7vBJgFmTVmiKkj9fIoNuDMmA8frzgfKUhVEFk
         8TQ2e6MML4yZZp4jUDV7bXxoO1lhuLYaBvsugAMrYbeb+4+yRJIUXFJYJ8f5SUMc3i
         oxso3w2rqCCwy3PLNnMwH75TqKjUA7P0XvTF+JuuojyN7ju/OTFMFOkjqQMnh6k1YA
         ZtK9yUSmdW8PzT5bGYvmePjJje3PSlB+VcET+sfnwnsC3Tlv1s9qc2unXgUFF/dB2x
         QtTWmsZYgthoqPTxJzIVA/KMAphicjgkt7wXGSNvTkbRS575JM5kqfH7aadFXq9YoM
         Ug9sqIrI1JERw==
Date:   Fri, 5 May 2023 18:57:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>
Subject: [GIT PULL]: Generic phy fixes for v6.4-rc1
Message-ID: <ZFUELDT/xaxm0lmP@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X4DcDbEFAfyTRw2S"
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X4DcDbEFAfyTRw2S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull to receive the two fixes for Mediatek driver warnings
as reported. Kbuild bot and my tests indicate that this fixes the reported
issue.

The following changes since commit a0106132372120dd0abf5ad7636614e5aeb5da08:

  phy: cadence: cdns-dphy-rx: Add common module reset support (2023-04-12 2=
2:16:16 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.4-1

for you to fetch changes up to 9d9ff3d2a4a567b543b71c2967d2ccc5e0ac6816:

  phy: mediatek: hdmi: mt8195: fix wrong pll calculus (2023-05-04 23:12:11 =
+0530)

----------------------------------------------------------------
phy fixes for 6.4

 - Fix for mediatek driver warning for variable used uninitialized and fix
   for wrong pll math

----------------------------------------------------------------
Guillaume Ranquet (2):
      phy: mediatek: hdmi: mt8195: fix uninitialized variable usage in pll_=
calc
      phy: mediatek: hdmi: mt8195: fix wrong pll calculus

 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)


--=20
~Vinod

--X4DcDbEFAfyTRw2S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmRVBCsACgkQfBQHDyUj
g0cHgQ//Rb+Q6bxeU0x33Vvcoy+Acbl8G0EYR2+apDdM2Nv3+4AulrkFto3eWFTp
yjWM6R/2PMcwEVMoc/TyGTfnGPHpFhrI6gyoLeMtT3dA5yBsIIQXuuaZbOyvqOKX
gzGwvsMFCMZEslvRXfG2IIRwIATsM7Pbm9EL5p4n2PofI1L1Bhpm32ccoQ3b5GKd
ADogUaP4cWYVfQ5Qxf56PQD895wDfaVipn9NTPCrq4rrmXwWgPUbNn4Od7+Cszpn
FdzZja18J3zs74vRpvvEa2LsF5RyvV4jcmPLuba52X5p4UUg4wfHYpmUDbnQLOfF
Ovtx4SMyURNQVn0yRby/x02sUvJkw0SuBwBkGuKXSWRwcxeThhFM91E6rQ8STxK+
4ujT0jNzRGGbtKJmFr9HuNrDvkPhbha9602y7o4O9h1widdPyJsOmZgCbyAwKKD/
PvxHBZDvdiN/KYXtbRP8buTQYmjgnjKOdPlfkWfMu3Tb4Ci9mx5wsVRkXfO4Dq/q
S1GEikj13tmskcBX5HuTdtJ+rDSJJTsl+GKWS2gwkJ/KpJ+cJZolzBAJ0Bb0nkcY
M7NKAdjH1k9LesXRDe1k9jNFOCGS4DwqTgCukCi90KXdKUm2Opia8u/6S/EcDUwe
fHI3sGGa07V9TDc2Lsg7N8VeafEyyhlX4m9zAkKEFC+MTdB0SAE=
=fVZq
-----END PGP SIGNATURE-----

--X4DcDbEFAfyTRw2S--
