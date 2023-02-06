Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6859A68C840
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBFVIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBFVIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:08:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4DEAD25;
        Mon,  6 Feb 2023 13:08:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P9f4Q1qxCz4xFv;
        Tue,  7 Feb 2023 08:08:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675717703;
        bh=5FrpEJPSx/JOOGyCE7L7xgqN7I1KcEZd3zZGRHG6Yv0=;
        h=Date:From:To:Cc:Subject:From;
        b=XAzylvLs86Ry0M8LKe5BuRQH07vEl09/dZMmts6P4+GlVNGH4B+EbC3I3CIwlDQK0
         wtwxtfoKwgyKLGURwEFx76T6rwNXrdgFrgDOLVVyVgCkPjWPhFSaQmm1jEKZQn/8Ym
         jvrbxATI/WnJgxtJgnKf2ubPZXQUOAzKCBBjzRu9AEjPJDx5+QqLzxVtl13EnOrMpT
         Vh5tKREjMMBWIoXK+qPdPwUyL4XYm/Ays4rcd8VvMMlWtUONzlRfY8uSn3gX/NReTD
         HpWXtUSny+ur22U+nXKBHerlPif/cotHHHDK1kdfEkUDL6q5A0U2FtOZQTEAig7gg4
         O3vHCe3A5pKjg==
Date:   Tue, 7 Feb 2023 08:08:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
Message-ID: <20230207080820.5381b336@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kSe_BzqRsU+FdMzasx2n8jF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kSe_BzqRsU+FdMzasx2n8jF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  909d3096ac99 ("media: ipu3-cio2: Fix PM runtime usage_count in driver unb=
ind")

Fixes tag

  Fixes: commit c2a6a07afe4a ("media: intel-ipu3: cio2: add new MIPI-CSI2 d=
river")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/kSe_BzqRsU+FdMzasx2n8jF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPhbEQACgkQAVBC80lX
0GyDZQgAib0tyN6nUFjGwt1ksuJzAdYBGatxOqO+l7fw1uJCE1EJUDRm0+TyfVOG
R7DRkDzq7c6qyQZ+4i6sJcPKRte/vNzPOx1Ow7Lc9WwV59vMXrNLjKK2pnMK6/46
vxrkzkWY1ipk6rHwihTwqzPeb19Fq+SIdHcB0t9yYxUZ+JwVKI5TbyWjTksKqJKB
qPmiwwlXRsIQA0V4S6/gQjHGCihbzeAsp4Fv8Vm8p/izyzgdRP8EBNKZU9LAuL2b
5ikdlNHGzHcmNl+KWTUZPNXfp/2FXv92z4RLg7vjlKxJ+42glzpXAz21+6R4ZC/y
C/ZdVX6WCk/FFU2ZIwL30T1HJmHIag==
=5mJh
-----END PGP SIGNATURE-----

--Sig_/kSe_BzqRsU+FdMzasx2n8jF--
