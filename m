Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C972361E8B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 03:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiKGCwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 21:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKGCws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 21:52:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EA2DE81;
        Sun,  6 Nov 2022 18:52:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N5G4C5VFpz4xG8;
        Mon,  7 Nov 2022 13:52:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667789564;
        bh=yW3DO2jzP+a8S5PL8vmgBqBntPr0iyhX4uNvTOoFaY8=;
        h=Date:From:To:Cc:Subject:From;
        b=A83rCxj+8Ms+S/fVVi1k5p+z3YLXyFx/6O0QIDiAmvrA1T+iWHudELckKPM9ojJeD
         vwWmWMSsxcs+mfnPr901FpyISfFnwAw4VlwOVQ62epzQ+7Z23iCpgSztacKSkL8Pa5
         Zq0GjJuk1Bz5zudH8rFHCUMmKSFmlGR3QrbY08sBjEgaSj5O80xay4MK3dCwql6PRr
         Djl4LgXbCkrQbGQWlkxTgruhNPHDSRIoUdH9YEkxBkk7kB6b9u+1oJIpq5rvumuwds
         vicBSM3kbmJOyo0EaGIel9r/8fomQkE1LytVgtcqzQBB5LkLuLRY95AOu/7dU4PDhI
         SrjlksSJQDdFw==
Date:   Mon, 7 Nov 2022 13:52:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Rafael Mendonca <rafaelmendsr@gmail.com>,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20221107135239.77e8b1da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WxTQCICi2oFaP.G7a75LoQB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WxTQCICi2oFaP.G7a75LoQB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  kernel/trace/fprobe.c

between commit:

  d05ea35e7eea ("fprobe: Check rethook_alloc() return in rethook initializa=
tion")

from Linus' tree and commit:

  7ceeb4e77fec ("kprobes,lib: kretprobe scalability improvement")

from the mm tree.

I fixed it up (the latter included the fix from the former, so I just
used the latter) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/WxTQCICi2oFaP.G7a75LoQB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNocvcACgkQAVBC80lX
0GyigQf/YU6AngrZ4iMRaiXZ+rvGKVT8Y5yNpeMNo7V8Y/w6u6jS2UxNY0CcqGeT
TJ2xcQ7U5xD4Lr+BfMRYd48YiD6Z1p5upzTW5uCZ3h70Wf3WeUgs9uP/hVqgPNOj
io0IZqfSuKF3+vvCK3b1bfv8AYY+Hh5skbnecwBY5VHjKqHTTFZTPOCJKIH9j/45
sylptiYY/51YGVbveQBPtp+GRkY0+FhD+450j4hzTMFkIiFHNs67uRKbrDnSOQie
Ld8bEkigwU6E2FwIdb5sX+qv4ZPlo8jx4f5SyrqFG2IIlgE5zYXuGV3XhTDjz/9C
+C7sDW1y5y5UWt9b7Kbl9S+erYeuGw==
=mJZR
-----END PGP SIGNATURE-----

--Sig_/WxTQCICi2oFaP.G7a75LoQB--
