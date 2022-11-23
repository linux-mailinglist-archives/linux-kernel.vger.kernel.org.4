Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D3636CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKWWNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKWWNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:13:36 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1011922DF;
        Wed, 23 Nov 2022 14:13:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NHb3w548xz4x1T;
        Thu, 24 Nov 2022 09:13:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669241597;
        bh=xwBv0lx8WWUPKMv48p6jAU8TvfVAnOqvxHo64k/jwqo=;
        h=Date:From:To:Cc:Subject:From;
        b=FMHamTAf5snffKzYAEkTMIM0N1YgU3z+yqvCy+vfGYCx3eIjX0Q3EAw1MjR8TKXp+
         E8Qk2zBBRCPmOUuTAIioi02w931r84OtWB9J/+zVX7GmLbPfmHsM1x6KggqZxFrwzY
         n/F4MhwkVekLa9MZaDv5n5SmfzTjUaVNBxpqLOSgEeWGoiYdXibmN/5hMDJDoP8iac
         kBTFtx2IkzCh5rGeSWKcgG4FJOhj/MjcmAnzhVxVnBo3wm2tc5i8KnqmYKpDmDpQQN
         JcktbX7m2TkgF/cblNYjkLq5V+ZDD8BXBFOoJJ4OD2V3KNJsA+QoE5wJQl721I22pj
         qBc5UhN6o5BPQ==
Date:   Thu, 24 Nov 2022 09:13:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Li Zetao <lizetao1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mm tree
Message-ID: <20221124091315.56ca5235@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gdpTz79gJllcd0XzzTL/h7/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gdpTz79gJllcd0XzzTL/h7/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  55847dd3e622 ("ocfs2: fix memory leak in ocfs2_mount_volume()")

is missing a Signed-off-by from its author.

Another one routed via a mailing list :-(

Maybe we need something like "if the From: address includes ' via '
and there is a Reply-To: header, then use that address as the author"?

--=20
Cheers,
Stephen Rothwell

--Sig_/gdpTz79gJllcd0XzzTL/h7/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN+mvsACgkQAVBC80lX
0GyB7Qf+M3S87FpYYFUkQkeZiwfIu29PpnSr/CP0W+E9TwSSCtxA3mZRzKCIiVsQ
CXEsMO/OPq6XBYNONVBXPB4EzqEY18/AEtQGBBWNBCugvcgb78j31swceL1ceZYV
8IhEXuoskt7PFkAJ9WuMVQdPlrqYGakX2QhBoauo34echfyrbaP319PnYdVdHWPS
RT+j8nACGJpeeRiYfG9Tgb6DF8gDDYe8lzPAfJv4Jq7MP8xJHrrBUuYAHuz0FgMK
qK9dpPhX+GMHknCWZHkwPXl5oc9/vxazlP3ohgEDbBHmdnoFHXc3vLrqMSOStXfs
CNuiliAnSLWsL4NquFU+I+oxM9SJdg==
=IsBm
-----END PGP SIGNATURE-----

--Sig_/gdpTz79gJllcd0XzzTL/h7/--
