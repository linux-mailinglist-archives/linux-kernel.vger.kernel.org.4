Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B543A6DCCD3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDJV1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJV1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:27:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE54E73;
        Mon, 10 Apr 2023 14:27:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwMWf0FHhz4xDh;
        Tue, 11 Apr 2023 07:27:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681162062;
        bh=iRs66dznQqNV896srdz06oPNaa4iLcPHxUnJBlnIW2k=;
        h=Date:From:To:Cc:Subject:From;
        b=rgrWQLJgY1WaMyuTUZxDDMQFZwI1jPGM9q+hDMJYSV7edYYZFNsL0iWT8yIYlqnHB
         RG9Zw8wd8mtNP6tnjdx//0/Hyt2ldgH0qEqC2GxJAcCnEIVs+VDqcDaeCHLY/jxPzi
         ixdoEYIFbkQcj7bJhhzh0hZ0v8wqKtKHF0rd8sv716y1JmrunucagYsOoPaM4gEgAJ
         Tt6DNylscDZxRwXmzgIsncFxl0chHmASTLasQ2MyBr4fmLoRiAgalFuf1FpKdXtx0H
         2SQYXDucNadoTnGMCjJB/3r90c/MR+rQVD/TkzZEITI8ScyLmR8LeAYRs1QK92Y1SW
         TkBSlNimEK/7A==
Date:   Tue, 11 Apr 2023 07:27:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20230411072741.3ac89dfb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K4++JWlGEIOlDADOuEiA8/V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K4++JWlGEIOlDADOuEiA8/V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  3a6f4dc2c8cf ("dt-bindings: vendor-prefixes: add chargebyte")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/K4++JWlGEIOlDADOuEiA8/V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ0f00ACgkQAVBC80lX
0GxYKAf9EkYkmZ7GvVMHwAAAeOnM8IlzFEzKqXYUZj4+mp6TGY/ZswKLgq3ONWhT
+JASbjjF7PV/NtFVcPsicWa1Xsyxna/Uq1U95RqydUzOQSn2WLsuCqfM1ouxGdJI
jWAvHOIfH93ioX87rXvDYkeO6AABbQhKDWCBLiEziOzCk/Td29C97GfsewvHC2gp
qeOjHmDRHyFRkeZE4yvhAmNXZn140ApDnAn7ufdRBV1A+JKNf+y/bTQx3UphNFDx
kpTEzKK8kHwO5ean6dccCxsoFGKt9+WooKq610q6AvKrnh5k6IexBkrRTQULJydc
GvdBON7mHIZNZ/Dzxr8XwH5e0Q5fBw==
=gpqA
-----END PGP SIGNATURE-----

--Sig_/K4++JWlGEIOlDADOuEiA8/V--
