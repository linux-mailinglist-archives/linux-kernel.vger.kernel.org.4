Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5466BA147
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCNVQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjCNVQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:16:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DF73C7A2;
        Tue, 14 Mar 2023 14:16:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PbmXb1qDWz4xDp;
        Wed, 15 Mar 2023 08:15:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678828559;
        bh=k0ktuaYalzyCguU1+7hbc6HyWBUmK2Mt7aTsFgmLwTE=;
        h=Date:From:To:Cc:Subject:From;
        b=uVktjRNtXwqzosI48URxZ0KG9kTavB1LGru9uEMupSNoWT20xdruvwHTWI+GlM/pU
         f4YE6IKdlZ2VxYGqWyAbI2Mj23qBDfcEGjwnLDbtFc0B8Ie/Da/ileleZGyfE7dbgG
         Wr9SocMHovL6iE9Gia02NDX1iGw8nB3Rdbap9Gh9pX07H0lrlCzeI2lVJU/iTU81EF
         pSC1SBZkpTxVxGc7TrDpsLBBuPf4613CbjN3VoXRjoJRKDnnNz8S2CNo66+5eh7VIt
         J/GsAqBWgIq73gXdF3PQYwDGHHZUCVy+IoEYs+2NZNMOCqoX9VKW458VyHAqVzmqTg
         3zGA8PdjFoQrg==
Date:   Wed, 15 Mar 2023 08:15:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20230315081558.613c56d3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tjkS22j.O/oHWB2spP/EsfN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tjkS22j.O/oHWB2spP/EsfN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  bdbff740e57e ("arm64: dts: qcom: sm8550: Fix PCIe PHYs and controllers no=
des")

Fixes tag

  Fixes: 98a4dc3a78fa ("arm64: dts: qcom: sm8550: Add PCIe PHYs and control=
lers nodes")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 7d1158c984d3 ("arm64: dts: qcom: sm8550: Add PCIe PHYs and controlle=
rs nodes")

--=20
Cheers,
Stephen Rothwell

--Sig_/tjkS22j.O/oHWB2spP/EsfN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQQ5A4ACgkQAVBC80lX
0GzQFwgAn1aPP0mBtk/vTzi4n7a9yBKO3sI0raHFETYJa73dxPs1UysRLbxQeJv1
neT38HylZ5/YULDp+sum/s7rAgBp6tOB1+s/nSzfsphFacZGLuK+HqyJS3q/MSGn
nVzeQnJCGGX07GIw4eSi7xPZ24t+ND/DWT53FR2Yezbc8ND6DXidyWAdARklDV/B
dAB7DAcihIyEmwDwga+lIE28zN5m/zXMtoX/hqhEqqRd6YZfGpyY/hQ+ITyZkaw3
NR7SWmD8hAE2/T/HwZA4ymCljbT9EP8hbAiKIBUkhlRnJtHbX5xOiFuep7uBwdV3
1SKrDuxEu+xHqq/QagPZzFUmzQr4AA==
=AFUL
-----END PGP SIGNATURE-----

--Sig_/tjkS22j.O/oHWB2spP/EsfN--
