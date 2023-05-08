Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D936F9D22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 02:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjEHA4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 20:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHA4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 20:56:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E757AA2;
        Sun,  7 May 2023 17:56:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QF2t46B4Qz4x1R;
        Mon,  8 May 2023 10:56:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683507389;
        bh=JOYnKno/4+Y/0Mv0KqROwiCkkHiJv96y4AOVgHzWVZA=;
        h=Date:From:To:Cc:Subject:From;
        b=PcTm5VQ4ZVDTvFqHqp7HuUKGfNCT0srXvW9vcEuERAmOs5L2rNe2LBDFOBUNqJ4+U
         Aq2VGem0523swKQ21zAJhYFCpEuK7X4Dy6xX+aSQUGWm2skZ969oxNlzDoPn1tT8Cc
         8cXpjO4xN5u5fBUPTSdC8CcAwzP20a53MU8HyfV7/6MbhcLCDJ3FL7v/JYHOjHTMEW
         8avEVLA/DE2K9ggP+faFShtU09petDZT/MP9qeDDiw65NXO1PmElQ167JQqEFGR3yZ
         P0c0lIB13NzXW0Wu/vQoPg1ZLE1B4Cqziy7xNtdezKJ68k0S4tH3i+DaH49fq2b0zV
         lRVUETdpmvxmw==
Date:   Mon, 8 May 2023 10:56:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the vfs-idmapping tree
Message-ID: <20230508105626.4b7fbef1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rB8b/wFVrykcK3lMm0lFbjo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rB8b/wFVrykcK3lMm0lFbjo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  85ef56bc2d65 ("ocfs2: reduce ioctl stack usage")
  ec30adeb289d ("pipe: set FMODE_NOWAIT on pipes")

--=20
Cheers,
Stephen Rothwell

--Sig_/rB8b/wFVrykcK3lMm0lFbjo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRYSLoACgkQAVBC80lX
0Gwv1Qf/d483RYnQmgW0O1uILxXyseH/C+SA9MyMK8RVawqiAW7qU5t5B3PGzzmA
qWDYG+BdBDku0Y0vBmMfoceztpkRBq9+FyiLYKU8vTMMCe+2Ozylvj5dH3CHa5tW
eqB2hWRttjpqq5gz8c/soAY34evoLh91Tb2U3PYy9naDy66qcCse4NZuntlbc/2s
tmbdJlYPqlTAfvNTpN8iRfRzIS/jprZNgWiL8H17/Xo/e7odd/Vg63a0VLdF6tuW
NUiyGJbCzqvbpcTnGB29QDRfP8yRhOPuxpWXJV+UhJXNQ44H3zOYWnhc/kSV0Qbv
web9UwSf7P66L2/1IoXuYJhL1Fl38A==
=3O+H
-----END PGP SIGNATURE-----

--Sig_/rB8b/wFVrykcK3lMm0lFbjo--
