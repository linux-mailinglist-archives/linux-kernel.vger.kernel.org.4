Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA965F66A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbjAEWHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjAEWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:07:49 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFCD67BE4;
        Thu,  5 Jan 2023 14:07:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Np0vd0X02z4xyY;
        Fri,  6 Jan 2023 09:07:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672956461;
        bh=3g9cALt3rH0oMbViZng59jBHpUpw8NsCSYmFrfsjYb8=;
        h=Date:From:To:Cc:Subject:From;
        b=Mm+NiGmynJnlvwb011T9uYqG5YVihcsywZoTSI70f45gHdu5NNzoIHyQpJQX26YuD
         SmvxJNUtdfQCOOZf4Ua7P6qtKNrIkL5OP4w7U8meFBjiyFHibsw3NBuJm+wM4/hC/W
         dzN++X+fRs5p2EouWGh5P7ZQU36m6MM0nMynp0/Z813tRGVighZBhhHKW7w5DjLld/
         uYqKbgZ1VjEuYdwASVqXzmxmqyMy7Z+NQB69XuFWbmdhZvMFXYEiklBrPtXYUF57FM
         GXr6gRCgnjVOXct6iEYmhlqMRGNNBkfckH1ddl6mkJy8DCpEAAz5SgcVxuRxh3h0wt
         4VaBqju5Uov9Q==
Date:   Fri, 6 Jan 2023 09:07:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the drm-misc tree
Message-ID: <20230106090740.49e98abe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lDdmJ0_m2WhJ8clp9S3Y86+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lDdmJ0_m2WhJ8clp9S3Y86+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits also exist in Linus Torvald's tree as different
commits (but the same patches):

  a189b2ee938f ("fbdev: Make fb_modesetting_disabled() static inline")
  7aa3d63e1ad5 ("Revert "drm/fb-helper: Remove damage worker"")
  8b83e1a45538 ("Revert "drm/fb-helper: Schedule deferred-I/O worker after =
writing to framebuffer"")
  e3ddd2d25533 ("Revert "drm/fb-helper: Perform damage handling in deferred=
-I/O helper"")

--=20
Cheers,
Stephen Rothwell

--Sig_/lDdmJ0_m2WhJ8clp9S3Y86+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO3SiwACgkQAVBC80lX
0Gx71wf/V0jEa3YFx+ZkVwrVu1aA5mHbBEUG53PenZwEjhFKLuJCS7o/Aysf4Qu6
RFP5TGzC8U2bPY50Wc+I5BV5ai9ru1GS24Qunj5OPltwu7KM24ADt39AUZ8mrwZA
e4Hx+Rq4Ddsid24g3hXoPbZWofuiuJu46+XjUTumMSc6JqtOkupWSiAM/COYStUL
DqmaZ+T8khQdo6rGpz5Oif2HxfaYHluThXpqhnUTlqolIQzInKmPsFGRcsYAeaY/
VEMOxSSNo5NF5tUjd/ZjdfffnXNngeSCyvOBnklSkmQuNnyy4YspexcWkujGba9/
Kfb2kajlkCzoFF0+e2QU0riyabUCfw==
=VWKa
-----END PGP SIGNATURE-----

--Sig_/lDdmJ0_m2WhJ8clp9S3Y86+--
