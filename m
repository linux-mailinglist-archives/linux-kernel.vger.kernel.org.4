Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFE4702100
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjEOBOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjEOBOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:14:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA310F4;
        Sun, 14 May 2023 18:14:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKLxF4vC7z4x4D;
        Mon, 15 May 2023 11:14:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684113251;
        bh=5eO6hmlEDHMYvF+MD1uVdqvOY9u8sSGqBFatZrLOT/I=;
        h=Date:From:To:Cc:Subject:From;
        b=U3YG/GL2kYoW7PtMdnzmvyWMHrkmHl7/GfL+3dR8fuO0kVU7UfNi+ipxpJVQddVNO
         RSv7x97vJ4sSugE5uecZUSKRVfVCZ1NNm2Md9lLh4Ihb4aGO7xyozI15ldIUIQq/2i
         ZxH3QPvQHkYjFcRnprsRiOc+2dtg7j+tq6o8ioWXHgjX3ro6lBmZzz2m+W1TkJO1Fk
         Pya5WHkh+mXEepvLujwrN5jB07StbpHGjNRUUIazGkJLs9qKELWYDkcTFRFknoBRVR
         lL2n7scQAmIMUx5b36oYXCTHXaalLpQtWZPU6anOv7w1fYNDzVD7m0N7u2yg/7nTLI
         mUTrOZZJtvNaw==
Date:   Mon, 15 May 2023 11:14:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Helge Deller <deller@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20230515111407.493674b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lUWi8Sea6sAsGuu5Z9aCWoO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lUWi8Sea6sAsGuu5Z9aCWoO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/video/fbdev/stifb.c

between commit:

  8000425739dc ("fbdev: stifb: Remove trailing whitespaces")

from Linus' tree and commit:

  0d556f1f0e01 ("video: Remove trailing whitespaces")

from the drm-misc tree.

I fixed it up (the changes in the latter included those in the former)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/lUWi8Sea6sAsGuu5Z9aCWoO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRhh18ACgkQAVBC80lX
0Gwq3wf9EygXdY6GTEMIzQT76/h5OODPwyMnZzJfF3+QBvLFLQWNRgCTskigN9K4
l9grkvFxM8tCZJ9W9VgFuTPnRiNLg7r2o6Yzo774RQh0yVB/VFK/Mo2jbDTWSaNu
vBDryZ1t+uyDM6+Rj/tL/CgQ+nu+H5a0K+BCGWi6RvaysLUDIm3XvLar2aVz1gmw
M9N9jh7LPh3mHFmhb1FZjXiuq8r/q9NOMDD2M5zf9ly9sSU5wbaR6fJgc+5H8fr2
Dhg++vlLv0P5k38y8QjM6+lTmLdDANuzqUk1Fh6ONocy1kM9iA3DnePDkXgGR3Wi
T7OQOCp8AtjZ+2raGIwPXXiETEpoGw==
=MPnr
-----END PGP SIGNATURE-----

--Sig_/lUWi8Sea6sAsGuu5Z9aCWoO--
