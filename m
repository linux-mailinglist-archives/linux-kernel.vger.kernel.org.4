Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D716823A7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjAaFLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjAaFLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:11:36 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A3730B24;
        Mon, 30 Jan 2023 21:11:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P5Y7554Lcz4wgv;
        Tue, 31 Jan 2023 16:11:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675141889;
        bh=A3B/7yXHPQTZ01yG4M+Om5AqTRao+IUfpWqMVK+rdWY=;
        h=Date:From:To:Cc:Subject:From;
        b=NzzxPum6yNsdEaFRf2HXm2EzrFw2zGpwToHpimmWVq/pnUu5SuSWU23u6ZKoKx560
         Tkp6wvfQFZML96i/iLNiSZcv0ulSYjf/q63fIZeqxwsUZ6swprMGurtThra+axgSsv
         5vPBlOpxRxLtbAE1acZlXyq09I6r0PhesMFpyZauAmBxPv2lRDQihhAVVOvwhkTgoj
         vI/+3XmEx0ZfqB0jIWnaN/ejlLW5EWIUE1ZQ14/qBp76YFfJLmVLHcyquWg7hKez5v
         a8aoVo4y8suPlj8ZV9R59s+WWZb7Irc1L9sxhs6iNDgc3ZGCsxKwDd4/b7/NiPTWIq
         2zmpSB4B0VFgA==
Date:   Tue, 31 Jan 2023 16:11:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the qcom tree
Message-ID: <20230131161128.3845f226@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LWB+tOMHk1sWBSNBK7Wa=Zc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LWB+tOMHk1sWBSNBK7Wa=Zc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  bb8379ce26d0 ("dt-bindings: interconnect: Add QDU1000/QRU1000 devices")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/LWB+tOMHk1sWBSNBK7Wa=Zc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPYowAACgkQAVBC80lX
0GwLdwf/VrHE3z5kbBSbHlZsN17zhdSndP/Uiyi5xoCEKO13A8KiZfnDzkf9klCZ
cLUTu9C6NfY7tV0D5Og+YnqeTMahtYtu3KrskeCZz45OwxKaGoiNFPWAL9CzuXdG
tpx2IaNmAnHWXmyk6H+vepoCrxJC/lShTNt1jxmNtzKLK9NjeE2Q9s05TzfN3bXF
sX9zM3Cx22JYnBilaNgqv1GkzzFmr6FEWWNsO/Dpgr2Iizr67AY9jor2d/T2TvVP
qtZupoCPEHyBeN5zUMETlNKbVlxzY+/y7x0tBfDLm6icmpaBR5HZwyBdCZn644J0
OVpkj+0qjn6AnL9hoXh1KsOX73lZDg==
=xbu3
-----END PGP SIGNATURE-----

--Sig_/LWB+tOMHk1sWBSNBK7Wa=Zc--
