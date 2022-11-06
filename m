Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F0561E657
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiKFVML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFVMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:12:07 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78CAC05;
        Sun,  6 Nov 2022 13:12:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N56W76Fw8z4x2c;
        Mon,  7 Nov 2022 08:12:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667769124;
        bh=y2mhc0yB7+mWXvIZT4NxyeHSkwcxbEs5u7GiiTc5baw=;
        h=Date:From:To:Cc:Subject:From;
        b=G2ZNq+U6H1j4Oo50D97EwScAl8tEGN7ZSfqciQ0pHGL7dlmIjnCf/2yzMWiHa70KU
         pMWv0Ij9gPCXwZ4wEPn408U1XbBQ8vKs6SrImlhfVxVqETpmdjkNzWaN4we9h2kayM
         6u5GxWQ+dn1iB7AWVO9u5b1NIKAGtjE47wULCeTTEQMK7vnS5ov+KviorFbxZZyJMA
         gQl1gh5P3yTk5NexAo+44uqwy3h+sRkjh5mU6GfFOigh1axgfrlwJ2GHO7IUjKD0aH
         zWZneQfF/yW5qHBd/8FP4En9XyQ4e7BBQqNN8jijDcTHceAOHZsC4yKrV1Z5pCX8UC
         8F4XNwQjO3JwQ==
Date:   Mon, 7 Nov 2022 08:11:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Justin Chen <justinpopo6@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the phy-next tree
Message-ID: <20221107081159.7ba208fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F/rSmrPaburX=JFNr_zL1Ys";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F/rSmrPaburX=JFNr_zL1Ys
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commits

  5b679072af07 ("phy: usb: Fix clock imbalance for suspend/resume")
  219ec4e8f7b2 ("phy: usb: Use slow clock for wake enabled suspend")

Fixes tag

  Fixes: ae532b2b7aa5 ("usb: Add "wake on" functionality for newer Synopsis=
 XHCI controllers")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/F/rSmrPaburX=JFNr_zL1Ys
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNoIx8ACgkQAVBC80lX
0GxEqAf9ED0xFEIyx2teU6hy4taveo360Lp909afoPN82dopqtUa2jrRGt50KTzZ
tXU+MrmLXg9yxAI1Vu1fO8iELVk9d0t2hz3uqizZIn6WKqHu629kwA6nEIVOmT6z
f+hHDgV01Fk8ZjWsce12f+W+Xl4HlCFo7R6x56PJYI4btQzBYSXZO3fiBW1g2Mh5
+Upad0T54x2b9tLHICAJ8JY7yVOqRAviKk9/IcN1vEzL35POchWWEt7sdcZ3gnL+
XAPl40t2nzqJr4qBIZl9g7TnA1X7PrWLCVWjwbl6/LA96QfLeaNIECaiyfi7ZZ+c
Jth5jQYBEyz/F/nlYyeGQyyeg8zJ8Q==
=UhYp
-----END PGP SIGNATURE-----

--Sig_/F/rSmrPaburX=JFNr_zL1Ys--
