Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC465634910
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiKVVSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 16:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiKVVSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:18:03 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9E88B849;
        Tue, 22 Nov 2022 13:18:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NGxtX35Qsz4wgv;
        Wed, 23 Nov 2022 08:17:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669151876;
        bh=DJmz63qNR630cYU/2IgMgViIxyDoLfgrkG0RXDOwOk0=;
        h=Date:From:To:Cc:Subject:From;
        b=MXBu0UOhfmiJovFe5R3yZ7qeDDXVm7EtYseKDPnyt3eX6EPiytnTHiE4PlXeokcKe
         sXttrjE9PrVXbUCsj4XPg4q+Yv3knS911ikfbviBu5MSZN5BKB7SF1I/ASAr315gM/
         9SWCSkZI6W1XUXu04umwNoIlG+irKZ/eV6+6+mVF19ixZ3TFRCPc3EdbC8JQt78DiJ
         Xr37SKeQ18u8oeJSrpzh8SmEsEbJiKIcuHh8aPLrIQFnD41ZU1V57NT5QugGvQRJ1h
         BA5oRWbze41gdPKJTftSpstfOtUOShY6RmQ+Os9OSt47z7t9RqMPr4GEP1Ziza4j5m
         9o092AZhwc2bA==
Date:   Wed, 23 Nov 2022 08:17:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Boris Burkov <boris@bur.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the btrfs tree
Message-ID: <20221123081726.140b18d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vA8zu+Z/rKVRpXW4_6DoXzh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vA8zu+Z/rKVRpXW4_6DoXzh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e60fd7bf12f2 ("btrfs: fix improper error handling in btrfs_unlink")

Fixes tag

  Fixes: 6a1d44efb9d0 ("btrfs: setup qstr from dentrys using fscrypt helper=
")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: aa8270bea38f ("btrfs: setup qstr from dentrys using fscrypt helper")

--=20
Cheers,
Stephen Rothwell

--Sig_/vA8zu+Z/rKVRpXW4_6DoXzh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN9PGcACgkQAVBC80lX
0GwAtAf+JMJA+gUijkDC0D/aSTr2HLbpIY0HL+V0JtT9n0+gQzaluXTg4d22B8eh
oguFB/YvUypc9Se8UUUBbBCef1lk4xPxWsEyelzXCDIwiVri5PC8QafY1keqpyGq
Q6gQNpkaC5fJ3C8Y4sc5hji6sjiW6IvCxQndWdjMm2mkVe3bi6nweuLGe0Vy5F42
x/XVckjuUjiuBKL1IADiT3c4uR5juFoI5yuF6mHWH4XOKtSOc8FO0dZLHE5o9PsN
En15QyIdtBJEKOfEn0v7TAJcCHermqZhCnLUsiqRZcv55HTEXMcLhr+ExoXyaWr9
DT3+6SfXMuC9MVZJ8r2L97EOvDexlw==
=++x2
-----END PGP SIGNATURE-----

--Sig_/vA8zu+Z/rKVRpXW4_6DoXzh--
