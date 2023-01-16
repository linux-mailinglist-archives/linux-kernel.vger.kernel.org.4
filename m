Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D424866D0F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjAPVex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjAPVeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:34:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA7AF;
        Mon, 16 Jan 2023 13:34:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nwlfb0tm5z4xMx;
        Tue, 17 Jan 2023 08:34:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673904887;
        bh=5Vjh1SwyZ3SGuFxoq6hteZnhdy95xfFTzvUAFR1cxWQ=;
        h=Date:From:To:Cc:Subject:From;
        b=q5+f7I4WnYpwtbq+vQ9rcdaDJJvFboc3KYkaFsmOY5iYcVNtCQwMlqPcYnGH6Ryg1
         q88xX0bY9GvhzcrAoNO75/Ov1qD+7feFliycK2Gm+fyXgShGoAvWBqvrp7ehXwQ6DA
         3youANdi3bEM02ZpRLbz55y/AhhC3sMl/RANqobI+I4yCa/vEgTlkQ7QO59gXay/Mu
         Pumdn5CPCMqs6Uq0K9ciRDx/9u/RQoJzM5V9e+Dr6HpPpXUdmAg2YQwUl7AqYRevew
         ZwXikH2w7th36nCSJr1cBuc6bSOZovZu2i20mFKrZjvh0Kv/Eh9V2TsXamURHoS7pN
         nk1jKLhQ2pGzg==
Date:   Tue, 17 Jan 2023 08:34:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs-fixes tree
Message-ID: <20230117083345.7443cbfe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hs8UnPzqQfjcAFdjGiNn=Rq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hs8UnPzqQfjcAFdjGiNn=Rq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  3d223cb5a2f7 ("btrfs: do not abort transaction on failure to write log tr=
ee when syncing log")
  46fc636870f4 ("btrfs: fix directory logging due to race with concurrent i=
ndex key deletion")
  52bd17801bcb ("btrfs: add missing setup of log for full commit at add_con=
flicting_inode()")
  8ba46a395c7f ("btrfs: fix missing error handling when logging directory i=
tems")
  b8a4b882f62c ("btrfs: do not abort transaction on failure to update log r=
oot")

--=20
Cheers,
Stephen Rothwell

--Sig_/hs8UnPzqQfjcAFdjGiNn=Rq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPFwvUACgkQAVBC80lX
0GxINAf/SDJlhiH17hwezdtYvjw7Jj2MllTzyFoc8zGEo9McIjjJBRD+Fi3GIQqo
0qp7LI+nzdiCzQVqyek5xrxlulWZFnV4IuNfKJducawa+gXvwa94f17vOO0WAPqL
u5E8z0vKKvRDi05KSwJ0oUevmBK8UTuCAGtK/53voFFAWnbFRml7bTJMHQLla6Oi
TamVu75jAmeT5inDwc3yz215GdD6iALhmmH0XjH9pTtIbt8/33WzL8ILpYafzB8l
+IiHSSDt0PN5FKNcLDU5QWS+gifZZrVQpYWI2nnnLDSlt6elDad8gp7u8sXysch0
AUV3eX0E4dl9IcpHpMMOEMSA78GJrA==
=Zgul
-----END PGP SIGNATURE-----

--Sig_/hs8UnPzqQfjcAFdjGiNn=Rq--
