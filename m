Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50DB68B49F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBFDuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBFDuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:50:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275842D5E;
        Sun,  5 Feb 2023 19:50:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P9C2P4Ws0z4xFy;
        Mon,  6 Feb 2023 14:50:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675655406;
        bh=5ut9VXfyca1PgxhVxh8rSbXsgHM3j1eFHTyJZvDzSeI=;
        h=Date:From:To:Cc:Subject:From;
        b=c5sMgzfsKYtTbqwMaV1fLb6QF2kPCqgf3dKyS8J26CAvAQM/TswM5lirgaQAABHEa
         XkrpRnmSbJAYtktRlWXC2oUpoaRg1jRFAS3wRigRd5f0WSwAJq15yfAQq/eSd044m+
         uCyLgfDTQYRir3btoAORCvHVwPrqTi9ITeQr76OQ/vkal0PTTv4xuB36o1+78KLqaR
         8N7eU64I53USC4+G6Gx12XIkrWVnIp1uMRcRC1E3K3wxapNMlEXWFZpmACcOmCnd91
         cvPxrxPVO+N2upMD4Y9F2zw28YnWPTxLX9ds6ODsdBT+J5klYVi9naGrKIg9OatTGx
         BH/2ZWVms2B3A==
Date:   Mon, 6 Feb 2023 14:50:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the usb tree
Message-ID: <20230206145004.6e043ed3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Dw=70Hk9xqiC0kaAoksB+rX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Dw=70Hk9xqiC0kaAoksB+rX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/ABI/testing/configfs-usb-gadget-uvc:14: ERROR: Malformed tabl=
e.
Text in column margin in table line 4.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
bInterfaceNumber        USB interface number for this
                        streaming interface
enable_interrupt_ep     flag to enable the interrupt
                        endpoint for the VC interface
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  a36afe780461 ("usb: gadget: uvc: Add new enable_interrupt_ep attribute")

--=20
Cheers,
Stephen Rothwell

--Sig_/Dw=70Hk9xqiC0kaAoksB+rX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgeOwACgkQAVBC80lX
0GxbQwf/QM5FnN89MDVbg/2YrcYpeh60z/StTQLRVsIDmg+pf4YhhK+yL6EFG1c6
mO8cSek4ShC/RlmYOTA7+fFkly01vHwzmbUXS188urqPUDRO9KnnL8np8yTMT7JF
a7nX00pxN62LMriLzGFQ9CLWfbA++zRVWkyg5j1a/i2DZlYg+EdS+x00fl39U/q3
Be6pu/nNxapoO80l8rDARU9soMwI7rRGJXgsp9sl3oMsQ4zcsduTcQo9xOh0izgo
eC5RyG17X+mVAQJULiTq6k+/M4M2Tc5WtJpru3FoizGxbh3oDtPAJQ/mGP4CNLIS
kb/s+/lgM6KiyvX5GjeUcu/Hhg2rhg==
=Mreh
-----END PGP SIGNATURE-----

--Sig_/Dw=70Hk9xqiC0kaAoksB+rX--
