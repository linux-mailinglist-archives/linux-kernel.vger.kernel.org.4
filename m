Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E0165DF32
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbjADVnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbjADVmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:42:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB551CFE9;
        Wed,  4 Jan 2023 13:42:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnNPF4NTRz4xyY;
        Thu,  5 Jan 2023 08:42:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672868561;
        bh=c5AO3nQUrD95kxRlrzwvREFMv+bpnPEuWKn84LXpZj0=;
        h=Date:From:To:Cc:Subject:From;
        b=qlJg11d79B0NF4+t7ptOe+dJ7TJFozY5paj6BEnhboenSpJ3yVAZ+wDD4peqaOiET
         k+AqC4gSphV+ePFxAWdckZJBpcL1+H/OeHa2qDP/SC3RfWrodJ6tF0R8O67wMBmv6j
         +HFjVRoI+BATbqwkI4hZJWIRgnMfJzDEg0FVpVpWMSZxh3xcgx/7wSdP+G9CYaPs2E
         5NUrURIuj83TB0IuscjCb58cmTYsCFDOERB9iPMVjU1XWV3kjwlx3qw1Fyk6SXI384
         Ksgjd+M+I/0/6VC3eFp6GRXCyNmBoBiwH2qpT719K9+q2adL7TuMCGWy1pebbWP6Tm
         iScSXcQR3WoDg==
Date:   Thu, 5 Jan 2023 08:42:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the v4l-dvb-next tree
Message-ID: <20230105084240.735cb1ce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8Y600HhPYrLLol2lz0MGC2v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8Y600HhPYrLLol2lz0MGC2v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits already exist in Linus Torvald's tree as different
commits (but the same patches):

  f523c655325c ("media: sun6i-csi: bridge: Error out on invalid port to fix=
 warning")
  6ceef05440ac ("media: sun6i-csi: capture: Remove useless ret initializati=
on")
  1607a95c0d81 ("media: sun6i-mipi-csi2: Clarify return code handling in st=
ream off path")
  73402fd7ac09 ("media: sun8i-a83t-mipi-csi2: Clarify return code handling =
in stream off path")
  f7f346862bbc ("media: sun6i-isp: proc: Fix return code handling in stream=
 off path")
  5534ce51056d ("media: sun6i-isp: proc: Error out on invalid port to fix w=
arning")
  618001e8b1c6 ("media: sun6i-isp: proc: Declare subdev ops as static")
  002886582094 ("media: sun6i-isp: capture: Fix uninitialized variable use")
  10413ad08d57 ("media: sun6i-isp: params: Fix incorrect indentation")
  d4acfa22b634 ("media: sun6i-isp: params: Unregister pending buffer on cle=
anup")

--=20
Cheers,
Stephen Rothwell

--Sig_/8Y600HhPYrLLol2lz0MGC2v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO18tAACgkQAVBC80lX
0Gx/8AgAmWSs9SGT/YWvOQzOthrW10YbCxAZn9CPZSdWjZcpZOwePRUftCMNs4QT
rkWOAU5IasbcCTR5liGALJmV2F8CqCFwnUpbN7wzR6BwofUUu7TEaiZmADEJJkDU
+npuHd2SIAj/BiT6yzNiPY5idb7re3jmk5fr28YIOysq/2FSKPq7urOLy318Xdvz
m4qiyBDWVlyDbOKYkgSuv/XaAzTj0Jm+RzMTp9pg3ZbZtlbJ7QcOlpdWqsEFc0kP
B0ZDfnQ2lOPePIC8/Mvn3NfPQRDMq100zLwtPrM8kLdUDAy2e6Hr5kta9qEiQQBb
R9kv8vdQ2wIAwN8lepDxWu6oNiY3dQ==
=aszs
-----END PGP SIGNATURE-----

--Sig_/8Y600HhPYrLLol2lz0MGC2v--
