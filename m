Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA43164D149
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiLNUfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiLNUfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:35:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794531572E;
        Wed, 14 Dec 2022 12:29:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NXRmx3F1Jz4xYQ;
        Thu, 15 Dec 2022 07:29:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671049793;
        bh=JvSot3OZ2NTAEu0YUkSG3UKmeaFnVYAJSjMyGuLbtIk=;
        h=Date:From:To:Cc:Subject:From;
        b=VqgTEHnMNTMgvq7vZ0iTIM6f4uGU8OQZZEeTZsNvBQS+bE0q8Cvmy6LMBVuyHxJWu
         FYX9NvP/GV82ngBJCjR0v3N2ohZUT5vyjmOK/55JiNzlZMJ/CmJx117QGgcvNnMp54
         LHM65Wf7g55mZJ3UmlVyh0L55STq0C61+0RxnQM1sWSowI3RzbxyMOgvvH4aVHaXN3
         BN0CTOsCxtgfg+oNXajYVIvtukC++m3elmxZBB+RTFPgZKhMf2H9/XUbgid2lY3kb2
         iXOADOUk5oPIKwoPasBBROADPgg0m+JyjYo0J6b/jvMDssrQz1kTxrRiifoDn8qYVi
         mA60ib0ur91qQ==
Date:   Thu, 15 Dec 2022 07:29:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-fixes
 tree
Message-ID: <20221215072940.0c3538cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0k2KlUqh4A/1hXP_JjhdCbe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0k2KlUqh4A/1hXP_JjhdCbe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  542d3c03fd89 ("media: sun6i-isp: params: Unregister pending buffer on cle=
anup")
  94c34359c887 ("media: sun6i-isp: params: Fix incorrect indentation")
  7266eb7c5a52 ("media: sun6i-isp: capture: Fix uninitialized variable use")
  44723b8c4692 ("media: sun6i-isp: proc: Declare subdev ops as static")
  f72af7709478 ("media: sun6i-isp: proc: Error out on invalid port to fix w=
arning")
  504307f2b3ae ("media: sun6i-isp: proc: Fix return code handling in stream=
 off path")
  761ebebabd09 ("media: sun8i-a83t-mipi-csi2: Clarify return code handling =
in stream off path")
  52109d91d2f9 ("media: sun6i-mipi-csi2: Clarify return code handling in st=
ream off path")
  f2c174e5018e ("media: sun6i-csi: capture: Remove useless ret initializati=
on")
  7fabed7ae618 ("media: sun6i-csi: bridge: Error out on invalid port to fix=
 warning")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/0k2KlUqh4A/1hXP_JjhdCbe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOaMjUACgkQAVBC80lX
0GySaAgAiuI50c57bMXd6LB2DANL44mW5Dm5cgLenJRfhgSMxuQLSHyM4Y6J2Q1a
Ca7GYZzL9erqWgfTbk86ptPoPdH4Qe+NMUBEAD6pXQVoQJsiux73S8XCBaqntxkw
Xhiv7tr06wwURRjEfD/H1nd2gRLGijncSNel+XwpYIcf14b50I54oP//yOHPCzyQ
/C0LBct1joesl32rNe74iK37GZxevOU3qTSuNiGunAGPNLqz1be3cKol5Zi807LA
5US49Vj+x1QuTN0tV+HCQmCq6JJJpMWhUkJAFdJK1Oe7pmvnl1zc1Za19FzUSs3b
sWU/Rjd6fv5HCd8KJ5xm27pbsoNwIA==
=jjmh
-----END PGP SIGNATURE-----

--Sig_/0k2KlUqh4A/1hXP_JjhdCbe--
