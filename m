Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46076382B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKYDaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKYDaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:30:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1211DA76;
        Thu, 24 Nov 2022 19:30:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NJL393T3cz4x1V;
        Fri, 25 Nov 2022 14:30:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669347014;
        bh=6SWwZc2uQtmpeEVjQzq7dy69TnAznszEflKHW/ZfoLY=;
        h=Date:From:To:Cc:Subject:From;
        b=SnCFcg/C4VSrKZZ+rUfjyyLZ44/oQbDrg/sJp1Q5r3pSsZIN+0vTqPNGugZHmoiwZ
         jShzCWsdh2qx5xOb61DO+rwX2ddHafsHh4E3uWDemT73c3GOB43aDIdoqxDFpP86PV
         KshHXPQdYCtnh+PQwWQ2vldLjOF86GReJkbTorfi7+kf9OECLD9aqP0iFSsrdiL+wU
         ANr8T6jLZlOct4Sncyq8ql0VXb+SmJzERPqjuvpJ9S6ikITpASHyZQAFVxVefWwOge
         GJJSX2Yw+0SveJv8oHb2iYm5hpby6t2ckc6K2vZuUMXDG89Bqr/k4gpbBRVmLISeVb
         VtIwtOrtQMK1g==
Date:   Fri, 25 Nov 2022 14:30:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the powerpc-objtool tree
Message-ID: <20221125143012.6426c2b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qIAd5CAuMjQ7zm8y6Hspz0Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qIAd5CAuMjQ7zm8y6Hspz0Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc-objtool tree, today's linux-next build (powerpc
pseries_le_defconfig) produced these warnings:

arch/powerpc/kernel/head_64.o: warning: objtool: end_first_256B(): can't fi=
nd starting instruction
arch/powerpc/kernel/optprobes_head.o: warning: objtool: optprobe_template_e=
nd(): can't find starting instruction

I have no idea what started this (they may have been there yesterday).

--=20
Cheers,
Stephen Rothwell

--Sig_/qIAd5CAuMjQ7zm8y6Hspz0Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOANsQACgkQAVBC80lX
0Gx9qggAl/flwI3IFQ4qQYlHsYOAVZdsiag897RGpD2qHFNlnRyfaoBHVwSh4XFj
LPSFRiK4kjbMj4iJgD57WCDqklvx5R6BrixXRHFXaMecbJzBDWepEVZLhR7Cth2C
ZeDWXrZC38j8Yx/nHMjQqPXxZCV5ua4sUYGMcX9V6D8cRA5Qaf8nDbV4hzZEYKsA
pqByt5NeRX6sOGRSSJwd/ddIKbASklks1sYxYk7ijeGgB+up94tTarDwnHbWo5mO
UiYfx6uPfiijrT8B3Nd/9XtxL4+Eoru1cfj9+eZJxqb83NcpiTDfVlQk1YL4W+09
iutP/nnvH3/N4yk9i95pDrikytSbEA==
=6Rr6
-----END PGP SIGNATURE-----

--Sig_/qIAd5CAuMjQ7zm8y6Hspz0Y--
