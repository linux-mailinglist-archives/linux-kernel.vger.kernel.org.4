Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A825BF020
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiITWbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiITWah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:30:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD615FF49;
        Tue, 20 Sep 2022 15:30:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MXGTB014Nz4xGC;
        Wed, 21 Sep 2022 08:30:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663713022;
        bh=qk4XgG2mzxcKbrNJ8FlRuD3pj6kHAOuNVoW4BlDXlJw=;
        h=Date:From:To:Cc:Subject:From;
        b=f81RY+b/quqLOFIx8N9MIzxrhHymvetFzNarhofNuYMHB9w5sBeefH3PeqwTgwNo6
         6d2C9hMTU9PtKi2gy7JGRJuUzxr4s0NgYaMJpSshv5t3NewUYYaLoYnod0iYh9ElfJ
         ykfRIEjdO3kAeov1RefqbcWkFmhhUzh2ysqBsZHVLPwyWQWM86eYUcMp382WlSt/1K
         SUeItz4cn4/nKpsALw2Rgxka3/ndSxFSAd2msYEQdDt252n3RKy7I42kKa1VAVhvxJ
         HfEZfCmw/jXB/7Pm+MRPMBG7vhYTda7Lu0d/spRzQdGhlf7/hxt7SaRgfE5nsNb+Pz
         xrJI1KLzahxBA==
Date:   Wed, 21 Sep 2022 08:30:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bluetooth tree
Message-ID: <20220921083020.6c046d27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_zjlSnq9o4G_7A3n7Zn9mli";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_zjlSnq9o4G_7A3n7Zn9mli
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  239491111238 ("Bluetooth: MGMT: fix zalloc-simple.cocci warnings")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/_zjlSnq9o4G_7A3n7Zn9mli
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMqPvwACgkQAVBC80lX
0GyzXwgAg3vvs5U2kqAow1jJgjbShphCclwj8V20W/32g/bcPXfNVSdjAZqcchTK
3HeENwAFtV/Eqy7kIHhfBYbtseZ0rNJkYS1uRcHcWPPgsglgQ5GzSpvjfqiKleq5
UrIocL8CgkwBwCIWSv9sNYBSVsIHLTzLetwj9cpg5K3CRkgFehMiYtWQcByiWs3C
5O8qd9794HDET9Ou8L5Hq6RE2//WGcjI+nHnK/7YqQx1p+5cxuJ22sqHJgJoBQBw
1E6W2TK7lG1sU16GjWOVxkxBwGO+4lfVJVKoXxDlEXycFMZ/7yc/88aW4A1F32FS
XO8hFWvbvYmRKz0HIAKqUmZrtP2BWQ==
=ALgB
-----END PGP SIGNATURE-----

--Sig_/_zjlSnq9o4G_7A3n7Zn9mli--
