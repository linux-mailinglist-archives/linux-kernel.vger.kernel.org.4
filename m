Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130716C98F5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 02:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjC0AUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 20:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjC0AUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 20:20:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083D4C15;
        Sun, 26 Mar 2023 17:20:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PlD3x1GJjz4xDH;
        Mon, 27 Mar 2023 11:20:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679876430;
        bh=w4EPmmlw5vv1KJeyjCbRrQ05FWTrkVG2gquM/xIjYSo=;
        h=Date:From:To:Cc:Subject:From;
        b=AGyX1D7xX2eVD9dGvN9SLTcmXl0XS6X6un60AOBGY3wJAom0yAQ1THXxE9voXFN5v
         FQhhB614baN1dfYTRgqKmkrisrmRov8Ekn71I1sZY6R9ZzaL8VbO/jDgieGEfnZ9wu
         2zoreECwFLirhSO4x5xvswa6GGRe2zy+ZD9co3H+AAb4xjR32uOAw0MUI4ip/bh10P
         gHg1ylNuaqWhgjv80VpEbge4wo59hBaAwnV3VqO/EHRR68i9DgLAB9eeGP62oikH80
         oUrO7A2tqnQsIcLgkadQrba/x+S/wWHeS94xIe0pU8rHpn77xrBiX38QUfQmUnTPtI
         X4/abnV/a1jMw==
Date:   Mon, 27 Mar 2023 11:20:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the gpio-intel tree
Message-ID: <20230327112026.409883c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zX4Tua9urLYEV_7G9_0pF_z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zX4Tua9urLYEV_7G9_0pF_z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the gpio-brgl-fixes tree as a different
commit (but the same patch):

  782eea0c89f7 ("gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU")

This is commit

  a21031ccf31b ("gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU")

in the gpio-brgl-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/zX4Tua9urLYEV_7G9_0pF_z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQg4UsACgkQAVBC80lX
0GyL+Qf+NYlb7Gpa9tf+4KeoicTfEWBwiphZs3X3BktNtgTvDg01/cMZqyj0T7q1
Pv/Yrk07QzmTtDRFPMw4b5QprdtGWBRmwKUqjE/EVO6/7F3qZ2kphuMVDzcKl2wu
5Z3js8IdFqQQ7WMToGcPZGdW9OiLklunqOvK8yah2SInvnqXrNdadTbMqlRdp10f
TALda4BpnXV8t5z5HjETBiGmF7Jjw2LwCXgrjWRo26aZCgNtKQhdplSc4yzKpru1
gykJTQogeYTGUVX6trps9ZjFzVnWdizWP00irdH9o9s6S0OehubRLhb9BHxwBxv3
4TMiDtZmjvbbzVfn1KI2Leilt9+6Ww==
=V4TM
-----END PGP SIGNATURE-----

--Sig_/zX4Tua9urLYEV_7G9_0pF_z--
