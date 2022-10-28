Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11247610952
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 06:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ1Ef6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 00:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1Ef4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 00:35:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD41974F2;
        Thu, 27 Oct 2022 21:35:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mz8qk6zqTz4x1H;
        Fri, 28 Oct 2022 15:35:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666931747;
        bh=jYVyOznY0Ty08p58XciatRHPLJe6l8bz5Z+PwSrqua8=;
        h=Date:From:To:Cc:Subject:From;
        b=MqXSG+emjTvH2eAtgoGy9NAn+eqO75uEOcTPC3JDreiDh++7If9ySsDkciiM6YRcl
         87sw1j+pXAuqnFUiAlrq7UG9Hu9S5Nti8z9nN/5ncMT7B5Bjj1EOzDkU7gW4FKWQqU
         hutzvcD1zEN/fA7RxxEqxQ/GOvP//V0fIlBYiXFKqHRGS6BFKLlDSnT/UNN/8yM6BY
         KZ5tT3by+0Cf+f/cwOCRcEq2KRmz1dH8XcyM7FTHQspM67tFc9+xpBNOkH2zHd19FQ
         +fUxTwi+ngrhkaLvva5XCLAlmv4ccpVw9kwKKwCayIZohFEGFtxxfZNIcFYWxD7RUX
         7uDskzlt5MpcA==
Date:   Fri, 28 Oct 2022 15:35:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drm-fixes tree
Message-ID: <20221028153545.0a5195a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x3gbvUrwnqAeqAVG5AHr4Fr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x3gbvUrwnqAeqAVG5AHr4Fr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ec8f1813bf8d ("drm/msm/a6xx: Replace kcalloc() with kvzalloc()")

Fixes tag

  Fixes: b859f9b009b (drm/msm/gpu: Snapshot GMU debug buffer)

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/x3gbvUrwnqAeqAVG5AHr4Fr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNbXCEACgkQAVBC80lX
0GzxMwgAnNSpKSk1/mMjlIDphSpmVpa9BAl6lWec3YHqovC9uFVEyfoqlHd/GmM6
7aqtB0fMr+EEggQdvCRuQMRYJjsx51LY+wUB+29RC9NDHst5+Rdgwx3T8u11q5cq
AhgYpSVAbl/8ecK4tyeeJG+UOjdEQXipWPwrsA4bg2pMXNcK0N3ZTDQQOkCyi4s5
ILtPLuzD4uUF8nWOV9vBgUk3Djon/ybawq/m2gow6TrUDEUnTplCMyRw8UzRLEhY
ai3IksSO8O044q6irexGw6G3RehqWR9qg/gP2TnaGE9PQBMyGrfgUt7XG1X9/mB0
7fhFVMedj+BXA+yDOmq8raAOktvdLA==
=Jn1u
-----END PGP SIGNATURE-----

--Sig_/x3gbvUrwnqAeqAVG5AHr4Fr--
