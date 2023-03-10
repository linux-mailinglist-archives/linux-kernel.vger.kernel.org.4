Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DFF6B3474
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCJDBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCJDBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:01:16 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A021F6C41;
        Thu,  9 Mar 2023 19:01:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PXrRD4KCFz4x80;
        Fri, 10 Mar 2023 14:01:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678417272;
        bh=1JrlsnXi1EOsu+4DdrGsOaAXXhmN01ZZTDilkSx+VnA=;
        h=Date:From:To:Cc:Subject:From;
        b=Wczv/nooJ68TzRFZEPVIQAd8jdkVpRmU68MJGjGcUryHNNkSeEwLpSby6nUePS7g8
         SSzn3r3moLSBx/uHI+flyNP3uBjMmf6376r8e00WsTs1ma1e6PFTEtWwdPi7/5YHyL
         8lLFFH+2DXoNyM39CPc5WLWLFnVhOwCpyMuYs8L5PTJ/4zMAisUeEiIVqF/K40Wy6i
         rrUV38UINBO2hN1N6UH4OTI0jVsWf8G+ZgGKpH44sUEdkj85PVj5fKWujUoIPS7K+3
         ipP07jkcARoK98bkQbjsISCRv0GkPP31QTqPszVCeG69548+xJyDSQTdWewpgRtoW5
         RF/Xj0ZxJytAg==
Date:   Fri, 10 Mar 2023 14:01:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the drm-msm-lumag
 tree
Message-ID: <20230310140111.6843985b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wrj2VbZs=FFensSiyBzgkuY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wrj2VbZs=FFensSiyBzgkuY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  7eaace06eaaa ("drm/msm/dp: set self refresh aware based on PSR support")
  22459a50890f ("drm/msm/disp/dpu: update dpu_enc crtc state on crtc enable=
/disable during self refresh")
  31c98355c44e ("drm/msm/disp/dpu: add PSR support for eDP interface in dpu=
 driver")
  e57669adb9c9 ("drm/msm/disp/dpu: use atomic enable/disable callbacks for =
encoder functions")
  94d3b11ccbf0 ("drm/msm/dp: use the eDP bridge ops to validate eDP modes")
  0b2997e060cc ("drm/msm/dp: Add basic PSR support for eDP")
  884ad965b6df ("drm/msm/dp: use atomic callbacks for DP bridge ops")
  acb0c11f657d ("drm/msm/disp/dpu: reset the datapath after timing engine d=
isable")
  9cc249dfddab ("drm/msm/disp/dpu: wait for extra vsync till timing engine =
status is disabled")
  8a9ca0105519 ("drm/msm/disp/dpu: get timing engine status from intf statu=
s register")
  01733a9d3510 ("drm/msm/disp/dpu: check for crtc enable rather than crtc a=
ctive to release shared resources")
  7a4d735b3fca ("drm/bridge: add psr support for panel bridge callbacks")
  afed6525a251 ("drm/bridge: use atomic enable/disable callbacks for panel =
bridge")
  52e6ac96e351 ("drm: add helper functions to retrieve old and new crtc")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/wrj2VbZs=FFensSiyBzgkuY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQKnXcACgkQAVBC80lX
0GzKzAgAgy6g4GP/oE93pII4Y4FkYEba5c+2u4nN65lERW26g2eqmcqqdrOcxrs9
4wN4Ezf18/m0ckV1sMd8ln+R/NfRfFfRU9s0ScQhVWqcNgfBpYctMwgZKVR2byqR
vuA0FIPvH6yb42C2LkzuBLrRv2bEBeYTaatvPopmeSiUQHZA0pi8rtuKtr5JC5nn
M3aJbhVVYDU5yPG8GsmTeCSPo71jVhtHGDy1l8m6IH9MCb5/JID0ftykgqvUqk4Q
NasagxxF8lSuZLL63WPOuwf4zlea5TuC4JFS3GKfwpSe49/dhmV4m7RtF3drTNUM
vUGs0+KT9XQmVeUJy275htlsPkVW1Q==
=3cvv
-----END PGP SIGNATURE-----

--Sig_/wrj2VbZs=FFensSiyBzgkuY--
